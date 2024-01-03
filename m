Return-Path: <linux-kernel+bounces-15634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D4822F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590D4282319
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507911A5AC;
	Wed,  3 Jan 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MtN2uqGh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129E1A58B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso5169336e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704291175; x=1704895975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2Zhz0tCrknBbn4mPfnDfT6xUAWt/cZjWnjiUj21MAI=;
        b=MtN2uqGhkL5A+9nZdQhYxLu15fh3qGjiukGpgu/OCsiInp0gBCCnwYxZ9Ix8fwg8XD
         8KD3qTIc+wf6Q02aCv+WLkWOEsNp+UIsh+gBPMv9qYgP2HatSv+ksYs08IkChSGcy9Te
         reh5qVTo9e9COLjZIaOpvNxqaBREZ1KWsKJlG1AccXXvA7LQ6sxT6rabxbe0cvhmHpan
         qHR7T/QqrH6irzhgik8E+BJI2ASkER2+iKkhsswvogARdlW0LURByt4h1Qox7TOix7V9
         tHcImiEZslshlZSV1JDO0m2LJEy6fccIPfEipYq2ygAdGc6t3gi092x8PsiG+CRpV0mq
         K/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291175; x=1704895975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2Zhz0tCrknBbn4mPfnDfT6xUAWt/cZjWnjiUj21MAI=;
        b=xMPl8HgnEGurLhIgAoBYUo/JEkVp45fIGeFZ9X1XXz/eHcrJZWrEiFW10kV/+mM4GP
         6opiUf4fvUCCgFwH0nMhZahG9C0bXY3hHF4Z5Of3eiTYzuPozh3IMQ+e41DMIG3x1hH5
         SO52ZbaL6r/s9gaCHBrnK/ajFrnBAkZSQ27BTgsLPUdfRx3N3njWWpjD9Kcy/rqjyEbm
         qWk6KsdSrr9SzO0Y2hIHx5qo8nfc1INB1Da3+hYOLf3E4q3yNuA/ZyRrX2Gt+dafmmNi
         ij//s6to1UzIxGpJOUmLxYhQ/bzCGy8601yMXoyz9F7T9j+w9HPjnpS4br4dbgnfKa5i
         JNFw==
X-Gm-Message-State: AOJu0YweLlK1k3maBTxVXOMBrI3B+i5ylX2Fg/fwUufrHlcyC9YKfKvj
	lGgkBhc4txrEGVouthy2Uk6EUEu9iBM22PiyqxOuffZl82LP3Q==
X-Google-Smtp-Source: AGHT+IGPdg2u4pBEOGmI4XV//9plC/mF5CKpkp9utMVG8zs3fwUavyPzk0fmGhV1JzjwG198frCIk53F+i0kplp55zg=
X-Received: by 2002:a05:6512:943:b0:50e:a517:6f0b with SMTP id
 u3-20020a056512094300b0050ea5176f0bmr500241lft.55.1704291174797; Wed, 03 Jan
 2024 06:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com> <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 3 Jan 2024 22:12:43 +0800
Message-ID: <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That's around 2.7% increase in real time, no? Admittedly, this
> micro-benchmark is too small to conclude either way, but the data
> doesn't seem to be in your favor.
>
> I'm a bit concerned about the overhead here, given that with this
> patch we will drain the per-cpu batch on every written-back entry.
> That's quite a high frequency, especially since we're moving towards
> more writeback (either with the new zswap shrinker, or your time
> threshold-based writeback mechanism). For instance, there seems to be
> some (local/per-cpu) locking involved, no? Could there be some form of
> lock contentions there (especially since with the new shrinker, you
> can have a lot of concurrent writeback contexts?)
>
> Furthermore, note that a writeback from zswap to swap saves less
> memory than a writeback from memory to swap, so the effect of the
> extra overhead will be even more pronounced. That is, the amount of
> extra work done (from this change) to save one unit of memory would be
> even larger than if we call lru_add_drain() every time we swap out a
> page (from memory -> swap). And I'm pretty sure we don't call
> lru_add_drain() every time we swap out a page - I believe we call
> lru_add_drain() every time we perform a shrink action. For e.g, in
> shrink_inactive_list(). That's much coarser in granularity than here.
>
> Also, IIUC, the more often we perform lru_add_drain(), the less
> batching effect we will obtain. IOW, the overhead of maintaining the
> batch will become higher relative to the performance gains from
> batching.
>
> Maybe I'm missing something - could you walk me through how
> lru_add_drain() is fine here, from this POV? Thanks!
>
> >
> > After writeback, we perform the following steps to release the memory a=
gain
> > echo 1g > memory.reclaim
> >
> > Base:
> >                      total        used        recalim        total     =
   used
