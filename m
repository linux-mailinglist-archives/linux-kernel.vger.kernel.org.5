Return-Path: <linux-kernel+bounces-84662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4D86A9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B0B23F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12642C6BD;
	Wed, 28 Feb 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RqxuxW7r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xyKVfKU5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RqxuxW7r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xyKVfKU5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF292C6A7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108424; cv=none; b=dejZAi/ekO1Pi0dLJD4RWwMo5vSwDJZZGDqP5hvVh4uTuPv1ddM1A0IHSwM0BS7QHU0xNISDGTIIcwBdzoF66IsEOLdnPs5HHTW8AGcG6mQKrPtt10VR11s5dgOZLDPS3ogSwdYdiPNVIBfAyykfUfMJyD4QyZ/efBRtB77hcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108424; c=relaxed/simple;
	bh=1bYqA36wO+dMo6ElEtiZO52eiDvjT/jZFlj9vPWgQOY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCt/IN9XGkuO6hAcrmdIOBC9yyH05hfOT14+Lm5zljF3M2V7idQD/uOdKR16RaoA6MYNb7KAKZy40MdvTNfLJMj0RNAtyhF7iruh+HGL3qidKmy0I7OlX4NW044G0dt0t79euv60Jj8UkFJmwYE692M2itewTHzH+XTLwfUTq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RqxuxW7r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xyKVfKU5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RqxuxW7r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xyKVfKU5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A804A223AA;
	Wed, 28 Feb 2024 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709108419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMR+qkbjCUKnlQqa2cWW/40LSnPugg005ObwlW3P/rI=;
	b=RqxuxW7rAS4w7WvOJxgJr8sLDnFgYmBMzE9MQym3aAZANHXg6nCv4/Sv26gzQ8tJ++wE14
	9CPIAeJuT8SQbTNtBL+lsRkau7SeZqGhZ50Sg6FMSZE+nQEbkzLFkC7fnmcA4fm0dNfsG4
	+hBf0M3PvI7GXIkCs1rdVgk1OEnlxMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709108419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMR+qkbjCUKnlQqa2cWW/40LSnPugg005ObwlW3P/rI=;
	b=xyKVfKU5heLmx00WpoOlFPswCj2lgRQ125pNkeMQoxw+/ZZdFInBIWnTpJbEJbm6bhF3eX
	xunZZtR5Cx9kZ7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709108419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMR+qkbjCUKnlQqa2cWW/40LSnPugg005ObwlW3P/rI=;
	b=RqxuxW7rAS4w7WvOJxgJr8sLDnFgYmBMzE9MQym3aAZANHXg6nCv4/Sv26gzQ8tJ++wE14
	9CPIAeJuT8SQbTNtBL+lsRkau7SeZqGhZ50Sg6FMSZE+nQEbkzLFkC7fnmcA4fm0dNfsG4
	+hBf0M3PvI7GXIkCs1rdVgk1OEnlxMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709108419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMR+qkbjCUKnlQqa2cWW/40LSnPugg005ObwlW3P/rI=;
	b=xyKVfKU5heLmx00WpoOlFPswCj2lgRQ125pNkeMQoxw+/ZZdFInBIWnTpJbEJbm6bhF3eX
	xunZZtR5Cx9kZ7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7270113A58;
	Wed, 28 Feb 2024 08:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RnxsGsPs3mWbGwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 28 Feb 2024 08:20:19 +0000
Date: Wed, 28 Feb 2024 09:20:19 +0100
Message-ID: <878r35huf0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: songxiebing <soxiebing@163.com>
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>
Subject: Re: [PATCH v1] ALSA: hda: optimize the probe codec process
In-Reply-To: <20240228074138.23679-1-soxiebing@163.com>
References: <20240228074138.23679-1-soxiebing@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RqxuxW7r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xyKVfKU5
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[163.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FREEMAIL_TO(0.00)[163.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A804A223AA
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Wed, 28 Feb 2024 08:41:38 +0100,
songxiebing wrote:
> 
> From: songxiebing <songxiebing@kylinos.cn>
> 
> In azx_probe_codecs function，when bus->codec_mask is becomes to 0(no codecs),
> execute azx_init_chip, bus->codec_mask will be initialized to a value again，
> this causes snd_hda_codec_new function to run, the process is as follows:
> -->snd_hda_codec_new
> -->snd_hda_codec_device_init
> -->snd_hdac_device_init---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_SUBSYSTEM_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_REV_ID) 2s
> 		       ---snd_hdac_read_parm(...AC_PAR_NODE_COUNT) 2s
> when no codecs, read communication is error, each command will be polled for
> 2 second，a total of 10s, it is easy to some problem.
> like this:
>   2 [   14.833404][ 6] [  T164] hda 0006:00: Codec #0 probe error; disabling it...
>   3 [   14.844178][ 6] [  T164] hda 0006:00: codec_mask = 0x1
>   4 [   14.880532][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0000
>   5 [   15.891988][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0000
>   6 [   16.978090][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0001
>   7 [   18.140895][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0002
>   8 [   19.135516][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0004
>  10 [   19.900086][ 6] [  T164] hda 0006:00: no codecs initialized
>  11 [   45.573398][ 2] [    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [kworker/2:0:25]
> 
> Here, when bus->codec_mask is 0, use a direct break to avoid execute snd_hda_codec_new function.
> 
> Signed-off-by: songxiebing <songxiebing@kylinos.cn>

Thanks for the patch.  The code change looks OK, but you use both
ASCII and non-ASCII comma letters in the patch description.
Could you try to keep only ASCII letters?


Takashi

