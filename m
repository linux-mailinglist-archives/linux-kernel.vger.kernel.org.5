Return-Path: <linux-kernel+bounces-118530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89588BC35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD041C2862A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9088313341C;
	Tue, 26 Mar 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jMUR1KX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0MMiilL+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mCKqyz60";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZmYeRiyF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371C1CAA2;
	Tue, 26 Mar 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441530; cv=none; b=a5cvSQ5NNshB3yZ3L6lf/uPGba/bTRuqfRDBN3oz0pKF2R4dhQ7VS3MPg8n/PpZX3DKWGtCjDu/P6JppotH3kKIyPKm0NPgpp1yIZMJzrlQSAB5Mfn1wwIZFRi0j8Mswd0mQKqHvdc5ngXswBn33tf3+Zwe7xxTbzw0+jj8525Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441530; c=relaxed/simple;
	bh=eBTAxInTITOaeErmzo1CWw6lx2uzOSOpRzyTiEHPDHM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GV1g7Q6VHsaXjG4m/kqy9jqRsX+b1iKVAcHA2b4O2ruoAiB/lloC3UsiaL0smjxpWRtYyrYOtxOiDYsz0wNOxQYhnPZtZpqydqgTcJkHnRgo0Y+zxhyR6EzSCmSsqgvYdCfanqa7867q8npG5LcOtDPKlpN1+c4l+En/lUzOc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jMUR1KX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0MMiilL+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mCKqyz60; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZmYeRiyF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D596A5D30E;
	Tue, 26 Mar 2024 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711441525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HwNVZ8vGUi21YrBu1k8FuwFUwUUE5fxjqfIFZFMZ+k=;
	b=jMUR1KX4c8bP+yJX7noP9dez/VLUcJk965/nQDTn9KcW40zPmDgoG8Q9h8QwkPZ1QSsSUG
	GMnDpHwMw5oHlzClx7+VNWvGwCyBDUOIO0SnVH9Kc1wxM7iSHJPneIsAV22nLrfjDBgom2
	u25bmEAknet3W+6fRBlMbiZ4F0nHIXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711441525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HwNVZ8vGUi21YrBu1k8FuwFUwUUE5fxjqfIFZFMZ+k=;
	b=0MMiilL+9YcJzziMaaN7km4c/jk+tkSLE9wCXslZ0FAX/Zbh6CRfk8P25BIiUyh6Lyv+sp
	uA+IsT+/IK8Ut5DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711441524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HwNVZ8vGUi21YrBu1k8FuwFUwUUE5fxjqfIFZFMZ+k=;
	b=mCKqyz60GRI/FLSq4HDOZWL7YYmKSgT7IrCU+Y+b+61791e11cEe+RDhO2XGO5XQAfZGKu
	jQ2df7Sk7D+JJ6dNvYQVXZp+CCeVTCvcos5r3f0wVZ8S/ox1hbWcHoQFvPvwqLpexXG88W
	fVTZajj2DfIzIQ3itWey5ACF2LvgUNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711441524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HwNVZ8vGUi21YrBu1k8FuwFUwUUE5fxjqfIFZFMZ+k=;
	b=ZmYeRiyFrnqputND11OkO9rSDoTPOPOc6nOABLHb0HUYB6ARtyY6usg4wZy2SeI/cqDCeB
	VeuQMT7BBPcEliDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A17B8138A1;
	Tue, 26 Mar 2024 08:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6/mPJXSGAmYsXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Mar 2024 08:25:24 +0000
Date: Tue, 26 Mar 2024 09:25:26 +0100
Message-ID: <87zfulv1qh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: duoming@zju.edu.cn
Cc: "Takashi Iwai" <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: Re: [PATCH] ALSA: sh: aica: reorder cleanup operations to avoid UAF bug
In-Reply-To: <3c71609d.7271.18e79cbb047.Coremail.duoming@zju.edu.cn>
References: <20240325033946.47052-1-duoming@zju.edu.cn>
	<871q7yybeb.wl-tiwai@suse.de>
	<43e102f3.61dc.18e7601a2f2.Coremail.duoming@zju.edu.cn>
	<874jcuxtf9.wl-tiwai@suse.de>
	<75af0c57.6e39.18e796e478f.Coremail.duoming@zju.edu.cn>
	<875xx9wjv6.wl-tiwai@suse.de>
	<3c71609d.7271.18e79cbb047.Coremail.duoming@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -5.51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mCKqyz60;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZmYeRiyF
