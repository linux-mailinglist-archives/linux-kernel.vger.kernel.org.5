Return-Path: <linux-kernel+bounces-127653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C7894EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8129282D62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C558ABB;
	Tue,  2 Apr 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h6wjHOy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ik5BZpXE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9617597
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051149; cv=none; b=XEpsw1mms+CfsKDrDMWXIndeYEkGtlAbHIf5zQhoQA5xG2KcUl0tvnHkRhmxZRMyq8NoG6q9GMHroY9EusAhKf/OYsDuZoCwxkfNHN6zB1v506ueeha6Xd/1Tg0sP7iv/62xjCXbw1UDaSkX7+VdelQ2ObA7mXUDvUECAdxVMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051149; c=relaxed/simple;
	bh=TpDjYcDJTEwBQv23SgML+k5kBhoSqJh8z0wj7Hlb1cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ny+7gV5mB1aWvjZxFs89s2nFb/UjwuG78bArEhvk/k6XZioHEhGToE1wZRWdJlIRLPRIVyCDDSGGVPSB+7XhmOajtDycJqWZ8M3Gmv9J/2WRDA/CjG4nchmJofPE84Q1/HAh2QA5ncnHSo/E0MrEM/vGoftDA6IsvQ4hmYZPB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h6wjHOy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ik5BZpXE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC1FC20F01;
	Tue,  2 Apr 2024 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712051145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDYWPh9W842+NarazX7IGM60Ne3NuUq4V7uhwpL30C8=;
	b=h6wjHOy+wKQyBBgtWta6IMyhrS/ULjUOZc2b4JTH2b/FcAAwzVCKqAhRHzAx3idWWcY9yv
	UM5ydFu3xnQdOzRxH1JDEU4WpxTea2mOq3/kixNqSF/z3aPbBnQ7V0g2uEORxuDxXtHUlq
	Cfdm3WUV+y4uRHFNaatnBtgdAka+Yqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712051145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDYWPh9W842+NarazX7IGM60Ne3NuUq4V7uhwpL30C8=;
	b=ik5BZpXEngWVzPLH2TQFuHy1B+pO6NR/qPVwZVS6bpWloHZTbh2xZSvinvsOnOtz+s0NH6
	Xu7I0D/ltmUoV/DQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E6413A90;
	Tue,  2 Apr 2024 09:45:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ivHII8nTC2ZfAwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 09:45:45 +0000
Message-ID: <d5a7f24c-52e6-471c-893e-44448efccbd4@suse.cz>
Date: Tue, 2 Apr 2024 11:45:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/slub: remove the check of
 !kmem_cache_has_cpu_partial()
Content-Language: en-US
To: xiongwei.song@windriver.com, rientjes@google.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, chengming.zhou@linux.dev
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-2-xiongwei.song@windriver.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240331021926.2732572-2-xiongwei.song@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.19
X-Spamd-Result: default: False [0.19 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.987];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[windriver.com,google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.02)[53.65%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 3/31/24 4:19 AM, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> The check of !kmem_cache_has_cpu_partial(s) with
> CONFIG_SLUB_CPU_PARTIAL enabled here is always false. We have known the
> result by calling kmem_cacke_debug(). Here we can remove it.

Could we be more obvious. We have already checked kmem_cache_debug() earlier
and if it was true, the we either continued or broke from the loop so we
can't reach this code in that case and don't need to check
kmem_cache_debug() as part of kmem_cache_has_cpu_partial() again.

> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/slub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7b6..059922044a4f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2610,8 +2610,7 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  			partial_slabs++;
>  		}
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> -		if (!kmem_cache_has_cpu_partial(s)
> -			|| partial_slabs > s->cpu_partial_slabs / 2)
> +		if (partial_slabs > s->cpu_partial_slabs / 2)
>  			break;
>  #else
>  		break;


