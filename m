Return-Path: <linux-kernel+bounces-63582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733508531C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CE3286CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6656449;
	Tue, 13 Feb 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HL+hL/xK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6YQtjF/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HL+hL/xK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6YQtjF/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412955C15;
	Tue, 13 Feb 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830694; cv=none; b=I9nT9d8XvawAZv4/TU37g4uK7iDClNz932vqvGiLM94Yv0/B7dhVe6A5SN/jCtn5kinuyAkpaNQIzaEr2Kz/bZoazdvsZLNdYQQEYq9c3JJPXODN0BYpGfisWavsCJEw4335371YjqbN00/ZeWlh3j5faXUTwiSum5marhE7jBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830694; c=relaxed/simple;
	bh=gHAqRnNx7ISKTaBmUVgcAxvnqRWderuHrYnh/VtMCHQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCBttV9+9EVjsWP8/gPQ1iV+WmZ2BjJaHZDpy+OUVRYVupsXWlCTb5GT3qWeA5fcRyjavlLnt+Vlu7WLdjPxMJWcBMkJZwclkCxigqw0exzhRfTCLg2xET/1Jif0WyNjaZ1Scqs4OsNKfo9CB/N9oltV/ez8pcPxLioXKcDtSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HL+hL/xK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q6YQtjF/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HL+hL/xK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q6YQtjF/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE66421F4A;
	Tue, 13 Feb 2024 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707830690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCMyNXQ+BG09aEpA12n/MMHKfk58UJhXVc0veXpotdA=;
	b=HL+hL/xKkqJdNLRvSaNj+rf94ROwygNPHFkOr8b1DF3qL3GoYtB4R5CH3MoiEmfxT7T5uA
	O4Ylt8t3AJ7HitLxszs7x8h5KZhVAQ8BGnMqv4/U99nf7PXV2hmPBOFJsMjTAWo8UHV+//
	FcREUmkZBVpwjp1jKaxsSFy1Vw9zKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707830690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCMyNXQ+BG09aEpA12n/MMHKfk58UJhXVc0veXpotdA=;
	b=Q6YQtjF/pPLJDBAOoRMfY5ynEehaZbIyasSyJ+t77xDSwtaMSAbd1pxBbzRLPw7PWeIsh9
	+CyUH23sLIbtz4AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707830690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCMyNXQ+BG09aEpA12n/MMHKfk58UJhXVc0veXpotdA=;
	b=HL+hL/xKkqJdNLRvSaNj+rf94ROwygNPHFkOr8b1DF3qL3GoYtB4R5CH3MoiEmfxT7T5uA
	O4Ylt8t3AJ7HitLxszs7x8h5KZhVAQ8BGnMqv4/U99nf7PXV2hmPBOFJsMjTAWo8UHV+//
	FcREUmkZBVpwjp1jKaxsSFy1Vw9zKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707830690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCMyNXQ+BG09aEpA12n/MMHKfk58UJhXVc0veXpotdA=;
	b=Q6YQtjF/pPLJDBAOoRMfY5ynEehaZbIyasSyJ+t77xDSwtaMSAbd1pxBbzRLPw7PWeIsh9
	+CyUH23sLIbtz4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A57F41370C;
	Tue, 13 Feb 2024 13:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o1/cJ6Jty2UFGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 13:24:50 +0000
Date: Tue, 13 Feb 2024 14:24:50 +0100
Message-ID: <87eddgxzrx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wai Yew CHAY <wychay@ctl.creative.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ctxfi: avoid casting function pointers
In-Reply-To: <20240213101303.460008-1-arnd@kernel.org>
References: <20240213101303.460008-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HL+hL/xK";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Q6YQtjF/"
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BE66421F4A
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO

On Tue, 13 Feb 2024 11:12:46 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver creates an abstraction for different components by casting function
> pointers to slightly incompatible types for each one to get the correct
> argument even when the caller does not know those types. This is a
> bit unreliable and not allowed in combination with control flow integrity
> (KCFI):
> 
> sound/pci/ctxfi/ctatc.c:115:25: error: cast from 'int (*)(struct hw *, struct src_mgr **)' to 'create_t' (aka 'int (*)(struct hw *, void **)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   115 |         [SRC]           = { .create     = (create_t)src_mgr_create,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/ctxfi/ctatc.c:116:20: error: cast from 'int (*)(struct src_mgr *)' to 'destroy_t' (aka 'int (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   116 |                             .destroy    = (destroy_t)src_mgr_destroy    },
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/ctxfi/ctatc.c:117:27: error: cast from 'int (*)(struct hw *, struct srcimp_mgr **)' to 'create_t' (aka 'int (*)(struct hw *, void **)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   117 |         [SRCIMP]        = { .create     = (create_t)srcimp_mgr_create,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/ctxfi/ctatc.c:118:20: error: cast from 'int (*)(struct srcimp_mgr *)' to 'destroy_t' (aka 'int (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   118 |                             .destroy    = (destroy_t)srcimp_mgr_destroy },
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change these to always pass void pointers and move the abstraction one level
> down.
> 
> Fixes: 8cc72361481f ("ALSA: SB X-Fi driver merge")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.


Takashi

