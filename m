Return-Path: <linux-kernel+bounces-70930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D874F859E23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1516E1C21F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8D2110F;
	Mon, 19 Feb 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hKdCB4Dp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DXoXgj7m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UVN7980c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1niAQW7F"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A365208B9;
	Mon, 19 Feb 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331049; cv=none; b=EVglj3IiDq1itkjKyasuSWSj/eoSQGjVNRYdb1C6r83iVRRAxdO29Wv7NVg/UwvmNb1PEnVpiozx6FVOzI8fKAYgL+axhdf7glZkHuFnI/VVrxl3FTzwLLqqLWJHMhrBpmeYKylwzVm3AUhfdiDqVD5yqwRSO1Z5/4gqzR1Xnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331049; c=relaxed/simple;
	bh=jNiuGMdKQuAqFWJvxAojwpVsbjDd6if8yJz7fs6ToDU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI5MZdaz4/Jzkz14AVqOakGsiHCEg5TzZ+1x5Gq6DTpk4nuawuZJCyAo2OHzmSOltQRiPtd9YbMjtxbeff6eWJGcZQXpg9+a7XMA+32PjAVBDdq3PpQ4vFLB3+940Y5iYYpJA7iyInLEPjrCs7a/iRmmJaxQokeXHoNOYj3UyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hKdCB4Dp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DXoXgj7m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UVN7980c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1niAQW7F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B54C221BD4;
	Mon, 19 Feb 2024 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708331045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3geTuouwuKJu4oP/3eOGhRrpShoe38npl2lgVrudkQQ=;
	b=hKdCB4Dp5X4sIHSL8lhL3Me0uIS4ISO47AfInYYrNMhby1oDAf8EaY0sZbW7m+AfLSZmUJ
	NagQ7k77ApncQkwAX1g/xaKrcefv51Lu0JtwUaTv1F/qjcfr1M/Z66IBLwT1el0EsLVI1T
	U0n9TkfYUO92UPMdVDYsE/Q7n7/66qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708331045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3geTuouwuKJu4oP/3eOGhRrpShoe38npl2lgVrudkQQ=;
	b=DXoXgj7mdccE69DGVnP5azjcgmoa+ZGUniZL/VZ8Syr78pOw/Z98uEY1b3CNtloO/6rons
	Wxfv2cU0U9FABwBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708331043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3geTuouwuKJu4oP/3eOGhRrpShoe38npl2lgVrudkQQ=;
	b=UVN7980cAg9iY10Mh3rP2sYnq1pvRIkI3zB8du0zdHPsv06AE3t6IR8Xs5GouInyN5oVC2
	87XIyzvvhDb5l+FhZwsg4D4WzfBVCjzufZo/zQdw3j7DFYcWfM/AB/xAKCFpgEMuKxZCRH
	BqV0rX0/KQjaRppwHnSyPYjv6FAcanc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708331043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3geTuouwuKJu4oP/3eOGhRrpShoe38npl2lgVrudkQQ=;
	b=1niAQW7FZyg4juBHxt3mzOtcuupIZZfxX34b833Vuziobaiejfj1QhsIDs7XomGauuTYoe
	9MNAdDtC/sK+0CCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 776AA13647;
	Mon, 19 Feb 2024 08:24:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d0PdGyMQ02WuBAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 08:24:03 +0000
Date: Mon, 19 Feb 2024 09:24:03 +0100
Message-ID: <87a5nwq2u4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ALSA: core: fix buffer overflow in test_format_fill_silence()
In-Reply-To: <20240217104311.3749655-1-arnd@kernel.org>
References: <20240217104311.3749655-1-arnd@kernel.org>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UVN7980c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1niAQW7F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linaro.org:email,arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,arndb.de,linaro.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: B54C221BD4
X-Spam-Flag: NO

On Sat, 17 Feb 2024 11:42:38 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> KASAN caught a buffer overflow with the hardcoded 2048 byte buffer
> size, when 2080 bytes are written to it:
> 
>  BUG: KASAN: slab-out-of-bounds in snd_pcm_format_set_silence+0x3bc/0x3e4
>  Write of size 8 at addr ffff0000c8149800 by task kunit_try_catch/1297
> 
>  CPU: 0 PID: 1297 Comm: kunit_try_catch Tainted: G N 6.8.0-rc4-next-20240216 #1
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   kasan_report+0x78/0xc0
>   __asan_report_store_n_noabort+0x1c/0x28
>   snd_pcm_format_set_silence+0x3bc/0x3e4
>   _test_fill_silence+0xdc/0x298
>   test_format_fill_silence+0x110/0x228
>   kunit_try_run_case+0x144/0x3bc
>   kunit_generic_run_threadfn_adapter+0x50/0x94
>   kthread+0x330/0x3e8
>   ret_from_fork+0x10/0x20
> 
>  Allocated by task 1297:
>   __kmalloc+0x17c/0x2f0
>   kunit_kmalloc_array+0x2c/0x78
>   test_format_fill_silence+0xcc/0x228
>   kunit_try_run_case+0x144/0x3bc
>   kunit_generic_run_threadfn_adapter+0x50/0x94
>   kthread+0x330/0x3e8
>   ret_from_fork+0x10/0x20
> 
> Replace the incorrect size with the correct length of 260 64-bit samples.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use a named constant as suggested by Ivan Orlov

Thanks, applied now.


Takashi

