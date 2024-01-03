Return-Path: <linux-kernel+bounces-15406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908F822B96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961932853DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2640A18C3A;
	Wed,  3 Jan 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aMVSUKwr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LXjTni6i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L3Dr+y52";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fMD2WkQk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6518C19;
	Wed,  3 Jan 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF8151FD0D;
	Wed,  3 Jan 2024 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704278863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5KRAwo0AFVwbHMpXUMvMXUGfmIiWah+X+scYHvmWs=;
	b=aMVSUKwrNxKsDAtUhf83urZiLbahRA7dJv4iQjHxUh+linKRV+pUcXJCCPGFN5u7AcGhI1
	IOB2tFAsBrKF2NBPp15LiB0cuBZyeaT/VJDg11OJt8LZwI2Ejd4J6+COUcAKcnuyIcshls
	0dZb93UyC28ht4DE29UksYuO/1CbnCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704278863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5KRAwo0AFVwbHMpXUMvMXUGfmIiWah+X+scYHvmWs=;
	b=LXjTni6iQ+fTVuHvu61vqthFR6yFRCHGPc6Iui8mFt3NrYCEYaflXhh31Ku5oBrWZGx+87
	QomT+jNovuQZIHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704278862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5KRAwo0AFVwbHMpXUMvMXUGfmIiWah+X+scYHvmWs=;
	b=L3Dr+y526qc0FBu3bqQMGQ50XpMSEiO9d48DUvXIryxfDurx0LPNjmoVRTq7MYo1gxiNuE
	jX0g8s/bdQnRhG/MNMgYwVfHa4gJBNtd10MHTqDE2Av/ptZMTGLHE2DgXBexnbZzjQ4S0m
	5kD7ZobGVDaNTjudjPftmhoqDP6h6sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704278862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5KRAwo0AFVwbHMpXUMvMXUGfmIiWah+X+scYHvmWs=;
	b=fMD2WkQkqIdPqohQoq1TdjD3GDNhi5RWUkxKZwFRbthol1/6FrTA6vZ6NMqrhsl4zy+wKJ
	SGLbUpRyweJynqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A3E41340C;
	Wed,  3 Jan 2024 10:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AVoIE47lWXuBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Jan 2024 10:47:42 +0000
Date: Wed, 03 Jan 2024 11:47:42 +0100
Message-ID: <87cyuibsmp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yu Liao <liaoyu15@huawei.com>,
	Dawei Li <set_pte_at@outlook.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ac97: fix build regression
In-Reply-To: <20240103102544.3715055-1-arnd@kernel.org>
References: <20240103102544.3715055-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L3Dr+y52;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fMD2WkQk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[outlook.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,linuxfoundation.org,arndb.de,huawei.com,outlook.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.56)[92.15%]
X-Spam-Score: -2.07
X-Rspamd-Queue-Id: CF8151FD0D
X-Spam-Flag: NO

On Wed, 03 Jan 2024 11:25:38 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ac97_bus_type structure is no longer declared in this file:
> 
> sound/ac97/bus.c: In function 'ac97_codec_add':
> sound/ac97/bus.c:112:27: error: 'ac97_bus_type' undeclared (first use in this function); did you mean 'bus_type'?
>   112 |         codec->dev.bus = &ac97_bus_type;
>       |                           ^~~~~~~~~~~~~
>       |                           bus_type
> sound/ac97/bus.c:112:27: note: each undeclared identifier is reported only once for each function it appears in
> sound/ac97/bus.c: In function 'snd_ac97_codec_driver_register':
> sound/ac97/bus.c:191:28: error: 'ac97_bus_type' undeclared (first use in this function); did you mean 'ac97_bus_reset'?
>   191 |         drv->driver.bus = &ac97_bus_type;
> 
> Include the header that contains the declaration and make sure the definition
> is const but not static.
> 
> Fixes: 66e82d219924 ("ALSA: mark all struct bus_type as const")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied now.


Takashi

