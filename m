Return-Path: <linux-kernel+bounces-160427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25888B3D64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C59B2804D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7ED171075;
	Fri, 26 Apr 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ghnuW8yd"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7A16F914;
	Fri, 26 Apr 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150619; cv=none; b=d9IIGYXRQue+DztGWE0H2ZuYD9h9VZtUESKkhT03kO603yuvLPIl3Nc9kXrecFufDjmnEbQ7pI5IAaVNzLnLfygZGxIxny+DvUwTXK6k4B27WaiVn0Eqv1uhq3hQzAWapJcxZJEUy67ff8kJgoPfOE52Ops81mJ4YrX7QtmhpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150619; c=relaxed/simple;
	bh=/jnaUB3Eb1FdwMsrUXBpAK6Q7IzWpVBENDZQ5igeM7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwHSbUyKxsMyZiPBImB+M8FRV5JYmwgh7IM6v24GVJtiq3qiqc8AK6x8V0wik4C0OeztD2fGybv7nkC5e+l4yANO3G4V/sEic0lmzLRDl9VXir6U1nra26zzrB9XeZsFchKYOOKU+SYq3fN1Y7K2FMb2touiXyNt4MCk+DkJzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ghnuW8yd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0A8DFF80B;
	Fri, 26 Apr 2024 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usivvK38WjvktYZbpdXlYorFChab9V2d8xiA3hJZNWc=;
	b=ghnuW8yddFB5QeT64qP1THlBFvvFHnib3MohbVWg3GBJyymnSPlCdGuUPNSTW/HydQf9n+
	W4a2jQEhK/hU090tJ8CUAQLkJXDJOYlgJMj//OtNZCuxsue4tiRJ4wstUIiLnWIc1Hqe/R
	I+hRr0UVqAhD7XEwOXmfDT1KcsZtMyBSa5Pia+neDpAG0KRCwoJ9mbXUoqVdxkX/Hcw3bx
	L5q3/PH2/8Kp6VNf/cdDDq9oCxPXCdHYSA2919fT46ABrsUGU2VYn7AC9kk9FicElV0Z26
	Js3R7Rpf86lzokAMjZLry/Yq5jqkLSzAvOQgx85hfeVC8HT3drRVR0UB+EXF0A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:43 +0200
Subject: [PATCH v2 10/12] ASoC: doc: dapm: improve section "Codec/DSP
 Widget Interconnections"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-10-87b07547eb5b@bootlin.com>
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

Improve wording in a few places, cleanup ReST colon syntax, remove space
before colon, and remove the "codec" parameter in the parentheses of
snd_soc_dapm_new_widgets() (there should be no parameters in the docs, and
that function takes a card, not a codec).

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 2831b00ae4e2..6096334226c0 100644
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


