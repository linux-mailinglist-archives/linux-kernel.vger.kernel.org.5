Return-Path: <linux-kernel+bounces-782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68F8145F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B52B22C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD332DB76;
	Fri, 15 Dec 2023 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GtEIaGzI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D428E3F;
	Fri, 15 Dec 2023 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702637170;
	bh=UNr7RTkECrw2TxwP67coHpk8jV76hI6PEfp00kugbrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtEIaGzILk5FFGMwWx9fvBPAp9iHXtyDK3mpOnzpcpO2uO5vXIaA2CnnSR2WZzpEw
	 SCqkcJl54LvKv4+duzvjeGYo5YkC63Tmao2CuC77YoOIUb6qEtLBr7v31ZYK+d+JDT
	 0Rp0aem4p3JExjssdjU9TE9ySkkITrkpL2Anti4Hm7dt/5G4RmXbeGMCyEycG4mhVT
	 H5Umqz2GAdodHVnArWDJWU5YbM17PlWNfhku56sQwfR0Kzz6ScQ1Xl/IGIOZRh8jaM
	 pJGin0TH9qyVJei87hjzUl0bnJZpdTzgaqH6Wnwqpa0kTeRfxHXL2Z1jK/7Yrd4/6T
	 46aNNJU4jwLdQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C10383781FDB;
	Fri, 15 Dec 2023 10:46:09 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	linux-media@vger.kernel.org,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	Kyrie Wu <kyrie.wu@mediatek.com>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2 7/7] arm64: dts: mediatek: mt8186: Add venc node
Date: Fri, 15 Dec 2023 12:45:51 +0200
Message-Id: <20231215104551.233679-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215104551.233679-1-eugen.hristev@collabora.com>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyrie Wu <kyrie.wu@mediatek.com>

Add video encoder node.

Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
[eugen.hristev@collabora.com: minor cleanup]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v2:
- change node name
- change compatible to include 8186
- change props order
- change clock name to cope with binding


 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 66ead3f23336..ebd07bf3d9d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1993,6 +1993,30 @@ larb7: smi@17010000 {
 			power-domains = <&spm MT8186_POWER_DOMAIN_VENC>;
 		};
 
+		venc: video-encoder@17020000 {
+			compatible = "mediatek,mt8186-vcodec-enc", "mediatek,mt8183-vcodec-enc";
+			reg = <0 0x17020000 0 0x2000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu_mm IOMMU_PORT_L7_VENC_RCPU>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_REC>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_BSDMA>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_SV_COMV>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_RD_COMV>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_CUR_LUMA>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_CUR_CHROMA>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_REF_LUMA>,
+				 <&iommu_mm IOMMU_PORT_L7_VENC_REF_CHROMA>;
+			dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>;
+			clocks = <&vencsys CLK_VENC_CKE1_VENC>;
+			clock-names = "venc_sel";
+			assigned-clocks = <&topckgen CLK_TOP_VENC>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D3>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_VENC>;
+			mediatek,scp = <&scp>;
+		};
+
 		camsys: clock-controller@1a000000 {
 			compatible = "mediatek,mt8186-camsys";
 			reg = <0 0x1a000000 0 0x1000>;
-- 
2.34.1


