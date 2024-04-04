Return-Path: <linux-kernel+bounces-131605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C145D8989FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F81292069
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CD12A145;
	Thu,  4 Apr 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dda+Fr73";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/xhTIim";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dda+Fr73";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/xhTIim"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816E129E7B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240428; cv=none; b=WStjexx4SMEfPLNN/2eo9BkUpbvLGGfJRYbZ/DbrLTzsNRjSZs7hYpF6LsMTcz+v58q+1je3z+tEGLiTUZ0HMfnELymoRRd9H/5V05KJnaStP+cpsX1OtTVgin+j6evLHMXREmAWMEpcYxPBFMpcTUWROHiAT6oDaykr1v6qUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240428; c=relaxed/simple;
	bh=38ifp+9U/tmcMtRDRwJirKgMZ3pkp0T33E7PMYrwkPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBlCXutMzX5QOrAMGwC9eNyohNgySezI5LBoZ34ej6Wr5eAnbdwn7YHSEcZKzfNB1K7TIKJ4L8pdMz4sf8PLh56b6KN7n7ItS+fc0UZjE7XgLT2i4uaQqaEQayhWHDbk91uLjIx0i1B4Jqt66MMzGioCwNmvKzsSda3BMGmNK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dda+Fr73; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/xhTIim; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dda+Fr73; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/xhTIim; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2F235F7BE;
	Thu,  4 Apr 2024 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712240424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmlPJFJH+2pgSlIxGAzUjJA+7LBxZ4wX4p8uWafMaAU=;
	b=dda+Fr73TfgnmUVxHbwmW4mu1Gxtc377KIJXRzrIRiQuKsDiHZgGAFyM1f6alg0+z+JVYh
	12eF4YhQxSpvtHsRU6WXwtVv2+WTXunGjpNIEXQKVsQFa7AmWAyctZ29wJjjqpEMxJy2qX
	rH9AJoxxL1dOao4MBkGDV4MblYYcrbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712240424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmlPJFJH+2pgSlIxGAzUjJA+7LBxZ4wX4p8uWafMaAU=;
	b=k/xhTIimxY+YML86hHqK4jIMUgsrNGY2pSHuGRCuFhcbbaCbmaI/EXdDLf9FVfVbcnEFQ9
	BYWoMY/AulfMmoBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dda+Fr73;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="k/xhTIim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712240424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmlPJFJH+2pgSlIxGAzUjJA+7LBxZ4wX4p8uWafMaAU=;
	b=dda+Fr73TfgnmUVxHbwmW4mu1Gxtc377KIJXRzrIRiQuKsDiHZgGAFyM1f6alg0+z+JVYh
	12eF4YhQxSpvtHsRU6WXwtVv2+WTXunGjpNIEXQKVsQFa7AmWAyctZ29wJjjqpEMxJy2qX
	rH9AJoxxL1dOao4MBkGDV4MblYYcrbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712240424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmlPJFJH+2pgSlIxGAzUjJA+7LBxZ4wX4p8uWafMaAU=;
	b=k/xhTIimxY+YML86hHqK4jIMUgsrNGY2pSHuGRCuFhcbbaCbmaI/EXdDLf9FVfVbcnEFQ9
	BYWoMY/AulfMmoBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9213B13298;
	Thu,  4 Apr 2024 14:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id j+pHIyi3DmaDBgAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Thu, 04 Apr 2024 14:20:24 +0000
Message-ID: <dc25b95b-8515-4108-94e3-d83e6948b861@suse.cz>
Date: Thu, 4 Apr 2024 16:20:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slub, kunit: Use inverted data to corrupt kmem cache
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Oliver Glitta <glittao@gmail.com>,
 Daniel Latypov <dlatypov@google.com>, Marco Elver <elver@google.com>
References: <20240402133839.283793-1-linux@roeck-us.net>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240402133839.283793-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A2F235F7BE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On 4/2/24 3:38 PM, Guenter Roeck wrote:
> Two failure patterns are seen randomly when running slub_kunit tests with
> CONFIG_SLAB_FREELIST_RANDOM and CONFIG_SLAB_FREELIST_HARDENED enabled.
> 
> Pattern 1:
>      # test_clobber_zone: pass:1 fail:0 skip:0 total:1
>      ok 1 test_clobber_zone
>      # test_next_pointer: EXPECTATION FAILED at lib/slub_kunit.c:72
>      Expected 3 == slab_errors, but
>          slab_errors == 0 (0x0)
>      # test_next_pointer: EXPECTATION FAILED at lib/slub_kunit.c:84
>      Expected 2 == slab_errors, but
>          slab_errors == 0 (0x0)
>      # test_next_pointer: pass:0 fail:1 skip:0 total:1
>      not ok 2 test_next_pointer
> 
> In this case, test_next_pointer() overwrites p[s->offset], but the data
> at p[s->offset] is already 0x12.
> 
> Pattern 2:
>      ok 1 test_clobber_zone
>      # test_next_pointer: EXPECTATION FAILED at lib/slub_kunit.c:72
>      Expected 3 == slab_errors, but
>          slab_errors == 2 (0x2)
>      # test_next_pointer: pass:0 fail:1 skip:0 total:1
>      not ok 2 test_next_pointer
> 
> In this case, p[s->offset] has a value other than 0x12, but one of the
> expected failures is nevertheless missing.
> 
> Invert data instead of writing a fixed value to corrupt the cache data
> structures to fix the problem.
> 
> Fixes: 1f9f78b1b376 ("mm/slub, kunit: add a KUnit test for SLUB debugging functionality")
> Cc: Oliver Glitta <glittao@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> CC: Daniel Latypov <dlatypov@google.com>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Added to slab/for-next, thanks.

> ---
>  lib/slub_kunit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index d4a3730b08fa..4ce960438806 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -55,7 +55,7 @@ static void test_next_pointer(struct kunit *test)
>  
>  	ptr_addr = (unsigned long *)(p + s->offset);
>  	tmp = *ptr_addr;
> -	p[s->offset] = 0x12;
> +	p[s->offset] = ~p[s->offset];
>  
>  	/*
>  	 * Expecting three errors.


