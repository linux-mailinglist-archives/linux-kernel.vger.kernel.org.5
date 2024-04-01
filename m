Return-Path: <linux-kernel+bounces-126511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172D8938D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F119B212E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBDC129;
	Mon,  1 Apr 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qS75Bbn2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qg8n0I9D"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE512F55;
	Mon,  1 Apr 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959431; cv=none; b=I7GxMTWmiZn/yNd3OsGb2mre+1j9NfQBzv1OyzCxMHi80aQEud1cYwddwmkF780rKbKGTFRwSfyx3QS2BvzOHQYVsxzLkVhslKEr9k5lWjXy+oN+rohNSzb3WFY15rYJF49QZyhBdehAmGuzKwwAf7jjYNXS8NVV9NJTmZ/2cdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959431; c=relaxed/simple;
	bh=hD+JFrXRECvhZbZ12DNiwryETIVEm3rvTSfSBJGtdXA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsXSEeFEf7aNhyG9pFtFKVHenPnTILCUqRCBckTAJq0bBylre5KlDqbDZ/xo8slOZHRUwwVf6ZEIoH74/S5z6u0nzxijXmdj6XJTmUzNiU84c8UisGSfSMl/H7F0am0EnliEoHcmxcfdqlLLZux9lqnb6y55RXYEZ4MHvDO0re4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qS75Bbn2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qg8n0I9D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8BB91FFFE;
	Mon,  1 Apr 2024 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711959427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrJpAFGfCJ0h1kLKIIsvQ6k5CatU6WVXQbToDjkcQm0=;
	b=qS75Bbn2u08OgS2kveIhL/jwKurJPSeo/T4KWQXM1MTiOc40NEdYHznkF6zXc16vKK8UyY
	ru44M5lCDce7vUOGyfNVhVi8XPYEF0ORA36rMkXsVgBKmgmsDJPPWWEaqzPnY9QtEDLIjH
	Qnr78iN+a0byWbg/W5IcuKQUPq9NcAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711959427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrJpAFGfCJ0h1kLKIIsvQ6k5CatU6WVXQbToDjkcQm0=;
	b=Qg8n0I9Dn61i66LVakgqsf6rB/Cmaoedc+C5r3+Jvstu2iKRC6xI4a1R5BmxJQrnp9ULbJ
	CKImALz6enKf9mCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 61EBD139BE;
	Mon,  1 Apr 2024 08:17:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LBBFFoNtCmbBWAAAn2gu4w
	(envelope-from <tiwai@suse.de>); Mon, 01 Apr 2024 08:17:07 +0000
Date: Mon, 01 Apr 2024 10:17:11 +0200
Message-ID: <87y19x5wfs.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v2] Add sound quirks for Lenovo Legion slim 7 16ARHA7 models.
In-Reply-To: <20240330115554.27895-1-christian@bendiksen.me>
References: <20240329185406.9802-1-christian@bendiksen.me>
	<87r0fsnmky.wl-tiwai@suse.de>
	<20240330115554.27895-1-christian@bendiksen.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C8BB91FFFE
X-Spamd-Result: default: False [-2.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.16)[-0.790];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -2.27
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 30 Mar 2024 12:56:09 +0100,
Christian@bendiksen.me wrote:
> 
> From: Christian Bendiksen <christian@bendiksen.me>
> 
> This fixes the sound not working from internal speakers on
> Lenovo Legion Slim 7 16ARHA7 models. The correct subsystem ID
> have been added to cs35l41_hda_property.c and patch_realtek.c.
> 
> Signed-off-by: Christian Bendiksen <christian@bendiksen.me>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 4 ++++
>  sound/pci/hda/patch_realtek.c        | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 72ec872afb8d..d6ea3ab72f75 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -109,6 +109,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
>  	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
> +	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
> +	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
>  	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
>  	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
>  	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
> @@ -497,6 +499,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "10431F1F", generic_dsd_config },
>  	{ "CSC3551", "10431F62", generic_dsd_config },
>  	{ "CSC3551", "17AA386F", generic_dsd_config },
> +	{ "CSC3551", "17AA3877", generic_dsd_config },
> +	{ "CSC3551", "17AA3878", generic_dsd_config },
>  	{ "CSC3551", "17AA38A9", generic_dsd_config },
>  	{ "CSC3551", "17AA38AB", generic_dsd_config },
>  	{ "CSC3551", "17AA38B4", generic_dsd_config },
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index a17c36a36aa5..0fb2d23b3d35 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10333,6 +10333,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
>  	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
> +	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2"),
> +	SND_PCI_QUIRK(0x17aa, 0x3878, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2"),

Those break the builds obviously.
*PLEASE* verify the compilation before submitting your patches.


thanks,

Takashi

