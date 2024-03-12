Return-Path: <linux-kernel+bounces-100037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE58A879126
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059D61C20F71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C567826D;
	Tue, 12 Mar 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kx///rIW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9178670;
	Tue, 12 Mar 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236506; cv=none; b=WSPMO+rM2+f0yPT3FDWoiucTzn675TtrUGWp/3JwazB7iAAV8nqiwgxh92MckrhCYwlwrPtU10wT0eMHdJXh0QP9hwbJLEKB97H5+sREOJ48/SdSgIow5Fz2ulLYx7/Slfilk2d/gUodpG3jhzVgPusLzMd25paBhN3e+sRJsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236506; c=relaxed/simple;
	bh=eqk80KT5Hg0+A1d1PLo19GF//BADE5/tRXTctPDKUYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUXrZ09z1u8KhVsFMrTX3kbXOjzsS5Two+3fVEqSZ+vaG2Oyo2stDYF4vq9rsyD+TGf4twL1ct+RJlcvs5ealix3dJbz8YmHK5rtCiViR1RORxzhWdZl0XhTTem4cLYmLiYldej1uY0Q2tS5htrjg1OLEr4eLHMO804X3Lo5wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kx///rIW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D66AD13AC;
	Tue, 12 Mar 2024 10:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710236475;
	bh=eqk80KT5Hg0+A1d1PLo19GF//BADE5/tRXTctPDKUYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kx///rIW2/IU8urV9myiMh2wZ5sU3k0F7F/IwOVKKHosnMWgZ2jKfkT6C+fBH6SmM
	 Q5KJwNYE0m4JaX0OTKa/j6VN/nl0r+METdxc7r1rlEu+qNSDIEpZIFcBPcNp6ZOmrc
	 LdOtzlvH3Pu6vEufySVRiW0xCgghFO7wo+gSTndk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 12 Mar 2024 11:41:03 +0200
Subject: [PATCH 2/4] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio DMAs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-xilinx-dp-audio-v1-2-696c79facbb9@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=eqk80KT5Hg0+A1d1PLo19GF//BADE5/tRXTctPDKUYs=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl8CNLSFAaEuuv54MbSbVeCFWrsPfOUtznqja5v
 V1IAykhV6qJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfAjSwAKCRD6PaqMvJYe
 9QXEEACuwaAocwwGrot8pawUgEAzFpXRCUg59ItcIBz6LhuMfoDFgbGiAtgwm9Mkt43NnDFtP8L
 Qr8A0HjYYTv7GCfV+MYuzUMhJ5Zf6ozXEK7pSMfiTPHSegCVf5bR2XTto/HyJWyDY/n4lPzBpB5
 RGbznfrP5PjmkHk40dR3bPoW3RH3oCPTjmdBwCfevr3a3T5+tVVxOxaRQHHF0jkwlxW3ny7nZEr
 DjtS/kosA+bPQpRgm20OWRwzo/YIIyRu/atndxvpySMsJFv65rR0Xyv6bgCGbvnZRbIYS53WgY1
 zsZTkvsKkkJQqMmwzHg7cLTBC0imhRAjwf95U55jqGXaNfBSyywiwk9pAWsXhDWrgE0pILGJKBm
 uvmYvrpxlr2yQ0N0soPFi3OsJkdybF6TvHw97qtX1MKM1fdkiQxic6BrcnsWcr/5n8B8hP8NwdI
 tT5JOrK3yTBC+DF07nr6yFa13jbSNQP3Ys+9GgNQnm0lE/9ARMYMbgE4jqMVpT5AFGJY5B14Jhy
 Tru6f5QDkjZ0bPNfVNJ2e5llYqFpO6VqBJF9XqrXAhG/SRHT/hcWP1NqCEE6BCcZQQpxu6RRL5z
 AZCXILfC0ExU1IRjUHmeDI07XdqoE5UvhVzit/PWzCbsCL6nCCpU90UdB4wNDJgebZqiIyD+jpZ
 bRuXeN3dxrK5DxA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The DP subsystem for ZynqMP support audio via two channels, and the DP
DMA has dma-engines for those channels. For some reason the DT binding
has not specified those channels, even if the picture included in
xlnx,zynqmp-dpsub.yaml shows "2 x aud" DMAs.

Add the two audio DMAs to the binding.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
index 554f9d5809d4..8a56ab923cca 100644
--- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
+++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
@@ -100,12 +100,16 @@ properties:
       - description: Video layer, plane 1 (U/V or U)
       - description: Video layer, plane 2 (V)
       - description: Graphics layer
+      - description: Audio channel 0
+      - description: Audio channel 1
   dma-names:
     items:
       - const: vid0
       - const: vid1
       - const: vid2
       - const: gfx0
+      - const: aud0
+      - const: aud1
 
   phys:
     description: PHYs for the DP data lanes
@@ -194,11 +198,13 @@ examples:
         power-domains = <&pd_dp>;
         resets = <&reset ZYNQMP_RESET_DP>;
 
-        dma-names = "vid0", "vid1", "vid2", "gfx0";
+        dma-names = "vid0", "vid1", "vid2", "gfx0", "aud0", "aud1;
         dmas = <&xlnx_dpdma 0>,
                <&xlnx_dpdma 1>,
                <&xlnx_dpdma 2>,
-               <&xlnx_dpdma 3>;
+               <&xlnx_dpdma 3>,
+               <&xlnx_dpdma 4>,
+               <&xlnx_dpdma 5>;
 
         phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
                <&psgtr 0 PHY_TYPE_DP 1 3>;

-- 
2.34.1


