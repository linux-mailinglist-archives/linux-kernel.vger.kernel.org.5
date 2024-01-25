Return-Path: <linux-kernel+bounces-38197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDB83BC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AE728163D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349E1B95F;
	Thu, 25 Jan 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sSa+is6I";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sSa+is6I"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC71805A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172853; cv=none; b=RPUMF9v5xxrq91z0NSzXm6lNa30/vwNubpPqOgZMczgpsDe4aL4MenvPwk6v837OEUJKZBDeYdCFY7bjYkXWICOpRILX6slbgAPG4Bq1AtVVBxU9CboOEmtyNcTTAlIynM0de+LyiFc89bmqYw7eJPYRf6z0qwuqoZujpgp0G2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172853; c=relaxed/simple;
	bh=z6XRFaS84z9g7qblnH+LG49Jfq7o/lPDSgcB82hgA0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYw8f/DcbRHqpf1n6tk//z5Yj69vEJd/gmiH2HggfMDc0osw7Sa9JT7uN3unOzbdM/gCXBCHdUc0cDueqduIFqD0K7I/gVTXX6kv2sUrviNkAMnjM4IeSb0eyBg5JV5rVYwwp8fXIweVDINwW8PJj6ny+UkjuCBT3o0D/SyfAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sSa+is6I; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sSa+is6I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 603AD21F5F;
	Thu, 25 Jan 2024 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706172843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ecjAXcF2LiHHvxYnU8Fo2z7wDNf7fQuOUP6dn1MlNk=;
	b=sSa+is6I8ZeE4cqganZ4RLhvkR6KKtqLp98Nl1vxh2lwcgKBLKM5lsuv8lrs243U4F3jHp
	de/SVoIpJwrUYWelmAchqHmAIX8DPjO/WuGo78iVezDvZsCw9DuA+MuqvtopfrPoXcgWk6
	vh545D1vtOu5bNHdDgl3aNuTy1dGKPA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706172843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ecjAXcF2LiHHvxYnU8Fo2z7wDNf7fQuOUP6dn1MlNk=;
	b=sSa+is6I8ZeE4cqganZ4RLhvkR6KKtqLp98Nl1vxh2lwcgKBLKM5lsuv8lrs243U4F3jHp
	de/SVoIpJwrUYWelmAchqHmAIX8DPjO/WuGo78iVezDvZsCw9DuA+MuqvtopfrPoXcgWk6
	vh545D1vtOu5bNHdDgl3aNuTy1dGKPA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2779F134C3;
	Thu, 25 Jan 2024 08:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id exlXBqshsmVFNQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 25 Jan 2024 08:54:03 +0000
Date: Thu, 25 Jan 2024 09:53:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yang Shi <shy828301@gmail.com>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com,
	willy@infradead.org, cl@linux.com, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <ZbIhoj2PzD5jIdSn@tiehlicka>
References: <20240118133504.2910955-1-shy828301@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118133504.2910955-1-shy828301@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sSa+is6I
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,infradead.org:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 603AD21F5F
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu 18-01-24 05:35:04, Yang Shi wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") caused two issues [1] [2] reported on 32 bit system or compat
> userspace.
> 
> It doesn't make too much sense to force huge page alignment on 32 bit
> system due to the constrained virtual address space.
> 
> [1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab95
> [2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb1d
> 
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/huge_memory.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 94ef5c02b459..e9fbaccbe0c0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -37,6 +37,7 @@
>  #include <linux/page_owner.h>
>  #include <linux/sched/sysctl.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/compat.h>
>  
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> @@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>  	loff_t off_align = round_up(off, size);
>  	unsigned long len_pad, ret;
>  
> +	/*
> +	 * It doesn't make too much sense to froce huge page alignment on
> +	 * 32 bit system or compat userspace due to the contrained virtual
> +	 * address space and address entropy.
> +	 */
> +	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +		return 0;
> +
>  	if (off_end <= off_align || (off_end - off_align) < size)
>  		return 0;
>  
> -- 
> 2.41.0
> 

-- 
Michal Hocko
SUSE Labs

