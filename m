Return-Path: <linux-kernel+bounces-118445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13ED88BAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D442E20CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617312EBE1;
	Tue, 26 Mar 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="huTx0jkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k401TvKr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="huTx0jkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k401TvKr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834B128394;
	Tue, 26 Mar 2024 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436911; cv=none; b=DhT7zqQ8yHSOZogj2o/uh5xxttiHlSnJQCmtbkBzl7OK4t9JvrISM8JdhoZ2W9IVxBsg6CnIiThVmmvfBZeuimzpI/dm+OuyuDlG+aMPCmp0cFSN/hr3Eed3zsBBrG9kfQViSR6rXLD+0ZimbXzzTRqtdfFjt9UmlUX3c+0jxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436911; c=relaxed/simple;
	bh=n2hd0h+IMI9EUi59bqCDnD0Jo2dp7ZKvVfWC7VLjrgc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhOR97dPvwzbB+/Z5LZ+a1wTVBOQ4XX7t7/YSPE5NdVhfm274PdPTfw8oh8OEjxHm1EXPm0WjWATM2saQtDxXL5BJDU1WlF5fMtvO/V4W3szOhdx5vUINfdsSO/hVuXTYNpw0PR4E3PfCBQJDK9RTazmrjEJdPyXSnmwIm9wL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=huTx0jkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k401TvKr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=huTx0jkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k401TvKr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 320F237883;
	Tue, 26 Mar 2024 07:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711436908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9UVBcIjuVArecGJ6s7V8AL3G2kns/v6DY1WhKcSvhE=;
	b=huTx0jkmh13C5WyoBCysgaHvGE0wodtYSL+O58LiObkRHn0xiclNMot/je5rNa+nRj7eCM
	DBmjeyluACV0LLGLAbx3s+h93pI7r9FeelP+OsAyxQbqMycfoTazB6CrEJe9vZ5DtWwi8o
	+3mHUFbRk1Sp+IG7TJSMu+SXe0t8nH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711436908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9UVBcIjuVArecGJ6s7V8AL3G2kns/v6DY1WhKcSvhE=;
	b=k401TvKrL8szf1Lt+7DZ/5UlMUSeQeRJDj1xjCHdkYaRLtoFGmQKkHFJ3HCMF4utTvjUlK
	43W/CgWdXvXBdQDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711436908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9UVBcIjuVArecGJ6s7V8AL3G2kns/v6DY1WhKcSvhE=;
	b=huTx0jkmh13C5WyoBCysgaHvGE0wodtYSL+O58LiObkRHn0xiclNMot/je5rNa+nRj7eCM
	DBmjeyluACV0LLGLAbx3s+h93pI7r9FeelP+OsAyxQbqMycfoTazB6CrEJe9vZ5DtWwi8o
	+3mHUFbRk1Sp+IG7TJSMu+SXe0t8nH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711436908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9UVBcIjuVArecGJ6s7V8AL3G2kns/v6DY1WhKcSvhE=;
	b=k401TvKrL8szf1Lt+7DZ/5UlMUSeQeRJDj1xjCHdkYaRLtoFGmQKkHFJ3HCMF4utTvjUlK
	43W/CgWdXvXBdQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E439F13306;
	Tue, 26 Mar 2024 07:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L5dhNWt0AmaiTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Mar 2024 07:08:27 +0000
Date: Tue, 26 Mar 2024 08:08:29 +0100
Message-ID: <875xx9wjv6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: duoming@zju.edu.cn
Cc: "Takashi Iwai" <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: Re: [PATCH] ALSA: sh: aica: reorder cleanup operations to avoid UAF bug
In-Reply-To: <75af0c57.6e39.18e796e478f.Coremail.duoming@zju.edu.cn>
References: <20240325033946.47052-1-duoming@zju.edu.cn>
	<871q7yybeb.wl-tiwai@suse.de>
	<43e102f3.61dc.18e7601a2f2.Coremail.duoming@zju.edu.cn>
	<874jcuxtf9.wl-tiwai@suse.de>
	<75af0c57.6e39.18e796e478f.Coremail.duoming@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue, 26 Mar 2024 07:24:14 +0100,
