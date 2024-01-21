Return-Path: <linux-kernel+bounces-32159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F683576D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9BD281D23
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A9D3839F;
	Sun, 21 Jan 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mos0bxLS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A543838D;
	Sun, 21 Jan 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866292; cv=none; b=EfOkIKnXZeExc2HuEIN9/XR+FNnL7WrcS8JnPWXJz3tPMXXkhQmr+YU+sz94ggC27ZEbPQRWWJu4Cjl+znwo4Ka462co/2pEbuo1Hck83JTDNvGM3qAJcLBdMlhhgn50jdBzDkiW7ANbiu32mtW7dqPUfnf+LwDFPUCbk3wvqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866292; c=relaxed/simple;
	bh=kE6KwhmEk46EdDBF8Xa0zNV1QHs6MPTb7gv5QTBEnJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPcDvS2gMvKAsD4menav1WIMeJzva518eHFE7cZy8ns3G/3znZfq+cG65O8siAUdNl/oPCHJ2ap6GBWd+wGWc3neXTNWiT5yT4Nn7Peb6SwAjjFq5vVcXJp7JmVECYXvS5+Es0PNVk8IH7zAjYdExeAFr99mUrv63NcPRX6AwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mos0bxLS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so243011166b.0;
        Sun, 21 Jan 2024 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866288; x=1706471088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnqLSrn4btQ3vonmmCBGbb+1ntxX94Jc7ylr8L0oA0c=;
        b=mos0bxLS68NIncICCH/I7Ov65gFkSILwtstk0vU0SrNH9vOSxuL2h/nr71hWcByVH0
         sgjO147AJyT5FY96p4KcNwV7S2FZjD3mMGCCzfuDX7XKXopQd9oDfEn6FoYd09rWF+rj
         CsS/2Km126fKmnXXPk8BHHVTPTbb8eQRoUbt1dAI1HnqEY7XAcdoNM9qPjZneyYuzSD3
         3i9St9dt59vyBDrVV2Q0MnMa/dPh3Qa5eIPTzG95kLY3oIYHefjLSO88MTCY928WuQyr
         Q9OEZorTVy86pKjwCXKMCEcJB++mIESPZd8I/fB2te7eoXT0nlFzR0Tf0GT4MXuDPlno
         j6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866288; x=1706471088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnqLSrn4btQ3vonmmCBGbb+1ntxX94Jc7ylr8L0oA0c=;
        b=TjSbbZ7jBYMSeyinvzvZygyiPsyW4y9Jd8AtrNZiq85awjG7mrKNaDVzFRnGMJj2Jz
         J/wUjlm2cdxC3K2IWPJ6eiofc7EwOqoGR60mgxeb2nQlgLXxTAN+NN4XOkiPM79rPBvI
         ZrdIseXZiAEbDkRPlzosBBm+6VY0pyXbFa9h+yVY+CRemfvlV/ANbL/sMP7+ecMpP4h/
         0Ysf+bWVJEjdZdxbrnwuQoN2r003q4uT/YH82A1GK3GoEGy+aMVDrBaGKvPHmtVq3Qmp
         6w651zO9l8btEB5xo8vq72lrMjvySJpWESq+/yElLy+sqMOqTrUa0ycWIs8P6KtbtCkD
         kQgA==
X-Gm-Message-State: AOJu0YzY+ljqD3pSd6oXnwM5Poxp3IGCEcsiE6Oc4DoyjGehy0IOOd6Z
	xHOtIF6fSWTjrOzLQivYIUtcCxCEhY6Lc3x8b4R7OSLqA0gsmeuGzWSl8kQqR14=
X-Google-Smtp-Source: AGHT+IGEaNWjmJTqymB8KYil/cNyp5oM2ixT9tK89BS7eXP8SDPL2NmrSrd26a0kTLP5NWNXwHllow==
X-Received: by 2002:a17:906:844c:b0:a2c:ad93:2e79 with SMTP id e12-20020a170906844c00b00a2cad932e79mr1696389ejy.15.1705866288476;
        Sun, 21 Jan 2024 11:44:48 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:44:48 -0800 (PST)
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
Subject: [PATCH 1/8] arm64: dts: qcom: msm8976: Add IOMMU nodes
Date: Sun, 21 Jan 2024 20:40:59 +0100
Message-Id: <20240121194221.13513-2-a39.skl@gmail.com>
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

Add the nodes describing the apps and gpu iommu and its context banks
that are found on msm8976 SoCs.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index d2bb1ada361a..118174cfd4d3 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -808,6 +808,86 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x30000>;
 		};
 
+		apps_iommu: iommu@1e20000 {
+			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
+			ranges  = <0 0x01e20000 0x20000>;
+
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_APSS_TCU_CLK>;
+			clock-names = "iface", "bus";
+
+			qcom,iommu-secure-id = <17>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+
+			/* VFE */
+			iommu-ctx@15000 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x15000 0x1000>;
+				qcom,ctx-asid = <20>;
+				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* VENUS NS */
+			iommu-ctx@16000 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x16000 0x1000>;
+				qcom,ctx-asid = <21>;
+				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* MDP0 */
+			iommu-ctx@17000 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x17000 0x1000>;
+				qcom,ctx-asid = <22>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpu_iommu: iommu@1f08000 {
+			compatible = "qcom,msm8976-iommu", "qcom,msm-iommu-v2";
+			ranges = <0 0x01f08000 0x8000>;
+
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_GFX3D_TCU_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&gcc OXILI_GX_GDSC>;
+
+			qcom,iommu-secure-id = <18>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+
+			/* gfx3d user */
+			iommu-ctx@0 {
+				compatible = "qcom,msm-iommu-v2-ns";
+				reg = <0x0 0x1000>;
+				qcom,ctx-asid = <0>;
+				interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* gfx3d secure */
+			iommu-ctx@1000 {
+				compatible = "qcom,msm-iommu-v2-sec";
+				reg = <0x1000 0x1000>;
+				qcom,ctx-asid = <2>;
+				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* gfx3d priv */
+			iommu-ctx@2000 {
+				compatible = "qcom,msm-iommu-v2-sec";
+				reg = <0x2000 0x1000>;
+				qcom,ctx-asid = <1>;
+				interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0200f000 0x1000>,
-- 
2.43.0


