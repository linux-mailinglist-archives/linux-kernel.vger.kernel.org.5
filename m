Return-Path: <linux-kernel+bounces-10930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E430A81DED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EC71F2140B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718115C8;
	Mon, 25 Dec 2023 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIPijpeH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C1139F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d3b2c8517so128985e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 23:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703489332; x=1704094132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajjp7l7jDf3axBjq+hs31OFx0lpw7BRNQglDbs1yasM=;
        b=QIPijpeHDEnrU3PhyjyrYFqrpDqBygFLSMzV3cQZo5CMcyLf7o3yDz8lMOIAjNMzKN
         FSxE1buH2osyza4Dk0/9LN7OkPr4S4QYmxC7/kakO20w9bv7C+d/to2qljX3AVpFYGM/
         Iik2l+lX8gHR66Jtl11biqucsGle+bu6yU0U+xss079eB+GF1bHH1lwrwiCaK0KYBiX9
         emtXh+xY3S0tzs2kXJBDOnaOOwYLksLSJg/hjXx/BXsQjgNnbbJQv88U9I+eKMeCg6bc
         rIIW0YQFQGn2AxLhkGV+Eslu4jE9kLcNwY1SoH8cuDfTnBy+NxEYR7oy7BEqeD8Mmt5/
         jSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703489332; x=1704094132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajjp7l7jDf3axBjq+hs31OFx0lpw7BRNQglDbs1yasM=;
        b=eBzKxrrzbSqx7gkrFe2iclJu5kBBbZO3tUK2WccsVJcRP4mV2WOA/5QG5DnVVF2LTy
         qvFxfwbhb76R/JaIdTboljUiv/4RPEoPjT/Y991bKL6B546XpyKia4b/W940Arbx4ejV
         /yzKscM5tLV/8Xo8O0Na8OTd7v7uLF6F1VShY3Mj9yLHDXWLLEqPqkRX9fBKl4lWh0NZ
         T6seHfYquHOXhAq8haj0LUpHmWynznR0mrlMJHvi5slt5uhlHCsiuncg6eGq1CMTBZm3
         iJD3fTTojIkgMsHOx7s65rvgV/dycgN7RjxNJXIoHVPd0UvIakH/3DKpy8VSx78EB88g
         6P1w==
X-Gm-Message-State: AOJu0Yyefj5/2EM0xwHxu6RUB/ldiqYoOQAGnw6oaIUXBhOwjpvbXxxc
	nC5Xe2Z1tbIUZO7fPG55Q8i1+d/UQLMvzqsrUrGVk7O+iU+L
X-Google-Smtp-Source: AGHT+IF1dnp4CPwUhRLefYQ1twjaGlaGeltP36VFyAHwaOCrUXuV5npLxVWr2JaZUFYqVDywk1e7/EmT/XeeZCf7mfs=
X-Received: by 2002:a05:600c:744:b0:40d:2361:d0a2 with SMTP id
 j4-20020a05600c074400b0040d2361d0a2mr368118wmn.4.1703489332436; Sun, 24 Dec
 2023 23:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-2-ryncsn@gmail.com>
In-Reply-To: <20231222102255.56993-2-ryncsn@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 25 Dec 2023 00:28:14 -0700
Message-ID: <CAOUHufYtSQnrVBC6OEXpT=LJW=L4J1Uw1yXpPrzaUhPWauo_3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, lru_gen: batch update counters on againg
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> When lru_gen is aging, it will update mm counters page by page,
> which causes a higher overhead if age happens frequently or there
> are a lot of pages in one generation getting moved.
> Optimize this by doing the counter update in batch.
>
> Although most __mod_*_state has its own caches the overhead
> is still observable.
>
> Tested in a 4G memcg on a EPYC 7K62 with:
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
>     -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys \
>     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
>     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
>
> Average result of 18 test runs:
>
> Before: 44017.78 Ops/sec
> After:  44687.08 Ops/sec (+1.5%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 9 deletions(-)

Usually most reclaim activity happens in kswapd, e.g., from the
MongoDB benchmark (--duration=3D900):
pgscan_kswapd 11294317
pgscan_direct 128
And kswapd always has current->reclaim_state->mm_walk. So the
following should bring the vast majority of the improvement (assuming
it's not noise) with far less code change:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9dd8977de5a2..c06e00635d2b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3095,6 +3095,8 @@ static int folio_update_gen(struct folio *folio, int =
gen)
 static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio,
bool reclaiming)
 {
        int type =3D folio_is_file_lru(folio);
+       struct lru_gen_mm_walk *walk =3D current->reclaim_state->mm_walk;
+
        struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
        int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
        unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
@@ -3116,7 +3118,10 @@ static int folio_inc_gen(struct lruvec *lruvec,
struct folio *folio, bool reclai
                        new_flags |=3D BIT(PG_reclaim);
        } while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));

-       lru_gen_update_size(lruvec, folio, old_gen, new_gen);
+       if (walk)
+               update_batch_size(walk, folio, old_gen, new_gen);
+       else
+               lru_gen_update_size(lruvec, folio, old_gen, new_gen);

        return new_gen;
 }
@@ -3739,6 +3744,8 @@ static void inc_max_seq(struct lruvec *lruvec,
bool can_swap, bool force_scan)
        int prev, next;
        int type, zone;
        struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
+       struct lru_gen_mm_walk *walk =3D current->reclaim_state->mm_walk;
+
 restart:
        spin_lock_irq(&lruvec->lru_lock);

@@ -3758,6 +3765,9 @@ static void inc_max_seq(struct lruvec *lruvec,
bool can_swap, bool force_scan)
                goto restart;
        }

+       if (walk && walk->batched)
+               reset_batch_size(lruvec, walk);
+
        /*
         * Update the active/inactive LRU sizes for compatibility. Both sid=
es of
         * the current max_seq need to be covered, since max_seq+1 can over=
lap

