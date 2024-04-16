Return-Path: <linux-kernel+bounces-146300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360448A6353
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E688728276C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF626CDD2;
	Tue, 16 Apr 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iLYz7/9Z"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA84084C;
	Tue, 16 Apr 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247018; cv=none; b=QCGjz1L8sDq+1q4OOaWzXwV4+qa74la/S0yfWZ1W9i9BYRCOfR/S3pNH66M9vKhjJV+UFGGhy4EuzrCK0pMBoiNE6YfXEnXNWKcTO9VnJgsZmz3B7FX6pFPIumlwu1mpjbu9OMf+SqyNda6WDnE84zIkx7rNrMkknA7pSzcd/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247018; c=relaxed/simple;
	bh=L4Q8h5qQWx5dAIva59g5Es5n92kkIF6x/3ausbyFZko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgUS40SN1SIh4qwfGS+TX8zvlc4+kcvk5HPL5hTrzgEG0lokbJ/oIWqB32O5JAMHbQgjCr214+mdqYHozrvM7FS+Vj2I2V+gfRzCp6a85bM/mHASZsNN7vOoo+1DVB8Ug7Vj3xVLy5XSabSIkphSbiAK9tcY1Vms32MKN8+irGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iLYz7/9Z; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C331240002;
	Tue, 16 Apr 2024 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+odmWYEPbcdsslwrc46eJVEfN2ipmnpIcCgFwF/F7w=;
	b=iLYz7/9ZMvkCIMM2/BvfJiic6TwvoeyW5nuMh1JFFsjoL3KJyP/yAep3On8eLo3npWV0ar
	nsdV8tG4Q9bzKBeN6LlbfyaMpM6qwZGMq9oVOXu1ZxK/q8TrrCebmRDioL/n3QgttsUCDm
	h5YLKoPwpoEzWUhGdjihTT4F7q7XxBre+ST+qM8gueuyqHRx7DMKLg1VYIjzND/pS2Vtof
	PdUbjEuGyR5sjSZywQ4CYQSWKtWZV6DTzASbDU9YkkLaAu9jp9VVVHhwU7pVsJVze41oLz
	o0alzmfKMXovN1wiLR0ttIrY5QyJh1/ihdkcPflXWDfvjVnN9EFp27R4hy3C/Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:14 +0200
Subject: [PATCH 08/12] ASoC: doc: dapm: describe how widgets and routes are
 registered
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-8-a818d2819bf6@bootlin.com>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
In-Reply-To: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
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

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 3a2fde1d31bf..3aca913c99fc 100644
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


