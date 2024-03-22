Return-Path: <linux-kernel+bounces-111852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A08871BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B54B1F21B93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266A85FF0E;
	Fri, 22 Mar 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrKfRzgJ"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B460258;
	Fri, 22 Mar 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127412; cv=none; b=GllXG1fR2BsQGCiBUreZs98HznLVP6PlC5zDXVks6PrYG1OA3EKgQjdierD7+h2ted7igx1d423tEj2ff3nwww0Ld3XTfAmYa0Qg96RGdLGH+xaB6D7UH03C+4IIShRbQleB5+ADVVDWraQ4v/WzbSGew17wDjR2p+imkDP1mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127412; c=relaxed/simple;
	bh=BGf6m+3FUmEtjcPIdIXP/XbcrnNSXJyHQ7Wp/B64z6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmy+tvn97LdN56loYzAHc5TA3lGGaJYSgOeA8YIqcLZKDX7Td5h7b7u1jCydMBU8B1JKE9hsJi6NDN358RqSe5h8VZ22G74Qk3ZbRuQzqqsJUKzyrLwBO5kKTdGh8kQsvnocNt1SDvZL1ZFvHbWWy3hgojfVVfPvy1vfOvgcle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrKfRzgJ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a46b28a77dso1295841eaf.1;
        Fri, 22 Mar 2024 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711127409; x=1711732209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WK7ESWIrsT1mdAzBwJKIthGxoZjuPKZEr2RCxckPCI=;
        b=WrKfRzgJYbykiD2JH9TbDiXK4BGOdbyHpDGHiWp7TsXwWqx4B4hAeytyqhuxPGT1bZ
         yCH5gs2vqSfktEvzQHvhV2BIBPyeB9CjhPhdwhFYcCtquH1geCk+y/pdSXIAFI7Kgepp
         +3C0AOoL+7Wtg8CNQ+b5/0Ky6vLxehFZgpyUkVeRPjyE7hzI/TSgW/mX/GmnxX0F9VdV
         /sgs4KiBMnllewH/JjpqchypWR5PqoSRJDU4Q9/XTfw8VQyyFolUUREuS+W2zKOG1xtk
         PC3J+ihUEQa47AdRqmKYfXlDIUKzJ/MPnhytGBJak1scIrThb0bfuQA5Cg22xcPlASET
         H1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127409; x=1711732209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WK7ESWIrsT1mdAzBwJKIthGxoZjuPKZEr2RCxckPCI=;
        b=xUuIcybZzXWVGilKXbbkdCHDPEofECQxj+RwrkszgAGP2Jj3nSCg0NvbnRSr2bPji7
         +0aFZAWSgz2NgE/gt73RHn03V4AS1OBd7/CGdrzB2/u7CaNYN1rAG6t3Lt+Fp3Ii8LHb
         izfljcA3+72wFyXKg8TPo8gIg2mlqPPxsHo8ZO6iSsskYufVcU0BRF3rPP3faKzjq0Dp
         m2E9CDw/xNInn+6ziQXZQ/Pt37ndb499s1xuCSR9octEe6j6kTdu9cD6FWRTLRcKBj8m
         HMLtBJ+JaJgIAMie6r9lQDGJQyRTYgZ9a+El1DAybdTuA0vEHGEiLePpZinmAB2ez+9K
         tKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO48joyLhZ1FhrKMux/NfTiaAj2gQhwhABNK3qHbgr0Ycny9wyllda78ve6Sdz86vkNTJnJ+eDTQFDUqULlMwtDEqgrIq1BpqLKd2pGcdQqJU8Z13WJAsZEg5dFHyBHE0cBfrO
X-Gm-Message-State: AOJu0YzLUf1QpZOHNPXTYktxAr+1r3AnztzWLNuEQY6J4b3Jsqy7KGr9
	VYG2oGeEcFEAVIP6XwNeOxYM2UvFIIfsbNDXVoNf8SWf/pcw1hFq8zI6T5VIbtfY9JlK0dL94XM
	dxPGOPeWBkb7qsldJYLGp0P5GmRA=
X-Google-Smtp-Source: AGHT+IHe5lm8Oz3ykhLJ25PlsDeMFHiGkFXpFUiBjYMSOx4eCClJWATfPKU5nxuUmZxlDIAUFAQ1bN0dwuYpPYgZXJ8=
X-Received: by 2002:a05:6808:198d:b0:3c3:89a8:8de9 with SMTP id
 bj13-20020a056808198d00b003c389a88de9mr337900oib.51.1711127409375; Fri, 22
 Mar 2024 10:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321182532.60000-1-hannes@cmpxchg.org>
