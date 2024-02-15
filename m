Return-Path: <linux-kernel+bounces-66923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226E8563A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFCE2871FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07F412EBC7;
	Thu, 15 Feb 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nbJE4MbZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="teZGAvuO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nbJE4MbZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="teZGAvuO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282912DDB4;
	Thu, 15 Feb 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001402; cv=none; b=GXZtW70AOnJJj8zIYdTBfanDkZXfLRReUHCtWfkbKr7ovLPF3dMEhgTrxJw7XhRJfm5FOm+ZYdG8yr7Kdo3VzOft0gBHPxNOdXU6EzaPfR0JfCk03iNCywB1JgqKAv9IKrsdcQOJEFfOaRaqwwy7JWKrlJX8CGy2Hp3wlCt43gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001402; c=relaxed/simple;
	bh=4zz8eo1kQI8ow+hZNuKgds833uuafq8U6qjU+AcVAZs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEjOLdG6Rh1lJ2KrKfCeRT7QS22b8SR+FDLIGPzTvlUQ8gjPPAPPrP2F0lUYA6QsWtagFbPMLUL1mt+AvXibZT1GdkN4471Qk1zNmNPkAlTUkSzz802Nk2yiq1oVE+JMgM9K94HoXQWtsTYRAYAShI3wCRswO29ZEbghUHcsskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nbJE4MbZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=teZGAvuO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nbJE4MbZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=teZGAvuO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 947E621F92;
	Thu, 15 Feb 2024 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708001397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zWTjtS4yOYIrAnS3x5ojeu9zhlBFd5xLh3M3Wvv1Bk=;
	b=nbJE4MbZZF1FF6QxG0sakzq5OAqFbpyPro8qahY5GKLoB08oY4RHktnZDIIQg/c8bN+zEP
	Ofj2HudMmXbSHis4hfYhxQt0urFFm11KNsjAPJ5oCUSO5TNVRvaSpah1pcVrdm9hbBqdqD
	5coqjPfXIA6pjz82DsNWqLp2baW2ocs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708001397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zWTjtS4yOYIrAnS3x5ojeu9zhlBFd5xLh3M3Wvv1Bk=;
	b=teZGAvuOv9iPubX5biVScmaoxICF+AUvZA/SQYYjvNfmv8I3oDP42qeAeBV6B38qSdItQN
	Pu4wybSo9mrr8ZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708001397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zWTjtS4yOYIrAnS3x5ojeu9zhlBFd5xLh3M3Wvv1Bk=;
	b=nbJE4MbZZF1FF6QxG0sakzq5OAqFbpyPro8qahY5GKLoB08oY4RHktnZDIIQg/c8bN+zEP
	Ofj2HudMmXbSHis4hfYhxQt0urFFm11KNsjAPJ5oCUSO5TNVRvaSpah1pcVrdm9hbBqdqD
	5coqjPfXIA6pjz82DsNWqLp2baW2ocs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708001397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zWTjtS4yOYIrAnS3x5ojeu9zhlBFd5xLh3M3Wvv1Bk=;
	b=teZGAvuOv9iPubX5biVScmaoxICF+AUvZA/SQYYjvNfmv8I3oDP42qeAeBV6B38qSdItQN
	Pu4wybSo9mrr8ZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5438113A53;
	Thu, 15 Feb 2024 12:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ut9DE3UIzmXlTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Feb 2024 12:49:57 +0000
Date: Thu, 15 Feb 2024 13:49:56 +0100
Message-ID: <87v86pevt7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	Eniac Zhang <eniacz@gmail.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
In-Reply-To: <20240214184507.777349-1-alexandru.gagniuc@hp.com>
References: <20240214184507.777349-1-alexandru.gagniuc@hp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nbJE4MbZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=teZGAvuO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,perex.cz,suse.com,hp.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 947E621F92
X-Spam-Flag: NO

On Wed, 14 Feb 2024 19:45:07 +0100,
Alexandru Gagniuc wrote:
> 
> From: Eniac Zhang <eniacz@gmail.com>
> 
> The HP mt645 G7 Thin Client uses an ALC236 codec and needs the
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make the mute and
> micmute LEDs work.
> 
> There are two variants of the USB-C PD chip on this device. Each uses
> a different BIOS and board ID, hence the two entries.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>

Any reason to have two your sign-offs?
Also, can we get a sign-off from the original author?


thanks,

Takashi

> Cc: <stable@vger.kernel.org>
> ---
>  sound/pci/hda/patch_realtek.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 6994c4c5073c..c837470ef5b8 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9928,6 +9928,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8b0f, "HP Elite mt645 G7 Mobile Thin Client U81", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8b43, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> @@ -9935,6 +9936,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8b45, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8b46, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8b47, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8b59, "HP Elite mt645 G7 Mobile Thin Client U89", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> -- 
> 2.42.0
> 

