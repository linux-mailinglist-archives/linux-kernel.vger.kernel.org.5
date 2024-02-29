Return-Path: <linux-kernel+bounces-86256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B61F86C2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B881B23680
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC547F6F;
	Thu, 29 Feb 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PyHjHZgL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bPoeXd6N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PyHjHZgL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bPoeXd6N"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EC47F51;
	Thu, 29 Feb 2024 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193650; cv=none; b=lIGoCw0BHEXh99nQNK9b9z8pDUV0kHeY+4ZYJecx2jRJXoDi+gCVNTjiO0dJFY13om3vYJsIMHg82GcGL+rShXQz+BXbMn9uaanNOhzez9mMzfoNXI8XgnTBo1yiFbB7L4/LkIE5sLdR5hXeYEni1vfSCDF9fgkzLP0KaKfB7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193650; c=relaxed/simple;
	bh=7gVZBffV5ET91xGCn9g9Lc58TUCCN5Lyadr+5Z7Eu8M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwOgneq4Fo4DAvazxINPDxScEtYvsCUWXM39+VDV7C1KauKFrfopxdJIi/Pa5NcPd9Ry0em70s8zBqId/3v22OehSBP7/RvNFYJpzyTBNCMgTBJnZAN/ptmiONmAUJgyWSZoThpYpya4Tx+6mXidZ1SMJZMElfXsLB83kzd2ONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PyHjHZgL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bPoeXd6N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PyHjHZgL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bPoeXd6N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00C1822295;
	Thu, 29 Feb 2024 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709193647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OghcDKcsB6v5yBV6QewQrZL6yYW2i8yj15Dnj8J8i8=;
	b=PyHjHZgL+tgf09H0nnK1AN4mKtccJiyTV/JU22ncJVMLqjCdY+YHiQeYOj2ukLrkf53GCN
	M+6T9jS/BTEbyKkonxcWBKZqhjWfjHkNYSck9fz84jbcm5vDRBrF4CSlbDtokhA8ukGeLd
	IKRcG751MC/jNsIJMaJTEv8UjhJnQn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709193647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OghcDKcsB6v5yBV6QewQrZL6yYW2i8yj15Dnj8J8i8=;
	b=bPoeXd6N+VvO6bOCMCFvXBhTI6VhwosuV5XTtBzWIqacQneYspkvGjLwrRWfmnzTUbT+hq
	oMRb2Y8Oldp38KDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709193647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OghcDKcsB6v5yBV6QewQrZL6yYW2i8yj15Dnj8J8i8=;
	b=PyHjHZgL+tgf09H0nnK1AN4mKtccJiyTV/JU22ncJVMLqjCdY+YHiQeYOj2ukLrkf53GCN
	M+6T9jS/BTEbyKkonxcWBKZqhjWfjHkNYSck9fz84jbcm5vDRBrF4CSlbDtokhA8ukGeLd
	IKRcG751MC/jNsIJMaJTEv8UjhJnQn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709193647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OghcDKcsB6v5yBV6QewQrZL6yYW2i8yj15Dnj8J8i8=;
	b=bPoeXd6N+VvO6bOCMCFvXBhTI6VhwosuV5XTtBzWIqacQneYspkvGjLwrRWfmnzTUbT+hq
	oMRb2Y8Oldp38KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCB6E13503;
	Thu, 29 Feb 2024 08:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o7jyLK454GVWRQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 29 Feb 2024 08:00:46 +0000
Date: Thu, 29 Feb 2024 09:00:46 +0100
Message-ID: <878r33hf81.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <broonie@kernel.org>,
	<shengjiu.wang@gmail.com>,
	<Xiubo.Lee@gmail.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()
In-Reply-To: <20240221123710.690224-1-rf@opensource.cirrus.com>
References: <20240221123710.690224-1-rf@opensource.cirrus.com>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PyHjHZgL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bPoeXd6N
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,alsa-project.org,lists.ozlabs.org,opensource.cirrus.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 00C1822295
X-Spam-Flag: NO

