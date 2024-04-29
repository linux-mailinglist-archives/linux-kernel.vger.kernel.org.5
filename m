Return-Path: <linux-kernel+bounces-162189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54918B5767
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616392827EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF82F535C1;
	Mon, 29 Apr 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DJVKtHeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1G0nalj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DJVKtHeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1G0nalj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0052F9A;
	Mon, 29 Apr 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392316; cv=none; b=M0scoVYOyTHbJwMweIslLsHptQUPlwCUBhKjvmPMkh07p/PBz34Xhv6LlH/y3uysooJn/8HYKcGD8N6wVBwheNHtvmewgS8PZJOUD9ch/iMFbhpt+1j1gcOwi0fJcEZhHoLMmILXWOcBkfa4sW/BDE8Wt1dcGnnOrJ+0aJFX+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392316; c=relaxed/simple;
	bh=OmNjsWl0KvT4p5iOBj8Kvzg2oMkQflGASVR8UbH2pCg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oZP5TuhFWWJAEJhX5lpb+QQ/guzBSD9156Eq4ZnT6H2sk30Bdo5Gm0t08/4MzlVJfdk4vIGK7tecRjQ0HveR5oWJbO9+0B3agh5/KPp68a2e52av1eHrLudv6+K0xGPgZkCog+/wAbyqMlLiqcH2khP8znZHUZJoWKElj0q6IAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DJVKtHeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X1G0nalj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DJVKtHeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X1G0nalj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from knuth.suse.de (unknown [IPv6:2a07:de40:a101:3:9249:faff:fe06:959])
	by smtp-out2.suse.de (Postfix) with ESMTP id AA1461F390;
	Mon, 29 Apr 2024 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akRL7ROXXrCJ+02WODs6j3jnpy7lzzCLR0SqwV7vv9w=;
	b=DJVKtHeYFwL/bwuOZisjUIi42dTAlT6ws+53p4TgHASB2dMBcuDPvMowX9Ci+32g4xninR
	BjKO/gDFrebedq5smy87aToId7oRlS8chy/z+ka9ZpWqTHZBFiDILbXMO/dFCWz1tweEzf
	9hj0sZA/WEamJ7HC2G8T/F7VLMSzmy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akRL7ROXXrCJ+02WODs6j3jnpy7lzzCLR0SqwV7vv9w=;
	b=X1G0naljtqpQjWIzkwhu3rUOE094R4xZBQeO6JhKKVonvc+5mVI1h8XG9o3/JbyHwXA/dN
	CD02QD7QosaXAYCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DJVKtHeY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X1G0nalj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akRL7ROXXrCJ+02WODs6j3jnpy7lzzCLR0SqwV7vv9w=;
	b=DJVKtHeYFwL/bwuOZisjUIi42dTAlT6ws+53p4TgHASB2dMBcuDPvMowX9Ci+32g4xninR
	BjKO/gDFrebedq5smy87aToId7oRlS8chy/z+ka9ZpWqTHZBFiDILbXMO/dFCWz1tweEzf
	9hj0sZA/WEamJ7HC2G8T/F7VLMSzmy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akRL7ROXXrCJ+02WODs6j3jnpy7lzzCLR0SqwV7vv9w=;
	b=X1G0naljtqpQjWIzkwhu3rUOE094R4xZBQeO6JhKKVonvc+5mVI1h8XG9o3/JbyHwXA/dN
	CD02QD7QosaXAYCg==
Received: by knuth.suse.de (Postfix, from userid 10510)
	id 94AAA34F8E1; Mon, 29 Apr 2024 14:05:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by knuth.suse.de (Postfix) with ESMTP id 7D59334F8E0;
	Mon, 29 Apr 2024 14:05:12 +0200 (CEST)
Date: Mon, 29 Apr 2024 14:05:12 +0200 (CEST)
From: Michael Matz <matz@suse.de>
To: Borislav Petkov <bp@alien8.de>
cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, 
    linux-kernel@vger.kernel.org, x86@kernel.org, 
    Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Song Liu <song@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>, 
    Fangrui Song <maskray@google.com>, Arthur Eubanks <aeubanks@google.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
In-Reply-To: <20240420131717.GAZiPAXY9EAYnHajaw@fat_crate.local>
Message-ID: <836c267f-a028-acce-8b19-180162a5febc@suse.de>
References: <20240418201705.3673200-2-ardb+git@google.com> <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org> <20240420131717.GAZiPAXY9EAYnHajaw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: *
X-Spamd-Result: default: False [1.03 / 50.00];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	BAYES_HAM(-2.36)[97.02%];
	HFILTER_HELO_IP_A(1.00)[knuth.suse.de];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[knuth.suse.de];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:9249:faff:fe06:959:from];
	TAGGED_RCPT(0.00)[git];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Score: 1.03
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AA1461F390
X-Spamd-Bar: +

Hello,

On Sat, 20 Apr 2024, Borislav Petkov wrote:

> Interesting. I thought gcc doesn't have problems here yet and was
> talking to Matz on Thu about it and it seems he's forgotten about his
> statement too that "you should simply stop using -mcmodel=large.  Noone
> should use it." :-)

It may be so ingrained in my brain that I'm not _always_ saying it when 
talking about the large code model over a beer.  And indeed I know of no 
particular problems with it vis GCC, but that doesn't mean it's a good 
idea to use :-)

So once again: "everyone should simply stop using -mcmodel=large.  Noone 
should use it."

So the patch goes strictly into the direction of betterment of the 
universe. :)


Ciao,
Michael.

