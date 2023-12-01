Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39278011C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjLARfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjLARfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:35:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D4C4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:35:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c69c61b58so5738a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701452148; x=1702056948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ighLnsNKlGEusYnZIjGHrM2bIKvbBxs/6auQXEZuSN0=;
        b=J34iAoKCeFITWGvXAgC6ONpElc4ZfB6N997+O5K6Rs066hxp8DScjFXq592UVGgpf2
         M07akrQANtICr3GzzecYuGrDj7Hht9nxKsbR8twwLY+tMUG6zS8KgRl8ZYTImg9AmSys
         ebW6jGrD11lPkqkASWiuAewiubTqAgBfKCTb2DqEJTAWQdFymw47irUbaN9Jc2HHG4pf
         MLBoWrjhcK51/eZDY5t8+FadPJjbehZOvxqBmNZ0ixNuPbDSd1gSa2Sd9PeEQlv9bDDk
         u5hJgjk92e0LsW+JBn30wzPZ4GAlxWmQ6UYK1XO9688n5lpjZggLv3iankB/ZYeowTjW
         5Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452148; x=1702056948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ighLnsNKlGEusYnZIjGHrM2bIKvbBxs/6auQXEZuSN0=;
        b=d9Ki/N99OiU2ryEe4SICE/hFahpuUb2cK4effO3MAivZO9IN8BmFtZUeTWF89eaBSX
         tsKFWQxC5bgkaBk9JL1oooP/FMCcXLKAIjc1kXxnlq9UgTEvov/PUXIgqz9kSfr22Zfx
         wHFaEidNjjK/c63d9njf4oKjG2SYWq5VHnuoszhrHc9Ggb12z/dEoN1Nzn2TQ4l9EAnS
         LGgwHcFPpVZ4tcxf2XVHD2TYgBjksnaGHfiMpCr4YLloAnWUz6cycXi2NHEk8vB78omX
         sOS33mK+Aa+bJg/Hi2O6U+NcYBjzObC87LlUi0Et8P+Iyc2g7Vi3iE1d9n3ccg4mlZxn
         iiGQ==
X-Gm-Message-State: AOJu0YxY/DBMtcJtC9ilWfqBw+142h2VaCwKNZMEKOnYeqGKLQGkKI7G
        qYB9w6sGWTaAQeN8oy+5aYNZOpykrTjcXm9gT+W3ZQ==
X-Google-Smtp-Source: AGHT+IGOOWqrh7Pf7APXQCtAvo3OP32OjLA+KHU1DDueB4Pq6swavliS5/BSDYQUBoSU6stfcmOY/hUFfu5ApdRtIrg=
X-Received: by 2002:a50:c31b:0:b0:54c:44c7:4d4 with SMTP id
 a27-20020a50c31b000000b0054c44c704d4mr161793edb.2.1701452148022; Fri, 01 Dec
 2023 09:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
 <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com> <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 1 Dec 2023 18:35:34 +0100
Message-ID: <CANn89iLuY3dg6tpJCosGVOVR2FbT09DGXZpfb+zuW_BnPVf32g@mail.gmail.com>
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

On Fri, Dec 1, 2023 at 6:16=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Dec 1, 2023 at 7:58=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Dec 1, 2023 at 4:16=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > > >
> > > > On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromi=
um.org> wrote:
> > > > >
> > > > > We are seeing cases where neigh_cleanup_and_release() is called b=
y
> > > > > neigh_forced_gc() many times in a row with preemption turned off.
> > > > > When running on a low powered CPU at a low CPU frequency, this ha=
s
> > > > > been measured to keep preemption off for ~10 ms. That's not great=
 on a
