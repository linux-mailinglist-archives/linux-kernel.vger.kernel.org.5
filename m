Return-Path: <linux-kernel+bounces-29781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C40831355
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889D5B222BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D211715;
	Thu, 18 Jan 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvJYq3oF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E76C126;
	Thu, 18 Jan 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564095; cv=none; b=Vkni9pY7FLE7aKW9y+iPSzf83lht3CbA5ZkSP1EX+fi44ahzuirnzMWNULkmnbDpUe+SjlEEx1n2r5ptZ9sp20NqdMPQGZAhlPNw4u5e6BR6DcZMU5v9zeVIGFr6RYQTtAOXVOAnFB7LqpCiFNor8r4TqhKWcxQt6c/LgotENX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564095; c=relaxed/simple;
	bh=anzxoUWinJh6Uvwqun+tJ+PvxYp65xXJI9YiyDZjzLU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=XFo/Nd89t++A9qj3X/or84Bqi1xhkaEwiC7mIJx1KNVD8ejs5UrPEEQsaKRn2Q/Uo2cjU7cEhUjn2NXhz6B2gNhAfZHM6evBnHOuoGiMxZWgpWy6wL8H/0mIwrnJgkd3lCjuoMmrAOroYliFyDl5WYhhVXg7Nw7xcIjHrlJGfBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvJYq3oF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so14684893e87.3;
        Wed, 17 Jan 2024 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705564092; x=1706168892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs/E9fGafCqJa7+DInkT1TQFPQpCHEOwL+4hDsArJ7Q=;
        b=hvJYq3oFP0V0FCuh8FilIyT3u+b4ZTe086d0eKj0rmp82vEmNjO6iXjOhhEpK5YzAh
         iUMf+nBfuTLYkvYOi6OEphWHJ9ll6TPtWVVyGM1cwUKBX/EwV10EEqTOaxEuK/jvnD+c
         kgwNzmIiWPYgy9bfLVlMEl4oRjdPC8NSXPxYeVY28YgFL740iuVtOLd8TTt6pKObey+k
         kW3rJgRa7Ml2ITj06tIesemamNtFmHDvnfnxgAfXbn/tAsGcGAU7XMjK/K3zslZJwE9m
         sVzOtgUeWFUpqNpTLKiX1oZQYMZMw5TBAwnPKYmTmQan+K0JBdG7yHApaocoSmmhnFIV
         Owmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705564092; x=1706168892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs/E9fGafCqJa7+DInkT1TQFPQpCHEOwL+4hDsArJ7Q=;
        b=rvKRnYmaMqqX+WHlMcC9M0l7lZvsWQf3pYNhEaHsgVZIPcqlpt8BtSSXz1mV9dk0uJ
         EOmgu4S/eTXd1nb3wh0uD+BhZkBOGlTOFmiu+20k77TgdczMCbUlx+XugOwRskq0sGUl
         sXdAR3SJeYiXjmQGQ89naYmKlXIISH/NQAgIemnbVWH1yqkcVYj6v3R35OBTJzmshg9x
         q7u0kY8oativ77zsCVkiKcovsxrUptQIn43SxcUDaV44jZRXnddJR9og/XuawG4fDuaY
         Nh3OcOFVac81wtCbxfjzId3UdHfuhTnIEAQPKpgzl0goAYBC/sEA1DuDQYsQam+G0D4l
         gXiA==
X-Gm-Message-State: AOJu0YwsHX5H3l0a5L5+KG1jesF/d0rEsrjP7NrlW9u7s2cPp71ludnn
	A5vecwSzDGk9lRAumkZ/5KHmUbBt5N4byu/PCfReAv+/ZKc2vOPbDgeFBH3OMEtd+bCkelC8WOn
	nt0slFjNifiIMqnO5k80WecrnCfcFiUGM6yo=
X-Google-Smtp-Source: AGHT+IF8GApEodfiyi0w2S9MhVRNV8oqvQ4GrvYEqf+aKVIn7snERqenTiJiq9Gc/IB8vsjZ9Q7dFLuticR3Zkaf5Rg=
X-Received: by 2002:ac2:4e44:0:b0:50e:f4c0:52b3 with SMTP id
 f4-20020ac24e44000000b0050ef4c052b3mr213484lfr.44.1705564091480; Wed, 17 Jan
 2024 23:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com> <00afbc29-9f25-403e-af18-08953fa79e24@kernel.dk>
