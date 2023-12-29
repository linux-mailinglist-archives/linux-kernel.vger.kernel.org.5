Return-Path: <linux-kernel+bounces-13172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B88200B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4AB1C21953
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7DF12B75;
	Fri, 29 Dec 2023 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S/eGzVmA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rD9XuYYr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S/eGzVmA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rD9XuYYr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43612B68;
	Fri, 29 Dec 2023 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B323821CF2;
	Fri, 29 Dec 2023 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703869904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZehKtOidM/ksrl2T81jqfsSZp7GZn6XIl7nNRgrGng=;
	b=S/eGzVmAA6Ap3PuXn45nqNlTdrP2TIxrszu9GDoIwfM/hIItuegORKSbqkl4g7x9vrZyWg
	6vojizgLs7Ep0wNvKj6ITcUGUsGovOJGRM+zd3Jlw82s4BlM8BO5vwnJZbvpFYvPFtS2+6
	YX6Xns0fJC3ftU54pV11SuW8bM5UZls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703869904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZehKtOidM/ksrl2T81jqfsSZp7GZn6XIl7nNRgrGng=;
	b=rD9XuYYrGWY+QjCpAVprJTrwz2N7yEqzQxaPnNIWB/zCeDtfIY7h13wWZsT+SjIdzu4hQ2
	meSBlXwAe3zLE+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703869904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZehKtOidM/ksrl2T81jqfsSZp7GZn6XIl7nNRgrGng=;
	b=S/eGzVmAA6Ap3PuXn45nqNlTdrP2TIxrszu9GDoIwfM/hIItuegORKSbqkl4g7x9vrZyWg
	6vojizgLs7Ep0wNvKj6ITcUGUsGovOJGRM+zd3Jlw82s4BlM8BO5vwnJZbvpFYvPFtS2+6
	YX6Xns0fJC3ftU54pV11SuW8bM5UZls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703869904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZehKtOidM/ksrl2T81jqfsSZp7GZn6XIl7nNRgrGng=;
	b=rD9XuYYrGWY+QjCpAVprJTrwz2N7yEqzQxaPnNIWB/zCeDtfIY7h13wWZsT+SjIdzu4hQ2
	meSBlXwAe3zLE+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42738133E5;
	Fri, 29 Dec 2023 17:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIFiDtD9jmVDFwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 17:11:44 +0000
Date: Fri, 29 Dec 2023 18:11:43 +0100
Message-ID: <874jg1x7ao.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: peter.ujfalusi@linux.intel.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
In-Reply-To: <ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
	<87sf3lxiet.wl-tiwai@suse.de>
	<ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,kernel.org,perex.cz,suse.com,alsa-project.org,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spam-Flag: NO

On Fri, 29 Dec 2023 16:24:18 +0100,
Dominik Brodowski wrote:
> 
> Hi Takashi,
> 
> many thanks for your response. Your patch helps half-way: the oops goes
> away, but so does the sound... With your patch, the decisive lines in dmesg
> are:
> 
> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> 	platform sof_sdw: deferred probe pending
> 
> With a revert of the a0575b4add21, it is:
> 
> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
> 	sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
> 	sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
> 	input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input14
> 	input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input15
> 	input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input16
> 
> Maybe this helps a bit further?

Thanks for quick testing.
It shows at least that my guess wasn't wrong.

The problem could be the initialization order in the caller side.
Can the patch below work instead?


Takashi

-- 8< --
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -113,7 +113,9 @@ EXPORT_SYMBOL_NS_GPL(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 #define is_generic_config(x)	0
 #endif
 
-static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, int type)
+static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr,
+					       int type,
+					       struct hdac_hda_priv *hda_priv)
 {
 	struct hda_codec *codec;
 	int ret;
@@ -126,6 +128,10 @@ static struct hda_codec *hda_codec_device_init(struct hdac_bus *bus, int addr, i
 
 	codec->core.type = type;
 
+	hda_priv->codec = codec;
+	hda_priv->dev_index = addr;
+	dev_set_drvdata(&codec->core.dev, hda_priv);
+
 	ret = snd_hdac_device_register(&codec->core);
 	if (ret) {
 		dev_err(bus->dev, "failed to register hdac device\n");
@@ -163,15 +169,12 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 	if (!hda_priv)
 		return -ENOMEM;
 
-	codec = hda_codec_device_init(&hbus->core, address, HDA_DEV_LEGACY);
+	codec = hda_codec_device_init(&hbus->core, address, HDA_DEV_LEGACY,
+				      hda_priv);
 	ret = PTR_ERR_OR_ZERO(codec);
 	if (ret < 0)
 		return ret;
 
-	hda_priv->codec = codec;
-	hda_priv->dev_index = address;
-	dev_set_drvdata(&codec->core.dev, hda_priv);
-
 	if ((resp & 0xFFFF0000) == IDISP_VID_INTEL) {
 		if (!hbus->core.audio_component) {
 			dev_dbg(sdev->dev,

