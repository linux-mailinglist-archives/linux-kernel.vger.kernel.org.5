Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7788F7B222C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjI1QX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1QX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:23:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C5EB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:23:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so17294a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695918202; x=1696523002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoK7DrnkbZoEIlYmoBBEvLuBCh+s4Y05tdAexrGncuU=;
        b=oP8tWTNcPnRfRpkBzt1652ESSkvNJRz+wQdzgf34Dck6WUPoqMN+FAg3xAYmuHZgGv
         +8zy0V0TQiOp8kLzfk2+MGMIjnYUeDfm5ag9MSrG2in6ye+org/O/oUMolb9at2wZK/w
         /A2J4skXgpYpCiDdQbJEj5+bXpsQp3C69RdnE/2F5+o44iA+en1EYO26X5tdTYASCveD
         yJ3gs8P55VtHylKARuKbG/nWosuxnnx8BmNLjnwI4HLv2pwYjkDabWaERGiQCfpWbR/p
         ueZxvT4+N3ZXIeNVyWaUcOdyi+c95JgwPzmJfxhJd6JRXSyV1iYoRQrHXcap5rU+g4p2
         iyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918202; x=1696523002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoK7DrnkbZoEIlYmoBBEvLuBCh+s4Y05tdAexrGncuU=;
        b=wqiO+bqpsJ1h4+cz5ulLUmRI9J6JpNC3R3qP/qrfUPVpdZpjv+hO/pkYzc/c2E597Q
         X8SvMwxDctN1FBxYmPeOOFrYoPF2/8yDVcCma4jrHRl8iuraXz+L1wxjOMZEo9Um5ARe
         k7HQikedX6pwmT1g4gdqNN4ci37a9qc2/nGa0Z3kKkTXQhcrMLibV7ZI1mUpURRc4Hf5
         i/zaqxqVU/GKqAD/UwcQ4acUbMApETkAUCzovkOSiTFARUufh1w1o8KJbXNpezW4D+YG
         6p7V0yxOVJgmOQmkJFTWTh3dkuFD2yVV/qKifMYFlmir6B41NHRMhVjfz+IXYNBdNtzL
         jzfg==
X-Gm-Message-State: AOJu0YzpTbKJJ9LZPYcZl4JjlTpPmdjbi1q1oF4RxGmPWilHl4boFfPQ
        noUk6M/gUWkLOpy8kHAJTmRuY0OQvOhh2w5h4Is3cw==
X-Google-Smtp-Source: AGHT+IEumrZROsYRljFMvmWsDaEhoXqgx+m159N959ENHjD39+fOqU50QyiAKiyxyjglBFOuLthC1CdYkxePel+rzzs=
X-Received: by 2002:a50:aa93:0:b0:52e:f99a:b5f8 with SMTP id
 q19-20020a50aa93000000b0052ef99ab5f8mr418659edc.7.1695918202280; Thu, 28 Sep
 2023 09:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230928100418.521594-1-yajun.deng@linux.dev> <CANn89iL9uy58ZrZRPEtrvQ7ckv5hVTq8shx3OesQA6SWoUOP=g@mail.gmail.com>
 <c43a3dde-fa4d-4a87-6f96-397813db5bd6@linux.dev> <CANn89i+iT11qzCidTrHHRMQiYR-nXtbPNAUJGaEg0NQMCq_8CA@mail.gmail.com>
 <5d8e302c-a28d-d4f4-eb91-4b54eb89490b@linux.dev>
In-Reply-To: <5d8e302c-a28d-d4f4-eb91-4b54eb89490b@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 28 Sep 2023 18:23:11 +0200
Message-ID: <CANn89i+XQ_LKvr5LHd2QUgTMfZh9Nd1yQTYfRORHUt2_BCkxcg@mail.gmail.com>
Subject: Re: [PATCH v6] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 6:16=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/9/28 23:44, Eric Dumazet wrote:
> > On Thu, Sep 28, 2023 at 5:40=E2=80=AFPM Yajun Deng <yajun.deng@linux.de=
v> wrote:
> >>
> >> On 2023/9/28 22:18, Eric Dumazet wrote:
> >>> On Thu, Sep 28, 2023 at 12:04=E2=80=AFPM Yajun Deng <yajun.deng@linux=
.dev> wrote:
> >>>> Although there is a kfree_skb_reason() helper function that can be u=
sed to
> >>>> find the reason why this skb is dropped, but most callers didn't inc=
rease
> >>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped=
.
> >>>>
> >>>> For the users, people are more concerned about why the dropped in ip
> >>>> is increasing.
> >>>>
> >>>> Introduce netdev_core_stats_inc() for trace the caller of the droppe=
d
> >>>> skb. Also, add __code to netdev_core_stats_alloc(), as it's called
> >>>> unlinkly.
> >>>>
> >>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >>>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>> ---
> >>>> v6: merge netdev_core_stats and netdev_core_stats_inc together
> >>>> v5: Access the per cpu pointer before reach the relevant offset.
> >>>> v4: Introduce netdev_core_stats_inc() instead of export dev_core_sta=
ts_*_inc()
> >>>> v3: __cold should be added to the netdev_core_stats_alloc().
> >>>> v2: use __cold instead of inline in dev_core_stats().
> >>>> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.de=
ng@linux.dev/
> >>>> ---
> >>>>    include/linux/netdevice.h | 21 ++++-----------------
> >>>>    net/core/dev.c            | 17 +++++++++++++++--
> >>>>    2 files changed, 19 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>>> index 7e520c14eb8c..eb1fa04fbccc 100644
> >>>> --- a/include/linux/netdevice.h
> >>>> +++ b/include/linux/netdevice.h
> >>>> @@ -4002,32 +4002,19 @@ static __always_inline bool __is_skb_forward=
able(const struct net_device *dev,
> >>>>           return false;
> >>>>    }
> >>>>
> >>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(stru=
ct net_device *dev);
> >>>> -
> >>>> -static inline struct net_device_core_stats __percpu *dev_core_stats=
(struct net_device *dev)
> >>>> -{
> >>>> -       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> -       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> -
> >>>> -       if (likely(p))
> >>>> -               return p;
> >>>> -
> >>>> -       return netdev_core_stats_alloc(dev);
> >>>> -}
> >>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
> >>>>
> >>>>    #define DEV_CORE_STATS_INC(FIELD)                                =
              \
