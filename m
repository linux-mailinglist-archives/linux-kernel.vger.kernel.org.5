Return-Path: <linux-kernel+bounces-13684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B260820AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAE81C20CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E328F5;
	Sun, 31 Dec 2023 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i4QjwUUn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UKJuc0vh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i4QjwUUn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UKJuc0vh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46B211C;
	Sun, 31 Dec 2023 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FFAC21D10;
	Sun, 31 Dec 2023 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704018539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU/7SX+x84Zafnu4sZDk7oJ3cJRBbNvRTFmeeU4ZD7U=;
	b=i4QjwUUnP8EfCdJ6pSO98lkC2eo1ztbDer+ThE3OUzQxH/79lCPVN9DXf6uqHIDcqQdDGC
	yEMVZipdE3Xcd0R//urWYxog+gCP55HGkBmmX28Dj+RlgcFX36Z3nzvpyKBOTCQAgwtCM4
	MIi9XxAc81qC5ds7abr+u4L7grhtbqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704018539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU/7SX+x84Zafnu4sZDk7oJ3cJRBbNvRTFmeeU4ZD7U=;
	b=UKJuc0vhL8oLAgU78kqQqELwPa2vszCdM0e6n2gqVa8WR9yZu/VLK8293dqrjjr1XJxYRf
	GKoFoscWZFupInBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704018539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU/7SX+x84Zafnu4sZDk7oJ3cJRBbNvRTFmeeU4ZD7U=;
	b=i4QjwUUnP8EfCdJ6pSO98lkC2eo1ztbDer+ThE3OUzQxH/79lCPVN9DXf6uqHIDcqQdDGC
	yEMVZipdE3Xcd0R//urWYxog+gCP55HGkBmmX28Dj+RlgcFX36Z3nzvpyKBOTCQAgwtCM4
	MIi9XxAc81qC5ds7abr+u4L7grhtbqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704018539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU/7SX+x84Zafnu4sZDk7oJ3cJRBbNvRTFmeeU4ZD7U=;
	b=UKJuc0vhL8oLAgU78kqQqELwPa2vszCdM0e6n2gqVa8WR9yZu/VLK8293dqrjjr1XJxYRf
	GKoFoscWZFupInBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C0691398B;
	Sun, 31 Dec 2023 10:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 94VCDWtCkWUGNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 31 Dec 2023 10:28:59 +0000
Date: Sun, 31 Dec 2023 11:28:58 +0100
Message-ID: <87a5pqwtqt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: peter.ujfalusi@linux.intel.com
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
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
In-Reply-To: <87plyovwg7.wl-tiwai@suse.de>
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
	<87sf3lxiet.wl-tiwai@suse.de>
	<ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
	<874jg1x7ao.wl-tiwai@suse.de>
	<ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
	<87plyovwg7.wl-tiwai@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i4QjwUUn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UKJuc0vh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[dominikbrodowski.net,gmail.com,kernel.org,perex.cz,suse.com,alsa-project.org,vger.kernel.org,linux.intel.com,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 9FFAC21D10
X-Spam-Flag: NO

On Sat, 30 Dec 2023 11:03:36 +0100,
Takashi Iwai wrote:
> 
> On Sat, 30 Dec 2023 08:27:43 +0100,
> Dominik Brodowski wrote:
> > 
> > Am Fri, Dec 29, 2023 at 06:11:43PM +0100 schrieb Takashi Iwai:
> > > On Fri, 29 Dec 2023 16:24:18 +0100,
> > > Dominik Brodowski wrote:
> > > > 
> > > > Hi Takashi,
> > > > 
> > > > many thanks for your response. Your patch helps half-way: the oops goes
> > > > away, but so does the sound... With your patch, the decisive lines in dmesg
> > > > are:
> > > > 
> > > > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > > > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > > > 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > > > 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> > > > 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > > > 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> > > > 	platform sof_sdw: deferred probe pending
> > > > 
> > > > With a revert of the a0575b4add21, it is:
> > > > 
> > > > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > > > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > > > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
> > > > 	sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
> > > > 	sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
> > > > 	input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input14
> > > > 	input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input15
> > > > 	input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input16
> > > > 
> > > > Maybe this helps a bit further?
> > > 
> > > Thanks for quick testing.
> > > It shows at least that my guess wasn't wrong.
> > > 
> > > The problem could be the initialization order in the caller side.
> > > Can the patch below work instead?
> > 
> > Unfortunately, no:
> > 
> > sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > sof_sdw sof_sdw: snd_soc_register_card failed -517
> > sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > sof_sdw sof_sdw: snd_soc_register_card failed -517
> > platform sof_sdw: deferred probe pending
> 
> Hm, then it might be the logical failure of that commit.
> Peter?

FWIW, there was a report on bugzilla, too:
  https://bugzilla.kernel.org/show_bug.cgi?id=218304


Takashi