In-Reply-To: <20240321182532.60000-1-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 22 Mar 2024 10:09:56 -0700
Message-ID: <CAKEwX=Pnr1HZipHTqnvMruh21uO7UXDP67nAZ5s_WrwgWkNpzg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS recursion
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 11:25=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> Kent forwards this bug report of zswap re-entering the block layer
> from an IO request allocation and locking up:
>
> [10264.128242] sysrq: Show Blocked State
> [10264.128268] task:kworker/20:0H   state:D stack:0     pid:143   tgid:14=
3   ppid:2      flags:0x00004000
> [10264.128271] Workqueue: bcachefs_io btree_write_submit [bcachefs]
> [10264.128295] Call Trace:
> [10264.128295]  <TASK>
> [10264.128297]  __schedule+0x3e6/0x1520
> [10264.128303]  schedule+0x32/0xd0
> [10264.128304]  schedule_timeout+0x98/0x160
> [10264.128308]  io_schedule_timeout+0x50/0x80
> [10264.128309]  wait_for_completion_io_timeout+0x7f/0x180
> [10264.128310]  submit_bio_wait+0x78/0xb0
> [10264.128313]  swap_writepage_bdev_sync+0xf6/0x150
> [10264.128317]  zswap_writeback_entry+0xf2/0x180
> [10264.128319]  shrink_memcg_cb+0xe7/0x2f0
> [10264.128322]  __list_lru_walk_one+0xb9/0x1d0
> [10264.128325]  list_lru_walk_one+0x5d/0x90
> [10264.128326]  zswap_shrinker_scan+0xc4/0x130
> [10264.128327]  do_shrink_slab+0x13f/0x360
> [10264.128328]  shrink_slab+0x28e/0x3c0
> [10264.128329]  shrink_one+0x123/0x1b0
> [10264.128331]  shrink_node+0x97e/0xbc0
> [10264.128332]  do_try_to_free_pages+0xe7/0x5b0
> [10264.128333]  try_to_free_pages+0xe1/0x200
> [10264.128334]  __alloc_pages_slowpath.constprop.0+0x343/0xde0
> [10264.128337]  __alloc_pages+0x32d/0x350
> [10264.128338]  allocate_slab+0x400/0x460
> [10264.128339]  ___slab_alloc+0x40d/0xa40
> [10264.128345]  kmem_cache_alloc+0x2e7/0x330
> [10264.128348]  mempool_alloc+0x86/0x1b0
> [10264.128349]  bio_alloc_bioset+0x200/0x4f0
> [10264.128352]  bio_alloc_clone+0x23/0x60
> [10264.128354]  alloc_io+0x26/0xf0 [dm_mod 7e9e6b44df4927f93fb3e4b5c78276=
7396f58382]
> [10264.128361]  dm_submit_bio+0xb8/0x580 [dm_mod 7e9e6b44df4927f93fb3e4b5=
c782767396f58382]
> [10264.128366]  __submit_bio+0xb0/0x170
> [10264.128367]  submit_bio_noacct_nocheck+0x159/0x370
> [10264.128368]  bch2_submit_wbio_replicas+0x21c/0x3a0 [bcachefs 85f1b9a7a=
824f272eff794653a06dde1a94439f2]
> [10264.128391]  btree_write_submit+0x1cf/0x220 [bcachefs 85f1b9a7a824f272=
eff794653a06dde1a94439f2]
> [10264.128406]  process_one_work+0x178/0x350
> [10264.128408]  worker_thread+0x30f/0x450
> [10264.128409]  kthread+0xe5/0x120
>
> The zswap shrinker resumes the swap_writepage()s that were intercepted
> by the zswap store. This will enter the block layer, and may even
> enter the filesystem depending on the swap backing file.
>
> Make it respect GFP_NOIO and GFP_NOFS.
>
> Link: https://lore.kernel.org/linux-mm/rc4pk2r42oyvjo4dc62z6sovquyllq56i5=
cdgcaqbd7wy3hfzr@n4nbxido3fme/
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Cc: stable@vger.kernel.org      [v6.8]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

