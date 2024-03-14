Return-Path: <linux-kernel+bounces-103711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64D87C346
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A841B228CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59E76056;
	Thu, 14 Mar 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="IC9AqsZe"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCE7580B;
	Thu, 14 Mar 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442839; cv=none; b=PIeR0uRL5BgSHo9GxN/OZxnNpXkGcPNb+6hGYc7Rzc/BVdN6GGoOjFp+LbKtr+8fUp+HvSTlShJzzNjhPawfxwULeXriN3SQsKQiV+dvAsy7raG9m2zGqK5j8LHesrnrOCPDRU3D7wq2wC885K9sa9h2/VsMWCsYK3jtDstNX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442839; c=relaxed/simple;
	bh=eNFJevqRfDLr0CaUl1lVdY/o04DrNw/s+YIbhdNYSfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkn6wuym+pl057aiA4OITp9otnv6/GCWwy7kNya/STnZWUhsYoswOVb0uk/zEC08KFP0e+WsXy7vzDRAutAiFFht4gDfd1UxEPDne5V6IYDmt1NFOo+BFQMJIHNdjWWOa2Pvo9wS4uJU5ceQJnbB/cgvWPZ7hiDtxnctJL7hz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=IC9AqsZe; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710442828; bh=eNFJevqRfDLr0CaUl1lVdY/o04DrNw/s+YIbhdNYSfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IC9AqsZeYYVr3QiXp8gW28WfCV+opLsWGmH6eqWazeJlrjWQxTvs9s6Lth6xFkTUb
	 mPT2ObY6m8TFcqj1PB5z2XIkZZraZDGMZi+21GxBXW/XBv/+XBewJvl8MkOTxp4XVy
	 pBDTVWyGjWfoKF266YIrcVXHAI5DcU95+zZvTEzo=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 14 Mar 2024 20:00:14 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Samsung Galaxy Note 3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-samsung-hlte-v2-1-84094b41c033@z3ntu.xyz>
References: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
In-Reply-To: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=eNFJevqRfDLr0CaUl1lVdY/o04DrNw/s+YIbhdNYSfU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl80lDITKD63qIo+hj/Eih3pc5U1noMB7LAXJfP
 0vvC/TTiQaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfNJQwAKCRBy2EO4nU3X
 VnM5D/9fPCeaulAQxOysZYE1UwaWPfschbXq6CYKG43q/ilI24f2+S60+DAVfiGZNocPcww63m5
 XTWoKwQTlC6MIuQEevoT5ZcThqiAqylzV252guSWqxNlCyim4dOQBocC/BKdylp7b7/s5IQ8275
 NodU03hwlH5kAEAk7wD+DyFGT8rPuPyiAW2WiqKIqg+jztDj7yiayXRWVvfRJE/89C997xvO5oK
 JTcVOUknsTjzc7GOgwvTmjPxR9fq1N9b8DB4vrrHo3PsbUOvz/dzignmL3ADIKyzyP0IGAdjFgD
 fARCowRgBscXR06rReR0Eapzj1wUzNVPEsIMyjTJVMgiRBJJMz/mhSeriAsgerxlOQhHU1Tp3Tr
 plegxJK7SIhNbZjfHy1LyWVYkUt0wC9cewSOBUHiF+qgA5NKSRo80+qOUuFP0XRPF/R8yn/dB3V
 9wIZ+fgTyeNeCk0TBhoomdRY33INWjxJjkzOVIdF9ffMGsGgbuUYd0AkrkKpxszZzacbLHVEQj1
 jI8HTi4dOf0ILAk6lDIV+H2nfloFPrnji7np42fwryonztfADYLCtwusT9Vf6dBxHOwp7mJ8MTQ
 BKyyF2/OKvrv1EZbpmCwPNp4rVqmOnNxeC8XVQC41H9kilVlIZQtjYQPMBuPMhYhNc2XBekBBGC
 dux7zCon3IcYteg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the compatible for this Samsung smartphone ("phablet" as it was
named in that era).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


