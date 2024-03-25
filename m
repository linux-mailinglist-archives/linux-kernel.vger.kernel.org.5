Return-Path: <linux-kernel+bounces-116734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1633D88A2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3903A1C39736
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABA16ABC7;
	Mon, 25 Mar 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sy604nBw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgOtZyUf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+1EawY2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMoknTVc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E916D9C6;
	Mon, 25 Mar 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357410; cv=none; b=WZLDKo7OL61BZaKoA8Xq+HH0H3m0S50yxPyGz4pG4g91YTWHLqflIsfRa+ohUhj/vHnhR47kmESA2Kr+hEzJNMCYBd1ui4VHLRQfmau9c436wacwcaBDJEGQoORF31aGIb3OBs4s3cffSdmY511R74gGHGlTyaFHrf5aWhg0KZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357410; c=relaxed/simple;
	bh=ZLgf5k9dYFpuYV92qIDT8jX5N1PKaunEPFjINTt8igE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz+6AF8QnBMQ6lWhUowHge0ZNppMDk/qdkaSISyqWhZNCgi3yoSAcZ3nWnSGP+o79AtDwl7DRGfs7e78gFOiu5hK5PU0vd1/N+kKUNfcwbZcHgNG+xM4dJR06F9KayjFPpfyZxXANjh87hKa057osp/aaI9NRaBG1CEJJ0ynIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sy604nBw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgOtZyUf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+1EawY2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMoknTVc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92C0020A18;
	Mon, 25 Mar 2024 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711357404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USYfYpVzCaTHzXO8m+V03aFdxTBKJIoKjS9fav42aOk=;
	b=Sy604nBwxOBrz2uqOVlqI3hgloSv11CVfJac3oNh9PyzYcjTRkbkorelJ6W3hj+bUUN0pI
	NbGlitsEOVrn4ot5TFuzqgNR6VDx0n/h+B7kDeklARO4eCchjJ56bCYUbgcAnmYcihazsz
	hvND0g3ltxvUh6S5P9i4HCpSBjK9ShA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711357404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USYfYpVzCaTHzXO8m+V03aFdxTBKJIoKjS9fav42aOk=;
	b=qgOtZyUfpPVvTc6okdCBphjfsltfyDCzJX2aYYzwbEgTsa2UYRfCVItyMhvyrpOBitX42S
	r8XsmFkmc7K5sgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711357403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USYfYpVzCaTHzXO8m+V03aFdxTBKJIoKjS9fav42aOk=;
	b=a+1EawY2oVwpJZ5JNMNd03zI/AHxA7oebEGtXLSha2XivURqmxlo9g2gqFbsBNA+lUqLNV
	L62RwjomdN+HgcThQAkkrQT+oFSfYeDWxNvdN8mZ4GYPv/12luiT3tXaO8r94LxTMIeJF1
	dYrDb+jFoeofPbYqz2jl2+4WrieXdwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711357403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USYfYpVzCaTHzXO8m+V03aFdxTBKJIoKjS9fav42aOk=;
	b=QMoknTVcZXz/DCtE4PAXlE9wD8BuGfEtgORa87I2XgD1WhJnKhCgBbBvxyQKl7go2b1nms
	ZoF7XUiDKV+yesCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6931C13503;
	Mon, 25 Mar 2024 09:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id duPQGNs9AWY9KQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 09:03:23 +0000
Message-ID: <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
Date: Mon, 25 Mar 2024 10:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, "GONG, Ruiqi"
 <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jann Horn <jannh@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 jvoisin <julien.voisin@dustri.org>
References: <20240305100933.it.923-kees@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 R_RATELIMIT(0.00)[to_ip_from(RLpoh6j7ozpkb3cnstoapfqm8c)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,huaweicloud.com,huawei.com,vger.kernel.org,kvack.org,dustri.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a+1EawY2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QMoknTVc
X-Rspamd-Queue-Id: 92C0020A18

On 3/5/24 11:10 AM, Kees Cook wrote:
> Hi,
> 
> Repeating the commit logs for patch 4 here:
> 
>     Dedicated caches are available For fixed size allocations via
>     kmem_cache_alloc(), but for dynamically sized allocations there is only
>     the global kmalloc API's set of buckets available. This means it isn't
>     possible to separate specific sets of dynamically sized allocations into
>     a separate collection of caches.
> 
>     This leads to a use-after-free exploitation weakness in the Linux
>     kernel since many heap memory spraying/grooming attacks depend on using
>     userspace-controllable dynamically sized allocations to collide with
>     fixed size allocations that end up in same cache.
> 
>     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
>     against these kinds of "type confusion" attacks, including for fixed
>     same-size heap objects, we can create a complementary deterministic
>     defense for dynamically sized allocations.
> 
>     In order to isolate user-controllable sized allocations from system
>     allocations, introduce kmem_buckets_create(), which behaves like
>     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
>     which behaves like kmem_cache_alloc().)
> 
>     Allows for confining allocations to a dedicated set of sized caches
>     (which have the same layout as the kmalloc caches).
> 
>     This can also be used in the future once codetag allocation annotations
>     exist to implement per-caller allocation cache isolation[0] even for
>     dynamic allocations.
> 
>     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]
> 
> After the implemetation are 2 example patches of how this could be used
> for some repeat "offenders" that get used in exploits. There are more to
> be isolated beyond just these. Repeating the commit log for patch 8 here:
> 
>     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
>     use-after-free type confusion flaws in the kernel for both read and
>     write primitives. Avoid having a user-controlled size cache share the
>     global kmalloc allocator by using a separate set of kmalloc buckets.
> 
>     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
>     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
>     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
>     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
>     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
>     Link: https://zplin.me/papers/ELOISE.pdf [6]

Hi Kees,

after reading [1] I think the points should be addressed, mainly about the
feasibility of converting users manually. On a related technical note I
worry what will become of /proc/slabinfo when we convert non-trivial amounts
of users.

Also would interested to hear Jann Horn et al.'s opinion, and whether the
SLAB_VIRTUAL effort will continue?

Thanks,
Vlastimil


[1]
https://dustri.org/b/notes-on-the-slab-introduce-dedicated-bucket-allocator-series.html

> -Kees
> 
>  v2: significant rewrite, generalized the buckets type, added kvmalloc style
>  v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/
> 
> Kees Cook (9):
>   slab: Introduce kmem_buckets typedef
>   slub: Plumb kmem_buckets into __do_kmalloc_node()
>   util: Introduce __kvmalloc_node() that can take kmem_buckets argument
>   slab: Introduce kmem_buckets_create()
>   slab: Introduce kmem_buckets_alloc()
>   slub: Introduce kmem_buckets_alloc_track_caller()
>   slab: Introduce kmem_buckets_valloc()
>   ipc, msg: Use dedicated slab buckets for alloc_msg()
>   mm/util: Use dedicated slab buckets for memdup_user()
> 
>  include/linux/slab.h | 50 +++++++++++++++++++++-------
>  ipc/msgutil.c        | 13 +++++++-
>  lib/fortify_kunit.c  |  2 +-
>  mm/slab.h            |  6 ++--
>  mm/slab_common.c     | 77 ++++++++++++++++++++++++++++++++++++++++++--
>  mm/slub.c            | 14 ++++----
>  mm/util.c            | 23 +++++++++----
>  7 files changed, 154 insertions(+), 31 deletions(-)
> 


