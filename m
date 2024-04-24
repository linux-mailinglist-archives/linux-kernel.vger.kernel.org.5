Return-Path: <linux-kernel+bounces-156483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FD8B0321
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0BC1C242A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272E157E6E;
	Wed, 24 Apr 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJUFihmQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="052F/Kuj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJUFihmQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="052F/Kuj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDD157478;
	Wed, 24 Apr 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943484; cv=none; b=P1aQBYrDA8qlggUNqbSWbEwijhtLQ7QnCZAX5Swa0kqXeGl/5NSZdLESNvXxx2xzB1PlRSVrJuZqp73WcuH/ga6ai7J/eo9uZai2OwHIU3XRcXRefouWESTKOHD5wdjIlhiBpYVpGBvGeq5wg8DgJPkeyYvalA82gXbh9JX45p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943484; c=relaxed/simple;
	bh=YbZB/+5TpAoCnauXoU3cpYQqczYGgGL2RNOzRj9VfK4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTZ0gIm3G1iPDlcCTgH0oCwYjBBjcLvPMfrqsM/6H0bwKjD4s47oGS5ZaajPOkUHgiZgUwRjijo+GJZoMKNOyvxPaqGX+BNx2QEEAhbNdLEFae+8VHQzTyrOiJJV/eIbHDHkbzik1BT0eO9LeWxzo6FTfDHtD6WxaTotywG+m3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJUFihmQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=052F/Kuj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJUFihmQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=052F/Kuj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45D76610CB;
	Wed, 24 Apr 2024 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713943480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xykwgGOYFauBfbd8C637dSjyaIqoLTSspkq4htR5Jok=;
	b=iJUFihmQX81Ptjdvcn3qwDRebaPni3L+YmUvEdyBvpKKhq0FJLWTWynRM/fXOpPDu6u8jH
	CVD4tr5U30SC0xuWWxm4Oox6mXP2eCzqKH4tTceY1QWWsRwbr9AjZz6dtB3CXMcCa5wy6u
	DNb8lMR2s84mNHvzavZxnH4pRqu1lKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713943480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xykwgGOYFauBfbd8C637dSjyaIqoLTSspkq4htR5Jok=;
	b=052F/KujTMP5lyDzv7MOpQFUxTYC0kUzj5wA35LSevtTnwN0oaz5+y3ubQOwRGBBwNPXtB
	q7LXzs2jODqqLWAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iJUFihmQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="052F/Kuj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713943480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xykwgGOYFauBfbd8C637dSjyaIqoLTSspkq4htR5Jok=;
	b=iJUFihmQX81Ptjdvcn3qwDRebaPni3L+YmUvEdyBvpKKhq0FJLWTWynRM/fXOpPDu6u8jH
	CVD4tr5U30SC0xuWWxm4Oox6mXP2eCzqKH4tTceY1QWWsRwbr9AjZz6dtB3CXMcCa5wy6u
	DNb8lMR2s84mNHvzavZxnH4pRqu1lKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713943480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xykwgGOYFauBfbd8C637dSjyaIqoLTSspkq4htR5Jok=;
	b=052F/KujTMP5lyDzv7MOpQFUxTYC0kUzj5wA35LSevtTnwN0oaz5+y3ubQOwRGBBwNPXtB
	q7LXzs2jODqqLWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21BB613690;
	Wed, 24 Apr 2024 07:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d1ZOB7izKGakFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Apr 2024 07:24:40 +0000
Date: Wed, 24 Apr 2024 09:24:49 +0200
Message-ID: <87h6frdxz2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ALSA: control: Use list_for_each_entry_safe()
In-Reply-To: <20240423211102.3785556-1-andriy.shevchenko@linux.intel.com>
References: <20240423211102.3785556-1-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.12
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 45D76610CB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.12 / 50.00];
	BAYES_HAM(-1.61)[92.50%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, 23 Apr 2024 23:10:22 +0200,
Andy Shevchenko wrote:
> 
> Instead of reiterating the list, use list_for_each_entry_safe()
> that allows to continue without starting over.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> ---
> v2: added tag (Jaroslav)

We have a similar repeat in snd_ctl_led_reset().
Wouldn't it be better to catch both?


thanks,

Takashi

>  sound/core/control_led.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index 061a8ea23340..ea95405c76a4 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -290,16 +290,13 @@ static void snd_ctl_led_clean(struct snd_card *card)
>  {
>  	unsigned int group;
>  	struct snd_ctl_led *led;
> -	struct snd_ctl_led_ctl *lctl;
> +	struct snd_ctl_led_ctl *lctl, *_lctl;
>  
>  	for (group = 0; group < MAX_LED; group++) {
>  		led = &snd_ctl_leds[group];
> -repeat:
> -		list_for_each_entry(lctl, &led->controls, list)
> -			if (!card || lctl->card == card) {
> +		list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
> +			if (!card || lctl->card == card)
>  				snd_ctl_led_ctl_destroy(lctl);
> -				goto repeat;
> -			}
>  	}
>  }
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

