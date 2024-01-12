Return-Path: <linux-kernel+bounces-24217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4982B93A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CD61F23817
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1311117;
	Fri, 12 Jan 2024 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZabsNhqF"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7831108
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so2614a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705023944; x=1705628744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEfISs9ZyPWQwCOYVIyleeKa+hLnbG7wvgHnAkt1Tcs=;
        b=ZabsNhqFOOJyBEYpSeUGL5Fv8y/f03i3CL8T9tpltuNe9A3oOu5Txv1k1CQ7JiyspF
         hY0vrq1n8DdySE8dR3GOU5tveQjGkQgGZL76KH5Pi5dGHfiULtEV+rjSPcmqYI9SdXOY
         dk2KnATQ2f1KvOA373OKbb8xWOEHPuTayAWBj/8uMjj7T/RAmeIcWB/8B95Cx4Bw+Fxf
         iV6y5BARgR+TWs6Dn5OuQslAeOBL06iIvyCZujE9qanbOYM0MjtNzK/4hF+dRTbKTydP
         yHC8dMeaH40PiJfZBMvoX0VhA0SscbmxeJz0CXOj1mIbUqGcRZ/aNtnciQlrZau9XbEr
         izNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705023944; x=1705628744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEfISs9ZyPWQwCOYVIyleeKa+hLnbG7wvgHnAkt1Tcs=;
        b=QBMygkiVijJSnHU4bha4Aig6xKPkl1GGApeHDyUrcRjbQc9xHVYEMoXRb4D2we8THX
         mCWaElmvYMeTu4x13hHtTmhdgA8/pKjFE8hzkNqjuc7+RwMjvF8/pu8IzAW5VOgU43ds
         9QFfxuqsT2z9dW2tH+Sf3JvIVGz2hGxYpMP7phEza6UfvfKj4O9W7MJriu648rOPa/KO
         uX3RKOANWz/b41BFzAQ9MPl10oCAB4ht4HO86W7mPwl47ltdfK0cn13bPQ89feEdllPU
         As5G7HXqk41jP08mksvorJup2ETkkiMXzYI4nGxUW+fuUN0lmZJee5UGzM2mQgNnx70f
         asCw==
X-Gm-Message-State: AOJu0Yx4+yb3qid90Zj4sGFQyD6YT6hnGhx5/5y/jkoXKxHbrtyqzrBB
	3kXleS16j8+kP/KsLTdmS4nIUvWd0Kob6zgtm+ioZMkcYZXw
X-Google-Smtp-Source: AGHT+IHLx9fUoHx6GHUHd75f0Eh5Bj9WLXwRPezg7yzXALYXeT4YUVTyI9zKPXGPnXtIMRn6NT5EMpFd1SyNM9ywMq8=
X-Received: by 2002:a05:6402:40d2:b0:557:15d:b784 with SMTP id
 z18-20020a05640240d200b00557015db784mr246444edb.2.1705023943390; Thu, 11 Jan
 2024 17:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
 <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
 <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
 <CAOUHufa=ybd-EPos9DryLHYyhphN0P7qyV5NY3Pui0dfVSk9tQ@mail.gmail.com>
 <ZXpx0K8Vdo3FJixg@google.com> <CAMgjq7CRf4iEKuW2qWKzbhssMbixBo3UoLPqsSk4b+Tvw8at8A@mail.gmail.com>
 <CAOUHufY6x_Erz02Bzoejfs_g2hcmrMFpiOdjiaWZ97oirz71aQ@mail.gmail.com>
 <ZXvcgyjTu92Qqk5X@google.com> <CAMgjq7BsY1tJeOZwSppxUN7Lha-_a7WLfhv1_bxTuU4EuiQyVg@mail.gmail.com>
 <CAOUHufZFkdDjCdQKBV5+W_bp_7x5VwrwkYbJeDdQ19S=m4Mc6A@mail.gmail.com>
 <CAOUHufbRq8WsGzNRn119GqL5AmeSOkZxQv3L2LTaCm=k3bzrRA@mail.gmail.com>
 <CAMgjq7C8uUOz5i8rEHNCs37fdEiAuMZsuV+Ktnz3TMX9Nf8F+g@mail.gmail.com>
 <CAOUHufamzdOL8ByV9V7KQJKnvZBMboVz-EGD=Fus7LZk1inhCw@mail.gmail.com>
 <CAOUHufaWkAvQK_fmXF5WZW4ZKQ0W4UZfjWDG+OZAxgF_J0dOuA@mail.gmail.com>
 <CAMgjq7BR4wyT5itvs58Wjar6EymdazhKvpAjSPHF-SYvrguu2Q@mail.gmail.com>
 <CAOUHufbZTJN6TRv55DVDjMp3frqpJOZP0HsQx3Y7veGCuaih8g@mail.gmail.com>
 <CAMgjq7C+zMYtoE=JVsXZitxKHoCh5MqB76OENs7a+NDgGGQ0Kw@mail.gmail.com>
 <CAOUHufbnLX60n+=OV92kXLZGY5_-f_y0ZtETV+0uTqFo5dvBCg@mail.gmail.com>
 <CAOUHufa12C7Knp78fq4C-ohGz1yrtdriW5xQD=wchinTJD8UVQ@mail.gmail.com>
 <CAMgjq7BRaRgYLf2+8=+=nWtzkrHFKmudZPRm41PR6W+A+L=AKA@mail.gmail.com>
 <CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com> <CAMgjq7CWRH0sJLCTU80c44gG9z=ff75u_S104iot0wNv_ModdQ@mail.gmail.com>
