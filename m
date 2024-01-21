Return-Path: <linux-kernel+bounces-32164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0153835783
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589DC281DB2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840438DE1;
	Sun, 21 Jan 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2qZz7Ie"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E238F97;
	Sun, 21 Jan 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866351; cv=none; b=Lmtw/V/IDHnihxjdfnhviTLN4iokSKwNMDIpopuviqgjldwzj9cRtBc8JzzunQIHeZ4IwvDm4kccIM/mh809pKfaVVyYkVXsuNRF13PdzUkmNayzL6wmF7yBZQdUt4P5NBIQ+OgHkFQTIqeZqABA+XxaRUVynxdscGX8KeYyCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866351; c=relaxed/simple;
	bh=jiG8dNM4EeCqicvJq35Mwv8i8fdhtFDvlbFQpXu1o1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ga3ZdKol7jUZ6qlUJbIQUJtYkji0OP3/FyhKFtAaIAusJFr5/DNy+I4MWJXiiqSCXAKJuRnMg2T9Id0DuDYVbzHgC0Nrx7JkPXLrd6dPR9hGKg9+UIR7xjLfjMP6ja0eEJ1mzeKzRokFzTaFBYOSH8uI/MK/QMcW6AG2MiIpAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2qZz7Ie; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3046221b0eso22095266b.1;
        Sun, 21 Jan 2024 11:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866347; x=1706471147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSqr1Vk76fk8EOA0eDt1nJ6pOVxZRQ6awuBBes4l838=;
        b=L2qZz7IebjbkAMEBRU9dwlq/SpT2DD1LnR9sfr2N7iV1c+7XxIrj9Rt+sXUl7Vwiq+
         T53DUX5zr3TnRFnZGydxr+uzbG0vGu+W/zuPX1IXPGTHMCBE+OWiOO6MJ8zlSl3qo4lj
         QMmJn0+PdgY+aFYnC0GsKVhXZyRT8DFIrvBSBDHhIbG+0mgrYxknV4Ijj9A/rwHubgHV
         9zGNW1pcyLPr9jBwfTBUNwhFFCqV9Y73oLlur5KNs1+kCtfkJs5jn5om/lC4rUAdpW/P
         WClB6KhBoE871yhDbA16A95SmTTZyKckweANK786oysb7cneZNvxVZRl8h2Pb5cKSQPp
         FqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866347; x=1706471147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSqr1Vk76fk8EOA0eDt1nJ6pOVxZRQ6awuBBes4l838=;
        b=W+Gp8K6psLyOASJlwxmqLgP8MfPtscnbGfQFFpLtsiC639oMBoPHN3y/BpPq5ZoTp0
         oM+2AaG+wIdOq0omxKAAyWQvzw5B3CjRqUXYpDnghZTocX0TCygGtVGYv6hrgtKOm+eE
         LYQgcbY1kysDq2DzmhYOz/3hnGzpZqDwL8OruzECDpxhFzcl0S3yLsVXv9Dlh7H4NjTU
         SG3vmqxUgzG0Ve0UZJpkmDJk61IUMPh3OzDoofjHTFnUYwdgySqKEdGNtm0SCPFV0yeF
         N0AHCC/UHqAQ2p/9Y5C4spEH/VYoGRck5J5ZnTG5TYLSCgyP4FBfCV4/+NG7kHnip98K
         8pOQ==
X-Gm-Message-State: AOJu0YwEwT1uDbc/SYY341MAhbxWKJu1memlpGUB8TzpGTGw2mOwYNfN
	VrcAu/YUpntBP7tgmIX384Uef9r8tDA1JQBSbT9Jl07ppx/ORI+t6z+xsSeFlBY=
X-Google-Smtp-Source: AGHT+IGsCmZv1novA+/rF0kwFG7flhcKuCUpSzseVeBQ6O+PKFUlzXtm9pZWAynzdjUeKyHkgZsWqw==
X-Received: by 2002:a17:906:f24c:b0:a28:fc03:f199 with SMTP id gy12-20020a170906f24c00b00a28fc03f199mr1456478ejb.107.1705866347749;
        Sun, 21 Jan 2024 11:45:47 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:45:47 -0800 (PST)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm64: dts: qcom: msm8976: Add Adreno GPU
Date: Sun, 21 Jan 2024 20:41:04 +0100
Message-Id: <20240121194221.13513-7-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121194221.13513-1-a39.skl@gmail.com>
References: <20240121194221.13513-1-a39.skl@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 2d71ce34f00e..765c90ac14cb 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1068,6 +1068,72 @@ mdss_dsi1_phy: phy@1a96a00 {
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
+			clock-names = "core",
+				      "iface",
+				      "mem",
+				      "mem_iface",
+				      "rbbmtimer",
+				      "alwayson";
+
+			clocks = <&gcc GCC_GFX3D_OXILI_CLK>,
+			    <&gcc GCC_GFX3D_OXILI_AHB_CLK>,
+			    <&gcc GCC_GFX3D_OXILI_GMEM_CLK>,
+			    <&gcc GCC_GFX3D_BIMC_CLK>,
+			    <&gcc GCC_GFX3D_OXILI_TIMER_CLK>,
+			    <&gcc GCC_GFX3D_OXILI_AON_CLK>;
+
+			power-domains = <&rpmpd MSM8976_VDDCX>;
+
+			iommus = <&gpu_iommu 0>;
+
+			status = "disabled";
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			gpu_opp_table: opp-table {
+				compatible  ="operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					opp-level = <RPM_SMD_LEVEL_SVS>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					opp-level = <RPM_SMD_LEVEL_NOM>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-480000000 {
+					opp-hz = /bits/ 64 <480000000>;
+					opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					opp-supported-hw = <0xff>;
+				};
+
+				opp-540000000 {
+					opp-hz = /bits/ 64 <540000000>;
+					opp-level = <RPM_SMD_LEVEL_TURBO>;
+					opp-supported-hw = <0xff>;
+				};
+			};
+		};
+
 		apps_iommu: iommu@1e20000 {
 			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
 			ranges  = <0 0x01e20000 0x20000>;
-- 
2.43.0


