Return-Path: <linux-kernel+bounces-127463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6569894BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0B01C21B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0673A2D600;
	Tue,  2 Apr 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FarnXZ3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Sf7gBAw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634B249E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040872; cv=none; b=JYWX1sadgqL14Vv469sc6uXeKICy4rN87Iq9ml8855zYA88Q2t4w3zW7Af8OxH43qebvsIFv6NQfabMEfxftsKasvlXJ87FC7KdfNlIyOgdNOl2Go/tqh8UdSdZRoWn9XkaNSgZ6e2hPJmiynUqTrsz5sag8dI/1a/PeAqTTOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040872; c=relaxed/simple;
	bh=opx37VCoLcNHNfcnHdBIyzq9r1hkY+cMiLiMx3Y4TNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cC8U/lALSCaSqbHCZTIhw/ajrSTlu59QiVKHDWx08uzFixvm+emm8OfmzC/hdZCzHiBQAfAEF+wrbqSHA04P09VvHJe5G5j9WeN4zbDtshM+5dvi1VvDTsvJEu6mQyTWwyVIhKfawA1Mow77JPl99zVsH80k/mwzF3y9CdFpz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FarnXZ3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Sf7gBAw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 807A120D0B;
	Tue,  2 Apr 2024 06:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712040868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qymx0oXlDxbLz6J14s2W5aAHw+ug/jiWzZ3y4+9QKVw=;
	b=FarnXZ3WnwX/C+V+slPb6chTuWeME0W34cIpYhRH+d9Ov8Z3b0+9c6nu3HE1hDEtH+LX5W
	ROqKAvKy4AoaroykLl2gdrc6Ehv6wPaOYwM6K6U7b/uDiCbesQcGYzYflqaqw2MFdNLvtK
	Z3uzdRPVc1I/LTFRUqPsvkVRfQ3OJ34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712040868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qymx0oXlDxbLz6J14s2W5aAHw+ug/jiWzZ3y4+9QKVw=;
	b=/Sf7gBAw4bj6/0IGFmdg8eAngYWP9dAyWqiMUsXrGTiOznFCdCrUpLa62GXNmH/Z14lpAz
	BMhqNb+0OhKMt/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 639E913357;
	Tue,  2 Apr 2024 06:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0ry6F6SrC2YPQwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 06:54:28 +0000
Message-ID: <b939165e-a227-4b96-bdc8-12afba801c03@suse.cz>
Date: Tue, 2 Apr 2024 08:54:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stackdepot: Rename pool_index to pool_index_plus_1
To: Peter Collingbourne <pcc@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>,
 Omar Sandoval <osandov@fb.com>
References: <20240402001500.53533-1-pcc@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240402001500.53533-1-pcc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[google.com,gmail.com,suse.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 4/2/24 2:14 AM, Peter Collingbourne wrote:
> Commit 3ee34eabac2a ("lib/stackdepot: fix first entry having a
> 0-handle") changed the meaning of the pool_index field to mean "the
> pool index plus 1". This made the code accessing this field less
> self-documenting, as well as causing debuggers such as drgn to not
> be able to easily remain compatible with both old and new kernels,
> because they typically do that by testing for presence of the new
> field. Because stackdepot is a debugging tool, we should make sure
> that it is debugger friendly. Therefore, give the field a different
> name to improve readability as well as enabling debugger backwards
> compatibility.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ib3e70c36c1d230dd0a118dc22649b33e768b9f88

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Although this technically isn't a bug fix in the kernel,
> I would appreciate if this could be picked up for 6.9
> to avoid temporarily introducing a silent regression in drgn
> (loud regressions are fine).
> 
>  include/linux/stackdepot.h | 7 +++----
>  lib/stackdepot.c           | 4 ++--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 3c6caa5abc7c..e9ec32fb97d4 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -44,10 +44,9 @@ typedef u32 depot_stack_handle_t;
>  union handle_parts {
>  	depot_stack_handle_t handle;
>  	struct {
> -		/* pool_index is offset by 1 */
> -		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
> -		u32 offset	: DEPOT_OFFSET_BITS;
> -		u32 extra	: STACK_DEPOT_EXTRA_BITS;
> +		u32 pool_index_plus_1	: DEPOT_POOL_INDEX_BITS;
> +		u32 offset		: DEPOT_OFFSET_BITS;
> +		u32 extra		: STACK_DEPOT_EXTRA_BITS;
>  	};
>  };
>  
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index af6cc19a2003..68c97387aa54 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -330,7 +330,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
>  	stack = current_pool + pool_offset;
>  
>  	/* Pre-initialize handle once. */
> -	stack->handle.pool_index = pool_index + 1;
> +	stack->handle.pool_index_plus_1 = pool_index + 1;
>  	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
>  	stack->handle.extra = 0;
>  	INIT_LIST_HEAD(&stack->hash_list);
> @@ -441,7 +441,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
>  	const int pools_num_cached = READ_ONCE(pools_num);
>  	union handle_parts parts = { .handle = handle };
>  	void *pool;
> -	u32 pool_index = parts.pool_index - 1;
> +	u32 pool_index = parts.pool_index_plus_1 - 1;
>  	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
>  	struct stack_record *stack;
>  