duoming@zju.edu.cn wrote:
> 
> On Mon, 25 Mar 2024 15:44:26 +0100 Takashi Iwai wrote:
> > > > > The dreamcastcard->timer could schedule the spu_dma_work and the
> > > > > spu_dma_work could also arm the dreamcastcard->timer.
> > > > > 
> > > > > When the Yamaha AICA card is closing, the dreamcastcard->channel
> > > > > will be deallocated. But it could still be dereferenced in the
> > > > > worker thread. The reason is that del_timer() will return directly
> > > > > regardless of whether the timer handler is running or not and the
> > > > > worker could be rescheduled in the timer handler. As a result, the
> > > > > UAF bug will happen. The racy situation is shown below:
> > > > > 
> > > > >       (Thread 1)                 |      (Thread 2)
> > > > > snd_aicapcm_pcm_close()          |
> > > > >  ...                             |  run_spu_dma() //worker
> > > > >                                  |    mod_timer()
> > > > >   flush_work()                   |
> > > > >   del_timer()                    |  aica_period_elapsed() //timer
> > > > >   kfree(dreamcastcard->channel)  |    schedule_work()
> > > > >                                  |  run_spu_dma() //worker
> > > > >   ...                            |    dreamcastcard->channel-> //USE
> > > > > 
> > > > > In order to mitigate this bug, use timer_shutdown_sync() to shutdown
> > > > > the timer and then use flush_work() to cancel the worker.
> > > > > 
> > > > > Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
> > > > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > > > ---
> > > > >  sound/sh/aica.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> > > > > index 320ac792c7f..bc68a3903f2 100644
> > > > > --- a/sound/sh/aica.c
> > > > > +++ b/sound/sh/aica.c
> > > > > @@ -354,8 +354,8 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
> > > > >  				 *substream)
> > > > >  {
> > > > >  	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> > > > > +	timer_shutdown_sync(&dreamcastcard->timer);
> > > > 
> > > > I thought this call invalidates the timer object, hence it can't be
> > > > used again; i.e. it breaks when the stream is re-opened, I suppose?
> > > >
> > > > In general timer_shutdown*() is used for the code path to clean up the
> > > > driver (or the object the timer belongs to).  The PCM close is only
> > > > about the PCM stream, and it's not the place.
> > > > 
> > > > A proper fix would be rather to implement two things:
> > > > - Call mod_timer() conditionally in run_spu_dma()
> > > > - Implement PCM sync_stop op to cancel/flush the work
> > > > 
> > > > The former alone should suffice to fix the UAF in your scenario,
> > > > though.  The latter will cover other possible corner cases.
> > > 
> > > Thank you for your time and reply! I know using timer_shutdown_sync()
> > > is not proper. In order to solve the problem, I add a shutdown flag 
> > > in the struct snd_card_aica and set the flag to true when the PCM 
> > > stream is closing. Then call mod_timer() conditionally in run_spu_dma().
> > > What's more, use del_timer_sync() to stop the timer and put it before 
> > > flush_work(). As a result, both timer and worker could be stopped safely. 
> > > The detail is shown below:
> > 
> > You can use the existing API to check the PCM running state, e.g.
> > 
> > --- a/sound/sh/aica.c
> > +++ b/sound/sh/aica.c
> > @@ -278,7 +278,8 @@ static void run_spu_dma(struct work_struct *work)
> >  		dreamcastcard->clicks++;
> >  		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
> >  			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
> > -		mod_timer(&dreamcastcard->timer, jiffies + 1);
> > +		if (snd_pcm_running(dreamcastcard->substream))
> > +			mod_timer(&dreamcastcard->timer, jiffies + 1);
> >  	}
> >  }
> 
> Thank you for your suggestions, The following is a new plan using the
> existing API to mitigate the bug.
> 
> diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> index 320ac792c7fe..bc003dd91a82 100644
> --- a/sound/sh/aica.c
> +++ b/sound/sh/aica.c
> @@ -278,7 +278,8 @@ static void run_spu_dma(struct work_struct *work)
>                 dreamcastcard->clicks++;
>                 if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
>                         dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
> -               mod_timer(&dreamcastcard->timer, jiffies + 1);
> +               if (snd_pcm_running(dreamcastcard->substream))
> +                       mod_timer(&dreamcastcard->timer, jiffies + 1);
>         }
>  }
> 
> @@ -316,6 +317,7 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
>         struct snd_pcm_runtime *runtime;
>         runtime = substream->runtime;
>         dreamcastcard = substream->pcm->private_data;
> +       __snd_pcm_set_state(runtime, SNDRV_PCM_STATE_RUNNING);

Such an explicit state change isn't needed, rather wrong.
The above condition check is performed only when kicked off from the
timer handler, and that's always after the stream started.

> @@ -354,8 +357,9 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
>                                  *substream)
>  {
>         struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> +       __snd_pcm_set_state(substream->runtime, SNDRV_PCM_STATE_DISCONNECTED);

This breaks things again!  You don't disconnect the device at closing
the stream at all.  And the state change is handled in PCM core side,
not in the driver side.

> +       del_timer_sync(&dreamcastcard->timer);
>         flush_work(&(dreamcastcard->spu_dma_work));
> -       del_timer(&dreamcastcard->timer);

I'd leave this unchanged.  The UAF itself is covered by the stream
state check.  And, if any, we can change more properly:

- Add the same PCM state check at the beginning of
  aica_period_elapsed(), and bail out immediately if not running

- Implement PCM sync_stop ops:
  it should have like

static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
{
	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;

	del_timer_sync(&dreamcastcard->timer);
	cancel_work_sync(&dreamcastcard->spu_dma_work);
	return 0;
}

  and get rid of the corresponding calls from snd_aicapcm_pcm_close()


thanks,

Takashi

