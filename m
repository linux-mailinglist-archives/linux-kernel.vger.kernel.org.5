Return-Path: <linux-kernel+bounces-104437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063FD87CDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF042821AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D9A36B04;
	Fri, 15 Mar 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UOnbzokV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqgsxWh4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UOnbzokV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqgsxWh4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFE36AED
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508069; cv=none; b=K+kbqjZIpjKp2RmBsfs/02c6Uu5sOgJw48ZMxtG8I6tqSEqnV6rNHqdxRXSOIeODxvz6MvU9ubzPc8mcXO+vmwpyU4/hhFl13lGeeqnuXFi8F+RrgeYqKoRPksn5iUD9Wt64ri5AHgUMC/gVZlMeKvvqiyJzu9j/EVIQu/aySh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508069; c=relaxed/simple;
	bh=mSohghLDJbp7142TrJKBKFeVxl4X6hCtsSehtNibEsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqcYVXn2O32W82EXpt+nlo7kzDbWmJOPj2qiPyV9KQKw7zS359QU7IgvihbHDcTMs2EWbCYO9XNHHCBIk04pF6zA1LTYTsWHCyvUogvGKPL8oac0eS5S5X8S0EaP8yp4GFP5G4id9qjHXgjqeIIl66kQe8WQD39TYs8XQEnP/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UOnbzokV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqgsxWh4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UOnbzokV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqgsxWh4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 879881FB63;
	Fri, 15 Mar 2024 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710508065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb4nW2xcC1S94ZTnXVVn5Q1xi4EnOrvKCc0jSiOkq4=;
	b=UOnbzokVpaISeHhqtQu7ppsFLwcFl+UAfZyMYUt/+B98tl1wHEyZNnIlS42ZEhjGd87XNb
	PAWbFqH/cvMcoXtpY3a5BcJ7OxDqcsyQO1b1rPlttp7DrSDAgTke46qzPcvboa4/f33n9f
	IvSK4R9XvvkERRDKBd3xuiLhTjUu9h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710508065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb4nW2xcC1S94ZTnXVVn5Q1xi4EnOrvKCc0jSiOkq4=;
	b=yqgsxWh4wuRpVXb6X+sty568bStfsC/RERcqFnyydjWWv6Kj67cCkABvD8fGbeAnTND9Ai
	GPfyPfEDhWaTf6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710508065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb4nW2xcC1S94ZTnXVVn5Q1xi4EnOrvKCc0jSiOkq4=;
	b=UOnbzokVpaISeHhqtQu7ppsFLwcFl+UAfZyMYUt/+B98tl1wHEyZNnIlS42ZEhjGd87XNb
	PAWbFqH/cvMcoXtpY3a5BcJ7OxDqcsyQO1b1rPlttp7DrSDAgTke46qzPcvboa4/f33n9f
	IvSK4R9XvvkERRDKBd3xuiLhTjUu9h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710508065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb4nW2xcC1S94ZTnXVVn5Q1xi4EnOrvKCc0jSiOkq4=;
	b=yqgsxWh4wuRpVXb6X+sty568bStfsC/RERcqFnyydjWWv6Kj67cCkABvD8fGbeAnTND9Ai
	GPfyPfEDhWaTf6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 748A51368C;
	Fri, 15 Mar 2024 13:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bd4ZHCFI9GXQIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Mar 2024 13:07:45 +0000
Message-ID: <3bd30334-0a46-4050-930f-7f606a72b3e7@suse.cz>
Date: Fri, 15 Mar 2024 14:07:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,page_owner: Fix recursion
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240313234245.18824-1-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240313234245.18824-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.03
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.03)[55.66%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UOnbzokV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yqgsxWh4
X-Rspamd-Queue-Id: 879881FB63

On 3/14/24 00:42, Oscar Salvador wrote:
> Prior to 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> the only place where page_owner could potentially go into recursion due to
> its need of allocating more memory was in save_stack(), which ends up calling
> into stackdepot code with the possibility of allocating memory.
> 
> We made sure to guard against that by signaling that the current task was
> already in page_owner code, so in case a recursion attempt was made, we
> could catch that and return dummy_handle.
> 
> After above commit, a new place in page_owner code was introduced where we
> could allocate memory, meaning we could go into recursion would we take that
> path.
> 
> Make sure to signal that we are in page_owner in that codepath as well.
> Move the guard code into two helpers {un}set_current_in_page_owner()
> and use them prior to calling in the two functions that might allocate
> memory.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> ---
>  mm/page_owner.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> @@ -292,7 +302,9 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>  		return;
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  	page_ext_put(page_ext);
> +	set_current_in_page_owner();
>  	inc_stack_record_count(handle, gfp_mask);
> +	unset_current_in_page_owner();

This is because of the kmalloc() in add_stack_record_to_list() right? Why
not wrap just that then?

>  }
>  
>  void __set_page_owner_migrate_reason(struct page *page, int reason)