> > Mem:           38Gi       2.5Gi       ---->             38Gi       1.5G=
i
> > Swap:         5.0Gi       1.0Gi       ---->              5Gi        1.5=
Gi
> > used memory  -1G   swap +0.5g
> > It means that  half of the pages are failed to move to the tail of lru =
list,
> > So we need to release an additional 0.5Gi anon pages to swap space.
> >
> > With this patch:
> >                      total        used        recalim        total     =
   used
> > Mem:           38Gi       2.6Gi       ---->             38Gi       1.6G=
i
> > Swap:         5.0Gi       1.0Gi       ---->              5Gi        1Gi
> >
> > used memory  -1Gi,  swap +0Gi
> > It means that we release all the pages which have been add to the tail =
of
> > lru list in zswap_writeback_entry() and folio_rotate_reclaimable().
> >
>
> OTOH, this suggests that we're onto something. Swap usage seems to
> decrease quite a bit. Sounds like a real problem that this patch is
> tackling.
> (Please add this benchmark result to future changelog. It'll help
> demonstrate the problem).

Yes

>
> I'm inclined to ack this patch, but it'd be nice if you can assuage my
> concerns above (with some justification and/or larger benchmark).
>

OK=EF=BC=8Cthanks.

> (Or perhaps, we have to drain, but less frequently/higher up the stack?)
>

I've reviewed the code again and have no idea. It would be better if
you have any suggestions.

New test:
This patch will add the execution of folio_rotate_reclaimable(not executed
without this patch) and lru_add_drain,including percpu lock competition.
I bind a new task to allocate memory and use the same batch lock to compete
with the target process, on the same CPU.
context:
1:stress --vm 1 --vm-bytes 1g    (bind to cpu0)
2:stress --vm 1 --vm-bytes 5g --vm-hang 0=EF=BC=88bind to cpu0=EF=BC=89
3:reclaim pages, and writeback 5G zswap_entry in cpu0 and node 0.

Average time of five tests

Base      patch            patch + compete
4.947      5.0676          5.1336
                +2.4%          +3.7%
compete means: a new stress run in cpu0 to compete with the writeback proce=
ss.
PID USER        %CPU  %MEM     TIME+ COMMAND                         P
 1367 root         49.5      0.0       1:09.17 bash     =EF=BC=88writeback=
=EF=BC=89            0
 1737 root         49.5      2.2       0:27.46 stress      (use percpu
lock)    0

around 2.4% increase in real time,including the execution of
folio_rotate_reclaimable(not executed without this patch) and lru_add_drain=
,but
no lock contentions.

around 1.3% additional  increase in real time with lock contentions on the =
same
cpu.

There is another option here, which is not to move the page to the
tail of the inactive
list after end_writeback and delete the following code in
zswap_writeback_entry(),
which did not work properly. But the pages will not be released first.

/* move it to the tail of the inactive list after end_writeback */
SetPageReclaim(page);

Thanks=EF=BC=8C
Zhongkun

> Thanks,
> Nhat
>
> >
> > Thanks for your time Nhat and Andrew. Happy New Year!

