Return-Path: <linux-kernel+bounces-125618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB38929B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F31C20ECA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB998821;
	Sat, 30 Mar 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L2dWxHdh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZrvUGSan"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805864F;
	Sat, 30 Mar 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787759; cv=none; b=TTtsYKqFHEuLANMCw+F0zukE7EFNW2hJiIl/LtyaHtkNNUelEnZYSTwK70TiWfTV0QeDMtRH/EkZQTWiS9tOJKppySUdlQGPhZxL5TmBb/uzwpPkYMNHJG3Y1lDAdf8ywXUqovEzDRKxgcL4fwpB7Ta60/yPbJyOix/QBl0i0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787759; c=relaxed/simple;
	bh=hM4zzObcqkeasLl3jnP0T9cpvHHhPp0Da05+trJoYeE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjgbY4BN6FUYKPPsnd31e9WYHElMmxFyVe8DAU20qY3RLBvQcZJ5by0kvbfobCfPrUdTo9s+GRKa2uj5J/21Zfe5x09GLwYBB1FH0BJ5FVQJlbDKSIjy8WXGDTGU80HzzzYFbfXU6vvStEjDWSkgs6WIt6cJXf4L8B+wsUvFALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L2dWxHdh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZrvUGSan; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E75D37742;
	Sat, 30 Mar 2024 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711787755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2rff1aQCpGhc3FhH7+YpI1m0oW/YTR5lwhWBWR+MWM=;
	b=L2dWxHdhHQBbmDnWDDY/twSTB0Y7np0RtUa6rulFdt40+f6hSfH81QlGBHZ83XNmr1WAMa
	im7x6Jgn585hVUkof4uIGPsNyJlk8vN/VtgbvKSRPeVrfScdmD4rFCgYyRtEsjYCTUNFHP
	7LCvbiMHXD8cVOPYWTh+/HmDSo9hSDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711787755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2rff1aQCpGhc3FhH7+YpI1m0oW/YTR5lwhWBWR+MWM=;
	b=ZrvUGSanyUfJVvEv88A9+YDSxEJDknzi7Cc2RWTiJxizoQmdmP65PvgBCBz2HaC3WfRwtA
	y76R4wu3P9BDp8Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE77513A90;
	Sat, 30 Mar 2024 08:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id h6WLMOrOB2bgbQAAn2gu4w
	(envelope-from <tiwai@suse.de>); Sat, 30 Mar 2024 08:35:54 +0000
Date: Sat, 30 Mar 2024 09:35:57 +0100
Message-ID: <87r0fsnmky.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christian@bendiksen.me
Cc: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	foss@athaariq.my.id,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Bendiksen <christian@bendiksen.me>
Subject: Re: [PATCH] Add sound quirks for Lenovo Legion slim 7 16ARHA7 models.
In-Reply-To: <20240329185406.9802-1-christian@bendiksen.me>
References: <20240329185406.9802-1-christian@bendiksen.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.91
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.91 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.80)[-0.796];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E75D37742

On Fri, 29 Mar 2024 19:54:14 +0100,
Christian@bendiksen.me wrote:
> 
> From: Christian Bendiksen <christian@bendiksen.me>
> 
> This fixes the sound not working from internal speakers on
> Lenovo Legion Slim 7 16ARHA7 models. The correct subsystem ID
> have been added to cs35l41_hda_property.c and patch_realtek.c.
> 
> Signed-off-by: Christian Bendiksen <christian@bendiksen.me>

The entries are sorted in SSID order.  Could you put them at the right
positions?


thanks,

Takashi

> ---
>  sound/pci/hda/cs35l41_hda_property.c | 4 ++++
>  sound/pci/hda/patch_realtek.c        | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 72ec872afb8d..959864994eca 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -115,6 +115,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
>  	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
>  	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
> +	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
> +	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
>  	{}
>  };
>  
> @@ -503,6 +505,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "17AA38B5", generic_dsd_config },
>  	{ "CSC3551", "17AA38B6", generic_dsd_config },
>  	{ "CSC3551", "17AA38B7", generic_dsd_config },
> +	{ "CSC3551", "17AA3877", generic_dsd_config },
> +	{ "CSC3551", "17AA3878", generic_dsd_config },
>  	{}
>  };
>  
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index a17c36a36aa5..540868d6c602 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10347,6 +10347,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
> +	SND_PCI_QUIRK(0x17aa, 0x3877, "Legion Slim 7 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
> +	SND_PCI_QUIRK(0x17aa, 0x3878, "Legion Slim 7 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
> -- 
> 2.44.0
> 
> 

