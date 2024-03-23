Return-Path: <linux-kernel+bounces-112278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103078877CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE921C20CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1BF9FE;
	Sat, 23 Mar 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OPbChKgC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZuIG7HtC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RzmjmKcs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I9Lv+MVs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01902DDA7;
	Sat, 23 Mar 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186166; cv=none; b=P+FBZ6awl0mq1htINgLZZ+YpgSzHzD8SrZjfvkbRaWhDx+MZqz4YfnFRg3xtPb8Lm2qk7nry0AZAEv3amHBcEGgh9dJw4YUzcCyQorHD3u5XKpyzZrHJeqqK79mhPCbvrN3Qke1LB8JFGNkmshuFBDJB5JEPCkgO8FWbFID0gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186166; c=relaxed/simple;
	bh=H7oYposl0GwFoIb6IHUNAm2CvsLwYCv10sk+TgtI4Yc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuVXYLsjI53DDM4YrQkuD9QxIVcLp8uXXsyfaCEQ6O7lcLSZEgvGE3ZVDqipCcanXHVlL18iw/H8hAIRpDByNsthdNQLOniQieQff8YRaZEFV3ty+LmD6dmc7blaUhlfNd9PiauPTGNKZpI7JPj6evmfE/iKZJm7SYGUHsb4bPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OPbChKgC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZuIG7HtC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RzmjmKcs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I9Lv+MVs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E73BA3E721;
	Sat, 23 Mar 2024 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711186163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foR8jJ3NyeoOmucMmLm1YR46lFSkeRKHrCwZRfXvYhc=;
	b=OPbChKgCcSBIlVKbl3/4HX5w6MDx71UsUPtzBjYYXfdl8Y9/6Fpp2Oy88ZLBDv8+zBpzrl
	uxsEmgC6TsBk82Hw6YbDvMF0TvK+qpygfwzfELtRXCdvdOdnbL4wVbBpeSuQxTPhWMAjtL
	lko41dBXgvDnjapGcEK8CFEmSwiJq0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711186163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foR8jJ3NyeoOmucMmLm1YR46lFSkeRKHrCwZRfXvYhc=;
	b=ZuIG7HtCP+C9HvccyF4URLF2X99l4HvlFf3MGvAgjh1pXhdS7CMGha4HrU5/ten02mjKWs
	L2hjWBj4s3/LD1BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711186162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foR8jJ3NyeoOmucMmLm1YR46lFSkeRKHrCwZRfXvYhc=;
	b=RzmjmKcs0aS/J4xs9c1s2PVlnCkFt7WnGgImU+Emsytn+adZ08ICvPdUgNqn7YqY48F8rQ
	d7G5pDBFcwETQuZv6QtkDoflwTzJmWKeHLlcbVOpALCwx/l2IyMmQDVQt5DxftRbi/tESr
	vtxwfYokvjSlFxSUX0UzMB73RaFUa1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711186162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foR8jJ3NyeoOmucMmLm1YR46lFSkeRKHrCwZRfXvYhc=;
	b=I9Lv+MVsZGS1FDrHalI5TaDAjkib65mYoTggHh/rfUbJAmPebRxrP8BRKbe3ijSpuS8G0D
	LXnkLs9ijtu+zyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE4A2136A1;
	Sat, 23 Mar 2024 09:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n1CgKPKg/mX9IgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 23 Mar 2024 09:29:22 +0000
Date: Sat, 23 Mar 2024 10:29:22 +0100
Message-ID: <87msqpxpn1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: LuMingYin <lumingyindetect@163.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	minhuadotchen@gmail.com
Subject: Re: [PATCH] sound:Fix a memory leak related to variable data
In-Reply-To: <20240323080413.641089-1-lumingyindetect@163.com>
References: <20240323080413.641089-1-lumingyindetect@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[163.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,perex.cz,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RzmjmKcs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I9Lv+MVs
X-Rspamd-Queue-Id: E73BA3E721

On Sat, 23 Mar 2024 09:04:13 +0100,
LuMingYin wrote:
> 
> In the file /linux/sound/core/control_compat.c, a pointer named 'data' is defined at line 82. This pointer allocates a block of dynamic memory using the 'kzalloc' function at line 85. When the if statement at line 86 returns false, it indicates successful allocation of the dynamic memory area pointed to by 'data'. However, when the if statement at line 90 returns true, the program returns at line 91. During this process, the dynamic memory area pointed to by 'data' is neither used as in the switch statement at line 108 nor deallocated, leading to a memory leak bug. The if statement at line 95 also has the same issue. This commit fixes this problem.
> 
> Signed-off-by: LuMingYin <lumingyindetect@163.com>

It's using the new automatic free mechanism.  See the commit
1052d9882269 ("ALSA: control: Use automatic cleanup of kfree()")


thanks,

Takashi


> ---
>  sound/core/control_compat.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
> index 934bb945e702..32113eb06f68 100644
> --- a/sound/core/control_compat.c
> +++ b/sound/core/control_compat.c
> @@ -87,13 +87,19 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
>  		return -ENOMEM;
>  
>  	/* copy id */
> -	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
> +	if (copy_from_user(&data->id, &data32->id, sizeof(data->id))){
> +		kfree(data);
> +		data = NULL;
>  		return -EFAULT;
> +	}
>  	/* we need to copy the item index.
>  	 * hope this doesn't break anything..
>  	 */
> -	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
> +	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item)){
> +		kfree(data);
> +		data = NULL;
>  		return -EFAULT;
> +	}
>  
>  	err = snd_ctl_elem_info(ctl, data);
>  	if (err < 0)
> -- 
> 2.25.1
> 

