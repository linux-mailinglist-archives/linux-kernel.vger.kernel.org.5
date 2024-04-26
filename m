Return-Path: <linux-kernel+bounces-160425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B18B3D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536901F21159
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626D16FF36;
	Fri, 26 Apr 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d6pd9TaQ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71816F271;
	Fri, 26 Apr 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150617; cv=none; b=uCnO/n7ZIsWIE5963NUWDo2MiDiJC51yWMtdPRqrqJxTpzOI2wsJTRTXDOqfn6rqtJZh1+wQDorkHA9h5o963XlxlrbBwc+fsvEFqmfsisf+nTodc3mRB/wyJBSL6FK5G4DXTN2LDWFOy+wC0igh4oNeUo1KpRefwNdAIrMQGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150617; c=relaxed/simple;
	bh=XYFPk3FkQ7DoDucDYSBcdACRbcapzxVltYw2E7kA37Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMbqtthrEzusFLvGqR1M2Kfa550F2FcaqCIrGBChfZ+l09jmrsxOUiC9GvX/rA8tJxO2f6FI3Ahu28QQqsTx9+kfLnRADGNFE7MPYcGK930bHIIP59P87uVYlvBG0A1zAhOHbwTudsrjFTUfyFrDyDSC/qgF2UrcNWsgcXteJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d6pd9TaQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2FD7FF80A;
	Fri, 26 Apr 2024 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UBvOzoqMa/jwSCZa3hO8uAMEhEb6gozqHJClVGlszs=;
	b=d6pd9TaQuiuO7ZYfLMgtn/1ztB6l8swWyCQvdAauc0eBgcA+oRBNRToKsNVxgQ0accHkIT
	Cwb+PvKNffPxwIQsme96rvglK88wwQT1lo2thCadQl2mi3IcSxVnV0YSDj1KTF3PTUvBj4
	qlUmQN206+nBU6/6IwNj/nsvuuS6h460WjevvaUdX96wYt/BUN0gRqPWVLOOY1esiRhY7Y
	QHDwco4JT4uOd0RQaqawrhXRLS5A8k7dupvyGRi+IJd9pxLg9rSZUYy2QMVdVIXva4so61
	xrZ8GsFHyk8az3E2Q+txwh30BZckK8aMey1nqpyEhowROuswDIUNKvUf/kPohA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:41 +0200
Subject: [PATCH v2 08/12] ASoC: doc: dapm: describe how widgets and routes
 are registered
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-8-87b07547eb5b@bootlin.com>
References: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
In-Reply-To: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The small paragraph describing how to register widgets is incomplete (does
not mention routes) and mentions snd_soc_dapm_new_control() which is not
really used. Moreover it appears as a part of the "Virtual Widgets"
subsection.

Replace it with a detailed and current description of how widgets and
routes are registered, mentioning both static declaration and runtime
registration. Also make this a section on its own.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 58ef880ac8b6..4b094c3d7942 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -251,8 +251,42 @@ a virtual widget - a widget with no control bits e.g.
 
 This can be used to merge two signal paths together in software.
 
-After all the widgets have been defined, they can then be added to the DAPM
-subsystem individually with a call to snd_soc_dapm_new_control().
+Registering DAPM controls
+=========================
+
+In many cases the DAPM widgets implemented statically in a ``static const
+struct snd_soc_dapm_widget`` array and the routes connecting them in a
+``static const struct snd_soc_dapm_route`` array in a codec driver, and
+simply declared via the ``dapm_widgets`` and ``num_dapm_widgets`` fields of
+the ``struct snd_soc_component_driver`` so the driver registration will
+take care of populating them::
+
+  static const struct snd_soc_dapm_widget wm2000_dapm_widgets[] = {
+  	SND_SOC_DAPM_OUTPUT("SPKN"),
+  	SND_SOC_DAPM_OUTPUT("SPKP"),
+  	...
+  };
+
+  /* Target, Path, Source */
+  static const struct snd_soc_dapm_route wm2000_audio_map[] = {
+  	{ "SPKN", NULL, "ANC Engine" },
+  	{ "SPKP", NULL, "ANC Engine" },
+	...
+  };
+
+  static const struct snd_soc_component_driver soc_component_dev_wm2000 = {
+	...
+  	.dapm_widgets		= wm2000_dapm_widgets,
+  	.num_dapm_widgets	= ARRAY_SIZE(wm2000_dapm_widgets),
+	...
+  };
+
+In more complex cases the list of DAPM widgets and/or routes can be only
+known at build time. This happens for example when a driver supports
+different models having a different set of features. In those cases
+separate widgets and routes arrays implementing the case-specific features
+can be registered programmatically by calling snd_soc_dapm_new_controls()
+and snd_soc_dapm_add_routes().
 
 
 Codec/DSP Widget Interconnections

-- 
2.34.1


