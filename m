Return-Path: <linux-kernel+bounces-127724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1988895000
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EF71F220E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FDE5B682;
	Tue,  2 Apr 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c3/Aew7R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+OK/CSv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D55914D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053615; cv=none; b=fw/eDj6PJiEv01XGU68y0Vb3es9oSS8LxmvFvEOVLp0Asx9u261DPUEWCgKhaJ4nxHtcYt+F8FmMsLF1kmmDya7LcQkQwJXhHr5IiWJ/CmpKD5R0FgeUuo03itW/v2G6wggLJMbX3gnCMPz3Vicrks7Gm5GSg3e7NTeRvzo2Kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053615; c=relaxed/simple;
	bh=Z4s92GPLQpERHtXq552PK4Et/Xyy0j6adzqg48pFqi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHx14gT6qu/7sp0zMr9XU/UucxwvPDIy74mI8dzXLWVYc+pdndvRmeeK3t4bmmt9vS4ZoYvSfWgEyxqEgjFAgb2fKgZhSxkfkFHApm3J7zdcuds2zAZAfz8wO43ftyX07QgfW3HXiMu54PEPSm7CAKzTPpx/DXlTjkWyjniExHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c3/Aew7R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+OK/CSv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1980834583;
	Tue,  2 Apr 2024 10:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712053612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsqZPy+24oMYT2lO+yB2VXDnHjznmcGdw0YcjOb204o=;
	b=c3/Aew7Rs4mdHLOk5Jc6KLh6wLveDiD9l+S9NpQ9u1vHFW8N3srNpN/1R74L07LiS/Y1KE
	aoQrxYTOXCZP9xQRY3G57KsmCvFA5ZTklQecxr2jvUn14NOKiIpk6vYOOKnpj8U1f4lzjQ
	ibIYUEHiuSY1hzwtfuthlyeuqVJhAlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712053612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsqZPy+24oMYT2lO+yB2VXDnHjznmcGdw0YcjOb204o=;
	b=J+OK/CSvXNWRf2bGQFKD2+SWhtkn244KMnJ5dJg17SZOJVmm96+OyCSanTMV4AEokgXU9Q
	R/JaBST64QnCUOCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0289013A90;
	Tue,  2 Apr 2024 10:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9A4EAGzdC2bUFAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 10:26:51 +0000
Message-ID: <50f31489-b5c3-480e-a7db-20edbbb2c9c2@suse.cz>
Date: Tue, 2 Apr 2024 12:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm,page_owner: Fix accounting of pages when
 migrating
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240326063036.6242-1-osalvador@suse.de>
 <20240326063036.6242-4-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240326063036.6242-4-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.10
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 BAYES_HAM(-3.00)[100.00%];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: 1980834583

On 3/26/24 7:30 AM, Oscar Salvador wrote:
> Upon migration, new allocated pages are being given the handle of the old
> pages. This is problematic because it means that for the stack which
> allocated the old page, we will be substracting the old page + the new one
> when that page is freed, creating an accounting imbalance.
> 
> There is an interest in keeping it that way, as otherwise the output will
> biased towards migration stacks should those operations occur often, but
> that is not really helpful.
> The link from the new page to the old stack is being performed by calling
> __update_page_owner_handle() in __folio_copy_owner().
> The only thing that is left is to link the migrate stack to the old
> page, so the old page will be subtracted from the migrate stack,
> avoiding by doing so any possible imbalance.
> 
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_owner.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 5df0d6892bdc..b4476f45b376 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -366,9 +366,12 @@ void __split_page_owner(struct page *page, int old_order, int new_order)
>  
>  void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>  {
> +	int i;
>  	struct page_ext *old_ext;
>  	struct page_ext *new_ext;
>  	struct page_owner *old_page_owner;
> +	struct page_owner *new_page_owner;
> +	depot_stack_handle_t migrate_handle;
>  
>  	old_ext = page_ext_get(&old->page);
>  	if (unlikely(!old_ext))
> @@ -381,6 +384,8 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>  	}
>  
>  	old_page_owner = get_page_owner(old_ext);
> +	new_page_owner = get_page_owner(new_ext);
> +	migrate_handle = new_page_owner->handle;
>  	__update_page_owner_handle(new_ext, old_page_owner->handle,
>  				   old_page_owner->order, old_page_owner->gfp_mask,
>  				   old_page_owner->last_migrate_reason,
> @@ -395,6 +400,16 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>  					old_page_owner->free_pid,
>  					old_page_owner->free_tgid,
>  					old_page_owner->free_ts_nsec);
> +	/*
> +	 * We linked the original stack to the new folio, we need to do the same
> +	 * for the new one and the old folio otherwise there will be an imbalance
> +	 * when subtracting those pages from the stack.
> +	 */
> +	for (i = 0; i < (1 << new_page_owner->order); i++) {
> +		old_page_owner->handle = migrate_handle;
> +		old_ext = page_ext_next(old_ext);
> +		old_page_owner = get_page_owner(old_ext);
> +	}

Can the migration still fail after __folio_copy_owner()? That goes again to
the comment you changed in patch 1/3. If it can, this will kinda create a
mess with the old folio's handles not reflecting reality? (although
refcounts will be ok)

So if that case is possible, could we instead just dec_stack_record_count()
for the handle that allocated the new folio (IIUC "migrate_handle" here) and
inc_stack_record_count() for the original handle that we duplicated from the
old to new. Then if either old is freed (successful migration) or new is
freed (failed migration), we'll have the correct refcounts.

>  
>  	page_ext_put(new_ext);
>  	page_ext_put(old_ext);


