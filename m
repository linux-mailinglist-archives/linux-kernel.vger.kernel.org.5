Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4313C800F91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjLAP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjLAP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:58:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B810DB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:58:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c69c61b58so4236a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446315; x=1702051115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4XTRLCjQNY4AaZPgLHYq/6hjlTc5C/AJGeUvs9n7yQ=;
        b=EutDptHiUw9rM5JuCY25WabPBKiHNyPj2O8tbnWZTfTULbh5vz19L9UJegjVgsyfFk
         cnKJvb6nZkgmUV/rwAMaUGJpGZd5hX+RNq71upD92ZX8d39R15O/ERxAo+csVA1cHGWe
         h0OnMhCRHTvVMVwlq58HGZcvhgh8dXO/L845Y5SGYxAnrGLYg1wa32vEFvVYHLTDwi74
         DcqSouehddDVIVFPWQvFQpRD9HoV23wB/cSE+MA+OPlrc3s+nkEMeoP6qN9tABLvpLY8
         q+dQtyl+0cpur+BJ78wT1WjMlm2YoK1B1qdFMTR9sk7jDFwd7ZhDtm4Ji3Pgeq2EcIM+
         c4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446315; x=1702051115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4XTRLCjQNY4AaZPgLHYq/6hjlTc5C/AJGeUvs9n7yQ=;
        b=PkuBhbdD/Doqc/1HTyxJ5tQe+JIne2xPwCCaGnx71rqciXx2Ucwwn//45N+3wF3P5A
         NXJwb4BF3tD7eIBO5YmS3RnQn7eCwQggEnuuFH7ue1d9D6EzUGdhvQCq0u3CGwLj402I
         q9KI1NpAd5VNusg9LNnol1ZU67VTYoMhFBDOfBHwE6fuK7sD85yMhmkgIqNXAI4/pM37
         jDDTqKJSLFs++xMg9dbDgIS8hNJ9S4UNZI7rpYdk+9S7X8vO5GUaNY4+ylL/9vf9MavM
         qISSmQc4M40S+bCTtSjw23CxMtjAo21JY+gES/mTOqNZMEDUFccTcayK/HhrnK8JhRyY
         Y7Nw==
X-Gm-Message-State: AOJu0YyeoSV+Rnz4vNe0A8BwIUeHA30vL91bu9F5/qK7jslKhBJ+wSJW
        akK14THyBz0CEMTdeTj1wng3KrNyMa/U9N58xvMA2A==
X-Google-Smtp-Source: AGHT+IETZC5B9Y3xnn8xU2T+GKS4UY7ZOf1kGKXZS07ClteBVWmFc9YIExz8FHVfWlSRa04bkafc9UBaoXCV5Z1s4T0=
X-Received: by 2002:a50:d49c:0:b0:543:fb17:1a8 with SMTP id
 s28-20020a50d49c000000b00543fb1701a8mr83421edi.3.1701446315174; Fri, 01 Dec
 2023 07:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com> <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 1 Dec 2023 16:58:21 +0100
Message-ID: <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Doug Anderson <dianders@chromium.org>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 4:16=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.o=
rg> wrote:
> > >
> > > We are seeing cases where neigh_cleanup_and_release() is called by
> > > neigh_forced_gc() many times in a row with preemption turned off.
> > > When running on a low powered CPU at a low CPU frequency, this has
> > > been measured to keep preemption off for ~10 ms. That's not great on =
a
> > > system with HZ=3D1000 which expects tasks to be able to schedule in
> > > with ~1ms latency.
> >
> > This will not work in general, because this code runs with BH blocked.
> >
> > jiffies will stay untouched for many more ms on systems with only one C=
PU.
> >
> > I would rather not rely on jiffies here but ktime_get_ns() [1]
> >
> > Also if we break the loop based on time, we might be unable to purge
> > the last elements in gc_list.
> > We might need to use a second list to make sure to cycle over all
> > elements eventually.
> >
> >
> > [1]
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d=
23ef09bb4b0db53b4
> > 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl=
)
> >  {
> >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> >                         READ_ONCE(tbl->gc_thresh2);
> > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
>
> It might be nice to make the above timeout based on jiffies. On a
> HZ=3D100 system it's probably OK to keep preemption disabled for 10 ms
> but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to use
> jiffies_to_nsecs(1)?

I do not think so. 10ms would be awfully long.

We have nsec based time service, why downgrading to jiffies resolution ???

>
> One worry might be that we disabled preemption _right before_ we were
> supposed to be scheduled out. In that case we'll end up blocking some
> other task for another full timeslice, but maybe there's not a lot we
> can do there?

Can you tell us in which scenario this gc_list can be so big, other
than fuzzers ?
