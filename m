Return-Path: <linux-kernel+bounces-118870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6C88C07A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3171F3F88E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1959B6F;
	Tue, 26 Mar 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nanpw0Nl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SNN5bTqH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nanpw0Nl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SNN5bTqH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D555C33;
	Tue, 26 Mar 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451992; cv=none; b=o7oPuIaAoGvFrU9Y7XDnJTNu7mbmvnnAAB9TwMADAz24knS+cn43Fbequej0M9Y37CT494H1+YvfAarFjRAw/i/kdvsRAlDRpPGCs4fJG2NmzEN921enqILnlt5J+BeTvp7S+4eXMBaqxe8G/VfXvKDYSD9hAcD4O2yP61Vjw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451992; c=relaxed/simple;
	bh=cxhWoUYtJZZNiOZfAH8xkrcFMUu4hcm2fAHSkSR/9gE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+SQQ/21w/Zm7F+sLHXsOVMci676waqdMhHqEmL+0JU26ye1JRdtS/pCiBHeXRA0RLQCUixKcgiFzf3RX9Gk7GI37H+kwGrDz8ht6RFHu+qcdixEPm21SHpdecqNGWVjnvBkpVFJ4V7y8GSxqMJuAurrlFCX10/sGvpCyjhGmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nanpw0Nl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SNN5bTqH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nanpw0Nl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SNN5bTqH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A17215CC2A;
	Tue, 26 Mar 2024 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711451988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u83TdCBVrchsJlkkgVuqOm/eHzpeZOQaY4sR+M9ssWE=;
	b=Nanpw0NlyJq7/olIQfRWLdoeO9mqWpO+Ra+hsJOjcIsex2H48VPVKUjvLNwTfOdFmfWkki
	yW6ELCVpaQyKkFBVQrS6RPTqt/ZaX35OTf/uJkUF1h2UQo7U181/92YIVVRxZqXOAg7rMR
	fCRhLEooRbcDEAQx3BT0Mu1UH+v9OFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711451988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u83TdCBVrchsJlkkgVuqOm/eHzpeZOQaY4sR+M9ssWE=;
	b=SNN5bTqHoZjjMgi1X4F3ly9GXE9CODoERNdJHDEiSnkimKsO+fSRDy8SpcXUGcCtK460xi
	wdmxQ5vg6ycF2PDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711451988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u83TdCBVrchsJlkkgVuqOm/eHzpeZOQaY4sR+M9ssWE=;
	b=Nanpw0NlyJq7/olIQfRWLdoeO9mqWpO+Ra+hsJOjcIsex2H48VPVKUjvLNwTfOdFmfWkki
	yW6ELCVpaQyKkFBVQrS6RPTqt/ZaX35OTf/uJkUF1h2UQo7U181/92YIVVRxZqXOAg7rMR
	fCRhLEooRbcDEAQx3BT0Mu1UH+v9OFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711451988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u83TdCBVrchsJlkkgVuqOm/eHzpeZOQaY4sR+M9ssWE=;
	b=SNN5bTqHoZjjMgi1X4F3ly9GXE9CODoERNdJHDEiSnkimKsO+fSRDy8SpcXUGcCtK460xi
	wdmxQ5vg6ycF2PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E97F13306;
	Tue, 26 Mar 2024 11:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cSodGVSvAmbiDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Mar 2024 11:19:48 +0000
Date: Tue, 26 Mar 2024 12:19:50 +0100
Message-ID: <87msqlutnt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: Re: [PATCH v2] ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs
In-Reply-To: <20240326094238.95442-1-duoming@zju.edu.cn>
References: <20240326094238.95442-1-duoming@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nanpw0Nl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SNN5bTqH
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.67)[92.96%]
X-Spam-Score: -2.18
X-Rspamd-Queue-Id: A17215CC2A
X-Spam-Flag: NO

On Tue, 26 Mar 2024 10:42:38 +0100,
Duoming Zhou wrote:
> 
> The dreamcastcard->timer could schedule the spu_dma_work and the
> spu_dma_work could also arm the dreamcastcard->timer.
> 
> When the snd_pcm_substream is closing, the aica_channel will be
> deallocated. But it could still be dereferenced in the worker
> thread. The reason is that del_timer() will return directly
> regardless of whether the timer handler is running or not and
> the worker could be rescheduled in the timer handler. As a result,
> the UAF bug will happen. The racy situation is shown below:
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
> In order to mitigate this bug and other possible corner cases,
> call mod_timer() conditionally in run_spu_dma(), then implement
> PCM sync_stop op to cancel both the timer and worker. The sync_stop
> op will be called from PCM core appropriately when needed.
> 
> Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - call mod_timer() conditionally and implement PCM sync_stop op.

Thanks, applied now.


Takashi

