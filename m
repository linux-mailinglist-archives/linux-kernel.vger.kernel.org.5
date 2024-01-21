Return-Path: <linux-kernel+bounces-32007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B4835536
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D242825A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF1364D5;
	Sun, 21 Jan 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="otZIrQ/m"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC6DEAF0;
	Sun, 21 Jan 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832524; cv=none; b=SzSchu6xQD3znXpPSl54+8VOGgby2Y/+JKaYzhfF/1/faDTaMt4L34J/lAOpnT/QRhffnO/+UENFzlvobPlaC3MwG4hCIi+A9DeHOUOGy6Y9giIjxQBvFdWvnoJHABltp1G7ylKWh4jNFLcKEQqxSlkAaWkKTYQFmp8eCJRkxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832524; c=relaxed/simple;
	bh=z3Dv/LCWVDM89jaw9e0El7a182pDasIGc+YgzmPMbIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LTzNIrLuQih4qSVItvH/jJr121ZYkFJ/tL+fap21sxUD4UiVssmsXgR+rF4wKehkV2FeFKIb5xMWmi9spRrFVvWZot3DRfF/P6MDzeVFkaqsNSKFhz2UTSAw4gtEIZRDhcYTV49fE/NRZ7rHh41PVlDgrrJ2EwyTDJ0LAE+pQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=otZIrQ/m; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1705832520; bh=z3Dv/LCWVDM89jaw9e0El7a182pDasIGc+YgzmPMbIk=;
	h=From:Date:Subject:To:Cc;
	b=otZIrQ/mv0lc2TWpCsVQc2rFm4zk7wtppKK5wcR2iEn5WnVOM2vzjwudDSiXK0UHG
	 IIESq91J22I3q45S0mMw5aDRARV72HcTxpOBEP5Sh/Ho4MrbMX4aF9ikQfTQ/yufmP
	 n+/Axv/+3mMjPdkPwPKAlo07YAr86zV73mFo77cY=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 21 Jan 2024 11:21:54 +0100
Subject: [PATCH] ARM: dts: qcom: msm8926-htc-memul: Add rmtfs memory node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-memul-rmtfs-v1-1-e9da29b1f856@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAEHwrGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyND3dzU3NIc3aLckrRiXcvERMskU5M0IwODRCWgjoKi1LTMCrBp0bG
 1tQDF6E6SXQAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=z3Dv/LCWVDM89jaw9e0El7a182pDasIGc+YgzmPMbIk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlrPBHTP49AI6fBzHZgjoGWdgWeplEAHasevrPZ
 RLW4n7TwzOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZazwRwAKCRBy2EO4nU3X
 VrWREAC6DwHw6i3EHEIIPsJ4DdsefEg04SEdhjjJbplWli4HCOAnSXlg2Oj52QdEt5LBeSeRkwg
 sQjQry4VO0O6D2aExTOrm83ubHUMC9v25PwyXRpT51jtFQv0f7AXH02NiYis/BKeKP+tE7iSNKc
 BKP7EkCYPHpeJ7c45BljdbdAvCBvzZER3b2uIuegLf8v2F8vJJIFm9n9SDfG3wleIepY3WnAMo7
 eTn0eFt62yZysM3OwwEBf3AAJgPkdQ4s98X698KDjSsmc7Jma8vsgrF7BWTagOUA0c3q8WvqoWC
 LJTxYNUlmrRFv8NshRxwlyvErvIDzIKyToHnaE0MBZkp5LY8Zl/zxlXja86nM2Rga/lXH8eQoMC
 hl3xhooCTPdEJFNAy2BrRIvVk91NngepFqMlUhjpEcQ+qHypYUc5EvJlv/AatozW6JAQtXbcabl
 k39fl9j8Da7RELCfB5pE3NgsG74xeQqoTEfr1hgV9/VL1bbgbBrNJNzmaDrHLLtBWri60lKMaY+
 i1An5MR4pU1V6mrBQW/a2/GWRgGiZvtW649vfqRhWDYONdxqYmPlAHGovNyqCaPWX+IsnhjcP6H
 W2QlD7tjjX5WOB53M6AXl/Pkf+6ANACG5xACkaE9yt/e064koh5azwcM1SWYCJo29M6zeqtUlsk
 53H/s/fIwAo+l7Q==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the rmtfs-mem node which was part of one of the "unknown" memory
reservation. Split that one, make sure the reserved-memory in total
still covers the same space.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
index ed328b24335f..3037344eb240 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
@@ -107,7 +107,20 @@ smem_region: smem@fa00000 {
 		};
 
 		unknown@fb00000 {
-			reg = <0x0fb00000 0x1b00000>;
+			reg = <0x0fb00000 0x280000>;
+			no-map;
+		};
+
+		rmtfs@fd80000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0fd80000 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+
+		unknown@ff00000 {
+			reg = <0x0ff00000 0x1700000>;
 			no-map;
 		};
 	};

---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240121-memul-rmtfs-9aa9b54f200a

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


