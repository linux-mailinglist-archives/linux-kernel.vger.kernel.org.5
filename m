Return-Path: <linux-kernel+bounces-127702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF765894FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DF4B2322B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0217A5A11D;
	Tue,  2 Apr 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4ywbHRJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXATRa89"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF759172
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052821; cv=none; b=M7bF5w18XylCL4eKazsyJ4E/61XZ4VDO/pOV01hX7Ql5PF9q15aZr/u2jXbUB/3SryM+zoyEnpjAkPXkMPqJiBTpN99CUgJvBykiTQOvnqMo+N5C9pOFf/1mQhCo7ypjFQuikBC1JMEQnm7Rg5JVmR22VTrIcO7CfkPqfNGOvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052821; c=relaxed/simple;
	bh=nnW9cY5UMc9aiVXVtJgznvmtK6B6GVzaC+9Ki/0JUqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbpI1V/jfC+rx3d/IHoXJlqmDYBOckm0pN6bQ6KGsd6Nfxa32WouO3lHuqudEH96j6ucqrnPJc+D7+w+sCGuQj7k0hLBJe8q9d7hijTg6Fr3q9sOD00xmyuIdUV0SDw47vBtEGu5rJynn3+Wqcz5dYVU5dPXNbk2nSw3vvtLUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4ywbHRJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXATRa89; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B61620F47;
	Tue,  2 Apr 2024 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712052817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njSlSGOMqBKNspEV8hCCFGcHqk6Kp8tl6U12MEOcK30=;
	b=w4ywbHRJHXHA595W2TmolBE+GoC4lQpd7D3ugWhG7HFeWG9P0wVr72QxVfv2b2NnZB3slV
	wtcosM3tkverf23koiL3ADiSuJYUHBhOK+DvG3zuzWuLVcKNN2SGPDEw3O1azKT0vK+muG
	vx01hxGCvkGIActugoepzogcafXLlno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712052817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njSlSGOMqBKNspEV8hCCFGcHqk6Kp8tl6U12MEOcK30=;
	b=vXATRa89zGM3jg+gaEqtjs49i8HxOmuwTfQoACMMBIqviAm4kikj1M7FE8vyLUKMPm19w5
	haphp9lEjifTJKDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 662BF13A90;
	Tue,  2 Apr 2024 10:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LjZxGFHaC2YyEAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 10:13:37 +0000
Message-ID: <fede9c3a-5686-4c44-a459-bf36c7093203@suse.cz>
Date: Tue, 2 Apr 2024 12:13:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm,page_owner: Update metada for tail pages
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240326063036.6242-1-osalvador@suse.de>
 <20240326063036.6242-2-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240326063036.6242-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7B61620F47
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO


Subject: metada -> metadata

On 3/26/24 7:30 AM, Oscar Salvador wrote:
> __set_page_owner_handle() and __reset_page_owner() update the metadata
> of all pages when the page is of a higher-order, but we miss to do the
> same when the pages are migrated.
> __folio_copy_owner() only updates the metadata of the head page, meaning
> that the information stored in the first page and the tail pages will not
> match.
> 
> Strictly speaking that is not a big problem because 1) we do not print
> tail pages and 2) upon splitting all tail pages will inherit the
> metada of the head page, but it is better to have all metadata in check

  metadata

> should there be any problem, so it can ease debugging.
> 
> For that purpose, a couple of helpers are created
> __update_page_owner_handle() which updates the metadata on allocation,
> and __update_page_owner_free_handle() which does the same when the page
> is freed.
> 
> __folio_copy_owner() will make use of both as it needs to entirely replace
> the page_owner metadata for the new page.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Also I think this series should move to mm-hotfixes due to fixing bugs from rc1.

Some more nits:

> @@ -355,31 +375,21 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>  	}
>  
>  	old_page_owner = get_page_owner(old_ext);
> -	new_page_owner = get_page_owner(new_ext);
> -	new_page_owner->order = old_page_owner->order;
> -	new_page_owner->gfp_mask = old_page_owner->gfp_mask;
> -	new_page_owner->last_migrate_reason =
> -		old_page_owner->last_migrate_reason;
> -	new_page_owner->handle = old_page_owner->handle;
> -	new_page_owner->pid = old_page_owner->pid;
> -	new_page_owner->tgid = old_page_owner->tgid;
> -	new_page_owner->free_pid = old_page_owner->free_pid;
> -	new_page_owner->free_tgid = old_page_owner->free_tgid;
> -	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
> -	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
> -	strcpy(new_page_owner->comm, old_page_owner->comm);
> -
> +	__update_page_owner_handle(new_ext, old_page_owner->handle,
> +				   old_page_owner->order, old_page_owner->gfp_mask,
> +				   old_page_owner->last_migrate_reason,
> +				   old_page_owner->ts_nsec, old_page_owner->pid,
> +				   old_page_owner->tgid, old_page_owner->comm);
>  	/*
> -	 * We don't clear the bit on the old folio as it's going to be freed
> -	 * after migration. Until then, the info can be useful in case of
> -	 * a bug, and the overall stats will be off a bit only temporarily.
> -	 * Also, migrate_misplaced_transhuge_page() can still fail the
> -	 * migration and then we want the old folio to retain the info. But
> -	 * in that case we also don't need to explicitly clear the info from
> -	 * the new page, which will be freed.
> +	 * Do not proactively clear PAGE_EXT_OWNER{_ALLOCATED} bits as the folio
> +	 * will be freed after migration. Keep them until then as they may be
> +	 * useful.
>  	 */

The full old comment made sense, the new one sounds like it's talking about
the old folio ("will be freed after migration") but we're modifying the new
folio here. IIUC it means the case of migration failing and then the new
folio MIGHT be freed. So I think you made the comment too much concise to be
immediately clear?

> -	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
> -	__set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
> +	__update_page_owner_free_handle(new_ext, 0, old_page_owner->order,
> +					old_page_owner->free_pid,
> +					old_page_owner->free_tgid,
> +					old_page_owner->free_ts_nsec);
> +
>  	page_ext_put(new_ext);
>  	page_ext_put(old_ext);
>  }
> @@ -787,8 +797,9 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  				goto ext_put_continue;
>  
>  			/* Found early allocated page */
> -			__set_page_owner_handle(page_ext, early_handle,
> -						0, 0);
> +			__update_page_owner_handle(page_ext, early_handle, 0, 0,
> +						   -1, local_clock(), current->pid,
> +						   current->tgid, current->comm);
>  			count++;
>  ext_put_continue:
>  			page_ext_put(page_ext);


