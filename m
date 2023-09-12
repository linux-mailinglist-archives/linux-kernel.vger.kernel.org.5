Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63479D5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjILQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjILQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:05:01 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8F10DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:04:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-414ba610766so384071cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534696; x=1695139496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn257WYOrS3LkII67EhvUZvd333x7jt7boK8QzFVO/o=;
        b=YSXlb+UMOEQahJQ7hBKbK61jboV0SafvkV1v3dbF8pc9TBIDZfg95qk9bJCOF7j5wr
         YyNmM9EQfhoq5a+9vMzSPHZZwYhI3unI74DLChVciVKlPgUD4LGUNyfjMXt5ooYezEek
         e6Wc6cvVrrIbmM3xXfj8Ivc9F7kAFaE/kw8sgZMZT3ELDH2IjYpdP1WinUV1tOPMM5DK
         YLDyPtSU/yMU7SUblzxKZuTB39qXsqMkHR8YNfMe371/qhZDyO6567WmIHggbwKcGkX4
         TW6kWyx7Rg/skVkGLnEISyKJlRiIS/bhza7n+SmKFK/O0BQAv/Z7XlpmhHafyQOgqzpL
         HGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534696; x=1695139496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn257WYOrS3LkII67EhvUZvd333x7jt7boK8QzFVO/o=;
        b=iIJG/qwt6WN/fomNKHuTSM62sHb+NchudTwLdvo9dYh4iWXGXmzZL22a9CYDrQYRSs
         mzopMpyBpvzazj3HAtaOWtF0NNFUO2R4yNdVs/pQ+i8NxnUc/VH7VSVq9Yhr2z/PwcWb
         7J9xo28SzovKXz8xRIfUX4B635Fqq/YzOtsmeps9ijxVfL6bfkiMsKRA4bkd3BhzVfRQ
         /4iruC61w0WHojvruW/Mz/bkL2GBOXwKzZGBmPWbNCRtkmuIyrj8N3wGmcIc7LVeIE2j
         aC39xz+JdhOh0w6Z/Jz8CulEeHdrjNSsJll4O1czT/xObS66HT1/Sd39gh/L43/7YiBk
         XJZA==
X-Gm-Message-State: AOJu0YwdSqlQtUQdNp4BzLLqAsRBL9NH7GLN0XbTrYtGRtCQC5kbf+/W
        e4xuU0yf32ntd1D7yY9gtYPvFHX0zR3kptvq2Cezrg==
X-Google-Smtp-Source: AGHT+IHcfbWCNr/kJQDrdJBsB4XTrbjXEStUo5CbayM8vA21cBP82yHCbKqFW+7+AvHHz2cCHCP3nj99RjlrKXgIga4=
X-Received: by 2002:ac8:7c43:0:b0:3ef:5f97:258f with SMTP id
 o3-20020ac87c43000000b003ef5f97258fmr298273qtv.16.1694534696295; Tue, 12 Sep
 2023 09:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com> <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com>
In-Reply-To: <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Sep 2023 18:04:44 +0200
Message-ID: <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
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

On Tue, Sep 12, 2023 at 5:58=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 12 Sep 2023 06:23:24 +0200
>
> > On Mon, Sep 11, 2023 at 10:20=E2=80=AFAM Yajun Deng <yajun.deng@linux.d=
ev> wrote:
> >>
> >> Although there is a kfree_skb_reason() helper function that can be use=
d
> >> to find the reason for dropped packets, but most callers didn't increa=
se
> >> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
> [...]
>
> >>  EXPORT_SYMBOL(netdev_stats_to_stats64);
> >>
> >> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct=
 net_device *dev)
> >> +static struct net_device_core_stats __percpu *netdev_core_stats_alloc=
(struct net_device *dev)
> >>  {
> >>         struct net_device_core_stats __percpu *p;
> >>
> >> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev=
_core_stats_alloc(struct net_device
> >>         /* This READ_ONCE() pairs with the cmpxchg() above */
> >>         return READ_ONCE(dev->core_stats);
> >>  }
> >> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> >> +
> >> +static inline struct net_device_core_stats __percpu *dev_core_stats(s=
truct net_device *dev)
> >
> > Please remove this inline attritbute. Consider using __cold instead.
>
> __cold? O_o I thought the author's inlining it as it's a couple
> locs/intstructions, while the compilers would most likely keep it
> non-inlined as it's referenced 4 times. __cold will for sure keep it
> standalone and place it in .text.cold, i.e. far away from the call sites.
> I realize dev_core_stats_*() aren't called frequently, but why making
> only one small helper cold rather than all of them then?
>

This helper is used at least one time per netdevice lifetime.
This is definitely cold.
Forcing an inline makes no sense, this would duplicate the code four times,
for absolutely no gain.

> >
> >> +{
> >> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_=
alloc() */
> >> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->co=
re_stats);
> >> +
> >> +       if (likely(p))
> >> +               return p;
> >> +
> >> +       return netdev_core_stats_alloc(dev);
> >> +}
>
> [...]
>
> Thanks,
> Olek
