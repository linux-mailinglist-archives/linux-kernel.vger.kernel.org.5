Return-Path: <linux-kernel+bounces-92505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3AA872153
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E71283936
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A086AE9;
	Tue,  5 Mar 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XoxnmDLh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhXwXIIy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XoxnmDLh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhXwXIIy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160986AE2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648218; cv=none; b=js0M+zzGEIbfjtjbiHxlALKZt4i+bfcD7It3LMN3FXOpCho1AdGeRKSOigXPepaDC1XWC/u4HF7ufk0BeU36MaNMbbd5bNmzJw70tGO1RzT5K3FoRjZQzWClKNdbLp4UfuWWAiHPstvt9T7fIGKq7Eyk5yFqdD0H3/KTFkpoLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648218; c=relaxed/simple;
	bh=EMtrprSFJjYRlNByA46g7xUS+JmzBrqw1ixMLY+jf94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db97I4TY8F9dlPkalmixmqAKiqmjR7VNI9UQ0/rL3o6Fa8Qae4dzovRuG/KQw0nlJMamvUt5hAlU8SbyT98SzKNloQlxrh9JdPTVY1hfQSd5nV9Bp89gb8PbvnwmkJ66DZkmd8PfoJKXvvFDoNa8EBJZpx+0T7nv07+o6gDW3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XoxnmDLh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhXwXIIy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XoxnmDLh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhXwXIIy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C55C3770A9;
	Tue,  5 Mar 2024 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709648214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3OMLq/c7VcyXaAMReTMMSzBFkdO2IL60HjJQlKcYdM=;
	b=XoxnmDLhtSwWnEZ5Vz+5a6ySWkFVp/XihrJPB6/7anvnI2U13FALvHrra9TJj5f3NEoAOR
	gpT/cdyhXSRLLf/JhiorLca1vs1QPEf5HKEpKSprH+67AZru1LLfIbQeehyzo6ZAE2QdyI
	KJrmqIlWlNF9Jg3OHa+rip/aycwxKo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709648214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3OMLq/c7VcyXaAMReTMMSzBFkdO2IL60HjJQlKcYdM=;
	b=XhXwXIIy+mZ+GJKPCn0Oe5bCe7p4aucj43BBFOlJLHt+rNuBaPKnNdKZdf3PH4T7BP0fyL
	gJ3EPnrFBBFxwhBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709648214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3OMLq/c7VcyXaAMReTMMSzBFkdO2IL60HjJQlKcYdM=;
	b=XoxnmDLhtSwWnEZ5Vz+5a6ySWkFVp/XihrJPB6/7anvnI2U13FALvHrra9TJj5f3NEoAOR
	gpT/cdyhXSRLLf/JhiorLca1vs1QPEf5HKEpKSprH+67AZru1LLfIbQeehyzo6ZAE2QdyI
	KJrmqIlWlNF9Jg3OHa+rip/aycwxKo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709648214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3OMLq/c7VcyXaAMReTMMSzBFkdO2IL60HjJQlKcYdM=;
	b=XhXwXIIy+mZ+GJKPCn0Oe5bCe7p4aucj43BBFOlJLHt+rNuBaPKnNdKZdf3PH4T7BP0fyL
	gJ3EPnrFBBFxwhBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BB18413A5D;
	Tue,  5 Mar 2024 14:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ue+rLVYp52XDRAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 05 Mar 2024 14:16:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73C72A0650; Tue,  5 Mar 2024 15:16:54 +0100 (CET)
Date: Tue, 5 Mar 2024 15:16:54 +0100
From: Jan Kara <jack@suse.cz>
To: chengming.zhou@linux.dev
Cc: jack@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] quota: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240305141654.t4x62sco3pqr3t5n@quack3>
References: <20240224135118.830073-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135118.830073-1-chengming.zhou@linux.dev>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XoxnmDLh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XhXwXIIy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.62 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.61)[98.28%]
X-Spam-Score: -3.62
X-Rspamd-Queue-Id: C55C3770A9
X-Spam-Flag: NO

On Sat 24-02-24 13:51:18, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index f73016c7bc39..dacbee455c03 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -3008,7 +3008,7 @@ static int __init dquot_init(void)
>  	dquot_cachep = kmem_cache_create("dquot",
>  			sizeof(struct dquot), sizeof(unsigned long) * 4,
>  			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
> -				SLAB_MEM_SPREAD|SLAB_PANIC),
> +				SLAB_PANIC),
>  			NULL);
>  
>  	order = 0;
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