In-Reply-To: <00afbc29-9f25-403e-af18-08953fa79e24@kernel.dk>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 18 Jan 2024 15:48:00 +0800
Message-ID: <CAGWkznGSreuTvYUoqhL0KaWEg-NpBazfjAcjGLJ3Oh8puzQF0g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] block: introduce activity based ioprio
To: Jens Axboe <axboe@kernel.dk>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:20=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 1/17/24 2:23 AM, zhaoyang.huang wrote:
> > [1]
> > ./fault_latency.bin 1 5 > /data/dd_costmem &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> > dd if=3D/dev/block/sda of=3D/data/ddtest bs=3D1024 count=3D2048000 &
> > dd if=3D/dev/block/sda of=3D/data/ddtest1 bs=3D1024 count=3D2048000 &
> > dd if=3D/dev/block/sda of=3D/data/ddtest2 bs=3D1024 count=3D2048000 &
> > dd if=3D/dev/block/sda of=3D/data/ddtest3 bs=3D1024 count=3D2048000
> >
> > [2]
> > mainline:
> > Summary for 5932.00(ms)
> >     All Faults:       1398   235.67 counts/sec
> >         Iowait:        553    93.22 counts/sec
> >    All latency:    7432948  1253.03 us/ms
> >         Iowait:    1321971   222.85 us/ms
> > Summary for 6706.00(ms)
> >     All Faults:       1921   286.46 counts/sec
> >         Iowait:       1273   189.83 counts/sec
> >    All latency:   25890252  3860.76 us/ms
> >         Iowait:    4468861   666.40 us/ms
> > Summary for 5838.00(ms)
> >     All Faults:       1580   270.64 counts/sec
> >         Iowait:        619   106.03 counts/sec
> >    All latency:    6862215  1175.44 us/ms
> >         Iowait:    1077616   184.59 us/ms
> > Summary for 5916.00(ms)
> >     All Faults:       1195   201.99 counts/sec
> >         Iowait:        494    83.50 counts/sec
> >    All latency:    4555134   769.97 us/ms
> >         Iowait:     902513   152.55 us/ms
> > Summary for 6229.00(ms)
> >     All Faults:       1395   223.95 counts/sec
> >         Iowait:        359    57.63 counts/sec
> >    All latency:    6091882   977.99 us/ms
> >         Iowait:    1251183   200.86 us/ms
> > Summary for 6059.00(ms)
> >     All Faults:       1201   198.22 counts/sec
> >         Iowait:        299    49.35 counts/sec
> >    All latency:    5612143   926.25 us/ms
> >         Iowait:    1155555   190.72 us/ms
> > Summary for 6005.00(ms)
> >     All Faults:        847   141.05 counts/sec
> >         Iowait:        320    53.29 counts/sec
> >    All latency:    5852541   974.61 us/ms
> >         Iowait:     433719    72.23 us/ms
> > Summary for 5895.00(ms)
> >     All Faults:       1039   176.25 counts/sec
> >         Iowait:        288    48.85 counts/sec
> >    All latency:    4184680   709.87 us/ms
> >         Iowait:     686266   116.41 us/ms
> > Summary for 6371.00(ms)
> >     All Faults:       1176   184.59 counts/sec
> >         Iowait:        269    42.22 counts/sec
> >    All latency:    6282918   986.17 us/ms
> >         Iowait:    1160952   182.22 us/ms
> > Summary for 6113.00(ms)
> >     All Faults:       1322   216.26 counts/sec
> >         Iowait:        281    45.97 counts/sec
> >    All latency:    7208880  1179.27 us/ms
> >         Iowait:    1336650   218.66 us/ms
> >
> > commit:
> > Summary for 7225.00(ms)
> >     All Faults:       1384   191.56 counts/sec
> >         Iowait:        285    39.45 counts/sec
> >    All latency:    6593081   912.54 us/ms
> >         Iowait:     934041   129.28 us/ms
> > Summary for 6567.00(ms)
> >     All Faults:       1378   209.84 counts/sec
> >         Iowait:        167    25.43 counts/sec
> >    All latency:    3761554   572.80 us/ms
> >         Iowait:     220621    33.60 us/ms
> > Summary for 6118.00(ms)
> >     All Faults:       1304   213.14 counts/sec
> >         Iowait:        268    43.81 counts/sec
> >    All latency:    3835332   626.89 us/ms
> >         Iowait:     413900    67.65 us/ms
> > Summary for 6155.00(ms)
> >     All Faults:       1177   191.23 counts/sec
> >         Iowait:        185    30.06 counts/sec
> >    All latency:    4839084   786.20 us/ms
> >         Iowait:     660002   107.23 us/ms
> > Summary for 6448.00(ms)
> >     All Faults:       1283   198.98 counts/sec
> >         Iowait:        353    54.75 counts/sec
> >    All latency:    4798334   744.16 us/ms
> >         Iowait:    1258045   195.11 us/ms
> > Summary for 6179.00(ms)
> >     All Faults:       1285   207.96 counts/sec
> >         Iowait:        137    22.17 counts/sec
> >    All latency:    3668456   593.70 us/ms
> >         Iowait:     419731    67.93 us/ms
> > Summary for 6165.00(ms)
> >     All Faults:       1500   243.31 counts/sec
> >         Iowait:        182    29.52 counts/sec
> >    All latency:    3357435   544.60 us/ms
> >         Iowait:     279828    45.39 us/ms
> > Summary for 6270.00(ms)
> >     All Faults:       1507   240.35 counts/sec
> >         Iowait:        361    57.58 counts/sec
> >    All latency:    4428320   706.27 us/ms
> >         Iowait:     741304   118.23 us/ms
> > Summary for 6597.00(ms)
> >     All Faults:       1263   191.45 counts/sec
> >         Iowait:        238    36.08 counts/sec
> >    All latency:    5115168   775.38 us/ms
> >         Iowait:     950482   144.08 us/ms
> > Summary for 6503.00(ms)
> >     All Faults:       1456   223.90 counts/sec
> >         Iowait:        402    61.82 counts/sec
> >    All latency:    6782757  1043.02 us/ms
> >         Iowait:    1483803   228.17 us/ms
>
> That's a lot of data, and I'm sure you did some analysis of this to
> conclude that the change makes a positive difference. It would be
> prudent to include such analysis, rather than just a raw dump of data.
> On top of that, you don't mention what you are testing on - what is sda?
Please find below for summary of the test result. The test case is
collecting io time of mmaped VA(from scheduler point of view) among
mix access of mmaped and vfs file data concurrently. sda is a raw disk
partition which is used for source data of command dd.
                             mainline                           commit
