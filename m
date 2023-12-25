Return-Path: <linux-kernel+bounces-11138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8B81E1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0953328238E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0F537E4;
	Mon, 25 Dec 2023 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCwQg5S1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BD52F98
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so40113541fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703527572; x=1704132372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfSdFLH0c+OXnYpo+8JLybKgdvKYAok3Q5sSWeoNCus=;
        b=VCwQg5S1OgcegNAVx5wvrliv4OpH/LgP7rKuqpo1xQEwczsKKpKcxvoNpN44rTG2C4
         8l1UTJFejRSvGXn+rMI2vd6BGB7U2LtwpBqjPweBJStd3hZYZj5OOS+dA5rfnGzzkOSc
         I+lFSorCtLzMYlYJI69MqBScj+kouUATzgz7gl1ey81CyMQM5w3c+KFvopNR5KiJ+b5v
         CSDXSKpm9ARio9MTOnug9CzkGNnxgQ0FmZXCfjJLZDt/0B/qq4ZysbC6GJ+6A2BLE0g3
         t6XA+CBwIjg2YeYFE2E2jESCNoK1lGOBiBYwcj6WSJ5sXgpVvmUnINAVueI7z6N47xY4
         EyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703527572; x=1704132372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfSdFLH0c+OXnYpo+8JLybKgdvKYAok3Q5sSWeoNCus=;
        b=hzRPwzTphEli0EMNYAT5vJc30CMYSjq/a6AuT6idgzE4t4aF3IXZaZHSpbatUp3WAg
         irV9Hd9WRae2SnJMVgzlZIIZ1vpdpQw6WLPmQjivhSpAUzvB9ZZtBMCbfvgx/7ll86a5
         kk/w8hEgbmI0pUpDfwsSDn1Rt2lXu+WHNTotapza66axohudD041j7QBZX047rIn4mWB
         vsmovSYBlxQyqPN0fLBy00HW16C0HWMauMzKj+xzsmNgwGKt/b7w8VbRs04bSBXdsbZC
         Jl3Xrwti+t0zpPPPQeg9VWLBi8U1bmtqyTSInwkNxSV+wu021E2z3J+l3ZynCg53yyR9
         6nLQ==
X-Gm-Message-State: AOJu0YzZNe8zLsujz1iu5pt8xfl96yeyAinoRSt8nUCeCo9A+i9seapw
	spLQ4jwGWkFDELUfXrJbMsHwAPL2NXgYWHr80f9ru/nxDVsEkwns
X-Google-Smtp-Source: AGHT+IGBqQFu2Rj7+H2ZRZ57EQXXxx7NMlETetd0SdwSLPfSIj07JtLQw9iiR1c804gfE5oo664NI0GKyA+aP1uNKFE=
X-Received: by 2002:a2e:3209:0:b0:2cc:6cba:ae7f with SMTP id
 y9-20020a2e3209000000b002cc6cbaae7fmr2446844ljy.92.1703527571746; Mon, 25 Dec
 2023 10:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-2-ryncsn@gmail.com>
 <CAOUHufYtSQnrVBC6OEXpT=LJW=L4J1Uw1yXpPrzaUhPWauo_3A@mail.gmail.com>
In-Reply-To: <CAOUHufYtSQnrVBC6OEXpT=LJW=L4J1Uw1yXpPrzaUhPWauo_3A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 26 Dec 2023 02:05:53 +0800
Message-ID: <CAMgjq7Bi19ou-c7rDZH+RMRMcV7Z49-xJh5KmFCfGy8XqCyREA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, lru_gen: batch update counters on againg
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8825=E6=97=A5=E5=
=91=A8=E4=B8=80 15:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > When lru_gen is aging, it will update mm counters page by page,
> > which causes a higher overhead if age happens frequently or there
> > are a lot of pages in one generation getting moved.
> > Optimize this by doing the counter update in batch.
> >
> > Although most __mod_*_state has its own caches the overhead
> > is still observable.
> >
> > Tested in a 4G memcg on a EPYC 7K62 with:
> >
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
> >     -a 0766 -t 16 -B binary &
> >
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys \
> >     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
> >     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
> >
> > Average result of 18 test runs:
> >
> > Before: 44017.78 Ops/sec
> > After:  44687.08 Ops/sec (+1.5%)
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 55 insertions(+), 9 deletions(-)
>
> Usually most reclaim activity happens in kswapd, e.g., from the
> MongoDB benchmark (--duration=3D900):
> pgscan_kswapd 11294317
> pgscan_direct 128
> And kswapd always has current->reclaim_state->mm_walk. So the
> following should bring the vast majority of the improvement (assuming
> it's not noise) with far less code change:

Hi Yu,

This won't work for the fault path (eg. the memtier test):
Samples: 30K of event 'cycles', Event count (approx.): 69411674954
  Children      Self  Command          Shared Object               Symbol
-   85.95%     0.69%  memcached        [kernel.vmlinux]            [k]
asm_exc_page_fault
   - 85.25% asm_exc_page_fault
      - 85.00% exc_page_fault
         - 84.81% do_user_addr_fault
            - 84.01% handle_mm_fault
               - 83.70% __handle_mm_fault
                  - 82.57% do_swap_page
                     - 61.66% mem_cgroup_swapin_charge_folio
                        - 61.11% charge_memcg
                           - 60.76% try_charge_memcg
                              - 60.68% try_to_free_mem_cgroup_pages
                                   do_try_to_free_pages
                                 - shrink_node
                                    - 60.51% shrink_lruvec
                                       - 60.45% try_to_shrink_lruvec
                                          + 60.42% evict_folios
                     + 10.00% __swap_entry_free
                     + 3.81% swap_read_folio_bdev_sync
                     + 1.49% __pte_offset_map_lock
                     + 0.92% swap_cache_get_folio
                     + 0.80% folio_add_lru
                     + 0.75% vma_alloc_folio
                     + 0.60% swap_read_folio
                  + 0.73% do_anonymous_page
              0.54% lock_vma_under_rcu

And:
sudo cat /sys/kernel/debug/lru_gen_full | grep -A 25 benchmark
memcg    72 /benchmark
 node     0
        218       3283          1x          0x
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
        219       2472       2756           0
                     0      14775r     303395e          0p          2r
         2e          0p
                     1          0r          0e          0p          0r
         0e          0p
                     2          0r          0e          0p          0r
         0e          0p
                     3          0r          0e      15262p          0r
         0e          0p
                                0           0           0           0
         0           0
        220       1652     456032          22
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
        221        808     578570          13
                     0      15665R     309071T          0           0R
         1T          0
                     1          0R          0T          0           0R
         0T          0
                     2          0R          0T          0           0R
         0T          0
                     3          0R      15364T          0           0R
         0T          0
                          9191594L    3532525O    2425411Y      94393N
     18515F      10578A

It ages fast.

It's hard to share the code with mm_walk, because in next patch, it
tries to move the pages in bulk, there is no such logic for mm_walk.

It's not very effective with this benchmark indeed, I'll update with
some other tests.

