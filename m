Return-Path: <linux-kernel+bounces-144298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F38A4448
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD63281A68
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910C5135418;
	Sun, 14 Apr 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="zAe8Sb/c"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4071350C8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114212; cv=none; b=mxDIvXgvfdr457wvmFLYx41C2TS0+6FCbl/Q1Z0U13tVMReBYZe64ytlk9y8i/cIUxXLb6eH7fMy5EBTztI819enDZj17UKF3BC4K10+FZiipjC8iba5kmeNBB/cA3ioq6yqXkCZhwdgnr3X5CgktVeD3GPijK1IAq04Jr+m8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114212; c=relaxed/simple;
	bh=Q2vi5tUa/JsZ1tExqUYwhUdTXyjbz/UnYNj61uLrxEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY2L8b5L0Eirm1ZZDsUOcdoKjP6T1jddCYCcdq2f+sfozlf80QzqX/juDnr003zf11q3eydmP2t44C5+BxzrVvPlWpA6+8D5yVJ/KxIG960IuvckgId9ZtmTlh+LipRz9IM8XxEfzuCvpWiahQR3QFGnFNsawulNDIVahx5sePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=zAe8Sb/c; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713114200; bh=oQvPHwK37sX7tQP2xpq0TkEx87p6aD7ris711rg5za8=;
 b=zAe8Sb/cDkbfdnjXOpk+XcEeRKeYQje6q94oweQD1QjU0/1DikVLzTw+drC8XoS/oinq91DRE
 qg4l3WF2I9Ei94tO9OXlXQJZa89Y57Z52nk/HgAC1j/2Qb4dMP2Ui3y6WDpUy+CiwUKw1qfnI5f
 ZSWZia1qeb4aiq7a3+HWmcsVycgQWOcXLWvXXJFCoy4z3zE+N3c3RgBVvosqUgew31JUZeVUUVR
 yA0ZhHVEIuXK5R8TDFAgBwIC/YAdDeEkug4M4cwCsLZdfzQQwoR2eRQ+YGFHp2JJiQkw60PXLpq
 a+Eo5qAK3YttZlOp2ewV69Me1Nl1K8PnYakX4Xz3wbXw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
Date: Sun, 14 Apr 2024 15:11:27 +0000
Message-ID: <20240414151135.1774981-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240414151135.1774981-1-jonas@kwiboo.se>
References: <20240414151135.1774981-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661bf23299ce03c87699d729

Add devicvetree binding documentation for Radxa ZERO 3W/3E boards.

The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
computer based on the Rockchip RK3566, with a compact form factor and
rich interfaces.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: Collect acked-by tag
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4bd033adeee4..2d43729bebab 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -804,6 +804,13 @@ properties:
           - const: radxa,rock-5b
           - const: rockchip,rk3588
 
+      - description: Radxa ZERO 3W/3E
+        items:
+          - enum:
+              - radxa,zero-3e
+              - radxa,zero-3w
+          - const: rockchip,rk3566
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.43.2


