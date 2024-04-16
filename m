Return-Path: <linux-kernel+bounces-146303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B438A6359
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18851F226CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044759158;
	Tue, 16 Apr 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CaXF5lPZ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD63BB30;
	Tue, 16 Apr 2024 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247032; cv=none; b=r2CtdZ3OBf6/52XHPZS71LP6pJfARFEF5tctgDfK000mNFd17HfIjG06U2yzcl1BL8g48nY6R4ylJMcBMlc0MHv/rkCwae/fPqZf2haQPV0fX3EtrT3YxIOD8Nz4Q1NBgrJOQIsj4IKJgQ1VfIwwL6xQ6yjXy4T6nlg8U9e5XmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247032; c=relaxed/simple;
	bh=qy57PegXWwkF2OifUn6/ndmkGcmkMysm1NDH1Ak9Umg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7cTTeyH/SZc3GqxqwnhVygyVu4w4Np4h/YuXfVlJwBeFvKXAtQs8X64cKGaTQUgWhG01EcQqTALKX2XHfqcnEjkGSh3gpPUoWp+CXClS0hRtcDqXPInSqK+WWWMX7efRaRTDY3tOYfHC1wXIZEZMeLOezgkVn7F8wdJPDXH8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CaXF5lPZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81AE3240004;
	Tue, 16 Apr 2024 05:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgZ6ZmxXz+RjUHsnpzM+2vkjxQTQsCHjp6Cpzx/OORg=;
	b=CaXF5lPZYHdYVhvVPyuD8aMBOVAjsJWCaNcjtfseuSsEHF8wnIoUHLKDw7anH7UMkWLoLZ
	OHPgyZZBYRRq+LyrGLHr57ISdeR/SnY1eUJezQ2UEi9+yX0THsUxZk9Snp7JsMEslVUpOL
	dvciB5FgocZ+2+CPL8GLmYpOv/HOqNpfhibuxYA4q3LhvJ+GF44Q6z+z7VG/jaJue/eJsG
	YMob+z0WULtxzEwpz5tT+gN32QdVRUUKK/RQLcVrfbi/hcIcp9G5cjPF6wCwlVYTHzwidf
	UiBOl4OGbnDXfsDZ3dGADQML7fTAZaUhPnLly9etzJJrji6DoY+6XG9Yflm9JA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:17 +0200
Subject: [PATCH 11/12] ASoC: doc: dapm: update section "DAPM Widget Events"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-11-a818d2819bf6@bootlin.com>
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

The example in this section is not in the kernel sources anymore. Replace
it with an up to date code fragment. Reword the initial paragraph. Remove
"Please" which is not standard practice in documentation.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 5b370daed499..75a85c9e33ff 100644
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


