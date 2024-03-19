Return-Path: <linux-kernel+bounces-107223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD8B87F982
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9DE1F215AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DA7CF18;
	Tue, 19 Mar 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pcuJTK+v"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981187BB1E;
	Tue, 19 Mar 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836589; cv=none; b=NTNU+2i1u1t4VBkaMaizpLn8zvwfV14OX6fnZZ1Y8lcSdNyholN7hvi6uhRx17oxs6YJ9e0jUBzOTtWeLM638m7lESZglmIW88Wwg7ptGJ+6s6m600B33dxg83n3+o1svR1z/R4YxYHAn5Fk88GDs6J9G3aMoICIl3jGjI1h+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836589; c=relaxed/simple;
	bh=Y6RVmetmEgN8TWQrDypOJtqOBBn8R0DdUU+0mKHsKSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIZVsUxDTjAwvFq2kKfUrdLUchsd4ilwk4UBC63sSec7YckJ+6ZoUincQRCqAeHq8In4n1qj8a1iM1/kF2trUsiCyiDd3nK8f8yavN4bDv0nwo39copAkIeo6F989yQm8a//oXxTayWGeTlO1SVZRaJV2FZEPh0S7DBMPlq4dQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pcuJTK+v; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7A6F15C5;
	Tue, 19 Mar 2024 09:22:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710836557;
	bh=Y6RVmetmEgN8TWQrDypOJtqOBBn8R0DdUU+0mKHsKSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pcuJTK+vdJYFs7vayb7mfXzp4i6BuS2xCcxlHJ21wLspUgFh8C4TMm1fteUTUWbwF
	 JjmBGZietswKUr0YfnMxBjElRLSJVz7o9YKNv8/DAtqTMBqRvxelByeSqS++OIeodM
	 iNr5dQ4LQHJkehpPHrgfF8pM3PSpOZ+NxrqoycZI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 19 Mar 2024 10:22:37 +0200
Subject: [PATCH v2 2/4] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-xilinx-dp-audio-v2-2-92d6d3a7ca7e@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Y6RVmetmEgN8TWQrDypOJtqOBBn8R0DdUU+0mKHsKSI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+UtjjF56r9Z+SUr4eRYEonZvLbfJ15xHcwtSi
 jhkC69VbjaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZflLYwAKCRD6PaqMvJYe
 9UQrEACV6QbO8hdZ6rrKyFLxpH5xlL85wzqzG8z19wnxZxMQCIq8/xYnCnK9Wyza4zZZaVLYcGR
 AjC5rAoWfvBdQ0Xj8UKkgffv7pTQmy7FITnfZ/pvlzN7TOV8DPIQ+eJufdHzhL0EtNs1pmG1+JR
 oXZy2oQVyeKryu72cLrK7FypIFxy+Am1fb4xLHPvDFNcXa6KCXPshYNhx2/VOxUhdHNppftnF6g
 bXdVMK4dBqTz9fO6ZtgomHH+SDqDrRn/XZIvk/CeqBmocvAenN32VzkcvUsj5EuRcgsFx6Hb/fr
 of97GtTHggJqSyfR4HMui77EQSugwvGMiK+UJ+SYdBQNkpvUUzX7KRgpqahWNr5W8BErRdyuXhS
 kKNTXDcXIQGVfvkda1IDlXprMTFCqtlbQ1OYUTpWv4sBqEtT83Xs0TgccG15svKv84XOfvRY4ng
 sWz1Btk99Uvb6mKE59+wqyI09bU5rDn2Q6mp4bp/5QF0LlR0GhyoM19i1+Rp/BlHR8N7gS5kAVs
 nLTp5/v5UTZQe7teULekF3ziNA3/mn3tBGsaRZiV+zwLQJkkp9mFyFg63J9GQzqiJdSpj9NTery
 FE3wSZPLb+b/OWe1tK52X5lOiYdHpFxuZPjIFF9geXdriH1UTMPro8KvPcLgtSc7/lac9cc2276
 Jyc0D+k3Ko7MGOw==
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
index 554f9d5809d4..6b754d4f260e 100644
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
+        dma-names = "vid0", "vid1", "vid2", "gfx0", "aud0", "aud1";
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


