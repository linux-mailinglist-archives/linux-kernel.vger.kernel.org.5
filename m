Return-Path: <linux-kernel+bounces-6964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C2819FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A593283884
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540535895;
	Wed, 20 Dec 2023 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xtpP4bgf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE460374D1;
	Wed, 20 Dec 2023 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703079189;
	bh=/UPfNwo0qoGJbrXtvl2TR/jus2hvpz31Qe5IC0w5A2c=;
	h=From:To:Cc:Subject:Date:From;
	b=xtpP4bgflfX1fY3Td2eH9fzxt0R8XHPB2Ys/fVeu10em5VQI3vV1hsRTjFXSppnkF
	 ceuac2A+CKLBbmwW0Oxegbd+RjBKJJzHJILBfY04dkkFLu99ri8LX+rWfgSLtV31tC
	 4wR698rKUKmyjvNylnfZj52cooP+7cKSMqSnlrXS8HAW48LVvs31Oz5omyzkeqbkx2
	 aZlpsEAD3eVAhLQaoH9Jqn7FMoHg5WptJo+VvdACwUCcEkAA2dEdEPdYPdAwynfCCd
	 wryarHvNPy849UyTaU+H1NLHWarHUvpl87I4l3ljo7ebtUHJ9aMVB+HOxZrLvSn1D6
	 xC+eAn3hrFBMg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2EAD93781F8C;
	Wed, 20 Dec 2023 13:33:08 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8186: Add video decoder device nodes
Date: Wed, 20 Dec 2023 15:33:02 +0200
Message-Id: <20231220133302.39411-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunfei Dong <yunfei.dong@mediatek.com>

Add mt8186 video decoder device nodes.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
[eugen.hristev@collabora.com: minor cleanup]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---

I based this commit on top of the video encoder patch series.


 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index ebd07bf3d9d2..e451b6c8cd9e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1959,6 +1959,43 @@ larb11: smi@1582e000 {
 			power-domains = <&spm MT8186_POWER_DOMAIN_IMG2>;
 		};
 
+		video_decoder: video-decoder@16000000 {
+			compatible = "mediatek,mt8186-vcodec-dec";
+			reg = <0 0x16000000 0 0x1000>;
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+			iommus = <&iommu_mm IOMMU_PORT_L4_HW_VDEC_MC_EXT>;
+			mediatek,scp = <&scp>;
+
+			vcodec_core: video-codec@16025000 {
+				compatible = "mediatek,mtk-vcodec-core";
+				reg = <0 0x16025000 0 0x1000>;
+				interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu_mm IOMMU_PORT_L4_HW_VDEC_MC_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_UFO_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_PP_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_PRED_RD_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_PRED_WR_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_PPWRAP_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_TILE_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_VLD_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_VLD2_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_AVC_MV_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_UFO_ENC_EXT>,
+					 <&iommu_mm IOMMU_PORT_L4_HW_VDEC_RG_CTRL_DMA_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC>,
+					 <&vdecsys CLK_VDEC_CKEN>,
+					 <&vdecsys CLK_VDEC_LARB1_CKEN>,
+					 <&topckgen CLK_TOP_UNIVPLL_D3>;
+				clock-names = "vdec-sel", "vdec-soc-vdec", "vdec", "vdec-top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D3>;
+				power-domains = <&spm MT8186_POWER_DOMAIN_VDEC>;
+			};
+		};
+
 		larb4: smi@1602e000 {
 			compatible = "mediatek,mt8186-smi-larb";
 			reg = <0 0x1602e000 0 0x1000>;
-- 
2.34.1


