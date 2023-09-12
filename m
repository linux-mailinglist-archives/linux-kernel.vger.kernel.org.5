Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E839279D786
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjILR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjILR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:29:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B210D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:29:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-415155b2796so22391cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694539741; x=1695144541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C68JmHetf6csZ7uaIOcZ347VMnT6195vMOibg6ebhPk=;
        b=icRgmMOZ1JamHxs7ch4TprRDtsyQ6w3whnhRDbhHRWL4kDhOtCeVotQJn1AnTIpU8g
         x/MePSsvDeWTTh7RdoI/X0LGiXEaAOlquEspn6oZnRswziZsminwZCqqKdtoNzyWpw+H
         XC1Yip8GgcQ7bBg4A1IWb8TvvkNpDOqsyDb+622qXzgCbUUOlryj6zouWh9FSzusaG0q
         P7fBOC2M0P/t+KlkJYfeHd7eJ5B7j3MSs2PvkjusxZDP+jw6w0cOgcm/AWhbGlki818G
         cWGJTb2fowKJTry25/xkvHWXU1mjPrcdTXyiv8ASHXR4zv1c3xNuxFdSvwpqzV97lMYx
         TPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539741; x=1695144541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C68JmHetf6csZ7uaIOcZ347VMnT6195vMOibg6ebhPk=;
        b=XNspg6GoLyO9TOGUwYC+T3/UmhHIU7/oUy4LpmEVXdFdB4giJNtTj9fXOVgWlCVweP
         9ikGV9YCmaingVsZp75UIsmDIRMnTX9Tt/PCcEIiOZUhnhtAcrzaIFoojXUFJN1bjlSM
         6KafcxqPpJ+5CjZV4vsqVu96sKOLQ6V2ISfeDrWOEPlLZrJPQYMN8dy2JZWNoTNF7e3K
         hF2gcBaeoTq0AXPm/eQjlpTwZTeZi4x/yVllrGpmeQUyWqXcGAKV30wBjGaEbKwlf4lF
         fuLelAeU+mLAeAFUs6mBrK3yT8gcAGBdgRXiP7tOMa7XoXbUm2zw7HAbXOUPC6ozhrUP
         udGg==
X-Gm-Message-State: AOJu0YxKicQXm5znZ6uxe4ySJ4ZWrTIFa/Q8I3bhdkUkggedMZTDuhbk
        cnkp2PaqIw2S29iuZG2riYdRItBhTEaFply+8lz3ow==
X-Google-Smtp-Source: AGHT+IFQsLvdANwfSgZAFEuZYncS5OyKbw/svHb1e7cq5kBKaXzbwRraAgtp/jHHozBU2dyWJsJiSiICFMZrXJHEVLo=
X-Received: by 2002:a05:622a:1914:b0:410:4845:8d37 with SMTP id
 w20-20020a05622a191400b0041048458d37mr253844qtc.29.1694539741427; Tue, 12 Sep
 2023 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com> <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
In-Reply-To: <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Sep 2023 19:28:50 +0200
Message-ID: <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 7:16=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 12 Sep 2023 18:04:44 +0200
>
> > On Tue, Sep 12, 2023 at 5:58=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Tue, 12 Sep 2023 06:23:24 +0200
> >>
> >>> On Mon, Sep 11, 2023 at 10:20=E2=80=AFAM Yajun Deng <yajun.deng@linux=
.dev> wrote:
> >>>>
> >>>> Although there is a kfree_skb_reason() helper function that can be u=
sed
> >>>> to find the reason for dropped packets, but most callers didn't incr=
ease
> >>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped=
.
> >>
> >> [...]
> >>
> >>>>  EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>>>
> >>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(stru=
ct net_device *dev)
> >>>> +static struct net_device_core_stats __percpu *netdev_core_stats_all=
oc(struct net_device *dev)
> >>>>  {
> >>>>         struct net_device_core_stats __percpu *p;
> >>>>
> >>>> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netd=
ev_core_stats_alloc(struct net_device
> >>>>         /* This READ_ONCE() pairs with the cmpxchg() above */
> >>>>         return READ_ONCE(dev->core_stats);
> >>>>  }
> >>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >>>> +
> >>>> +static inline struct net_device_core_stats __percpu *dev_core_stats=
(struct net_device *dev)
> >>>
> >>> Please remove this inline attritbute. Consider using __cold instead.
> >>
> >> __cold? O_o I thought the author's inlining it as it's a couple
> >> locs/intstructions, while the compilers would most likely keep it
> >> non-inlined as it's referenced 4 times. __cold will for sure keep it
> >> standalone and place it in .text.cold, i.e. far away from the call sit=
es.
> >> I realize dev_core_stats_*() aren't called frequently, but why making
> >> only one small helper cold rather than all of them then?
> >>
> >
> > This helper is used at least one time per netdevice lifetime.
> > This is definitely cold.
>
> But then each dev_stats_*_inc() (not cold) has to call it from a
> completely different piece of .text far from their. I either don't
> understand the idea or dunno. Why not make them cold as well then?
>

The __cold attribute is only applied to the helper _allocating_ the
memory, once.

Not on the functions actually incrementing the stats.

There are situations where they can be called thousands/millions of
times per second (incast flood).
If this situation happens, the _allocation_ still happens once.



> > Forcing an inline makes no sense, this would duplicate the code four ti=
mes,
> > for absolutely no gain.
>
> I'd love to see bloat-o-meter numbers, I suspect we're talking about
> 20-30 bytes.
>
> >
> >>>
> >>>> +{
> >>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> +
> >>>> +       if (likely(p))
> >>>> +               return p;
> >>>> +
> >>>> +       return netdev_core_stats_alloc(dev);
> >>>> +}
> >>
> >> [...]
> >>
> >> Thanks,
> >> Olek
>
> Thanks,
> Olek
