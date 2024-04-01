Return-Path: <linux-kernel+bounces-126904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B6894437
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C421F237D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F651C4F;
	Mon,  1 Apr 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMgrSLhB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761FF4F897;
	Mon,  1 Apr 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992128; cv=none; b=DWY/6QAyY0U7uM2PJRNQOpZ21EnBv43AOlC0QhsfLh1nKF7QVRm0oIwN8jYC95E8ghoz2+qY5RlwZetwr/wWUmuy/dOHW2YL/xJN1zLEgeGPT/sE3JV4uIdptad4LpBgjb4jvrF9LD3Y7Q5vkt9BK3XZ8cvBdopJ4XBt+d5rQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992128; c=relaxed/simple;
	bh=sW3zpSlIGwFyAynd9cDIq/nNSDBBXDSfPehTUPeVDdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cA13JswhlA3XrFcPpTrBOMobbspfj+/Io6+nff0EGONbqlhi4rVullO9/pAL+hrz1DjyVYzVCjwAy3plG9p42tNjiVVu/0/FySrqFxbtE22guweX1Vmtle2NrNzqpmSInLu8ndblP8mfJbY0dZ7eqSxW7jWXuPSAoZJzAfoxbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMgrSLhB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e6777af4so6985727e87.2;
        Mon, 01 Apr 2024 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992124; x=1712596924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA4GurxP5PJibrlcvf5UpY/AeoXbypPT8llBBvZXFbQ=;
        b=TMgrSLhBRXrIOwe8S3sg31s/IbhhydpV5EJzlH7iRg2//+rXZW82O7ztoKnGZSryAW
         ZtBBCbvsf5gYCAPZ274onoNLsJ/8adjE4w8+jLv3XQoazZKdIaVGyBzEzptcPV/013RZ
         vn/QftOVM5bIIkwSxoJ2j1PA+byyRI735nEl0dmtPKNd5FiSKlVGyaf4hRWIIPqy6Wk/
         VSrvWcXoONK03WYLduw1T/SrcfsA722nDSkzjoxhw22dSi2jOQ8kAw07x5iHeWx9z/BU
         7yiadJTxRXYhJ/NHwIfCaJbnB61wAoJZkJZH1K+fxCPYAEgVw+v68u92E2jOwWGU/GXp
         R+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992124; x=1712596924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4GurxP5PJibrlcvf5UpY/AeoXbypPT8llBBvZXFbQ=;
        b=r3aL6MhdmQIw/TWNtGeaYTEu4ZTkWCen/5oL+pG20vSC30rOAb5CpURU7LR5z8wq1M
         XrjyiCkRii6crEhToavCKfuvSU5M3egdBlJLTHFKztjpteK0ooH+h6m2MQSOW91UKN13
         rPJN81skc2BQ25pAUBtKu5XaMiFO4uGkO1by4Pz6uxrtp4YXaMfMWG2Pd9Lto49JqIOV
         IkZTAoAAWj3edEeRio9H6P2eoFUZo5o+zNLLRjTHzHfBNW7n2LIOjtACl0dnpqJPmP5P
         1wBiNc5QBUQZxKyP/xz8PmfyzSODOJNEXYmBh7A3nFcz0mx9+vMV4xr6QieSy+TNsIP+
         mSLg==
X-Forwarded-Encrypted: i=1; AJvYcCXSzF98dP0I9952hc39tEYKctRWy3iW6KPCp2yfCWM/h9Pgcy4r+BQd1Uxx29k/VoFor9fI26O/P6n4Ae2KyhKlnLXODVu+iFgy1QeqxoEJqscnIS+JxTci5JqHjUwWem4hEqNQIkGfRnzNCR2pZLc+KAOWh5wqT2vlANl6C+jMAimavi8xc/A=
X-Gm-Message-State: AOJu0Yzwuh3ismftkuzJ2J5ghCJ8HOZEvEN14y4fpRls4xziZCcwQlOI
	r64tek7QSr/KqYuw3bH3dqvTruUKvx0cD+0drMkW7D25DB0p6ww7uZRVxOU93Pc=
X-Google-Smtp-Source: AGHT+IEOnvv5tSnWQVYJHrrRJKN+SrqLGIYoAeRwMKHNL4dudLBnq+OGeUnQSsqAgdXUdMcqzGEqlA==
X-Received: by 2002:ac2:5106:0:b0:515:952b:7886 with SMTP id q6-20020ac25106000000b00515952b7886mr8202042lfb.61.1711992123718;
        Mon, 01 Apr 2024 10:22:03 -0700 (PDT)
Received: from localhost.localdomain (ccu40.neoplus.adsl.tpnet.pl. [83.30.144.40])
        by smtp.gmail.com with ESMTPSA id xi7-20020a170906dac700b00a4e23486a5dsm5347949ejb.20.2024.04.01.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:22:03 -0700 (PDT)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: msm8976: Add Adreno GPU
Date: Mon,  1 Apr 2024 19:21:52 +0200
Message-Id: <20240401172153.9231-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401172153.9231-1-a39.skl@gmail.com>
References: <20240401172153.9231-1-a39.skl@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 6be310079f5b..77670fce9b8f 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1074,6 +1074,71 @@ mdss_dsi1_phy: phy@1a96a00 {
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
+			status = "disabled";
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+
+				opp-480000000 {
+					opp-hz = /bits/ 64 <480000000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+				};
+
+				opp-540000000 {
+					opp-hz = /bits/ 64 <540000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+				};
+
+				opp-600000000 {
+					opp-hz = /bits/ 64 <600000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+				};
+			};
+		};
+
 		apps_iommu: iommu@1ee0000 {
 			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
 			reg = <0x01ee0000 0x3000>;
-- 
2.44.0


