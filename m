Return-Path: <linux-kernel+bounces-50757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23D847DA0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B631F250A4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59AECC;
	Sat,  3 Feb 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwo5n540"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE3636
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919019; cv=none; b=Bh1XhHUsQ+sITHfoAn6zEPxDf1WQiR5IXqWyEVw7LfDQwxdXLZCD8D/pWB0pMVlY8K3Ky1Xcz39YLm2RUWEKgoh6gpN9km9YQpOIylT9614qk6tRx/irGj/wlgaRmCjVKMc3Ps8D1mX+T2RgGveSdqGZvPts7eJgKXLCriv3Ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919019; c=relaxed/simple;
	bh=lYrl0fMGsQMv4kqgDrYyuon4dy2WZcZ4nXzIifz7B8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dv+G3FqugKSK5rURJllXn3NuPDqMjkS1oXlt5qa+3rFA1mm8nriktEkxPivErzOzc3Xn4Nz2hcj9oBra8gqamF28XW45qYlTp+UXu7e1Wkw+1ODDMFdAzY8/3ic1gWqnkEf7VTrI6Nrl+VI62hgLaIhxvOih0wqv/nHwOnC0f2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwo5n540; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5112a04c7acso4402831e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706919016; x=1707523816; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+i/pqntxef3SaSJAi399Z+K8zvxssthTj40vaMmV808=;
        b=pwo5n540YiAMwmMzWpFLlg26V4gpBMvNVCvIeJQ9o/KXppQo23jhYWf911yi/TI2wx
         Zt8Is5bkeQCHbyOk9UVUpvLkRKa4h5Cx4b60zQBppNgLhS+KDnxpqEZeFUpV7QfagqJ/
         hKW8aCUP3aOhg7hjdTj3inybWbUyZTi8FBUY+Wfrzyjv3qudoDvo58/l2SMz7gYCbseB
         77x802lxxkQThQFNk3kmxuFqNAqYl6Jau+2OnM59LRRRCP2/1u6aHMSAgEGOZdVZVHbe
         phQGBJaxOym+FiZf0BNPG6ZxFuJGKSRHJOYpIz291L2kZlelrrVtxhs6R0X4JP951133
         eNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919016; x=1707523816;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+i/pqntxef3SaSJAi399Z+K8zvxssthTj40vaMmV808=;
        b=W3Uwlgt8Y530XCD2O+jX5LWdVOkJcbDSrg4Iq8qBO3R6ff+SeWPslfCQv+ZokBxMxC
         ceAb9Xm+oDT8bxtV917hNQtU3uofAi4LwEH9xlihc9xfITZtc494CtC48bNVscT/eejU
         K3Y0ItoEZg55vKZpMh/4DObfH0WtynmkPKdIJM5oFkc3Av2PGEXfMHEwgK113fseyG2v
         pGUPRdyO12WiCuzdvQygJFPG+T0/azhvGxuQkJHuImRL7S5WYJrfDaULl+qXMGNNGzP9
         6Zmk0PtjCLghgQzYYRFlkogoabz44wKtNh/cveQu5VUFlbaxFjkeLDcyTc6ZCHRbsvfh
         xgbg==
X-Gm-Message-State: AOJu0Yz4niFZeE2Z8O7OwbF0MzVJro/AybCL9mZ4vkdoI2aQI9dAx8pA
	6/iB2ZNbONqJBwkVHBRbVdQV669pAUvedBJaXkj0R3+fGoCCvrO2WP8ewETWyNM=
X-Google-Smtp-Source: AGHT+IHv5rAc8QRwm75Y2Kq5VRPClPoZydxjw0V5JodbhYnOvc7BqLhI+FAL74jEj+E5+TpeQbpSdQ==
X-Received: by 2002:ac2:531a:0:b0:511:83e:87f with SMTP id c26-20020ac2531a000000b00511083e087fmr2255293lfh.19.1706919015679;
        Fri, 02 Feb 2024 16:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpfq7nsHkCKDeY3juM7KxutkUuUjuCzsgvPID2b8QyfgEAxG4ulY6Koxp679pTujGedhIugehLP7Ve/jgmDajdAu9L2rdew2fCwZ1YJwsPzw2U/LMnMGJnAhvMGMTGv1DLAUNrbz5cpNo659A6CjmGVe2SFU+qReWnLUZ8TI2ohkOqwPnbkaj7/p4ThY+E3/FsDUN51ODHO6Ccj7Ek/pfh13ubKDF2ENEFptu2Hll3ZqsDPRUc492Tx3M7ELmrAFiJqXx4k0LfQD4ljbNCm7a7kB37p3Jrc2wPLfmIRQJtQeolQax05lbO/UejADEeqSo0SxzLjZ05Dp49lCmrPt5+UkaJOUA=
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id jy13-20020a170907762d00b00a2b1a20e662sm1396594ejc.34.2024.02.02.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 16:10:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 03 Feb 2024 01:10:11 +0100
Subject: [PATCH v2] arm64: dts: qcom: sm8550: Switch UFS from opp-table-hz
 to opp-v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-topic-8550_ufs_oppv2-v2-1-b0bef2a73e6c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGKEvWUC/x2N0QqDMAwAf0XyvECJVsp+ZQxpa5wBaUszZSD++
 4qPd3DcCcpVWOHZnVD5EJWcGtCjg7j69GGUuTGQocGQ6fGbi0R01pppX3TKpRyEITg3j70fonX
 Q0uCVMVSf4tritG9bk6XyIr/79Xpf1x9/k6ByewAAAA==
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706919014; l=2714;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lYrl0fMGsQMv4kqgDrYyuon4dy2WZcZ4nXzIifz7B8c=;
 b=D8EXau7qLW2FEu0QWtjBIB2g9tGLro6lg8B0M7x5mNj8s6R8DKRpY8zY+JUe1ksDpFPcAliVb
 VSrQ2IxN6o5CDOljZLF+ZgZl2DWuwBs+HVnXFOc4G945qznfSH6AqGl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Now that the non-legacy form of OPP is supported within the UFS driver,
go ahead and switch to it, adding support for more intermediate freq/power
states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Extracted out of:
https://lore.kernel.org/linux-arm-msm/15d2bd66-29f3-435b-8494-d82ec4036413@linaro.org/#t

Changes since v1:
- Set the reference clock rate to 0 in opp entries, it doesn't support
  ratesetting anyway. Confirmed UFS still works.
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 50 +++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index c89d8f3dad21..144e20edf237 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1966,6 +1966,7 @@ ufs_mem_hc: ufs@1d84000 {
 			iommus = <&apps_smmu 0x60 0x0>;
 			dma-coherent;
 
+			operating-points-v2 = <&ufs_opp_table>;
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
 
@@ -1986,18 +1987,49 @@ ufs_mem_hc: ufs@1d84000 {
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
-				<75000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>,
-				<100000000 403000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
 			qcom,ice = <&ice>;
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-75000000 {
+					opp-hz = /bits/ 64 <75000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <75000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-150000000 {
+					opp-hz = /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ice: crypto@1d88000 {

---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20240203-topic-8550_ufs_oppv2-bb88d63a4c58

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


