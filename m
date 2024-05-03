Return-Path: <linux-kernel+bounces-167816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2F8BAFA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508E11F22FF4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C04F8BB;
	Fri,  3 May 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b6wBVG10";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5M4/TA5h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b6wBVG10";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5M4/TA5h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B61BF31;
	Fri,  3 May 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749424; cv=none; b=ufO8zLd2/OdiNnKzZbqY5Kc56/oumDT71lr1W5mNaIUnqVoVvVCrOs7HzphWE8FUuY8+0Ah9tQ0oYCM0ShfK0Qtplmu8d8vcP4CYoycB8HATtj6AaXQKg2wdgYOpgQ5KkJuR/RjP25zdpVjoTeqEhxklJgFNayhawCJT9TMyyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749424; c=relaxed/simple;
	bh=KJfqZgax64prPMpPNUNofDSkKySTwOCkxTH+UF6nTso=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXySEx4m2lQnSqXm/hw6Siu7UQzwHBznOJ2cHytDBORyEMFY4XwOYMM01aWAKXqc18p7L1MLsxNQIx0fO0BitQXWJGR2xSEajvZ1EIuXLIF/qe6KzmRpIWwENLKM7V8lorZruke8ZLbnU2hYsdKg1N4Td7pvshVH2UE0n3ji2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b6wBVG10; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5M4/TA5h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b6wBVG10; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5M4/TA5h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 736B533B85;
	Fri,  3 May 2024 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714749421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isFjC32uACt6O65rKRP2AYTy2BLvdanLyHjx9bEOYoU=;
	b=b6wBVG10rWRDWC/tMakRx+KruYCZjN2543NHu976oIzu0JGN47DSY8iDZfYOyCQ0LwbJxw
	s+enfHldW4I++Y0dmo87OWaS2DQCxwxuMuHZilQL8EvbD7NiN4NIeB9Wo4i+CjdBO8NwAX
	5+EEL737XNZ7oF9NBdDdrSOq10zxrPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714749421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isFjC32uACt6O65rKRP2AYTy2BLvdanLyHjx9bEOYoU=;
	b=5M4/TA5haAIuk+cA5ivsW29ZmdmtuEVP54jp+f6jhha/Cod1ggUopj4E6dg/Wxu/NonsMV
	QaB1I7uuKiUB0KDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b6wBVG10;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5M4/TA5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714749421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isFjC32uACt6O65rKRP2AYTy2BLvdanLyHjx9bEOYoU=;
	b=b6wBVG10rWRDWC/tMakRx+KruYCZjN2543NHu976oIzu0JGN47DSY8iDZfYOyCQ0LwbJxw
	s+enfHldW4I++Y0dmo87OWaS2DQCxwxuMuHZilQL8EvbD7NiN4NIeB9Wo4i+CjdBO8NwAX
	5+EEL737XNZ7oF9NBdDdrSOq10zxrPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714749421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isFjC32uACt6O65rKRP2AYTy2BLvdanLyHjx9bEOYoU=;
	b=5M4/TA5haAIuk+cA5ivsW29ZmdmtuEVP54jp+f6jhha/Cod1ggUopj4E6dg/Wxu/NonsMV
	QaB1I7uuKiUB0KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4689A139CB;
	Fri,  3 May 2024 15:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lxT9D+3/NGa0KQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 May 2024 15:17:01 +0000
Date: Fri, 03 May 2024 17:17:15 +0200
Message-ID: <87msp79b7o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/cs_dsp_ctl: Actually remove ALSA controls
In-Reply-To: <20240503144920.61075-1-rf@opensource.cirrus.com>
References: <20240503144920.61075-1-rf@opensource.cirrus.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 736B533B85
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.51

On Fri, 03 May 2024 16:49:20 +0200,
Richard Fitzgerald wrote:
> 
> hda_cs_dsp_control_remove() must remove the ALSA control when
> deleting all the infrastructure for handling the control.
> 
> Without this it is possible for ALSA controls to be left in
> the Soundcard after the amp driver module has been unloaded.
> So the get/set callbacks point to code that no longer exists.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 3233b978af23 ("ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls")
> ---
> Note: it would be better to use the control private_free to do the
> cleanup, and that is my plan long-term. But that is a larger change
> to the code.
> 
> I like to keep bugfix patches as simple as possible so they are
> low-risk and easy to cherry-pick into older kernels. So this patch
> fixes the bug. Sometime I will send a patch for future kernel
> versions that reworks the cleanup to use private_free.

I also like to keep as simple as possible :)

One slight concern is whether cs_dsp kctls can be deleted at the
snd_card removal (disconnect) before this function gets called.
That is, snd_card_free() of the main card may delete all associated
kctls, and may this function be called afterwards?
If yes, this change would lead to a UAF.

The structure is so complex and I can't follow immediately,
unfortunately...


thanks,

Takashi

> ---
>  sound/pci/hda/hda_cs_dsp_ctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
> index 463ca06036bf..a42653d3473d 100644
> --- a/sound/pci/hda/hda_cs_dsp_ctl.c
> +++ b/sound/pci/hda/hda_cs_dsp_ctl.c
> @@ -203,6 +203,10 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
>  {
>  	struct hda_cs_dsp_coeff_ctl *ctl = cs_ctl->priv;
>  
> +	/* Only public firmware controls will have an associated kcontrol */
> +	if (ctl && ctl->kctl)
> +		snd_ctl_remove(ctl->card, ctl->kctl);
> +
>  	kfree(ctl);
>  }
>  EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
> -- 
> 2.39.2
> 