io cost                    1379us                             736us
>
> A few comments - regardless of whether or not this change makes
> functional sense.
The commit's basic idea is the request priority should be decided by
the pages it carry instead of(or together with) the launcher.
>
> > diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
> > index 27f11320b8d1..cd6fcfca7782 100644
> > --- a/block/Kconfig.iosched
> > +++ b/block/Kconfig.iosched
> > @@ -44,4 +44,11 @@ config BFQ_CGROUP_DEBUG
> >       Enable some debugging help. Currently it exports additional stat
> >       files in a cgroup which can be useful for debugging.
> >
> > +config ACTIVITY_BASED_IOPRIO
> > +     bool "Enable folio activity based ioprio on deadline"
> > +     depends on LRU_GEN && MQ_IOSCHED_DEADLINE
> > +     default n
> > +     help
> > +     This item enable the feature of adjust request's priority by
> > +     calculating its folio's activity.
>
> Doesn't seem like this should be a config thing. In any case, 'default
> n' is the default, so you should kill that line.
ok
>
> > @@ -224,14 +225,42 @@ static void deadline_remove_request(struct reques=
t_queue *q,
> >               q->last_merge =3D NULL;
> >  }
> >
> > +static enum dd_prio dd_req_ioprio(struct request *rq)
> > +{
> > +     enum dd_prio prio;
> > +     const u8 ioprio_class =3D dd_rq_ioclass(rq);
> > +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
> > +     struct bio *bio;
> > +     struct bio_vec bv;
> > +     struct bvec_iter iter;
> > +     struct page *page;
> > +     int gen =3D 0;
> > +     int cnt =3D 0;
> > +
> > +     if (req_op(rq) =3D=3D REQ_OP_READ) {
> > +             __rq_for_each_bio(bio, rq) {
> > +                     bio_for_each_bvec(bv, bio, iter) {
> > +                             page =3D bv.bv_page;
> > +                             gen +=3D PageWorkingset(page) ? 1 : 0;
> > +                             cnt++;
> > +                     }
> > +             }
> > +             prio =3D (gen >=3D cnt / 2) ? ioprio_class_to_prio[IOPRIO=
_CLASS_RT] :
> > +                     ioprio_class_to_prio[ioprio_class];
> > +     } else
> > +             prio =3D ioprio_class_to_prio[ioprio_class];
> > +#else
> > +     prio =3D ioprio_class_to_prio[ioprio_class];
> > +#endif
> > +     return prio;
> > +}
>
> This is pretty awful imho, you're iterating the pages which isn't
> exactly cheap. There's also a ternary operator (get rid of it), and
> magic cnt / 2 which isn't even explained.
ok. The iterating is on purpose here to not enlarge the bio and
request structure. The magic number would be replaced by an more
sensible criteria like MULTI_GEN's thrashing tier things.
>
> This would make much more sense to do when the page is added to the bio,
> rather than try and fix up the prio after the fact.
>
> >  static void dd_request_merged(struct request_queue *q, struct request =
*req,
> >                             enum elv_merge type)
> >  {
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> > -     const u8 ioprio_class =3D dd_rq_ioclass(req);
> > -     const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> > +     const enum dd_prio prio =3D dd_req_ioprio(req);
> >       struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> > -
> >       /*
> >        * if the merge was a front merge, we need to reposition request
> >        */
> > @@ -248,8 +277,7 @@ static void dd_merged_requests(struct request_queue=
 *q, struct request *req,
> >                              struct request *next)
> >  {
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> > -     const u8 ioprio_class =3D dd_rq_ioclass(next);
> > -     const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> > +     const enum dd_prio prio =3D dd_req_ioprio(next);
> >
> >       lockdep_assert_held(&dd->lock);
>
> What are these changes?
That is for code's integrity of getting the request's prio for either
this feature enabled or not.
>
> > @@ -745,10 +773,30 @@ static int dd_request_merge(struct request_queue =
*q, struct request **rq,
> >  {
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> >       const u8 ioprio_class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > -     const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> > -     struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> > +     struct dd_per_prio *per_prio;
> >       sector_t sector =3D bio_end_sector(bio);
> >       struct request *__rq;
> > +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
> > +     enum dd_prio prio;
> > +     struct bio_vec bv;
> > +     struct bvec_iter iter;
> > +     struct page *page;
> > +     int gen =3D 0;
> > +     int cnt =3D 0;
> > +
> > +     if (bio_op(bio) =3D=3D REQ_OP_READ) {
> > +             bio_for_each_bvec(bv, bio, iter) {
> > +                     page =3D bv.bv_page;
> > +                     gen +=3D PageWorkingset(page) ? 1 : 0;
> > +                     cnt++;
> > +             }
> > +     }
> > +     prio =3D (gen >=3D cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_R=
T] :
> > +                     ioprio_class_to_prio[ioprio_class];
> > +#else
> > +     const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> > +#endif
> > +     per_prio =3D &dd->per_prio[prio];
>
> And here you duplicate the entire thing from above again?
could be solved by updating the dd_req_ioprio
>
> > @@ -798,10 +846,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx=
 *hctx, struct request *rq,
> >       struct request_queue *q =3D hctx->queue;
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> >       const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> > -     u16 ioprio =3D req_get_ioprio(rq);
> > -     u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >       struct dd_per_prio *per_prio;
> > -     enum dd_prio prio;
> > +     enum dd_prio prio =3D dd_req_ioprio(rq);
> >
> >       lockdep_assert_held(&dd->lock);
> >
> > @@ -811,7 +857,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> >        */
> >       blk_req_zone_write_unlock(rq);
> >
> > -     prio =3D ioprio_class_to_prio[ioprio_class];
> >       per_prio =3D &dd->per_prio[prio];
> >       if (!rq->elv.priv[0]) {
> >               per_prio->stats.inserted++;
> > @@ -920,8 +965,7 @@ static void dd_finish_request(struct request *rq)
> >  {
> >       struct request_queue *q =3D rq->q;
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> > -     const u8 ioprio_class =3D dd_rq_ioclass(rq);
> > -     const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> > +     const enum dd_prio prio =3D dd_req_ioprio(rq);
> >       struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
>
> And again these changes?
>
> --
> Jens Axboe
>

