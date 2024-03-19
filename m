Return-Path: <linux-kernel+bounces-107224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60187F984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE31F21833
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1057D061;
	Tue, 19 Mar 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WnKdGDY9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE053E25;
	Tue, 19 Mar 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836589; cv=none; b=Dy0ynj0KG4yvxv5VfaQJYBKr3KpBieC+Fa9ks/Q+WEWbTjzDQQ0GdyBCx3Nt5XTOM62pLnRoNyVCtbW46kFOe8LAq5alngFHwFCSBVH1c47mqsGKCIgxwFlWAGaoXg5qxp0ljUmr7r5nUDnFSKaFgtpzzw5rp9WGEo4zI9VPCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836589; c=relaxed/simple;
	bh=j2a+fTDMVSBS7rEaJXfVLc+dzulfLunaNx5cADI5ti4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Scx6JKoFl9MkT7MJYTLZyF4EIstYonG6CmkVGPnPLp8zRRYySpue/5O3tgteEPqhmonLBFswtgPi+oNtiV4ZxjNHtYKXJ/pqMjUB9EUt09T7StO+XLouOaWj6XO1/+LtdOdrXjlAONyzvxeBjMqRW1ZVRwhHtOhoa6sR7mNHJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WnKdGDY9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B55F15EE;
	Tue, 19 Mar 2024 09:22:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710836559;
	bh=j2a+fTDMVSBS7rEaJXfVLc+dzulfLunaNx5cADI5ti4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WnKdGDY9sUQJC/OaZKt9WkDaMF1FlAmPSqXYkh2g1BDXpsv52hMv3CdXXc86njtpt
	 n2o+rp6qVDYzNckEnTeKUYIWH4iwHWuBD1nFp4jchlFUheqdgXRGADIOycVtaoZ5y/
	 XNtzhDhmFDKGZbYNeaXclT2r9E05irJmbT4pJXkg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 19 Mar 2024 10:22:38 +0200
Subject: [PATCH v2 3/4] arm64: dts: zynqmp: Add DMA for DP audio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-xilinx-dp-audio-v2-3-92d6d3a7ca7e@ideasonboard.com>
References: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
In-Reply-To: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=j2a+fTDMVSBS7rEaJXfVLc+dzulfLunaNx5cADI5ti4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+Utjsbbzif7kYkgC3a3LIeGT0tK1XhAiEMFyC
 wvW8uwKxoqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZflLYwAKCRD6PaqMvJYe
 9W7OD/9dXHV2nZOs/P2aEWzcGt5Bbju6MhcKZbyAysKe+9PDGkfkdjCI+H51HeWUOUJGbjL8os7
 XjZmtyRZkuRTf8qlQrYKgrRfym4waSFtPxVDiPgW74D96TAmuZiXldmSywn0J3o/dI4c3ylRyGS
 S74ZR9uxr/iCi7BCUx0i3OxNHllRsz891PWnLehp1AUtZXo2sygtit9DhvtGRF57SyZ9DXJfNAH
 PnywvPtkfNCk8gJSYO26nldhfxhmxHVycHkLGt2/hdRJKWqS+8eVzgyl4+Wwxatp88hNGR3XkXQ
 i2GtS2fnKHZBo4m41iad7092NSa8awEPmlFDVzySW5IWsVnnk/3VU0flbtNY6pOJtfXqWMDaCPf
 JlTuyuQ4cd8Xth5dycQ3Jez2HVlSwfItgJsG3JuH8KiP10D/ylVO2lAhCIYO+ofakGu5yAy215f
 ojkOdHXF4cPcB3R3s1SN6aRF3k6aLXeIKuBwBT6G/21lntMpALZjLnlozKXRjTqBogVvEnuVo1j
 CAOnjeEOEO7NaWsu15ebPmqAOf8CrAKS8eoP8HlYAAYVobF2vTu/D3OoQIM8Se8PGRNg3GMfD4A
 WVY5s7LCoG6zY8LnNMn4cfv00Uw7JpnszLQBcZyQORqtaFVFVVkjrQ7v1vOQJEOQ8aOmMyjwOgQ
 opV7tYtfJS6ubUg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add the two DMA channels used for the DisplayPort audio to the
zynqmp_dpsub node.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index eaba466804bc..811d80cbf4c5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1036,11 +1036,14 @@ zynqmp_dpsub: display@fd4a0000 {
 				      "dp_vtc_pixel_clk_in";
 			power-domains = <&zynqmp_firmware PD_DP>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_DP>;
-			dma-names = "vid0", "vid1", "vid2", "gfx0";
+			dma-names = "vid0", "vid1", "vid2", "gfx0",
+				    "aud0", "aud1";
 			dmas = <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO0>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO1>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO2>,
-			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>;
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO0>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO1>;
 
 			ports {
 				#address-cells = <1>;

-- 
2.34.1


