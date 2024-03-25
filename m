Return-Path: <linux-kernel+bounces-116684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6D88AA11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B61B31097
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62B58205;
	Mon, 25 Mar 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h+hSJkiV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hus24AQd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h+hSJkiV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hus24AQd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F3174979;
	Mon, 25 Mar 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354576; cv=none; b=T5x54mKEE15WAUegRKXk86pE/bYrh4vnlF0TqjFRhrwRp250l3WRtHTH39+9F+jX4yOYVhyG42dJIc1feG4Csw0lGVgK41Pe8HpClodLZ+jHplKH5eJ5jSryEc5dY7xF3OfzaimGceKVg4PIYm/YOeX3ttkmTKKi41ANQxjjd3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354576; c=relaxed/simple;
	bh=zrpt65om+iFNhdhCeiZbSfF3Jv4eME/tnsKBlV+Rodg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhjtVY/r3/14tlBBmQBWZ0sljnZSGmOFXaQfQeEW/jI1X1TKSxOALHiM8OVtXvnzdQ1LHzxxB9ATMBhlDTB64VOzNBzwVHaOuwB9GfhAnS+XJM6m1w8veJgy/8n/qAkuyhCCnxNlR+2AreVprfMuRw+hAJeRplyh2pB19EAj1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h+hSJkiV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hus24AQd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h+hSJkiV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hus24AQd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C8A65C3F3;
	Mon, 25 Mar 2024 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711354571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPXGAo84hXrpIzyI362ELzciOl/SodbSHAdeHfFNjKc=;
	b=h+hSJkiVvjXwku6P6oA6/VC+g9lTw7f4lNaYgy4ony4i60Wap/SkOGZsBHaAzBUCH92Dcz
	hK+mDB9tR1ihmIyL4DWrXksknR3f5K3bniMgyB4B4gXO/otzI08SbeDbYM/dQ1984Fzn8/
	qnkDAtPYDqoHVq4tGN6hXzt5ednjjzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711354571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPXGAo84hXrpIzyI362ELzciOl/SodbSHAdeHfFNjKc=;
	b=hus24AQdlUPGy0yA2MGxReqSDXRkzzagSOFvBTlU0h1d7ct0z9+oDNhtSCO9KZlqSMvUzO
	72wkBkmPLi6ZD9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711354571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPXGAo84hXrpIzyI362ELzciOl/SodbSHAdeHfFNjKc=;
	b=h+hSJkiVvjXwku6P6oA6/VC+g9lTw7f4lNaYgy4ony4i60Wap/SkOGZsBHaAzBUCH92Dcz
	hK+mDB9tR1ihmIyL4DWrXksknR3f5K3bniMgyB4B4gXO/otzI08SbeDbYM/dQ1984Fzn8/
	qnkDAtPYDqoHVq4tGN6hXzt5ednjjzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711354571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPXGAo84hXrpIzyI362ELzciOl/SodbSHAdeHfFNjKc=;
	b=hus24AQdlUPGy0yA2MGxReqSDXRkzzagSOFvBTlU0h1d7ct0z9+oDNhtSCO9KZlqSMvUzO
	72wkBkmPLi6ZD9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C83E713503;
	Mon, 25 Mar 2024 08:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pnlTLMoyAWZeHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 25 Mar 2024 08:16:10 +0000
Date: Mon, 25 Mar 2024 09:16:12 +0100
Message-ID: <871q7yybeb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: Re: [PATCH] ALSA: sh: aica: reorder cleanup operations to avoid UAF bug
In-Reply-To: <20240325033946.47052-1-duoming@zju.edu.cn>
References: <20240325033946.47052-1-duoming@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[30.01%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[zju.edu.cn:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon, 25 Mar 2024 04:39:46 +0100,
Duoming Zhou wrote:
> 
> The dreamcastcard->timer could schedule the spu_dma_work and the
> spu_dma_work could also arm the dreamcastcard->timer.
> 
> When the Yamaha AICA card is closing, the dreamcastcard->channel
> will be deallocated. But it could still be dereferenced in the
> worker thread. The reason is that del_timer() will return directly
> regardless of whether the timer handler is running or not and the
> worker could be rescheduled in the timer handler. As a result, the
> UAF bug will happen. The racy situation is shown below:
> 
>       (Thread 1)                 |      (Thread 2)
> snd_aicapcm_pcm_close()          |
>  ...                             |  run_spu_dma() //worker
>                                  |    mod_timer()
>   flush_work()                   |
>   del_timer()                    |  aica_period_elapsed() //timer
>   kfree(dreamcastcard->channel)  |    schedule_work()
>                                  |  run_spu_dma() //worker
>   ...                            |    dreamcastcard->channel-> //USE
> 
> In order to mitigate this bug, use timer_shutdown_sync() to shutdown
> the timer and then use flush_work() to cancel the worker.
> 
> Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  sound/sh/aica.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> index 320ac792c7f..bc68a3903f2 100644
> --- a/sound/sh/aica.c
> +++ b/sound/sh/aica.c
> @@ -354,8 +354,8 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
>  				 *substream)
>  {
>  	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> +	timer_shutdown_sync(&dreamcastcard->timer);

I thought this call invalidates the timer object, hence it can't be
used again; i.e. it breaks when the stream is re-opened, I suppose?

In general timer_shutdown*() is used for the code path to clean up the
driver (or the object the timer belongs to).  The PCM close is only
about the PCM stream, and it's not the place.

A proper fix would be rather to implement two things:
- Call mod_timer() conditionally in run_spu_dma()
- Implement PCM sync_stop op to cancel/flush the work

The former alone should suffice to fix the UAF in your scenario,
though.  The latter will cover other possible corner cases.


thanks,

Takashi


>  	flush_work(&(dreamcastcard->spu_dma_work));
> -	del_timer(&dreamcastcard->timer);
>  	dreamcastcard->substream = NULL;
>  	kfree(dreamcastcard->channel);
>  	spu_disable();
> -- 
> 2.17.1
> 

