Return-Path: <linux-kernel+bounces-98242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B3E877747
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706A51C20BF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721B374C2;
	Sun, 10 Mar 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="NShvc2Ka"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA222D603;
	Sun, 10 Mar 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080055; cv=none; b=Xai1HC/VI0ft6ZhOj/6msVNyjTEll1zEwMCyQpEQBErbkbKpPPmhwDOgDO4WxUve4t0qhJHy0mgsdbkmw0gXcV0a0GRCmjA44HntSC64DLSfgENP1XWqGC3htCAOCLHGaGLhNruef61GJekJskJxD2EVCx4Z8NizzjOyWZgZ3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080055; c=relaxed/simple;
	bh=TJxw8f0aygk0U/0LHC304psvFghXzsQi4knKtalm1k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bg6P9MrcfjFxRAhqGBsmJleIZxDGI7mNq800EekHm5W8xcM1YfZO853Ie7RH+L2HVJ30M4qG7qhbtyvdHQvCSY5LD9+rpNv8OJzxmAcL0xneFywChU+E8HRyy4MaVz4gc+6TLDs507F1YETJ6HcA/sq6YwvcDu1LgqVpKLw2Dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=NShvc2Ka; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710080051; bh=TJxw8f0aygk0U/0LHC304psvFghXzsQi4knKtalm1k4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NShvc2KaTG8kP69H71ZWQSrfHEOA5ksVo30zXdGD3el229+EUiVno02d0ElNUfqYq
	 s3BUB7kK7GavWRzv46WGcMaeki9QeEwxKNDEl8HDVGSIWlf+ytFwxnQliv2XmY9uuP
	 xgYRAcYMIp0JyEs1PqKJhukO6y+0WtYPYZHzWe10=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 10 Mar 2024 15:13:36 +0100
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Samsung Galaxy Note 3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-samsung-hlte-v1-1-e9b55bf98a48@z3ntu.xyz>
References: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
In-Reply-To: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=TJxw8f0aygk0U/0LHC304psvFghXzsQi4knKtalm1k4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl7cAwubFxnpeKYeT8avt+AP4Q/od7RtvwRQAqg
 nEUyTTyjzeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZe3AMAAKCRBy2EO4nU3X
 Vn9LD/9VCT0eg5AF+Ro9hKjlqgOvjLwkw+18SzxhnANRyS0Tbjx6hSmoW8aPddgMJ2sdaHlMzdx
 aQnRuQNI8E1bw0KPrhw4/Sa/QgoktT83WYscqLo8bgYYr2sTN0Yrbsq63LrTVajziW9LaWfoyRe
 evWap1jZDa8EnUqz+hcbR+xXgIE22cZicZ7AKMwJBNxmJrTSuzHhIH5veNDbW3jMHFuzfPuJKN2
 aWT4QqfpBkHn7ejNrrxGz8EotvtUUOStBNwxJEiv8SkYpNMGLKVMcUBqJWR4Bb0uCpGCFJcKmzW
 233zhJ9YQY5Fy56HPfpmfP6xiAtmgTfbHR1VrPoKYtVga2T+6Z02X3hkCMRnFBBJ/wIYGeViEC/
 wqPKN6RU2Rc04il3ZlbYyTASDWNjXPKLPZQFBcOGPqHRq/pOmFJp664GYT6V78+4lbrhfLD9/cf
 7VGwqRL4vC5ACNvww67AM+jK4eilQqYpWNksBWVJW7CuQKdX/RG03mvBdhFbR3pgJgjpuDtGHpQ
 /emzS8Y6GrKMik3txUoKbkZI6lChhgBz3yrgII/7d3QO1IrsuLtYzDAp6rqwuwqYvjaFJEbRUbe
 G7BGsbCJ3VTry6KzGHp38zBC79jhM+4m5TfPORrU9H9TC5RqpNBQzPub05Gwc437x9vmh/dYbQK
 oKT2Hq8Chxz3obQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatible for this Samsung smartphone ("phablet" as it was
named in that era).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..57182bfa27ee 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -214,6 +214,7 @@ properties:
       - items:
           - enum:
               - lge,hammerhead
+              - samsung,hlte
               - sony,xperia-amami
               - sony,xperia-honami
           - const: qcom,msm8974

-- 
2.44.0