In-Reply-To: <CAMgjq7CWRH0sJLCTU80c44gG9z=ff75u_S104iot0wNv_ModdQ@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jan 2024 18:45:05 -0700
Message-ID: <CAOUHufbMnwcWd0g3rJuC+wsFr8E4DD_EUYUbj+J8iGkOw7McEQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Yu Zhao <yuzhao@google.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8811=E6=97=A5=
=E5=91=A8=E5=9B=9B 15:02=E5=86=99=E9=81=93=EF=BC=9A
> > Could you try the attached patch on the mainline v6.7 and see how it
> > compares with the results above? Thanks.
>
> Hi Yu,
>
> Thanks for the patch, it helped in some degrees, but not as effective:
> On that exclusive baremetal, I did a resetup, rebase on 6.7 mainline
> and reran the test:
>
> Refault distance series:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 901 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     4224            27030724835.9   0.16 txn/s
> ------------------------------------------------------------------
>   TOTAL           4224            27030724835.9   0.16 txn/s
>
> workingset_nodes 111349
> workingset_refault_anon 261331
> workingset_refault_file 42862224
> workingset_activate_anon 0
> workingset_activate_file 13803763
> workingset_restore_anon 250743
> workingset_restore_file 599031
> workingset_nodereclaim 23708
>
> memcg    67 /machine.slice/libpod-edbf5a3cb2574c60180c1fb5ddb2fb160df00bc=
ee3758b7649f2b31baa97ed78.scope/container
>  node     0
>          10     347163     518379      207449
>                      0          0r          2e          0p      33017r
>    1726749e          0p
>                      1          0r          0e          0p       7278r
>     496268e          0p
>                      2          0r          0e          0p      19789r
>      55418e          0p
>                      3          0r          0e          0p          0r
>          0e    4747801p
>                                 0           0           0           0
>          0           0
>          11     283279     154400     4791558
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          12     158723     431513       37647
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          13      44775     104986       27258
>                      0        576R        982T          0     2488768R
>    5769505T          0
>                      1          0R          0T          0     2335910R
>    3357277T          0
>                      2          0R          0T          0      647398R
>     753021T          0
>                      3          0R         20T          0       52725R
>    4740516T          0
>                           2819476L      31196O    2551928Y       8298N
>       5549F       5329A
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
> kB_read    kB_wrtn    kB_dscd
> dm-0             12.81       546.32        39.04         0.00
> 520178      37171          0
> dm-1              0.05         1.10         0.00         0.00
> 1044          0          0
> nvme0n1          13.17       561.99        41.19         0.00
> 535103      39219          0
> nvme1n1        5220.39    227385.96      1028.17         0.00
> 216505545     978976          0
> zram0          2440.61      2856.32      6907.13         0.00
> 2719644    6576628          0
>
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:           31830       11251         332           0       20246     =
  20144
> Swap:          31829        3761       28068
>
> Your attachment:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 905 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     4070            27170023578.4   0.15 txn/s
> ------------------------------------------------------------------
>   TOTAL           4070            27170023578.4   0.15 txn/s
>
> workingset_nodes 121864
> workingset_refault_anon 430917
> workingset_refault_file 42915675
> workingset_activate_anon 100194
> workingset_activate_file 21619480
> workingset_restore_anon 100194
> workingset_restore_file 165054
> workingset_nodereclaim 26851
>
> memcg    65 /machine.slice/libpod-c6d8c5fedb9b390ec7f1db7d0d7c57d6a284a94=
e74a3923d93ea0ce4e4ffdf28.scope/container
>  node     0
>           8     418689      55033      106862
>                      0         16r         17e          0p    2789768r
>    6034831e          0p
>                      1          0r          0e          0p     239664r
>     490278e          0p
>                      2          0r          0e          0p      79145r
>     126408e          0p
>                      3         23r         23e          0p      23404r
>      27107e    4736933p
>                                 0           0           0           0
>          0           0
>           9     322798     237713     4759110
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          10     182729     942701        5348
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>          11     120287        560         375
>                      0      25187R      29324T          0     1679308R
>    4256147T          0
>                      1          0R          0T          0      153592R
>     364122T          0
>                      2          0R          0T          0       51825R
>      98646T          0
>                      3        101R       2944T          0       13985R
>    4743515T          0
>                           7702245L     865749O    6514831Y      16843N
>      15088F      14167A
>
> Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
> kB_read    kB_wrtn    kB_dscd
> dm-0             11.49       489.97        41.80         0.00
> 488006      41633          0
> dm-1              0.05         1.05         0.00         0.00
> 1044          0          0
> nvme0n1          11.83       504.95        43.86         0.00
> 502932      43682          0
> nvme0n1        5145.44    218803.29       984.46         0.00
> 217928081     980520          0
> zram0          3164.11      4399.55      8257.84         0.00
> 4381952    8224812          0
>
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:           31830       11583         310           1       19935     =
  19809
