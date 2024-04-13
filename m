Return-Path: <linux-kernel+bounces-143822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B48A3DDB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC841F21953
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64A54772;
	Sat, 13 Apr 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2q/ab9z"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F6537F0;
	Sat, 13 Apr 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027815; cv=none; b=AEwFge6D9Jh+woCgMyKSNVr2m8mBX6B/+zbphzif5dAK6MD4fogkrhzATWxdnMx9b/zVXTsSU6KXLlsx/AmL3Nz1Tbmh8nSi0FegWy0ILvD/yqpA4gyOhvTOAABr3QdTpSZsqGGG/TvvWAZIy3+sBvljcduPsM6RJfAnfZXjBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027815; c=relaxed/simple;
	bh=CphlPbjjGHoVIAJDD8HniizmBKYJ7/HzV+cQzUb6Pyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keCqdxJtIcr5HNciasiQKYm7Gd6oo2vyxMBl5X6a3alw2/sDRZUCmjoNBpfuBa5o26UHAQlQ7cvnzpKD765HExI865lfbD/UHEy/rVvyPS5OWhRHPbet6SZD+HrlAnSdy/lMWymx/5pgejceNapBU5e4+jqVzPsIzTtRl9IfkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2q/ab9z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso1227546e87.3;
        Sat, 13 Apr 2024 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713027811; x=1713632611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD3PI/nRmGC2nmplOu5weQOMsCeqExisXrLosNDXmjw=;
        b=Q2q/ab9zarnOcpYeeg54GlFi6uAobyrQTwn0Umt57w9jXdYgqcP3J8L61Tom9d1bkr
         6n0BS1nY/B8YuHd04yY2/a1gKP67KTAUhedQzxRsLZ/Tm+lShxoU15XBz8KjkSTtI8Rq
         toETJpPFrxr1QuSZOrZpX08UZeEG10a5SU0P9eCUiMLxgjPjfdZ/aQE+YCSvejHgt+66
         151dBDyKnHvI2EbY6DI71Frzyt6S5ZCEQqr4+5JoJSg/4gPDqJQZv07oS0ERGBX92wts
         5rl8ijwlrShyt5D1K6qfdpXgkjhS22Bmnzag026/h2fNzRCmFfJqv5lBGcLCv8+bDJa3
         pqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713027811; x=1713632611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD3PI/nRmGC2nmplOu5weQOMsCeqExisXrLosNDXmjw=;
        b=mToy3C2BrGxA3NdgH08RDud4KrX4CI6mm078xTOCLBJak1PDfCgUzoymnZ/eAqI1/F
         VHC0S2h0xPIcSifpj/gcU1kJUqks7NKGl5Q98gFLFctKH30jeOuD9IUsuALOMSCHncwj
         rIeGL7x3xSfMzBZH6iCz4MbJ1O5H62dNR3NjSWAjPIy44d9GDTAALH6oRflHvdq1VmXD
         CqsSLwuW+MieJEOs2lrP3dEnqWfaunGLt1lrG787eFlx9LYuKrh5q+li1jnsf0xv+KWz
         BOJUZ2HkIdayBDaNFoSILkqMF4gzjcBGhC0I+pUnH7TxwTd2Op2ywR97FH3gOm8MBGNp
         o8NA==
X-Forwarded-Encrypted: i=1; AJvYcCUweklcss585EbJ7YNmNxAS2lf510OZ3fLrHdr/8ISqp+YbpNA5KH67EtaEAic/DGai928GH24ICEfqLoYE45FekTdcNjy4+BSFuQQfXyOHRaPF9hDkUD7iphz6y6beSsUupklKrq9yHQKRu8ddnstZbh89HKZjenfJBGuTWT95/klxiM/8sJc=
X-Gm-Message-State: AOJu0YwBt7Fpb0uKADw9SSY2UiN12DfSr/z32erOpz/m3cZKqoU7wrz3
	0VSQKSjbzgd3a4JjRhjZfflj2wCsjhJNnfjSDrVDSnhELiRTjwxjceZIyQ==
X-Google-Smtp-Source: AGHT+IEGGxkBTkriJVYgTHHpGXLTxTxlUikMu5NvtsBTFClyzHth0uiv6PXmHxY2cjUARM+z1GGDyg==
X-Received: by 2002:a05:6512:48c8:b0:515:acda:77f0 with SMTP id er8-20020a05651248c800b00515acda77f0mr4461358lfb.29.1713027811117;
        Sat, 13 Apr 2024 10:03:31 -0700 (PDT)
Received: from localhost.localdomain (ccu225.neoplus.adsl.tpnet.pl. [83.30.144.225])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3195967ejc.76.2024.04.13.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:03:30 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: qcom: msm8976: Add Adreno GPU
Date: Sat, 13 Apr 2024 19:03:16 +0200
Message-Id: <20240413170317.34553-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240413170317.34553-1-a39.skl@gmail.com>
References: <20240413170317.34553-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Adreno GPU node.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index ce15c6ec9f4e..acb6331999bd 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1080,6 +1080,77 @@ mdss_dsi1_phy: phy@1a96a00 {
 			};
 		};
 
+		adreno_gpu: gpu@1c00000 {
+			compatible = "qcom,adreno-510.0", "qcom,adreno";
+
+			reg = <0x01c00000 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "kgsl_3d0_irq";
+
+			clocks = <&gcc GCC_GFX3D_OXILI_CLK>,
+				 <&gcc GCC_GFX3D_OXILI_AHB_CLK>,
+				 <&gcc GCC_GFX3D_OXILI_GMEM_CLK>,
+				 <&gcc GCC_GFX3D_BIMC_CLK>,
+				 <&gcc GCC_GFX3D_OXILI_TIMER_CLK>,
+				 <&gcc GCC_GFX3D_OXILI_AON_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem",
+				      "mem_iface",
+				      "rbbmtimer",
+				      "alwayson";
+
+			power-domains = <&gcc OXILI_GX_GDSC>;
+
+			iommus = <&gpu_iommu 0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			status = "disabled";
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-480000000 {
+					opp-hz = /bits/ 64 <480000000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-540000000 {
+					opp-hz = /bits/ 64 <540000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-600000000 {
+					opp-hz = /bits/ 64 <600000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-supported-hw = <0xff>;
+				};
+			};
+		};
+
 		apps_iommu: iommu@1ee0000 {
 			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
 			reg = <0x01ee0000 0x3000>;
-- 
2.44.0


