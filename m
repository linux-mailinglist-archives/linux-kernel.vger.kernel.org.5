Return-Path: <linux-kernel+bounces-160428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A88B3D66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6CBB24E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE32171656;
	Fri, 26 Apr 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="esdeqpag"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8416FF39;
	Fri, 26 Apr 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150620; cv=none; b=SsNe8qPy7OXjBdF1gH3XJQ3ZuUq3xsBwcjtXJ/+D0vBVzzSzMW/KiZMwIwn7MrhhmG6nh3J6pl1+D62X/FlyzZHSbfOd4umobSNGN85IHZObvy9szDMJXfajoAsnGdlb7BDORIWTvflvwo1SvyUrqse7GDf3loryGSCqwYDXKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150620; c=relaxed/simple;
	bh=ZFg7sIJ9crczjv/BDIte8s7MP3nZeUb9WTkFeJyccUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YouiLkQfVayO+S5VI/ukOsndo3eiREscKNBO4rEhlpAwgtppY0TK6Tku4VYAItbeSXusrA3/hqFza7xe2xChpNk2fTHNbxdhyw/cRBTQurKbQNGaHI7sYP98WQ5b+buLmiW/g6L2f/W1+1I/+/RV9c50/Q+irbJ9J5oiBXB1wzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=esdeqpag; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0228AFF807;
	Fri, 26 Apr 2024 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg5gNzFKL5u/fDNdHuMLTH3QOE35rAIDeXoigKMZYRQ=;
	b=esdeqpagdxcHH+IWfmoEI0xxDBZHisgParjZBUZTnM44mSB+BWPdr8e7ko1fzn1lAQr2Ba
	ukp78m25sAYeLdaSpFexfnBVjATKfnXxa4oTlMgx9nxmWXH1n+AfHdWxPSzkKlY5t0yygL
	p4A819tOAaAcstBzJftM4AWupRmCDkIXSWJKgJMmi5bzB2VHicmlktamcnkWPZXKuT5pXT
	jtoJFsBKRt2iGwcjZPabvHur2J8j1a3b/lqVb54VDIsfohnJ5kK67fFILl4qik31pxdOgr
	DIGokBGPugPAFcf8+gD20W+2c3zJUiiLKbaRhQAqCNUHwlpePjcrPaCrqMEYDA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:44 +0200
Subject: [PATCH v2 11/12] ASoC: doc: dapm: update section "DAPM Widget
 Events"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-11-87b07547eb5b@bootlin.com>
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

The example in this section is not in the kernel sources anymore. Replace
it with an up to date code fragment. Reword the initial paragraph. Remove
"Please" which is not standard practice in documentation.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 6096334226c0..da9313e10fd4 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -377,23 +377,29 @@ jacks can also be switched OFF.
 DAPM Widget Events
 ==================
 
-Some widgets can register their interest with the DAPM core in PM events.
-e.g. A Speaker with an amplifier registers a widget so the amplifier can be
-powered only when the spk is in use.
-::
+Widgets needing to implement a more complex behaviour than what DAPM can do
+can set a custom "event handler" by setting a function pointer. An example
+is a power supply needing to enable a GPIO::
 
-  /* turn speaker amplifier on/off depending on use */
-  static int corgi_amp_event(struct snd_soc_dapm_widget *w, int event)
+  static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
+  					  struct snd_kcontrol *kcontrol, int event)
   {
-	gpio_set_value(CORGI_GPIO_APM_ON, SND_SOC_DAPM_EVENT_ON(event));
-	return 0;
+  	if (SND_SOC_DAPM_EVENT_ON(event))
+  		gpiod_set_value_cansleep(gpio_pa, true);
+  	else
+  		gpiod_set_value_cansleep(gpio_pa, false);
+
+  	return 0;
   }
 
-  /* corgi machine dapm widgets */
-  static const struct snd_soc_dapm_widget wm8731_dapm_widgets =
-	SND_SOC_DAPM_SPK("Ext Spk", corgi_amp_event);
+  static const struct snd_soc_dapm_widget st_widgets[] = {
+  	...
+  	SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
+  			    sof_es8316_speaker_power_event,
+  			    SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+  };
 
-Please see soc-dapm.h for all other widgets that support events.
+See soc-dapm.h for all other widgets that support events.
 
 
 Event types

-- 
2.34.1