> > > > > system with HZ=3D1000 which expects tasks to be able to schedule =
in
> > > > > with ~1ms latency.
> > > >
> > > > This will not work in general, because this code runs with BH block=
ed.
> > > >
> > > > jiffies will stay untouched for many more ms on systems with only o=
ne CPU.
> > > >
> > > > I would rather not rely on jiffies here but ktime_get_ns() [1]
> > > >
> > > > Also if we break the loop based on time, we might be unable to purg=
e
> > > > the last elements in gc_list.
> > > > We might need to use a second list to make sure to cycle over all
> > > > elements eventually.
> > > >
> > > >
> > > > [1]
> > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6=
e75d23ef09bb4b0db53b4
> > > > 100644
> > > > --- a/net/core/neighbour.c
> > > > +++ b/net/core/neighbour.c
> > > > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table =
*tbl)
> > > >  {
> > > >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> > > >                         READ_ONCE(tbl->gc_thresh2);
> > > > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> > >
> > > It might be nice to make the above timeout based on jiffies. On a
> > > HZ=3D100 system it's probably OK to keep preemption disabled for 10 m=
s
> > > but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to =
use
> > > jiffies_to_nsecs(1)?
> >
> > I do not think so. 10ms would be awfully long.
> >
> > We have nsec based time service, why downgrading to jiffies resolution =
???
>
> Well, the whole issue is that we're disabling preemption, right?
> Unless I'm mistaken, on a 1000 HZ system then a task's timeslice is
> 1ms and on a 100 HZ system then a task's timeslice is 10ms. When we
> disable preemption then the problem is that we can keep going past the
> end of our timeslice. This is bad for whatever task the system is
> trying to schedule instead of us since it will be blocked waiting for
> us to re-enable preemption.
>
> So essentially the problem here is really tied to jiffies resolution,
> right? Specifically, if jiffies is 100 Hz then it's actually
> inefficient to timeout every 1 ms--I think it would be better to use
> up our whole timeslice.

It is not because a kernel is built with HZ=3D100 that each thread has
to consume cpu times in 10ms slices.

Process scheduler does not use jiffies at all, but high resolution time ser=
vice.

Keep in mind this code is run from soft-interrupt, not a dedicated processu=
s.

>
>
> > > One worry might be that we disabled preemption _right before_ we were
> > > supposed to be scheduled out. In that case we'll end up blocking some
> > > other task for another full timeslice, but maybe there's not a lot we
> > > can do there?
> >
> > Can you tell us in which scenario this gc_list can be so big, other
> > than fuzzers ?
>
> The place we hit this wasn't actually with fuzzers but with normal
> usage in our labs. The only case where it was a really big problem was
> when neigh_forced_gc() was scheduled on a "little" CPU (in a
> big.LITTLE system) and that little CPU happened to be running at the
> lowest CPU frequency. Specifically Judy was testing on sc7180-trogdor
> and the lowest CPU Frequency of the "little" CPUs was 300 MHz. Since
> the littles are less powerful than the bigs, this is roughly the
> equivalent processing power of a big core running at 120 MHz.
>
> FWIW, we are apparently no longer seeing the bad latency after
> <https://crrev.com/c/4914309>, which does this:
>
> # Increase kernel neighbor table size.
> echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh1
> echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh2
> echo 8192 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
> echo 1024 > /proc/sys/net/ipv6/neigh/default/gc_thresh1
> echo 4096 > /proc/sys/net/ipv6/neigh/default/gc_thresh2
> echo 8192 > /proc/sys/net/ipv6/neigh/default/gc_thresh3
>
> However, I still believe that we should land something like Judy's
> patch because, no matter what kernel tunings we have, the kernel
> shouldn't be disabling preemption for so long.

Sure, and I suggested a refinement, because as I said jiffies can
stick to a value.

Not sure why a refinement given by a network maintainer is not an option ?

I must be missing something.

>
> I will also note that, while I don't know the code at all, someone on
> our networking team commented this: High CPU usage / latency on
> neigh_cleanup_and_release is expected naturally because of our
> relatively-noisy lab environment: there are often hundreds if not
> thousands of devices + virtual devices in a single L2 network.

Well, I know this code a bit, trust me.