X-Rspamd-Queue-Id: D596A5D30E

On Tue, 26 Mar 2024 09:06:15 +0100,
duoming@zju.edu.cn wrote:
> 
> On Tue, 26 Mar 2024 08:08:29 +0100 Takashi Iwai wrote:
> > > > > > > The dreamcastcard->timer could schedule the spu_dma_work and the
> > > > > > > spu_dma_work could also arm the dreamcastcard->timer.
> > > > > > > 
> > > > > > > When the Yamaha AICA card is closing, the dreamcastcard->channel
> > > > > > > will be deallocated. But it could still be dereferenced in the
> > > > > > > worker thread. The reason is that del_timer() will return directly
> > > > > > > regardless of whether the timer handler is running or not and the
> > > > > > > worker could be rescheduled in the timer handler. As a result, the
> > > > > > > UAF bug will happen. The racy situation is shown below:
> > > > > > > 
> > > > > > >       (Thread 1)                 |      (Thread 2)
> > > > > > > snd_aicapcm_pcm_close()          |
> > > > > > >  ...                             |  run_spu_dma() //worker
> > > > > > >                                  |    mod_timer()
> > > > > > >   flush_work()                   |
> > > > > > >   del_timer()                    |  aica_period_elapsed() //timer
> > > > > > >   kfree(dreamcastcard->channel)  |    schedule_work()
> > > > > > >                                  |  run_spu_dma() //worker
> > > > > > >   ...                            |    dreamcastcard->channel-> //USE
> > > > > > > 
> > > > > > > In order to mitigate this bug, use timer_shutdown_sync() to shutdown
> > > > > > > the timer and then use flush_work() to cancel the worker.
> > > > > > > 
> > > > > > > Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
> > > > > > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > > > > > ---
> > > > > > >  sound/sh/aica.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> > > > > > > index 320ac792c7f..bc68a3903f2 100644
> > > > > > > --- a/sound/sh/aica.c
> > > > > > > +++ b/sound/sh/aica.c
> > > > > > > @@ -354,8 +354,8 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
> > > > > > >  				 *substream)
> > > > > > >  {
> > > > > > >  	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> > > > > > > +	timer_shutdown_sync(&dreamcastcard->timer);
> > > > > > 
> > > > > > I thought this call invalidates the timer object, hence it can't be
> > > > > > used again; i.e. it breaks when the stream is re-opened, I suppose?
> > > > > >
> > > > > > In general timer_shutdown*() is used for the code path to clean up the
> > > > > > driver (or the object the timer belongs to).  The PCM close is only
> > > > > > about the PCM stream, and it's not the place.
> > > > > > 
> > > > > > A proper fix would be rather to implement two things:
> > > > > > - Call mod_timer() conditionally in run_spu_dma()
> > > > > > - Implement PCM sync_stop op to cancel/flush the work
> > > > > > 
> > > > > > The former alone should suffice to fix the UAF in your scenario,
> > > > > > though.  The latter will cover other possible corner cases.
> > > > > 
> > > > > Thank you for your time and reply! I know using timer_shutdown_sync()
> > > > > is not proper. In order to solve the problem, I add a shutdown flag 
> > > > > in the struct snd_card_aica and set the flag to true when the PCM 
> > > > > stream is closing. Then call mod_timer() conditionally in run_spu_dma().
> > > > > What's more, use del_timer_sync() to stop the timer and put it before 
> > > > > flush_work(). As a result, both timer and worker could be stopped safely. 
> > > > > The detail is shown below:
> > > > 
> > > > You can use the existing API to check the PCM running state, e.g.
> > > > 
> > > > --- a/sound/sh/aica.c
> > > > +++ b/sound/sh/aica.c
> > > > @@ -278,7 +278,8 @@ static void run_spu_dma(struct work_struct *work)
> > > >  		dreamcastcard->clicks++;
> > > >  		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
> > > >  			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
> > > > -		mod_timer(&dreamcastcard->timer, jiffies + 1);
> > > > +		if (snd_pcm_running(dreamcastcard->substream))
> > > > +			mod_timer(&dreamcastcard->timer, jiffies + 1);
> > > >  	}
> > > >  }
> > > 
> > > Thank you for your suggestions, The following is a new plan using the
> > > existing API to mitigate the bug.
> > > 
> > > diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> > > index 320ac792c7fe..bc003dd91a82 100644
> > > --- a/sound/sh/aica.c
> > > +++ b/sound/sh/aica.c
> > > @@ -278,7 +278,8 @@ static void run_spu_dma(struct work_struct *work)
> > >                 dreamcastcard->clicks++;
> > >                 if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
> > >                         dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
> > > -               mod_timer(&dreamcastcard->timer, jiffies + 1);
> > > +               if (snd_pcm_running(dreamcastcard->substream))
> > > +                       mod_timer(&dreamcastcard->timer, jiffies + 1);
> > >         }
> > >  }
> > > 
> > > @@ -316,6 +317,7 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
> > >         struct snd_pcm_runtime *runtime;
> > >         runtime = substream->runtime;
> > >         dreamcastcard = substream->pcm->private_data;
> > > +       __snd_pcm_set_state(runtime, SNDRV_PCM_STATE_RUNNING);
> > 
> > Such an explicit state change isn't needed, rather wrong.
> > The above condition check is performed only when kicked off from the
> > timer handler, and that's always after the stream started.
> > 
> > > @@ -354,8 +357,9 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
> > >                                  *substream)
> > >  {
> > >         struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> > > +       __snd_pcm_set_state(substream->runtime, SNDRV_PCM_STATE_DISCONNECTED);
> > 
> > This breaks things again!  You don't disconnect the device at closing
> > the stream at all.  And the state change is handled in PCM core side,
> > not in the driver side.
> > 
> > > +       del_timer_sync(&dreamcastcard->timer);
> > >         flush_work(&(dreamcastcard->spu_dma_work));
> > > -       del_timer(&dreamcastcard->timer);
> > 
> > I'd leave this unchanged.  The UAF itself is covered by the stream
> > state check.  And, if any, we can change more properly:
> 
> I think if we leave the cleanup operations unchanged, the UAF could 
> still happen. The scenario is shown below:
> 
>       (Thread 1)                 |      (Thread 2)
>                                  |  run_spu_dma() //worker
>                                  |    if (snd_pcm_running(dreamcastcard->substream))
> snd_aicapcm_pcm_close()          |
>  ...                             |  
>                                  |    mod_timer()
>   flush_work()                   |
>   del_timer()                    |  aica_period_elapsed() //timer
>   kfree(dreamcastcard->channel)  |    schedule_work()
>                                  |  run_spu_dma() //worker
>   ...                            |    dreamcastcard->channel-> //USE
> 
> So we should implement PCM sync_stop ops like below.
> 
> > - Add the same PCM state check at the beginning of
> >   aica_period_elapsed(), and bail out immediately if not running
> > 
> > - Implement PCM sync_stop ops:
> >   it should have like
> > 
> > static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
> > {
> > 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> > 
> > 	del_timer_sync(&dreamcastcard->timer);
> > 	cancel_work_sync(&dreamcastcard->spu_dma_work);
> > 	return 0;
> > }
> > 
> >   and get rid of the corresponding calls from snd_aicapcm_pcm_close()
> 
> Thank you for your suggestions, the improved plan is shown below:
> 
> diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> index 320ac792c7f..2989407606f 100644
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
> @@ -290,6 +291,8 @@ static void aica_period_elapsed(struct timer_list *t)
>         /*timer function - so cannot sleep */
>         int play_period;
>         struct snd_pcm_runtime *runtime;
> +       if (!snd_pcm_running(substream))
> +               return;
>         runtime = substream->runtime;
>         dreamcastcard = substream->pcm->private_data;
>         /* Have we played out an additional period? */
> @@ -350,12 +353,20 @@ static int snd_aicapcm_pcm_open(struct snd_pcm_substream
>         return 0;
>  }
> 
> +static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
> +{
> +       struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> +
> +       del_timer_sync(&dreamcastcard->timer);
> +       cancel_work_sync(&dreamcastcard->spu_dma_work);
> +       return 0;
> +}
> +
>  static int snd_aicapcm_pcm_close(struct snd_pcm_substream
>                                  *substream)
>  {
>         struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
> -       flush_work(&(dreamcastcard->spu_dma_work));
> -       del_timer(&dreamcastcard->timer);
> +       snd_aicapcm_pcm_sync_stop(substream);
>         dreamcastcard->substream = NULL;
>         kfree(dreamcastcard->channel);
>         spu_disable();

Don't call it here explicitly.  sync_stop is a PCM op, i.e. add
snd_aicapcm_pcm_sync_stop to snd_aicapcm_playback_ops definition,
instead.
Then it'll be called from PCM core appropriately when needed
(e.g. before calling the close callback via hw_free call).


thanks,

Takashi

