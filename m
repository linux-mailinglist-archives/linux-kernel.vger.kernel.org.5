Return-Path: <linux-kernel+bounces-162225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A18B57DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254481C230C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20206A359;
	Mon, 29 Apr 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4lAs4SH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5A5QsV30";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UAUcfHeh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U2Be5/nf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F356535A4;
	Mon, 29 Apr 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393047; cv=none; b=sXq7cYp7F3QaSumWHnLf1iBxqQ1SNmcUlcGgFfmOwD+xU0NZ/QB5HbtO6FFxbAlcgwTxjJNVVlX+tcyCUL0WgXHgaf4tCSH5mB1cBf7z8T1gf5yPX+zY1brg208jfsQPVxEJjbE8Pkj56Qy2Q8Qla1jeEudvHBKZTWEUDSVbvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393047; c=relaxed/simple;
	bh=dxgfccTFLndw2wPfMPSGEYD1XzuAN5HCa2sN5XVe7fQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxsRFCaY41PBHrL8e+XoRlvAB1s2/wlaTwdCL7NWMYmqbWoRjRckfzKTi3jfRKOpYGLmECm5a6hXw2uHQ8KGyTmZDnTVkfFTVW9ivFIoublP4DVtXvtUuGAAum4KRQlI0Y82Ct1b3dATOVl8GZAmjrL5hBceX7CaSXy4ifWtqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4lAs4SH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5A5QsV30; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UAUcfHeh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U2Be5/nf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAE6E3374B;
	Mon, 29 Apr 2024 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714393043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQjBbCqM/Xv/1Uj55usknQ9IHjRGdoAKU1qiXkguGwk=;
	b=o4lAs4SHJkeDloFUBXQxZi2n9LYsiPjooAtPDtrTqAYfZhBNTmNnl0muBqhXRdXu1DKVgr
	ehwG57Y9jPlCQnVsdvPPdOELbMLGpIbDbWLYJLYjIzfk6xIUVeI4wsbr6BbWS8IwTluKLB
	pcrcl8CBruzsId7jnbbdQgAkLbfUX7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714393043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQjBbCqM/Xv/1Uj55usknQ9IHjRGdoAKU1qiXkguGwk=;
	b=5A5QsV30JvPk+Ksj3crGhserdRRVStZd+042UkV4GfZLn8SbCys4sLi5ajUIWIz0z10Up2
	5ku642gyuJ3eYgAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UAUcfHeh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="U2Be5/nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714393042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQjBbCqM/Xv/1Uj55usknQ9IHjRGdoAKU1qiXkguGwk=;
	b=UAUcfHehMGUxevRVjh+sJBNwLWrUpQuupqdVZpO/zgCl1+ccA1tPi6Q4mKwTrHIjwVK85y
	Uwyj3BWjspJgKJCvTKkeXviFn54CE5d79ZO7LaE6eMp+mrtJNPewRJBgNuDF2Jh7yO3k8e
	M2T6Sjf8vFUQUfYT+Z1f3rbCSiG7kQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714393042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQjBbCqM/Xv/1Uj55usknQ9IHjRGdoAKU1qiXkguGwk=;
	b=U2Be5/nftG0R5GrVRdFg5VXP+tyzdrfKssLgU9D1+NogE4aSVccr5KpcZoOEsUVoykjcMv
	A2fNc49/jmFNAyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 630E7139DE;
	Mon, 29 Apr 2024 12:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YNGFtKPL2YAWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Apr 2024 12:17:22 +0000
Date: Mon, 29 Apr 2024 14:17:34 +0200
Message-ID: <87edaopdlt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,	Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,	Bard Liao
 <yung-chuan.liao@linux.intel.com>,	Brady Norander
 <bradynorander@gmail.com>,	Jaroslav Kysela <perex@perex.cz>,	Mark Brown
 <broonie@kernel.org>,	Mark Hasemeyer <markhas@chromium.org>,	Takashi Iwai
 <tiwai@suse.com>,	linux-sound@vger.kernel.org,	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14 NBLB-WAX9N quirk detection
In-Reply-To: <848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
	<20240418110453.10efcb60@sal.lan>
	<848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,gmail.com,perex.cz,chromium.org,suse.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BAE6E3374B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.51

On Thu, 18 Apr 2024 15:24:10 +0200,
Pierre-Louis Bossart wrote:
> 
> On 4/18/24 05:04, Mauro Carvalho Chehab wrote:
> > Em Thu, 18 Apr 2024 09:48:27 +0100
> > Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> > 
> >> Newer Matebook D14 model comes with essx8336 and supports SOF,
> >> but the initial models use the legacy driver, with a Realtek ALC 256
> >> AC97 chip on it.
> >>
> >> The BIOS seems to be prepared to be used by both models, so
> >> it contains an entry for ESSX8336 on its DSDT table.
> >>
> >> Add a quirk, as otherwise dspconfig driver will try to load
> >> SOF, causing audio probe to fail.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > 
> > Worth to mention that I opened an issue on Github about that:
> > 
> > https://github.com/thesofproject/linux/issues/4934
> > 
> > I added there the ACPI DSDT table as a reference.
> 
> This sounds like an 'easy enough' fix, but I don't have a burning desire
> to start adding quirks of this nature. To be clear, the entire support
> of the ES8336 is an absolute nightmare that I've stopped looking at
> completely given the lack of support of vendor/OEMs.
> 
> In this case, the ACPI table is completely wrong, we should try to
> 'mark' the ES8336 device as 'not present' or detect the presence of HDaudio.
> 
> Andy, what do you think and what would be your recommendation?

This one is still pending, and I'd like to hear the decision from
Intel people.  Let me know if this hack is acceptable.


thanks,

Takashi

> 
> >> ---
> >>  sound/hda/intel-dsp-config.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> >> index 6a384b922e4f..8e728f0585dd 100644
> >> --- a/sound/hda/intel-dsp-config.c
> >> +++ b/sound/hda/intel-dsp-config.c
> >> @@ -46,6 +46,22 @@ static const struct snd_soc_acpi_codecs __maybe_unused essx_83x6 = {
> >>   * - the first successful match will win
> >>   */
> >>  static const struct config_entry config_table[] = {
> >> +	/* Quirks */
> >> +	{
> >> +		.flags = 0,	/* Model uses AC97 with Realtek ALC 256 */
> >> +		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
> >> +		.dmi_table = (const struct dmi_system_id []) {
> >> +			{
> >> +				.ident = "Huawei NBLB-WAX9N",
> >> +				.matches = {
> >> +					DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
> >> +					DMI_MATCH(DMI_PRODUCT_NAME, "NBLB-WAX9N"),
> >> +				}
> >> +			},
> >> +			{}
> >> +		}
> >> +	},
> >> +
> >>  /* Merrifield */
> >>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
> >>  	{