> Swap:          31829        3710       28119
>
> Refault distance series still have a better performance and lower total I=
O.
>
> Similar result on that VM:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Execution Results after 907 seconds
> ------------------------------------------------------------------
>                   Executed        Time (=C2=B5s)       Rate
>   STOCK_LEVEL     1667            27151581934.5   0.06 txn/s
> ------------------------------------------------------------------
>   TOTAL           1667            27151581934.5   0.06 txn/s
>
> While refault distance series had about ~2500 - 2600 txns, mainline
> 6.7 had about ~800 - 900 txns.
>
> Loop test so far:
> Using refault distance seriese (previous result, it doesn't change much a=
nyway):
>   STOCK_LEVEL     2605            27120667462.8   0.10 txn/s
>   STOCK_LEVEL     3000            27106854857.2   0.11 txn/s
>   STOCK_LEVEL     2925            27066601064.4   0.11 txn/s
>   STOCK_LEVEL     2757            27035248005.2   0.10 txn/s
>   STOCK_LEVEL     1325            28053716046.8   0.05 txn/s
>   STOCK_LEVEL     717             27455091366.3   0.03 txn/s
>   STOCK_LEVEL     967             27404085208.2   0.04 txn/s
> Refault stat here:
> workingset_refault_anon 109337
> workingset_refault_file 191249716
>
> Using the attached patch:
> STOCK_LEVEL     1667            27151581934.5   0.06 txn/s
> STOCK_LEVEL     2999            27085125092.3   0.11 txn/s
> STOCK_LEVEL     2874            27120635371.2   0.11 txn/s
> STOCK_LEVEL     2658            27139142413.9   0.10 txn/s
> STOCK_LEVEL     1254            27526009063.7   0.05 txn/s
> STOCK_LEVEL     993             28065506801.8   0.04 txn/s
> STOCK_LEVEL     954             27226012906.3   0.04 txn/s
> Refault stat here:
> workingset_refault_anon 383579
> workingset_refault_file 205493832
>
> The peak performance almost equal, but still starts slow, refault is
> higher too. File refault might be interfered due to some IO layer
> issue, but anon refault is always accurate.
>
> I see the improvement you did in the attachment patch, I think
> actually they are not in conflict with the refault distance series.
> Maybe they can be combined into a even better result.
>
> Refault distance (which originally used by active/inactive LRU) is
> used here to give evicted pages priorities based on eviction distance
> and add extra feedback to PID and gen. While the PID info recorded in
> page flags/shadow represents pages's access pattern before eviction,
> and all the check and logics about it can also be improved.
>
> One critical effect of the refault distance series that boost the
> MongoDB startup (and I haven't see any negative effect of it on other
> test / workload / benchmark yet, except the overhead of memcg
> statistics itself) is it prevents overprotecting of tier 0 page: that
> is, a tier 0 page evicted but refaulted very quickly (refault distance
> < LRU / MAX_NR_GEN, this value may worth some more adjustment, but
> with LRU / MAX_NR_GEN, it can be imaged as an idea that having a small
> shadow gen holding these page shadows...) will be categorised as tier
> 1 and get protect. Other wise, if I got everything right, when most
> pages are stuck in tier 0 and keep refaulting, tier 0 will have a very
> high refault rate, and no pages will be protect, until randomness
> causes quick repeated read of some page, so they get promoted to tier
> 3 get get protected.
>
> Now min_seq contains lower tier pages and new pages will be added to
> min_seq too, so min_seq will stay for a long time, while min_seq + 1
> holds protected full ref tier 3 pages and they stay long enough to get
> promoted as tier 3 again, so they will always be kept in memory.
> Now MongoDB will perform well even without refault distance series,
> but this period may take a long time (~15 min for the MongoDB test for
> SATA SSD, which is based on a real workload), long enough to cause
> real issue.
>
> And this also means PID won't react to workload change fast enough.
>
> Also the anon refault's refs value is adjusted by refault distance too
> in the series, it tries to split the whole LRU as at least two gens
> for refaulted pages (only page with refault distance < LRU /
> MIN_NR_GEN will have full refs set, else will have refs - 1 set as
> penalty for long time evicted and unused page, which complies with
> LRU's nature). Which seems actually decreased refault of anon pages.
>
> There are some other issue that refault distance series is trying to
> solve too, eg. if there is a user agent force MGLRU to age
> periodically for proactive memory reclaim, or MGLRU simply ages fast,
> min_seq will grow periodically and PID won't catch enough feedback
> using previous logic.

Thanks. So far I've been making shots in the dark since I haven't been
able to reproduce your results on bare metal or VMs. So, either the
benchmark itself is not reliable, which according to your results is
unlikely, or I've been using different hardware configurations. Do you
think you can share some off-the-shelf hardware configuration that I
can buy and use to reliably reproduce your results? Ideally we use the
exactly same model from, for example, Dell, HP or Lenovo.

