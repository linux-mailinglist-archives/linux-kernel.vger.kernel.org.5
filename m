Return-Path: <linux-kernel+bounces-96607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD3875EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4386A1F21778
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8550A64;
	Fri,  8 Mar 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBA29ilh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/ssvpF3u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBA29ilh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/ssvpF3u"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842F4F606
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884391; cv=none; b=OTZ+OdCdG5IIONbqNjx0bGqqXzs1uQHm/MfpSXNCgUylI/A2XrEoCiwZFTERvvAR3/Y5gRC+RXoKCV+Kp2x+QStAGVttFCnnUzgf1cl7opJsjMYI5HL1K/JIGbMuN+AjAkrBojEZgwij2LMkcS/N8Dd8hEV914PYFiHe22zcf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884391; c=relaxed/simple;
	bh=1u1yoZkuur5fK5XMHKjD+QWaDuFGmhnSKT3vLp+Dkv8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sa5vzxJGwK5wbFQY6ZWGuXUDtemFgfbrAMYp06xrCOwkKtK1w7+cPC3/xnUjY05/gpOshV2ucUiZIO0rEvkRe7QGb35hne734OHzMIuwbhH7+Sv/6+IyVLhowwREAnPE/YRtx+9o5iwQQG52mMj+ca1DkEmqGbEtymwAKnQ6vMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBA29ilh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/ssvpF3u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBA29ilh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/ssvpF3u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 112375D273;
	Fri,  8 Mar 2024 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709884386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEzBdz5tlejxHIWRu4GFOXa0dCDGc6JHxZ8PAzaMiFQ=;
	b=oBA29ilhTB7HfBl6EYJt+liQQqFP+LB3mSqcHguimEdxgW3ZJwT0XacI2JN5Mmat8NizN6
	OA8fBO3z5wG97ahOECA0/z9qHD6uPOUpRlzi1DFUMuK71H08HQ5vsW4FXDw9wYSxHxAm4o
	ch7+X6c1kVLAihKpPjqzhBM2BzIqNdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709884386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEzBdz5tlejxHIWRu4GFOXa0dCDGc6JHxZ8PAzaMiFQ=;
	b=/ssvpF3uoes9ULrACOYM6H9o6VQH2ASD9Rwx0o4dvAd5CfpSpehnwpSBPvItk5XSo/zQJi
	TOShrmYSIh5jHACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709884386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEzBdz5tlejxHIWRu4GFOXa0dCDGc6JHxZ8PAzaMiFQ=;
	b=oBA29ilhTB7HfBl6EYJt+liQQqFP+LB3mSqcHguimEdxgW3ZJwT0XacI2JN5Mmat8NizN6
	OA8fBO3z5wG97ahOECA0/z9qHD6uPOUpRlzi1DFUMuK71H08HQ5vsW4FXDw9wYSxHxAm4o
	ch7+X6c1kVLAihKpPjqzhBM2BzIqNdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709884386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEzBdz5tlejxHIWRu4GFOXa0dCDGc6JHxZ8PAzaMiFQ=;
	b=/ssvpF3uoes9ULrACOYM6H9o6VQH2ASD9Rwx0o4dvAd5CfpSpehnwpSBPvItk5XSo/zQJi
	TOShrmYSIh5jHACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED3EB13310;
	Fri,  8 Mar 2024 07:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Th58OeHD6mUNSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 08 Mar 2024 07:53:05 +0000
Message-ID: <d6d8aef5-9ebf-4a38-bdb5-f1daf7818873@suse.cz>
Date: Fri, 8 Mar 2024 08:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/2] mm,page_owner: Check for null stack_record before
 bumping its refcount
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 kernel test robot <oliver.sang@intel.com>
References: <20240306123217.29774-1-osalvador@suse.de>
 <20240306123217.29774-2-osalvador@suse.de>
Content-Language: en-US
In-Reply-To: <20240306123217.29774-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oBA29ilh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/ssvpF3u"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.98 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.48)[79.54%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.98
X-Rspamd-Queue-Id: 112375D273
X-Spam-Flag: NO

On 3/6/24 13:32, Oscar Salvador wrote:
> Although the retrieval of the stack_records for {dummy,failure}_handle
> happen when page_owner gets initialized, there seems to be some situations
> where stackdepot space has been already depleted by then, so we get
> 0-handles which make stack_records being NULL for those cases.
> 
> Be careful to 1) only bump stack_records refcount and 2) only access
> stack_record fields if we actually have a non-null stack_record between
> hands.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403051032.e2f865a-lkp@intel.com
> Fixes: 4bedfb314bdd ("mm,page_owner: implement the tracking of the stacks count")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_owner.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 033e349f6479..7163a1c44ccf 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -107,8 +107,10 @@ static __init void init_page_owner(void)
>  	/* Initialize dummy and failure stacks and link them to stack_list */
>  	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
>  	failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
> -	refcount_set(&dummy_stack.stack_record->count, 1);
> -	refcount_set(&failure_stack.stack_record->count, 1);
> +	if (dummy_stack.stack_record)
> +		refcount_set(&dummy_stack.stack_record->count, 1);
> +	if (failure_stack.stack_record)
> +		refcount_set(&failure_stack.stack_record->count, 1);
>  	dummy_stack.next = &failure_stack;
>  	stack_list = &dummy_stack;
>  }
> @@ -856,6 +858,9 @@ static int stack_print(struct seq_file *m, void *v)
>  	unsigned long nr_entries;
>  	struct stack_record *stack_record = stack->stack_record;
>  
> +	if (!stack->stack_record)
> +		return 0;
> +
>  	nr_entries = stack_record->size;
>  	entries = stack_record->entries;
>  	stack_count = refcount_read(&stack_record->count) - 1;


