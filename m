Return-Path: <linux-kernel+bounces-146301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B968A6355
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F061F21EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5316D1BC;
	Tue, 16 Apr 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NFsDFNyM"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC26DCE8;
	Tue, 16 Apr 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247023; cv=none; b=fKC9ZOOM3mv7/AD4+tvejjtieeZrhEJdR1wSMgqOIL7sFTcdh7JouuWut4Qx+0aurJlTkykhAXOfpicmWLE0a3pfM3h5Wf7h6QuG0o6FG4og2eSzM1BAvM4UxREDQPIO0nKjXCRlj/I9r/xTLe27Q3D/QPgu/BqaAGmcPNO+jGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247023; c=relaxed/simple;
	bh=E4bs6D2WzBCW42I+wQm2fzSFtQ625oFSJYrPB7We/yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwqpKvjaQBPx60so+I/BVfGG9gobswm7mjXiW55rfzPXtn54iayTtp9wKHUPSjYZSCrb8r3y5/LenUW/BxuyvMUyMHiRHyMTLvoaaJNVbPtdVTCFt2PECWcqs8c7QJpe26VWxB+w4YmNPEokZJ7LdiLFIggEP3G9sruCbubdoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NFsDFNyM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90430240004;
	Tue, 16 Apr 2024 05:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLJKrvNE+JVwjBwnhmV7Me6gL52MTFx+b3V59KJSZ7c=;
	b=NFsDFNyMIBFnu/LnirCOKyLbxq9OfcXkRUU6aTiloDL/laEzbVEAsBVYKNXoc5/IIROO6I
	nbsDxyOo4IrQbO6J5F7v6v0wT3uWm0M/3yCM2t/KrKVEyqh3A7Vg7tKO0UdUFUvoDXF2QM
	uc86okzR4E4x6T4KNjsmu8T0s6t5KK8ldfy+bW8b0djxIMVQjHouB4Wpgv7RBrU2ugAhIL
	UqvASR+ZbRQPtQUEWCDE0qwrsTQSq67nYxOcHbWLr6JqrVAek7R3H7LstxC+r8y/wCcLeg
	SIDwX9eML5OT5jhLdAraC93EMwrvnvZaSkqHoCMeDMtwHA3Id0fc9tJrmjj+zw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:15 +0200
Subject: [PATCH 09/12] ASoC: doc: dapm: fix and improve section
 "Registering DAPM controls"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-9-a818d2819bf6@bootlin.com>
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

Extend the first paragraph to mention the {,num_}dapm_routes fields just
like the widget conterparts. Mention the route fields also in the code
example. Fix "at build time", this really means "at probe time".

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 3aca913c99fc..ab7d48582cf7 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -254,12 +254,17 @@ This can be used to merge two signal paths together in software.
 Registering DAPM controls
 =========================
 
-In many cases the DAPM widgets implemented statically in a ``static const
-struct snd_soc_dapm_widget`` array and the routes connecting them in a
-``static const struct snd_soc_dapm_route`` array in a codec driver, and
-simply declared via the ``dapm_widgets`` and ``num_dapm_widgets`` fields of
-the ``struct snd_soc_component_driver`` so the driver registration will
-take care of populating them::
+In many cases the DAPM widgets are implemented statically in a ``static
+const struct snd_soc_dapm_widget`` array in a codec driver, and simply
+declared via the ``dapm_widgets`` and ``num_dapm_widgets`` fields of the
+``struct snd_soc_component_driver``.
+
+Similarly, routes connecting them are implemented statically in a ``static
+const struct snd_soc_dapm_route`` array and declared via the
+``dapm_routes`` and ``num_dapm_routes`` fields of the same struct.
+
+With the above declared, the driver registration will take care of
+populating them::
 
   static const struct snd_soc_dapm_widget wm2000_dapm_widgets[] = {
   	SND_SOC_DAPM_OUTPUT("SPKN"),
@@ -278,11 +283,13 @@ take care of populating them::
 	...
   	.dapm_widgets		= wm2000_dapm_widgets,
   	.num_dapm_widgets	= ARRAY_SIZE(wm2000_dapm_widgets),
+  	.dapm_routes            = wm2000_audio_map,
+  	.num_dapm_routes        = ARRAY_SIZE(wm2000_audio_map),
 	...
   };
 
 In more complex cases the list of DAPM widgets and/or routes can be only
-known at build time. This happens for example when a driver supports
+known at probe time. This happens for example when a driver supports
 different models having a different set of features. In those cases
 separate widgets and routes arrays implementing the case-specific features
 can be registered programmatically by calling snd_soc_dapm_new_controls()

-- 
2.34.1


