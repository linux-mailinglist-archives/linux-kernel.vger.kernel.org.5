Return-Path: <linux-kernel+bounces-93088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D74872AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FA288CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB712D74C;
	Tue,  5 Mar 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="ObgII6FR"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880F1426F;
	Tue,  5 Mar 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680716; cv=none; b=AE9uGflt4Tj1w9J8d10Y7SRgqm0nFBQB7xdy68BV27PRQfIL+fPkwR04kqV9yskJIbHm523F6e5RRrGmzFt5jzNzHv6cI5l7H5Om0RnRBfSRj95HdW+WXcO90h//hOOAjvaKsglIgMLhp90wPZGOb5s1E4nISFMW+tNy3GB++Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680716; c=relaxed/simple;
	bh=/C52Li910U/Xv4kbIe7X14ZNBKEUjlNpqKLVWNOvhnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbzIiXqrxVKe5G/8qtvR8TPKrbSsockKZaRzhyTB/Zk2dh88r19JrKOiQ+GcnyPnq3tXiglFmmby82cT2owqLWihHHoC5cJFui+wet6K5EUiYt6Yrh6llNEZ2adwYYmaS1RsG6Ir28NbpGfCaK+0wmwralCjccd0R53VStLT9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=ObgII6FR; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1709680706; bh=/C52Li910U/Xv4kbIe7X14ZNBKEUjlNpqKLVWNOvhnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ObgII6FRsRxQKfJWCEZIZI2sbkhAWko8Tyc8SUiqkDB9JODY7wksWDtANJdktTJBM
	 LpiKRyhUaPaUuDIuhxwBsc7UfABMwcP3cHg8VZHQpTykGAXR6ROh4jGMSOT2ft42ER
	 0QmChD4CVLjt7dW/UHbSDgzqTkXdbsMhZ1Wvdpvk=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 06 Mar 2024 00:18:08 +0100
Subject: [PATCH 5/5] ARM: dts: qcom: msm8974pro-castor: Rename wifi node
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-castor-changes-v1-5-2286eaf85fff@z3ntu.xyz>
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=/C52Li910U/Xv4kbIe7X14ZNBKEUjlNpqKLVWNOvhnc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl56g/3eUrJtBMR8VCVrRvCl1GSrxTDzhsfdlPP
 gqBPHO/R06JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZeeoPwAKCRBy2EO4nU3X
 VtK9EACTRjjDnqwPDz+cWdlPlvDgsujpyQZ3JoVP4JpuuewjzZ29hsMUMVs2HX5J5gwdLXHJpok
 NJRpPFaMODJKDPy+9XsNM/e8wDke150Ka4lz1LBgL2TmFsIui1/pAyf1LtV3arZ7ApLkvd/LtA0
 2xm8dAjB6X72IVYPwhSLqwe3QKxMFM+ALK7pQ9HU/8hPOtLYke50fW3JeAKh0ZeJtBBfUGc6TGh
 TUMQp0BBjNYKaXJmYuR/R8hcJ7xnkAYA1wtNGmj4eVHdvDrOOn8l6AaHJ/1MV4LrAcnkoRJFN3q
 jsdnyVmghdvJztv5I13cVNhmUmkGWgjy/lPMKw3SEMHXjxXV3YSgcpsx0mJ8sSiNyTDPsEUlgp1
 X1wG6Z39UPscRglJETlkfRtXPY/gda0/JkRZTyrqWVZFNx2O/h14QpbPn5E4bUo3Ho9edl++1kz
 ypiuqHKspfXUg9Kgo9JTiwxnBXzq60Fdx6Rv5mD9Gl8u25Eez10UtZb+FIw2s1/MYV1msWUdj/r
 Z0wqrqxnc/2b6YgnYVbmXbdeagRILe9j1zfi5oGvvqIJzeXkcfnbTwEQnKfXP/iXBeBNUBH9gLr
 7Ump4bs/pPOERsRIK5/PuPIGFW3GPlROE9a+9cNPrwepQPLetPv4qrlDRHOS01+5KzgXtqj0ZmV
 NxTaWzEzpSJi7WQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Give the wifi node a generic node name 'wifi'.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index c9f74bf2f8bd..20f98a9e49ea 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -547,7 +547,7 @@ &sdhc_3 {
 
 	status = "okay";
 
-	bcrmf@1 {
+	wifi@1 {
 		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
 		reg = <1>;
 

-- 
2.44.0


