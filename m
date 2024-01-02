Return-Path: <linux-kernel+bounces-14255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B24821A09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D71F226DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64AE544;
	Tue,  2 Jan 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZTKcvSZS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3BD298;
	Tue,  2 Jan 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704191887;
	bh=cm7tGZegvFx11DaYuyNUHAKQJUZbqThwfuueF4e2NcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTKcvSZSPhwE9At3kqI+V7j+jbxAhit57MypSrzuU18aebz35/DRLJSDNsZihDq8o
	 xMwPz52VEjaPjvZP+8wyoQK0TAKilLm0LRRuz/heeCRpyburW0hWXtsqVeFpJczkeq
	 QuPPi5wj8Bqyva+XW675cXItJ5/N/UpUC/if8gjgD4L86bFaoGjEaFWtM94iLVZ0oI
	 GIqCTQqJO5F4p1f1nNyKoNBd0eeyb8J77tKtrE1V3nLFpTa4XA0lCB8lHgpndhaGhW
	 RfWe7Exr0Zqae57XiMOiWFjGXzkBQ26nOlplwlDuVlQd6fzDAUxPMzkNEPDBC7al42
	 hII9I30piTpSw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B25BE3780FC7;
	Tue,  2 Jan 2024 10:38:06 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	matthias.bgg@gmail.com,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Max Staudt <mstaudt@chromium.org>,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
Date: Tue,  2 Jan 2024 12:38:01 +0200
Message-Id: <20240102103801.268647-2-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102103801.268647-1-eugen.hristev@collabora.com>
References: <20240102103801.268647-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Add JPEG encoder node.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Max Staudt <mstaudt@chromium.org>
Tested-by: Max Staudt <mstaudt@chromium.org>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
[eugen.hristev@collabora.com: minor cleanup]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v2:
- renamed node
- reordered props

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index e451b6c8cd9e..8e57a7be67ad 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -2054,6 +2054,19 @@ venc: video-encoder@17020000 {
 			mediatek,scp = <&scp>;
 		};
 
+		jpgenc: jpeg-encoder@17030000 {
+			compatible = "mediatek,mt8186-jpgenc", "mediatek,mtk-jpgenc";
+			reg = <0 0x17030000 0 0x10000>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vencsys CLK_VENC_CKE2_JPGENC>;
+			clock-names = "jpgenc";
+			iommus = <&iommu_mm IOMMU_PORT_L7_JPGENC_Y_RDMA>,
+				 <&iommu_mm IOMMU_PORT_L7_JPGENC_C_RDMA>,
+				 <&iommu_mm IOMMU_PORT_L7_JPGENC_Q_TABLE>,
+				 <&iommu_mm IOMMU_PORT_L7_JPGENC_BSDMA>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_VENC>;
+		};
+
 		camsys: clock-controller@1a000000 {
 			compatible = "mediatek,mt8186-camsys";
 			reg = <0 0x1a000000 0 0x1000>;
-- 
2.34.1


