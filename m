Return-Path: <linux-kernel+bounces-85191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6EE86B1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BBA1C22069
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC2152E14;
	Wed, 28 Feb 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0wEfWmlJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3q68JWkh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JScXtA1t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bW/CNJxY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8214F995;
	Wed, 28 Feb 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131028; cv=none; b=hVsgXlxXl94HCYh4J666FfmeE4ayKDF7q+DdIY9/lN1RPwC0GIyUXss95u89uZlRiW3J1gO6e+DynEBIyIQx9j80eqv7EJkWltuu5UxMp4HB5hJawIWadxLM8wuCfQZYwnZar2uxQzu79F3rKCA77t47a/Kbv2FPeaUaYYn47Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131028; c=relaxed/simple;
	bh=kM8ftQLTQdhv8BhFXvPnKhJC/JpvkfnX+SaINYUddYE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8VbCZs/5SC8XIBfuzIvh2okphyZBFqf7rQHkGx/iSEEzbV1VFYxw+T4QYZJjDyqTwPsMzqCB1ZqkR60Z0z4SiCwV4Xj1kqmci+qM8Q9ANot7rab8KoKFBp+sOn9nFeuww6moo1cfMk5BRHGUZFHR+17QPCdeHpnCSvXoBrHNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0wEfWmlJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3q68JWkh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JScXtA1t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bW/CNJxY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79AF621D5D;
	Wed, 28 Feb 2024 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709131023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWekme/XpxvCOadHbmM/M4NP16DmW1k/K2GUXUKbm7Y=;
	b=0wEfWmlJzbKAeJQ6iaOEgvKOe8e6P8Xv82IlL3il0eC8gb7YbXtY/7itqHB0A6oHXtSFH1
	NGPhxs2SON1Irvjg+Eb/ak8ZIpLRdLqHO0CD82OVtAED/Tzmp0xiyH1B8wdlxHm9ev0/HX
	n/3Cw31FlfmRlkdDtcLqgjKHhreDxDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709131023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWekme/XpxvCOadHbmM/M4NP16DmW1k/K2GUXUKbm7Y=;
	b=3q68JWkhSoyA/ZZ8LHcfr2dYIK3r1YF6TYBlVLMJdAOuYSUneOK06SijAwt3xTSGB695xz
	lVXfLAjQm8v7vQCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709131022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWekme/XpxvCOadHbmM/M4NP16DmW1k/K2GUXUKbm7Y=;
	b=JScXtA1txOlmp+rRGF/NWTCy4MkREuTqDzEtKqFHpcot0f2835kZfvPopbcWtV7ky+l5m0
	z+wWeiE5Ibvamb+vK1Yz8Fe/UTpXPmU2XpAJspC/99wiiCQG3xPG7+k47C0A/tIJiX53m7
	f8+pTKwPHJN4nn8NUD9j23uHtwWOMR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709131022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWekme/XpxvCOadHbmM/M4NP16DmW1k/K2GUXUKbm7Y=;
	b=bW/CNJxY8O09R2qHY3RCgv5ai99SpSWV47k/XTN7C3WDvnx9YT+k6mht0Fv17WM/ksoRTU
	NOlzLXW6U+sip1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21AAD13A58;
	Wed, 28 Feb 2024 14:37:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1lHTBg5F32XOdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 28 Feb 2024 14:37:02 +0000
Date: Wed, 28 Feb 2024 15:37:01 +0100
Message-ID: <87msrkhcz6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: asihpi: work around clang-17+ false positive fortify-string warning
In-Reply-To: <20240228140152.1824901-1-arnd@kernel.org>
References: <20240228140152.1824901-1-arnd@kernel.org>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JScXtA1t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="bW/CNJxY"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 79AF621D5D
X-Spam-Flag: NO

On Wed, 28 Feb 2024 15:01:45 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> One of the memory copies in this driver triggers a warning about a
> possible out of range access:
> 
> In file included from /home/arnd/arm-soc/sound/pci/asihpi/hpimsgx.c:13:
> /home/arnd/arm-soc/include/linux/fortify-string.h:553:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>   553 |                         __write_overflow_field(p_size_field, size);
>       |                         ^

Hmm, I can't see the relevance of those messages with the code you
touched.  Do you have more info?

> Adding a range check avoids the problem, though I don't quite see
> why it warns in the first place if clang has no knowledge of the
> actual range of the type, or why I never saw the warning in previous
> randconfig tests.

It's indeed puzzling.  If it's really about adapter_prepare() call,
the caller is only HPIMSGX__init(), and there is already an assignment
with that index value beforehand:
  hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;

and this array is also the size of HPI_MAX_ADAPTERS.  That is, the
same check should have caught here...


thanks,

Takashi

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/pci/asihpi/hpimsgx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
> index d0caef299481..4f245c3956b1 100644
> --- a/sound/pci/asihpi/hpimsgx.c
> +++ b/sound/pci/asihpi/hpimsgx.c
> @@ -576,6 +576,9 @@ static u16 adapter_prepare(u16 adapter)
>  	/* Open the adapter and streams */
>  	u16 i;
>  
> +	if (adapter >= ARRAY_SIZE(rESP_HPI_ADAPTER_OPEN))
> +		return 0;
> +
>  	/* call to HPI_ADAPTER_OPEN */
>  	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
>  		HPI_ADAPTER_OPEN);
> -- 
> 2.39.2
> 

