Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34EF8012EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjLASlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjLASlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:41:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4BD10D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:41:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a18ebac19efso365165966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701456058; x=1702060858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55+ZUEjsrc3UB5LYQhm11Jk8d+ZjC/aqtysvU5RZ+wA=;
        b=Ef3Rl8uD2Z95PGtuJBl7HqGyGzLMfC7aT4P0C1CVrW1GxULmqtJJL0ipzgJnR59yLu
         hYG67eZJnQwLUXnwkbrI2ZUY5oFjDZ1gf2htwQ5co3bmCIoQODtuIGyKba1SEyu61Tpu
         n5LeRLWhpMJvlIzpnlq6WJujQ/NKaxTfrsMu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456058; x=1702060858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55+ZUEjsrc3UB5LYQhm11Jk8d+ZjC/aqtysvU5RZ+wA=;
        b=ZKqoteVwxg20NRXjfwCv8eRwiQmMK5Z9p+oRlPq09S9L0bZgBoM88EpU251o6iQ2sv
         eNyjd532Z0sRffimYCSCAip+rxfy5D/s1SGqNuXOo4QYxgc3Ujlm8JP0SiBW14mMZ9x4
         3Q/qCq8uYIBFxRIa1+NGEABYLHfr9tIK4dyGT9l3oaEkeJ1ErYTZVNooozI8R0iDwt/a
         gqNDj6I5yDUWAkE5/GRocECC/400fj+wEHWR3D2bx5iUZDV99spzm4CGgOsHj58xNG/o
         WjnQfRmeOTsj0xwqy0ivswQq49IotdPRHoyEWFJTlXNqbDJLNbtdHFSg5UQfNnH7BUyI
         V+eQ==
X-Gm-Message-State: AOJu0YzGJzPWwjkUMRW7Qi80GjgsDhtlghEwlqTSliF+BhkaWjGHUM1W
        vjPeqofsHdffPemGB8UyIdf2oBDPet1VM2A2sLdgi1pe
X-Google-Smtp-Source: AGHT+IEkR28U+zt8ErIg0AJD8/ZX+sbKiLKXJEmJ+rE8UGraXAoLUInYhmeUu8etl8CtQWw29UhuzA==
X-Received: by 2002:a17:906:208d:b0:a18:a5b1:31a9 with SMTP id 13-20020a170906208d00b00a18a5b131a9mr2042939ejq.12.1701456058466;
        Fri, 01 Dec 2023 10:40:58 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b00a015eac52dcsm2171559eje.108.2023.12.01.10.40.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 10:40:58 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1097a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:40:57 -0800 (PST)
X-Received: by 2002:a50:bb48:0:b0:54b:bf08:a95f with SMTP id
 y66-20020a50bb48000000b0054bbf08a95fmr204880ede.6.1701456057266; Fri, 01 Dec
 2023 10:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
 <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com>
 <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com> <CANn89iLuY3dg6tpJCosGVOVR2FbT09DGXZpfb+zuW_BnPVf32g@mail.gmail.com>
In-Reply-To: <CANn89iLuY3dg6tpJCosGVOVR2FbT09DGXZpfb+zuW_BnPVf32g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Dec 2023 10:40:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XvczUqrYVzDYy=uQ7-LMcRgpJj3iiehzfJNAq=UvJXbg@mail.gmail.com>
Message-ID: <CAD=FV=XvczUqrYVzDYy=uQ7-LMcRgpJj3iiehzfJNAq=UvJXbg@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Eric Dumazet <edumazet@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 1, 2023 at 9:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> > > > > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_tabl=
e *tbl)
> > > > >  {
> > > > >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> > > > >                         READ_ONCE(tbl->gc_thresh2);
> > > > > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> > > >
> > > > It might be nice to make the above timeout based on jiffies. On a
> > > > HZ=3D100 system it's probably OK to keep preemption disabled for 10=
 ms
> > > > but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want t=
o use
> > > > jiffies_to_nsecs(1)?
> > >
> > > I do not think so. 10ms would be awfully long.
> > >
> > > We have nsec based time service, why downgrading to jiffies resolutio=
n ???
> >
> > Well, the whole issue is that we're disabling preemption, right?
> > Unless I'm mistaken, on a 1000 HZ system then a task's timeslice is
> > 1ms and on a 100 HZ system then a task's timeslice is 10ms. When we
> > disable preemption then the problem is that we can keep going past the
> > end of our timeslice. This is bad for whatever task the system is
> > trying to schedule instead of us since it will be blocked waiting for
> > us to re-enable preemption.
> >
> > So essentially the problem here is really tied to jiffies resolution,
> > right? Specifically, if jiffies is 100 Hz then it's actually
> > inefficient to timeout every 1 ms--I think it would be better to use
> > up our whole timeslice.
>
> It is not because a kernel is built with HZ=3D100 that each thread has
> to consume cpu times in 10ms slices.
>
> Process scheduler does not use jiffies at all, but high resolution time s=
ervice.
>
> Keep in mind this code is run from soft-interrupt, not a dedicated proces=
sus.

Fair enough. I guess my mental model is wrong here. Please disregard
my suggestion about using something based on how long "jiffies" is
then. Using a fixed 1 ms timeout sounds great, then.


> > > Can you tell us in which scenario this gc_list can be so big, other
> > > than fuzzers ?
> >
> > The place we hit this wasn't actually with fuzzers but with normal
> > usage in our labs. The only case where it was a really big problem was
> > when neigh_forced_gc() was scheduled on a "little" CPU (in a
> > big.LITTLE system) and that little CPU happened to be running at the
> > lowest CPU frequency. Specifically Judy was testing on sc7180-trogdor
> > and the lowest CPU Frequency of the "little" CPUs was 300 MHz. Since
> > the littles are less powerful than the bigs, this is roughly the
> > equivalent processing power of a big core running at 120 MHz.
> >
> > FWIW, we are apparently no longer seeing the bad latency after
> > <https://crrev.com/c/4914309>, which does this:
> >
> > # Increase kernel neighbor table size.
> > echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh1
> > echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh2
> > echo 8192 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
> > echo 1024 > /proc/sys/net/ipv6/neigh/default/gc_thresh1
> > echo 4096 > /proc/sys/net/ipv6/neigh/default/gc_thresh2
> > echo 8192 > /proc/sys/net/ipv6/neigh/default/gc_thresh3
> >
> > However, I still believe that we should land something like Judy's
> > patch because, no matter what kernel tunings we have, the kernel
> > shouldn't be disabling preemption for so long.
>
> Sure, and I suggested a refinement, because as I said jiffies can
> stick to a value.
>
> Not sure why a refinement given by a network maintainer is not an option =
?
>
> I must be missing something.

Your refinement was good. I was merely trying to answer the question
you asked about how we got into it as completely as possible. Sorry if
I caused confusion.
