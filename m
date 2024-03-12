Return-Path: <linux-kernel+bounces-100038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FC879128
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63131B228C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887979B83;
	Tue, 12 Mar 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ac1FXk2B"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8479926;
	Tue, 12 Mar 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236507; cv=none; b=CgpCRu/EeoZLOktbFFYc8ouKrlwdD7VPxs46CamVrwMCw3T8VJfryLMLdXF2iwKX7CTG2iHENiXw9VjKveXxMFVsjylibMCzqObO6kg7a4rqosehqwjKjz0ytKC5JvTHkfR3yIIsc0aLV7eCVGCeUPvWpTkDIKNG8jAnBE/HuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236507; c=relaxed/simple;
	bh=j2a+fTDMVSBS7rEaJXfVLc+dzulfLunaNx5cADI5ti4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGazgnOome1P93NzwMlhQQenDyzmUwW6ZU2wkGQ9x6Yt1mwPC0GlUWabp6i0QyHo7g0o79+pKnEkcowH2lEfuKyG5PR4e+vN8mHH9vbTSGcMFKl8EyUNPO1arYHOmIiXJA+s0ZGQY26sk8M4QcED9rv9a10gGb44V5OhVzNX3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ac1FXk2B; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F4612133;
	Tue, 12 Mar 2024 10:41:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710236476;
	bh=j2a+fTDMVSBS7rEaJXfVLc+dzulfLunaNx5cADI5ti4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ac1FXk2B1qAQQkMqGZ+GPiSAtyiIQik+94LwBYT1JHvkMLASSOdwLDc9M35qTGtp8
	 LsHLFf0zwzNaqZ8bXSpdfajHfSqChmYKeIjdxsjBK4c1qGMEV3jQBF+vgrY6HgIoxx
	 zBfzbx9jPNo+O50n+lAQIxER2uLV0tmJgiAEhDaY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 12 Mar 2024 11:41:04 +0200
Subject: [PATCH 3/4] arm64: dts: zynqmp: Add DMA for DP audio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-xilinx-dp-audio-v1-3-696c79facbb9@ideasonboard.com>
References: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
In-Reply-To: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
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
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl8CNL7JHIYQ5Lh00SsbllFwWlS06TdmgtH1mHR
 Gdqb16gSymJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfAjSwAKCRD6PaqMvJYe
 9fUwD/0d+j42xGdpW3Tz+0ipWYy7jNZIsJHIbXVXX5+/KTNttSCGjp627yKTlSeHBJ6MsbyesZ6
 7I6La5WbDbrzVd9vem4K8+h82c92s95KE07KgkJJt9JawdZ58M0o33906M5YWJiPyH4ho+ybEb4
 I/H976VYwkQDWfmnVDl1kViR4Cwm2i2ozPnBWPGgT2Kz8XYhAzbLHirmxLpsfI03Fo4gg3w3yaU
 07gHi61aeyLn1aqPZYbiC+ZM2g/gE5kE2NQTFdxEzaGyJGZDLedlt+J8Yn4TD1UN+OQYcjaCsha
 hhlzyvq485p6JaxkthPt8mxUuM/fD9ePj8dCEuj9nY/J2EnHnJcNFOb24IqvmZIMurrNrzS7lul
 IMJ1Ol6lZPXo3p3n2GYuOx0kU5pbj3P81zzjypQ4m7e+OxxrxfUT3Q7+fe67e/X1toRyIpFNnig
 O8aY01wY/+jtmCqTCP8rAxN6Kku2zVRXCs6qtJBSj8eekkackk1xtvmjBuDw3teTgCGuGCKiMAg
 QAvnb8ifHC6AibyFv4F8aCbg/Nl0X3uBQfQ2h62T8LknxcoId2qMdUNa+1xZOec/vkASKDs5I3W
 IT7anAAMJG3KXUi7bkv6yJAOn5o3yl+bzBMRLbVUw0Ur4rnh2rEukm9dnVtYONhDe62YszfUZfA
 kXOQGrQSikHSMNw==
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


