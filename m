Return-Path: <linux-kernel+bounces-15654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA09822F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BC1286126
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788A1A5BC;
	Wed,  3 Jan 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EIhSiEnC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gdCEDPm6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EIhSiEnC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gdCEDPm6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0391A596;
	Wed,  3 Jan 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65B1821E96;
	Wed,  3 Jan 2024 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704292561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neGn1jiNFuUjohraOc1BEPgti9cKQvU6vU5CdtXSqJY=;
	b=EIhSiEnC18ukreeed9nWUKc1K4RndJxWpDmKlh0yRKi+KODhHt4ooZPIUKb14okCLlEqTE
	5aftYoQHRumeZuey+BJDV+ncYaTr34dhJJcZrvhFWRZNSEwE/QsERDRud9zT3NDEUdCeZe
	T6WYYBJ21OruHZ/kShSHr3CvJqjMkb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704292561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neGn1jiNFuUjohraOc1BEPgti9cKQvU6vU5CdtXSqJY=;
	b=gdCEDPm6SlJFXMcYQdjbROY+eczQFFIE3uPWCzaqbzUl2/hajUJKZRDL+JlKTq1F4TsrZT
	2U1jriLAoSdq6TBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704292561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neGn1jiNFuUjohraOc1BEPgti9cKQvU6vU5CdtXSqJY=;
	b=EIhSiEnC18ukreeed9nWUKc1K4RndJxWpDmKlh0yRKi+KODhHt4ooZPIUKb14okCLlEqTE
	5aftYoQHRumeZuey+BJDV+ncYaTr34dhJJcZrvhFWRZNSEwE/QsERDRud9zT3NDEUdCeZe
	T6WYYBJ21OruHZ/kShSHr3CvJqjMkb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704292561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neGn1jiNFuUjohraOc1BEPgti9cKQvU6vU5CdtXSqJY=;
	b=gdCEDPm6SlJFXMcYQdjbROY+eczQFFIE3uPWCzaqbzUl2/hajUJKZRDL+JlKTq1F4TsrZT
	2U1jriLAoSdq6TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6E301340C;
	Wed,  3 Jan 2024 14:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pw7HNtBwlWXDSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Jan 2024 14:36:00 +0000
Date: Wed, 03 Jan 2024 15:36:00 +0100
Message-ID: <87o7e2a3hr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Mark Brown <broonie@kernel.org>,
	lgirdwood@gmail.com,
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
In-Reply-To: <87y1d8ulxv.wl-tiwai@suse.de>
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
	<87sf3lxiet.wl-tiwai@suse.de>
	<ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
	<874jg1x7ao.wl-tiwai@suse.de>
	<ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
	<87plyovwg7.wl-tiwai@suse.de>
	<3260e806-a708-4462-9d4e-346e54143a65@linux.intel.com>
	<87y1d8ulxv.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[dominikbrodowski.net,kernel.org,gmail.com,perex.cz,suse.com,alsa-project.org,vger.kernel.org,linux.intel.com,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 02 Jan 2024 10:25:00 +0100,
Takashi Iwai wrote:
> 
> On Tue, 02 Jan 2024 10:08:47 +0100,
> Péter Ujfalusi wrote:
> > 
> > 
> > 
> > On 30/12/2023 12:03, Takashi Iwai wrote:
> > > On Sat, 30 Dec 2023 08:27:43 +0100,
> > > Dominik Brodowski wrote:
> > >>
> > >> Am Fri, Dec 29, 2023 at 06:11:43PM +0100 schrieb Takashi Iwai:
> > >>> On Fri, 29 Dec 2023 16:24:18 +0100,
> > >>> Dominik Brodowski wrote:
> > >>>>
> > >>>> Hi Takashi,
> > >>>>
> > >>>> many thanks for your response. Your patch helps half-way: the oops goes
> > >>>> away, but so does the sound... With your patch, the decisive lines in dmesg
> > >>>> are:
> > >>>>
> > >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > >>>> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > >>>> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> > >>>> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > >>>> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> > >>>> 	platform sof_sdw: deferred probe pending
> > >>>>
> > >>>> With a revert of the a0575b4add21, it is:
> > >>>>
> > >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
> > >>>> 	sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
> > >>>> 	sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
> > >>>> 	input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input14
> > >>>> 	input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input15
> > >>>> 	input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input16
> > >>>>
> > >>>> Maybe this helps a bit further?
> > >>>
> > >>> Thanks for quick testing.
> > >>> It shows at least that my guess wasn't wrong.
> > >>>
> > >>> The problem could be the initialization order in the caller side.
> > >>> Can the patch below work instead?
> > >>
> > >> Unfortunately, no:
> > >>
> > >> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > >> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > >> sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > >> sof_sdw sof_sdw: snd_soc_register_card failed -517
> > >> sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > >> sof_sdw sof_sdw: snd_soc_register_card failed -517
> > >> platform sof_sdw: deferred probe pending
> > > 
> > > Hm, then it might be the logical failure of that commit.
> > > Peter?
> > > 
> > > Without a fix in the next few days, we'll have to revert it before
> > > 6.7.
> > 
> > The fix for this was sent early December:
> > https://lore.kernel.org/linux-sound/20231207095425.19597-1-peter.ujfalusi@linux.intel.com/
> > 
> > It had the correct Fixes tag but it did not made it to 6.7-rc while
> > a0575b4add21 did made it.
> > 
> > Mark, Takashi, can you pick the fix for 6.7 (it is in -next)? I think we
> > might have time for it to land?
> 
> Oh that landed to Mark's for-next branch, i.e. only for 6.8.
> Mark, please cherry-pick and send a PR before 6.7 final.

I ended up with cherry-picking by myself now.

I'm going to send a PR to Linus for 6.7 final in tomorrow.


thanks,

Takashi

