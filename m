Return-Path: <linux-kernel+bounces-5894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F185819130
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4700128779B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D339AD0;
	Tue, 19 Dec 2023 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rB7ITkf9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584A39AC9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2331e7058aso434719166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703016380; x=1703621180; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqF6m19XZO5RL0DPMl/uBcbgEwCy9vcznM+Gd4elcus=;
        b=rB7ITkf9uZD3COxMcRb8KKv9yyV4DGPWDjQXuIJFdSflWUmk9Ph4ha4cS3hLE5WhCW
         ifNMbqbZOYKYhO/MYKxXVDmiJqC0zU8ZcCGuF9f9Mg0ocqOoY0DIp3fKvpsLpDf00gKg
         TeuiKRqQI3hHOXnrlTJ2Y5CWOabjSyTk99OyZ7ST7IjKB6PQpCCr7KbvSLdb/XLtWLer
         X3RB3EVkiibi0bhIxzKgoTiTD0Wm9bGr7lZ2FrP8KEHyzeLz7s6PH1eJfTDj9ECi4Cb/
         48NqAKTamuEIpjtG9KhCJLPFaRxh8fDx1TpsWzxp+cTfQADqQ8M3OxA+4V1+IBHFQ2qF
         gf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703016380; x=1703621180;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqF6m19XZO5RL0DPMl/uBcbgEwCy9vcznM+Gd4elcus=;
        b=mYGN9qaVnYW+KXiSgXgSikQXLsbinS3kwJc7JDtlXZrfLXTalXfDnx5Uhed8MY+SIa
         NpqJfE1zqBmNvG199qItZ8NDnp/4OMy1zb9AN54ZiQLDMcKQ8vG1S6cAXApe0ssayVgm
         tA2Vj1K1tbmcLl784zlWYZjtuCbp1C68789tlSAuWn0biWqi81zxF1S0612RxF4GV3C6
         tLi1TCkzjYnbu4aXmkkT73waVVl1tg5y9Ryp6wBYZVV4/8HolL0AZZ9JvzucTVRAPng4
         LWu72qlQ93P5cQ9JGt8Hi8GfUx2mZksJ26VV331C+d5PVy25RRGM5k+HR5UlOVggh/iR
         pWLg==
X-Gm-Message-State: AOJu0YwUNlLjjciUBW/chFmHwgcdKVhyrrKqDiAoazo1h6bCkObRYi/H
	aUxEPijrwJryyV+hWDmKGj1Xz3phCiAll/gxFNo=
X-Google-Smtp-Source: AGHT+IGrc9ErIzMU1vRl6zxfXqa0wGNvgzlcLREUARXZ0wU/2M/hvRhYw3Zsla3kuVR7dCKkMKBNpQ==
X-Received: by 2002:a17:906:b58:b0:a26:8806:a5a8 with SMTP id v24-20020a1709060b5800b00a268806a5a8mr225380ejg.91.1703016380457;
        Tue, 19 Dec 2023 12:06:20 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1cf3fce937sm15772302ejc.162.2023.12.19.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:06:20 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Dec 2023 21:06:15 +0100
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Describe the SMMUv3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-8280_smmuv3-v1-1-efeb32b2655b@linaro.org>
X-B4-Tracking: v=1; b=H4sIALb3gWUC/x2NQQqEMAwAvyI5G7AVsfoVkaXWuAa0SrOKIP7ds
 McZGOYGocQk0GY3JDpZeIsKJs8gzD5+CXlUBlvY0ljT4G/bOaCzrvjIuh5niZUZXd1UfqopgHa
 DF8Ih+RhmLeOxLCr3RBNf/1HXP88LwZ85e3gAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703016378; l=1584;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tbCr5cE54lb2i0xlMjLPkDs1oKBza31K8hbXR13Zg/s=;
 b=AXXSOLHDERsZeNBPsJxe64y+kBkHH6sCgNg8DlRp9avbu4tEtatNUpcwtIJlieBvmlOkwxD7L
 k9E7wuGFFCqC2vj4BoZUKD2MI1o4wsVn5KBFacZakk819AuzydUeLGL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SC8280XP actually has a third SMMU, which can be seen in e.g. the IORT
ACPI table.

Unfortunately though, the secure firmware seems to be configured in a
way such that Linux can't touch it, not even read back the ID registers.

Add it for hardware description completeness. Do note the reg space
size is only an educated guess.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..391aa783251d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4078,6 +4078,22 @@ tlmm: pinctrl@f100000 {
 			wakeup-parent = <&pdc>;
 		};
 
+		iommu@14f80000 {
+			compatible = "arm,smmu-v3";
+			reg = <0 0x14f80000 0 0x80000>;
+			interrupts = <GIC_SPI 951 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 955 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 953 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq",
+					  "gerror",
+					  "cmdq-sync";
+			#iommu-cells = <1>;
+			dma-coherent;
+
+			/* The secure firmware prevents register access from Linux */
+			status = "reserved";
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sc8280xp-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;

---
base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
change-id: 20231219-topic-8280_smmuv3-51d8795af7ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


