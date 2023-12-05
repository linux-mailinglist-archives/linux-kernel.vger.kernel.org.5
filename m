Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCF804B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjLEIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjLEIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:00:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9283
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:00:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso5745a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701763247; x=1702368047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBrtDZnHhmERsGfSGwxcZ4uuPk1wFk1eYV41lFIXMNo=;
        b=Uy9b9I83ywXItaYKX4J8cmHn+kuK5+SNHwscNxVyO1VKJTW7giMNGd3vNOYC2aez2B
         aSN6FTzpjzAxllhXssG3AOM/uGgrbc0aKyjc/IybLJZBlkc8ITfGrmtYjh8pv9opCc0j
         Ccr5RmSTzHewUbpATt3LewszcSnzbhkB/sOZEADyiz0mbfe7V1uJiJOa9maOmUPNfUBT
         d3x94cBC4POIiW/dN2f1jxnNnn7sWG93LLnTP1I0FGVtZWBB++YZWGBxaNvFEFus8QxE
         0V7UepPuU/Zt8EsmeXw0BQhbtY5jxDCOnxjxtaIZXcPgOcWDEVKW8eIppECdK3iCFQRM
         rp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763247; x=1702368047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBrtDZnHhmERsGfSGwxcZ4uuPk1wFk1eYV41lFIXMNo=;
        b=rIwXMqp1iJw77IH0A2SsWNAUlvKxbx4BARdJtIct6OAsEiWNUuQ6VqYih8zKReflk/
         pbBqIWPd1zD4gdq5flqcputdPNZJm8gzdPhmiPL7AQ4YdMZy1HWeWNMGkGJRyrkIM64n
         nCzp7lUi0CZ5/4rpof/nbfP8PIZhH8y5B4UYNuN+O+bzQVveu2PG/PZ0axiZ/Fd5h/Zc
         4aQeS9/fTxk9Xm9vTG3GypUHBl1jU7WSNl37zyf6Dk1wEWEsNXw79fFxPlux4Iaq1Mss
         S0CANXs6bPTN/d8XWHRDhrzRxMtM7H3zYyX7UVk9xS21LorwfKd5OL4oRv7lYknBhsi1
         27eQ==
X-Gm-Message-State: AOJu0YwhZZs8PUJZoKqWJlSE79bHwFesDCd1c18ku8O0Wlr5p0a2+ONn
        I2NHPXhFUlM1t9sAuvwIJuIewtFOVJrzACgOaGLHOo5jlT5whRU5y5Q=
X-Google-Smtp-Source: AGHT+IGTWSkWHGqACURo+daOEICeNg8WH3yLmgljr7qcEj6yyd16dvZBo2U9uvM+yLinzNfTeR+BFyDr83i5Y3LqzVs=
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr406156edb.0.1701763246503; Tue, 05 Dec
 2023 00:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com> <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 5 Dec 2023 09:00:33 +0100
Message-ID: <CANn89iLuxfSZs+HV6-3=2FJL_KHg3=7WLZ109VXqsXO2-k+KvQ@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 12:40=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
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
> >         unsigned long tref =3D jiffies - 5 * HZ;
> >         struct neighbour *n, *tmp;
> >         int shrunk =3D 0;
> > +       int loop =3D 0;
> >
> >         NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> >
> > @@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tb=
l)
> >                         if (shrunk >=3D max_clean)
> >                                 break;
> >                 }
> > +               if (++loop =3D=3D 16) {
> > +                       if (ktime_get_ns() > tmax)
> > +                               goto unlock;
> > +                       loop =3D 0;
> > +               }
> >         }
> >
> >         WRITE_ONCE(tbl->last_flush, jiffies);
> >
> > +unlock:
> >         write_unlock_bh(&tbl->lock);
>
> I'm curious what the plan here is. Your patch looks OK to me and I
> could give it a weak Reviewed-by, but I don't know the code well
> enough to know if we also need to address your second comment that we
> need to "use a second list to make sure to cycle over all elements
> eventually". Is that something you'd expect to get resolved before
> landing?

Please Judy send a V2 of the patch.

I gave feedback, my intention was not to author the patch.

This is standard procedure, I now realize this was Judy first
contribution, sorry for not making this clear.

I will simply add a "Reviewed-by: ..." tag when I agree with the result.
