Return-Path: <linux-kernel+bounces-34153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309483748F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6681D1C26FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679847A6B;
	Mon, 22 Jan 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlVgspKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796103D3A7;
	Mon, 22 Jan 2024 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956664; cv=none; b=Aocf2QCE+RLkE2yPe5E/hzdonIlER+UfXx2pumEumwvEOQ/ILGUeUGd8yu1X60sOXhM5Pr3Gd7ZKFxEuCrut2CqzGBVmKt1nXzjPLMFzIla4SSCmeoL8qAJLcpP+iQHcslpxB6Kb2eOe1wJx2iWq2pxc+rC7qozv/awN/VY5fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956664; c=relaxed/simple;
	bh=cD2X26TCLky80GPoDVS7IZ4B/2/aC8m0TzrgrR2pAl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agOyMJW6dFivkecC00edG3epAaV1ybEoIQVO06jq4UAS7J8eAvHQvYoV2BHLjIWJlwExz6knrU8i7O0x8+NTi4F3BlBYoh2UpSto/gukkXiothCRlITEbvXB4quWmhGg2JrbNv4UbTd+Aa1fJTjoM2BFWDSrFhvlMeFnGvHUxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlVgspKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2388EC433F1;
	Mon, 22 Jan 2024 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956664;
	bh=cD2X26TCLky80GPoDVS7IZ4B/2/aC8m0TzrgrR2pAl4=;
	h=From:To:Cc:Subject:Date:From;
	b=tlVgspKRLXT64aZlDEUrm580u6cSI3uGk3uXztzHuCUOuIn1ir55bWdzRhWh6mqcz
	 DXBawWcQ8oeo4s7uzmXKf13oB9svg3exL+hNwzEqGeLb4txve2/s5geRtfYIZvk+tP
	 kJWBh92NpvpZWha4whVzLj0wJAhXIsiYXFaVPVIawBuTO3oTMiMJQILUBHoKysEvM8
	 TbNhlKyBJJr735OnqYcZokBoomnYkvQVKSe+kgt7ugkYhK0C8b1d4iQycS0cfy8wAE
	 onPk31WX93H5xNgrLAboH21GZiStC0nF2lH0BghVJCFjLGLp5f8BWdBPe4P2iJPVPE
	 cO5RpXyAmhBmA==
From: Rob Herring <robh@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: nxp,tda998x: Fix 'audio-ports' constraints
Date: Mon, 22 Jan 2024 14:49:58 -0600
Message-ID: <20240122204959.1665970-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The constraints for 'audio-ports' don't match the description. There can
be 1 or 2 DAI entries and each entry is exactly 2 values. Also, the
values' sizes are 32-bits, not 8-bits. Move the size constraints to the
outer dimension (number of DAIs) and add constraints on inner array
values.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/bridge/nxp,tda998x.yaml    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml b/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
index 21d995f29a1e..b8e9cf6ce4e6 100644
--- a/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
@@ -29,19 +29,22 @@ properties:
 
   audio-ports:
     description:
-      Array of 8-bit values, 2 values per DAI (Documentation/sound/soc/dai.rst).
+      Array of 2 values per DAI (Documentation/sound/soc/dai.rst).
       The implementation allows one or two DAIs.
       If two DAIs are defined, they must be of different type.
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 2
     items:
-      minItems: 1
       items:
         - description: |
             The first value defines the DAI type: TDA998x_SPDIF or TDA998x_I2S
             (see include/dt-bindings/display/tda998x.h).
+          enum: [ 1, 2 ]
         - description:
             The second value defines the tda998x AP_ENA reg content when the
             DAI in question is used.
+          maximum: 0xff
 
   '#sound-dai-cells':
     enum: [ 0, 1 ]
-- 
2.43.0