> >>>>    static inline void dev_core_stats_##FIELD##_inc(struct net_device=
 *dev)                \
> >>>>    {                                                                =
              \
> >>>> -       struct net_device_core_stats __percpu *p;                   =
            \
> >>>> -                                                                   =
            \
> >>>> -       p =3D dev_core_stats(dev);                                  =
              \
> >>>> -       if (p)                                                      =
            \
> >>>> -               this_cpu_inc(p->FIELD);                             =
            \
> >>> Note that we were using this_cpu_inc() which implied :
> >>> - IRQ safety, and
> >>> - a barrier paired with :
> >>>
> >>> net/core/dev.c:10548:                   storage->rx_dropped +=3D
> >>> READ_ONCE(core_stats->rx_dropped);
> >>> net/core/dev.c:10549:                   storage->tx_dropped +=3D
> >>> READ_ONCE(core_stats->tx_dropped);
> >>> net/core/dev.c:10550:                   storage->rx_nohandler +=3D
> >>> READ_ONCE(core_stats->rx_nohandler);
> >>> net/core/dev.c:10551:                   storage->rx_otherhost_dropped
> >>> +=3D READ_ONCE(core_stats->rx_otherhost_dropped);
> >>>
> >>>
> >>>> +       netdev_core_stats_inc(dev,                                  =
            \
> >>>> +                       offsetof(struct net_device_core_stats, FIELD=
));         \
> >>>>    }
> >>>>    DEV_CORE_STATS_INC(rx_dropped)
> >>>>    DEV_CORE_STATS_INC(tx_dropped)
> >>>>    DEV_CORE_STATS_INC(rx_nohandler)
> >>>>    DEV_CORE_STATS_INC(rx_otherhost_dropped)
> >>>> +#undef DEV_CORE_STATS_INC
> >>>>
> >>>>    static __always_inline int ____dev_forward_skb(struct net_device =
*dev,
> >>>>                                                  struct sk_buff *skb=
,
> >>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>> index 606a366cc209..88a32c392c1d 100644
> >>>> --- a/net/core/dev.c
> >>>> +++ b/net/core/dev.c
> >>>> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_lin=
k_stats64 *stats64,
> >>>>    }
> >>>>    EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>>>
> >>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(stru=
ct net_device *dev)
> >>>> +static __cold struct net_device_core_stats __percpu *netdev_core_st=
ats_alloc(
> >>>> +               struct net_device *dev)
> >>>>    {
> >>>>           struct net_device_core_stats __percpu *p;
> >>>>
> >>>> @@ -10510,7 +10511,19 @@ struct net_device_core_stats __percpu *netd=
ev_core_stats_alloc(struct net_device
> >>>>           /* This READ_ONCE() pairs with the cmpxchg() above */
> >>>>           return READ_ONCE(dev->core_stats);
> >>>>    }
> >>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >>>> +
> >>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >>>> +{
> >>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> +
> >>>> +       if (unlikely(!p))
> >>>> +               p =3D netdev_core_stats_alloc(dev);
> >>>> +
> >>>> +       if (p)
> >>>> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset=
))++;
> >>> While here you are using a ++ operation that :
> >>>
> >>> - is not irq safe
> >>> - might cause store-tearing.
> >>>
> >>> I would suggest a preliminary patch converting the "unsigned long" fi=
elds in
> >>> struct net_device_core_stats to local_t
> >> Do you mean it needs to revert the commit 6510ea973d8d ("net: Use
> >> this_cpu_inc() to increment
> >>
> >> net->core_stats") first? But it would allocate memory which breaks on
> >> PREEMPT_RT.
> > I think I provided an (untested) alternative.
> >
> > unsigned long __percpu *field =3D (__force unsigned long __percpu *)
> > ((__force u8 *)p + offset);
> > this_cpu_inc(field);
>
> unsigned long __percpu *field =3D (__force unsigned long __percpu *)
> ((__force u8 *)p + offset);
> this_cpu_inc(*(int *)field);
>
> This would compiler success. But I didn't test it.
> This cold look complex.

Why exactly ? Not very different from the cast you already had.

> Shoud I base v3? Export dev_core_stats_*_inc() intead of introduce netdev=
_core_stats_inc().
> That would be easy.

Well, you tell me, but this does not look incremental to me.

I do not think we need 4 different (and maybe more to come if struct
net_device_core_stats
grows in the future) functions for some hardly used path.
