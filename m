Return-Path: <linux-kernel+bounces-5230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F6818840
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74018284441
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFCD18C21;
	Tue, 19 Dec 2023 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMT1p29H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83D1BDC4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso645247e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702991112; x=1703595912; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFXEHGuhlzVRVEQ8PU5ByFnn74CKERLNECfz23ehLu8=;
        b=OMT1p29HxMkpaucSB8ojVbn1mGNOCmtesk2zk3usu/K+Domgr5YCx7eq4bLY9R7vhZ
         FwAkqyliCMI0vV7NtKDRq/M6K/ga+K8Z2aiiqvfQtIipxaUm8GdGr9+9E8SbYbYFWdD6
         kya9Jc8CmCruhrndoIZQFPCoUUZumN4U6t0cw7e7xn4IVh2S+C3Ahb4oYNr/79c2JFsT
         dBX36xYtnKkC0q4YTc12sU5gJCFGywKudyMMHyeAttpLT7e2HPOVy4Ed/qUvGn8zTXlh
         D7cAZyTwZ/NK5O0T6sWMglmy5O5lArjw/Zt01obcX9vBD90CR+7GQBfmottGdplmuUAq
         yM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702991112; x=1703595912;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFXEHGuhlzVRVEQ8PU5ByFnn74CKERLNECfz23ehLu8=;
        b=rdHtQGdudZX6/hvQPnLqoi1ix8CwVt4rw9CbaEVfmlZ+MZfcCOylBP5dtlNIIGakRr
         yREZf+IoOn6nAt0K3HFJ4tH/0F30A6MTx93Bx/+aWvHyv75caloRrhErYprQzxnXwcKt
         cQeLcRs2CqPfio4JYX7nN6dbRsnNzLZEP2d7Z1Z7m6wItekvbl0a9Cz7GGSz2cHscWG8
         JByUBdOyrmJMq87IyxEKaPUuEDLAhgGeBE8sBzb1/pGkKycwI89yJR+Lj5E1ORr1o893
         tB3oHoUdWXUDUGwjZSkwoidtw0Km+mwoAYvFLz91QeHSHH7sF9OIlp2hARMhDnYnNBaJ
         JL+w==
X-Gm-Message-State: AOJu0Ywlqi2JLihzPD/TdzfYaSmmaiS+bAz1kdTJT7t1yVm6hDhsqvng
	F7w34dCuxUE9MeSgRxD7vmdKWQ==
X-Google-Smtp-Source: AGHT+IEfsADHOb0cI2Gfay+DUDpmgRdvyB8bPFcTt85ldcwoQuy0P3pADZ2ZkN1wC0jcYUAOFtr+rg==
X-Received: by 2002:ac2:5ecb:0:b0:50e:33c0:27c0 with SMTP id d11-20020ac25ecb000000b0050e33c027c0mr1993777lfq.69.1702991111994;
        Tue, 19 Dec 2023 05:05:11 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id i11-20020a056512340b00b0050e4db10fbfsm26603lfr.254.2023.12.19.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:05:11 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Dec 2023 14:05:06 +0100
Subject: [PATCH] arm64: dts: qcom: sc8180x: Fix up PCIe nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-8180_pcie-v1-1-c2acbba4723c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAGVgWUC/x2N0QqDMAwAf0XybMDWFau/IkPaLM6A1NJuYyD++
 8Ie7+C4EyoX4QpTc0Lhj1Q5koJpG6AtpCejPJTBdrY31oz4OrIQeuO7JZMw+uhubqXBDZFBqxg
 qYywh0aZdeu+7ylx4le9/M9+v6wfW0g7hdgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702991110; l=1644;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3qURocdV9JugtB3wzqN3xIUL65Cs1IGJ54XSfyLP3cM=;
 b=EdFJ2UfVugCsBHSXT4uh/4OBbUAwmzOAQRTget26RZRfwzkVVbAI13MEaPV3MVVo1A46qX0kQ
 jv30Y6QvwEQBpNG7L3Ha/qYEqsFEhl8FNAaxaPMV7AyNzc5jU+NbZUD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Duplicated clock output names cause probe errors and wrong clocks cause
hardware not to work. Fix such issues.

Fixes: d20b6c84f56a ("arm64: dts: qcom: sc8180x: Add PCIe instances")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index fe761d6d0dd3..acae2652a0f6 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -1761,7 +1761,7 @@ pcie0_phy: phy@1c06000 {
 			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
-				 <&gcc GCC_PCIE1_PHY_REFGEN_CLK>,
+				 <&gcc GCC_PCIE0_PHY_REFGEN_CLK>,
 				 <&gcc GCC_PCIE_0_PIPE_CLK>;
 			clock-names = "aux",
 				      "cfg_ahb",
@@ -1857,7 +1857,7 @@ pcie3_phy: phy@1c0c000 {
 			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
 				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_3_CLKREF_CLK>,
-				 <&gcc GCC_PCIE2_PHY_REFGEN_CLK>,
+				 <&gcc GCC_PCIE3_PHY_REFGEN_CLK>,
 				 <&gcc GCC_PCIE_3_PIPE_CLK>;
 			clock-names = "aux",
 				      "cfg_ahb",
@@ -2059,7 +2059,7 @@ pcie2_phy: phy@1c1c000 {
 				      "refgen",
 				      "pipe";
 			#clock-cells = <0>;
-			clock-output-names = "pcie_3_pipe_clk";
+			clock-output-names = "pcie_2_pipe_clk";
 
 			#phy-cells = <0>;
 

---
base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
change-id: 20231219-topic-8180_pcie-8b545fc757be

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


