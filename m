Return-Path: <linux-kernel+bounces-4023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC5F8176DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2828B24CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723674090;
	Mon, 18 Dec 2023 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbrVfNMI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6973472
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a235e394758so120121166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915359; x=1703520159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68epx+8M61EWdIAHlB2jaH+zZGGljEe5sZXZT/JYXwQ=;
        b=rbrVfNMIVyQlidrVqwAk7nr9mwdeNMl15IDMnUl0bZapRcmb7Pg5Rgjud5VjdbdbH8
         SNbKrPrbC7A3FM0mAiGTbNs8TVqA7Z80INlliPwcjlvCqsyuuiqZeU7momCtL0wWRnDE
         9cOZPDpG09fjUsQl20sehykDCakZ8AkD1M5dTONXofU9YESDWtKtMOoM6UKwEURWnlXN
         ayc1q8oPsE0JSA2YOK4J1rFaGi6tf1qxJA1GEasE89yO1xFBJIC+/tr/s/UsBvohmAeh
         7LYr+NOer3bgbMAs81d503Xor0fETV7ftu0uf/PdI2TFKPi5DUVOSTLHNGHwH7epx/my
         QAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915359; x=1703520159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68epx+8M61EWdIAHlB2jaH+zZGGljEe5sZXZT/JYXwQ=;
        b=dNk+B8x+JBNotaTx4J1wpIbRjRKmyeUebEJDMfXGLQNI+zLANg/mS57LFhHpVPt4sF
         oV1F8Z2DRHe7Wy/afz/zJ61ykPKD0uXLItK18p0+XKJPKfUrYiIbJD6cCE3WyscOr3sd
         VvZDWQmmJjxKt+d+YHSVSNExly2RtP7Fw1ORG5/I8pj3hX1ccmgmFtBmtH5Dazc2Y1V8
         ZOohRw9sb6RMuCL9C5awocg3JV2hZDreTES9ZoK7pzbAZy6AuDPeDto/REUU4tIo9Gmu
         M/bYGNEUGamXnyvqP/bLfuv/9mvEyCpfBvg4x4jJ+S7odeqG30Fpbf1qPVm/2uyEIytU
         LK3Q==
X-Gm-Message-State: AOJu0Yz6WMhmAe6NzYuhlquFnylflN4fBb0X8G78FqSc5TfKmNO4wZbu
	m6eSMjGp5d4aheRtnncbJNKHdw==
X-Google-Smtp-Source: AGHT+IEbONXPDpir1TjSdNrOy9M3GrwpvDOaTnBEqRBp7US4qzM/6nyUiuY5QQZJYs2vuBH4FIZOvQ==
X-Received: by 2002:a17:906:208a:b0:a23:32bd:d166 with SMTP id 10-20020a170906208a00b00a2332bdd166mr1900324ejq.48.1702915358698;
        Mon, 18 Dec 2023 08:02:38 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:38 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:11 +0100
Subject: [PATCH 10/12] arm64: dts: qcom: sm8550: Switch UFS from
 opp-table-hz to opp-v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-10-ce1272d77540@linaro.org>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
In-Reply-To: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=2459;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wNcQ3JT7sEMsU1w+gTv+f8IeE+qRg1HUjZAHm9x8uUo=;
 b=Tn2VqR3OuQzlYgOYCLyuUJ5lFuNNXNnfMBUCl1Uvy4X11c3bfrVFS75n0/96CCvsEOnj0ozi0
 3fnv6kuQZRcBPa1nVbVDDkVfSgl9/d1C2N4x3cC2gCHBoI6SlSHtYNq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Now that the non-legacy form of OPP is supported within the UFS driver,
go ahead and switch to it, adding support for more intermediate freq/power
states.

In doing so, add the CX RPMhPD under GCC to make sure at least some of
the power state requirements are *actually* propagated up the stack.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 50 +++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d707d15cea5b..d6edd54f3ad3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1930,6 +1930,7 @@ ufs_mem_hc: ufs@1d84000 {
 			iommus = <&apps_smmu 0x60 0x0>;
 			dma-coherent;
 
+			operating-points-v2 = <&ufs_opp_table>;
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
 
@@ -1950,18 +1951,49 @@ ufs_mem_hc: ufs@1d84000 {
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
+						 /bits/ 64 <100000000>,
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
+						 /bits/ 64 <100000000>,
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
+						 /bits/ 64 <100000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ice: crypto@1d88000 {

-- 
2.43.0


