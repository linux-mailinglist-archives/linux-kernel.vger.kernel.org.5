Return-Path: <linux-kernel+bounces-146302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A828A6357
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313E31C215CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643A3BB24;
	Tue, 16 Apr 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dwr5zFGc"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519806EB40;
	Tue, 16 Apr 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247028; cv=none; b=JGaMecHgiFU/HzmoT5Aur58hU7+Miv7otq9NeYragZNDZ8LYfRMQ063FvyAClcYq2iqbFhVEwqDWK6g44wtsgqE0pvm67ljo2bcKFZkRlzlM6NCo42rop8YCavO4+LLIR8zYKeKGjNd7aaIr5d7B3DCUGsIZnGe6sXrY5CFo/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247028; c=relaxed/simple;
	bh=W8ieXiaD2grKULBZH7ePr2myf5pDYSuRFVZ/zf5MH6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/OaxgkTnF95xMBNkw/0XMctc0Gw+7Z56SocQu7oItpPuYCHw0Q9ljvnDKoaJokZvL5vDk5Kt4lqH1qjITsxm/2cSyuMJjUnT4+ZBJ2STx6ZQJn/FLIwc/vpP3kYKKo8dxHAlcMyXitz9rSHE5hoMYY8+5qeU9MzCwt05paAJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dwr5zFGc; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C043F240002;
	Tue, 16 Apr 2024 05:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zT3Lgqr0SCMtCE+J3QwZUIXvFEw2cInrlnSEqndvvJQ=;
	b=dwr5zFGcBS4gT+fOWoysA7oZgILPzpnWccGCOPfIXFpfKbPeWI9eciGTnzXy3hA07G9+jm
	Z2K+ys9ma9v2iY94IKMRnc0eamYxWJD/MDBbO6wbcMMA1Ajv+NhKu7mC9rlOyGdAzf8G2s
	qRpRWM+4ZioG02byZPwYlQzrA73y4rcaX3skuK7Bz67SO12A1czPYDlI3KvGt8rbhIW7ja
	RX8QtX2u0VwRDCItxDsLxg1Yg2Slfh8dWuVM65Sl4+lVP7XVOW2LLF/VHdcvJ44CY1oRxb
	gcqueTpKxDcANYRgJ1nWxuYZTEqVrC1Bxsn+RQbDFJSKMBZLXe8tGzeHG3twWQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:16 +0200
Subject: [PATCH 10/12] ASoC: doc: dapm: improve section "Codec/DSP Widget
 Interconnections"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-10-a818d2819bf6@bootlin.com>
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

Improve wording in a few places, cleanup ReST colon syntax, remove space
before colon, and remove the "codec" parameter in the parentheses of
snd_soc_dapm_new_widgets() (there should be no parameters in the docs, and
that function takes a card, not a codec).

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index ab7d48582cf7..5b370daed499 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -307,25 +307,23 @@ This is easiest with a diagram of the codec or DSP (and schematic of the machine
 audio system), as it requires joining widgets together via their audio signal
 paths.
 
-e.g., from the WM8731 output mixer (wm8731.c)
-
-The WM8731 output mixer has 3 inputs (sources)
+For example the WM8731 output mixer (wm8731.c) has 3 inputs (sources):
 
 1. Line Bypass Input
 2. DAC (HiFi playback)
 3. Mic Sidetone Input
 
-Each input in this example has a kcontrol associated with it (defined in example
-above) and is connected to the output mixer via its kcontrol name. We can now
-connect the destination widget (wrt audio signal) with its source widgets.
-::
+Each input in this example has a kcontrol associated with it (defined in
+the example above) and is connected to the output mixer via its kcontrol
+name. We can now connect the destination widget (wrt audio signal) with its
+source widgets.  ::
 
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
 	{"Output Mixer", "Mic Sidetone Switch", "Mic Bias"},
 
-So we have :
+So we have:
 
 * Destination Widget  <=== Path Name <=== Source Widget, or
 * Sink, Path, Source, or
@@ -334,12 +332,11 @@ So we have :
 When there is no path name connecting widgets (e.g. a direct connection) we
 pass NULL for the path name.
 
-Interconnections are created with a call to:
-::
+Interconnections are created with a call to::
 
   snd_soc_dapm_connect_input(codec, sink, path, source);
 
-Finally, snd_soc_dapm_new_widgets(codec) must be called after all widgets and
+Finally, snd_soc_dapm_new_widgets() must be called after all widgets and
 interconnections have been registered with the core. This causes the core to
 scan the codec and machine so that the internal DAPM state matches the
 physical state of the machine.

-- 
2.34.1


