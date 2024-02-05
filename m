Return-Path: <linux-kernel+bounces-52107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CE84942D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD71F23E17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016EC14F;
	Mon,  5 Feb 2024 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hjazlctj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5i4whiUF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EgJW0+Vh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EHrdPpNm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6010A0F;
	Mon,  5 Feb 2024 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116894; cv=none; b=DZtZPconl8/Pwhj0iOV3gPFd06k4Y5vfbmICTI7EZ1J3G4wmRVN1DECAGBqXkL8h6LrSw+ha2rlbJvyjvwZDAIwqkLlvSqEx30d/VdUtkhm6O5RYKRbJ0Rvp+1kUGyUXH5sq1couCLGK5IL80/fp0svb+dBM/aXgN+PqseVbc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116894; c=relaxed/simple;
	bh=1iLIbIBVOwSyOWPA4Fbx/O8GvHzT+Eo2yKqLQt2Fif0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djY5xoilcPm9nRgmoDTDUqjzW8FUD/PnXst6X/+MXalfZzVPrBbrsvb0EhZsFRJaVs5niG1Z3GG2Kkly8JVWjw6MD3HZ2U71IeE3FQ9K7itGzodP82Zy6y0n+/jGse5pLrcACG8tdllYbouuiJrx4SYPy46vVBiObcM2AhzxK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hjazlctj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5i4whiUF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EgJW0+Vh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EHrdPpNm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 652161F88D;
	Mon,  5 Feb 2024 07:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707116890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoyD2mmxem1CPhb1QtcjIBOqvgNl473ksQrnP17zBz4=;
	b=hjazlctjZeHqdyYHWUF9MFnTWpORAgaCoNftpv7FqaGYjuSl8gGXMMPIi4iK24T/orG6Wc
	Y3vk+LCEM2tVUnQZt0Ah5kH4hUiQQP22egH0TNwYqVnM4XYylg2PuQBYKDqH6sCXizicRR
	h/SUpARNlJLH6Wq3vG1r4u8t1X959Qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707116890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoyD2mmxem1CPhb1QtcjIBOqvgNl473ksQrnP17zBz4=;
	b=5i4whiUFsGXpK/9vJVtQki7ZkLZBrqNQgwN5vY6gieaNycv695dkcnfB+QLD1bUYKHKez4
	VFJW1mpr38GaQdCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707116888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoyD2mmxem1CPhb1QtcjIBOqvgNl473ksQrnP17zBz4=;
	b=EgJW0+VhiMi1FC+PO+4jvuPXmfLLvH188qkOwR/G83TmewjFRis+jP8kfrb08GjNpl4FXZ
	RFWUFzfhKVhAJ864k0a8IG+896TbJTwEt/Rewwsua8Y/BxjZQbzOL+377WVsn5CPI80c7Z
	sjA3oVukIz56UBhiNkp3LUWbo7RsUtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707116888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoyD2mmxem1CPhb1QtcjIBOqvgNl473ksQrnP17zBz4=;
	b=EHrdPpNmKTSl3j8ABfuQf2cNmK9TQE+31kh43fu9vBT3MdBu6OrcQwSVERmMpJ7dBHSuZ4
	lEn70dsRyZoE1qAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C97C132DD;
	Mon,  5 Feb 2024 07:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZW3BFiJwGXbeQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Feb 2024 07:08:08 +0000
Date: Mon, 05 Feb 2024 08:08:07 +0100
Message-ID: <87v8739ync.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: fix unit test dependencies
In-Reply-To: <20240204212135.3158722-1-arnd@kernel.org>
References: <20240204212135.3158722-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EgJW0+Vh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EHrdPpNm
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,arndb.de,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 652161F88D
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Sun, 04 Feb 2024 22:21:29 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Kunit tests fail to link when PCM support is disabled:
> 
> aarch64-linux-ld: sound/core/sound_kunit.o: in function `test_pcm_format_name':
> sound_kunit.c:(.text+0x4c): undefined reference to `snd_pcm_format_name'
> aarch64-linux-ld: sound_kunit.c:(.text+0x12c): undefined reference to `snd_pcm_format_name'
> aarch64-linux-ld: sound/core/sound_kunit.o: in function `_test_fill_silence':
> sound_kunit.c:(.text+0x284): undefined reference to `snd_pcm_format_set_silence'
> aarch64-linux-ld: sound/core/sound_kunit.o: in function `test_format_signed':
> sound_kunit.c:(.text+0x400): undefined reference to `snd_pcm_format_signed'
> aarch64-linux-ld: sound_kunit.c:(.text+0x470): undefined reference to `snd_pcm_format_unsigned'
> aarch64-linux-ld: sound/core/sound_kunit.o: in function `test_format_width':
> sound_kunit.c:(.text+0x64c): undefined reference to `snd_pcm_format_width'
> aarch64-linux-ld: sound_kunit.c:(.text+0x71c): undefined reference to `snd_pcm_format_width'
> 
> Add the appropriate dependencies.
> 
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, but this was already fixed on for-next branch.


Takashi