On Wed, 21 Feb 2024 13:37:10 +0100,
Richard Fitzgerald wrote:
> 
> snd_soc_card_get_kcontrol() must be holding a read lock on
> card->controls_rwsem while walking the controls list.
> 
> Compare with snd_ctl_find_numid().
> 
> The existing function is renamed snd_soc_card_get_kcontrol_locked()
> so that it can be called from contexts that are already holding
> card->controls_rwsem (for example, control get/put functions).
> 
> There are few direct or indirect callers of
> snd_soc_card_get_kcontrol(), and most are safe. Three require
> changes, which have been included in this patch:
> 
> codecs/cs35l45.c:
>   cs35l45_activate_ctl() is called from a control put() function so
>   is changed to call snd_soc_card_get_kcontrol_locked().
> 
> codecs/cs35l56.c:
>   cs35l56_sync_asp1_mixer_widgets_with_firmware() is called from
>   control get()/put() functions so is changed to call
>   snd_soc_card_get_kcontrol_locked().
> 
> fsl/fsl_xcvr.c:
>   fsl_xcvr_activate_ctl() is called from three places, one of which
>   already holds card->controls_rwsem:
>   1. fsl_xcvr_mode_put(), a control put function, which will
>      already be holding card->controls_rwsem.
>   2. fsl_xcvr_startup(), a DAI startup function.
>   3. fsl_xcvr_shutdown(), a DAI shutdown function.
> 
>   To fix this, fsl_xcvr_activate_ctl() has been changed to call
>   snd_soc_card_get_kcontrol_locked() so that it is safe to call
>   directly from fsl_xcvr_mode_put().
>   The fsl_xcvr_startup() and fsl_xcvr_shutdown() functions have been
>   changed to take a read lock on card->controls_rsem() around calls
>   to fsl_xcvr_activate_ctl(). While this is not very elegant, it
>   keeps the change small, to avoid this patch creating a large
>   collateral churn in fsl/fsl_xcvr.c.
> 
> Analysis of other callers of snd_soc_card_get_kcontrol() is that
> they do not need any changes, they are not holding card->controls_rwsem
> when they call snd_soc_card_get_kcontrol().
> 
> Direct callers of snd_soc_card_get_kcontrol():
>   fsl/fsl_spdif.c: fsl_spdif_dai_probe() - DAI probe function
>   fsl/fsl_micfil.c: voice_detected_fn() - IRQ handler
> 
> Indirect callers via soc_component_notify_control():
>   codecs/cs42l43: cs42l43_mic_shutter() - IRQ handler
>   codecs/cs42l43: cs42l43_spk_shutter() - IRQ handler
>   codecs/ak4118.c: ak4118_irq_handler() - IRQ handler
>   codecs/wm_adsp.c: wm_adsp_write_ctl() - not currently used
> 
> Indirect callers via snd_soc_limit_volume():
>   qcom/sc8280xp.c: sc8280xp_snd_init() - DAIlink init function
>   ti/rx51.c: rx51_aic34_init() - DAI init function
> 
> I don't have hardware to test the fsl/*, qcom/sc828xp.c, ti/rx51.c
> and ak4118.c changes.
> 
> Backport note:
> The fsl/, qcom/, cs35l45, cs35l56 and cs42l43 callers were added
> since the Fixes commit so won't all be present on older kernels.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 209c6cdfd283 ("ASoC: soc-card: move snd_soc_card_get_kcontrol() to soc-card")
> ---
> It would be great if people could test the fsl/, qcom/, ti/rx51 and ak4418
> drivers.

This fix itself looks correct, and I merged Mark's PR now.

But in general, it'd be better to use snd_ctl_find_id() and
snd_ctl_find_id_unlocked() if possible.  Those standard APIs can use
the fast Xarray lookup, and especially for the case like many ASoC
drivers that expose hundreds of kcontrols, the performance gain
becomes significant.

I see that there is no snd_ctl_find_mixer_id_unlocked() variant, but
it should be trivial to add.


thanks,

Takashi

