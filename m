Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8A773E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjHHQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjHHQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:39 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831D12527;
        Tue,  8 Aug 2023 08:51:04 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bc9811558cso4837756a34.0;
        Tue, 08 Aug 2023 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509859; x=1692114659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB3IbLDDH4dHIpXftssp7QgZTWqPnFJDBjmyEtR5DK4=;
        b=duoUumTVjOyL7tQbqKRPwotvWXD9hEObA/wDR9lEWvDc9PT7DHoWcCW9bC5LB9Df+r
         VlggSUAHtrhWQsRQNw6UtfvBpQZZzj4znYfu+7r+0hjjietfNsufaw6WVgQrItTatLY8
         4pffBit6ABC2QFlCUUtZ14/uRg6ll5NBNkSuMcPxA7C4cfuDrqAnYiivguifhBlCkmm5
         GmyCNbHQ4L7xOwG5MtU4jeDlNwlsxob3DQ/gNnhZdY3c3E9ZUQB2Kx9BCl9Sg4Rn0+mF
         i2xyzZoMVSdZU3Q9fsQpBOMOWazMdiSSEjmyfEOi23ujxAIvY9iMV5NB0OKrH853pNvn
         Ncjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509859; x=1692114659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB3IbLDDH4dHIpXftssp7QgZTWqPnFJDBjmyEtR5DK4=;
        b=JxFlCIfuWcfAjXYVtE4JHhqgfsFbtixLlDcrAuM2WtJLz9DGBACs55IZjdCrEU/yfm
         pRICT2fWT1j/bGOitHGGlJmJ+klc/TDKr7zGU+Ylv1LDCgaRtknc4cDQJk3urYIP4ESI
         42PrhLkdbDdKKGYtDwCtMyW4HokQ118klqWa1dFeeoJtiwei5AF2GHg5jTVqZF9JHlG1
         D9yVSiLNLflMOPou34q5bCG5x+raY0HMdTJ9sP9IxhN5jGl0NxebJmwYxWYiXyV8DDJ8
         36kg5xojaFK4ub0UvYyi0PAXf0SxeHihB3c3czsI/4A/XZr8iGyYL5zDVO9MFbb9tUnK
         kstg==
X-Gm-Message-State: AOJu0YztFOaCs53ig7DNNfmRHqUInWlLLaOS+1rCEeNrRjogYkU3TE87
        FVX33YNhQwxnZwhOuCNURgf/4UitnrIwwg0wkI3a0HqA
X-Google-Smtp-Source: AGHT+IHYs2UczeXJuZ1GHWZCjGOfnzcKmZaaEwYQYwNVRvre0QM6ozs9r+lDjtt+Z/nAxw598+97/YKCN9PRlnTUol4=
X-Received: by 2002:a25:69c7:0:b0:d3b:3baf:2db2 with SMTP id
 e190-20020a2569c7000000b00d3b3baf2db2mr10633275ybc.51.1691506390104; Tue, 08
 Aug 2023 07:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <20230804180529.2483231-6-aleksander.lobakin@intel.com> <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
 <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com> <CAKgT0Uc0pLzaOfqFbvd9jFErAbTbsUMNNw5e_XY5NfCnO0=g0g@mail.gmail.com>
 <ca096c35-6ce4-6c1d-7e26-a017348f6ece@intel.com>
In-Reply-To: <ca096c35-6ce4-6c1d-7e26-a017348f6ece@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 8 Aug 2023 07:52:32 -0700
Message-ID: <CAKgT0UcZspvhYcfiKs90snAfwwb+CMn-vhA62XcSTRiV0BfOqw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] page_pool: add a lockdep check for
 recycling in hardirq
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:59=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Tue, 8 Aug 2023 06:45:26 -0700
>
> > On Tue, Aug 8, 2023 at 6:16=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Alexander H Duyck <alexander.duyck@gmail.com>
> >> Date: Mon, 07 Aug 2023 07:48:54 -0700
> >>
> >>> On Fri, 2023-08-04 at 20:05 +0200, Alexander Lobakin wrote:
> >>>> From: Jakub Kicinski <kuba@kernel.org>
> >>>>
> >>>> Page pool use in hardirq is prohibited, add debug checks
> >>>> to catch misuses. IIRC we previously discussed using
> >>>> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> >>>> that people will have DEBUG_NET enabled in perf testing.
> >>>> I don't think anyone enables lockdep in perf testing,
> >>>> so use lockdep to avoid pushback and arguing :)
> >>>>
> >>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> >>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>> ---
> >>>>  include/linux/lockdep.h | 7 +++++++
> >>>>  net/core/page_pool.c    | 2 ++
> >>>>  2 files changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> >>>> index 310f85903c91..dc2844b071c2 100644
> >>>> --- a/include/linux/lockdep.h
> >>>> +++ b/include/linux/lockdep.h
> >>>> @@ -625,6 +625,12 @@ do {                                           =
                         \
> >>>>      WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_contex=
t)); \
> >>>>  } while (0)
> >>>>
> >>>> +#define lockdep_assert_no_hardirq()                                =
 \
> >>>> +do {                                                               =
         \
> >>>> +    WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_contex=
t) || \
> >>>> +                                       !this_cpu_read(hardirqs_enab=
led))); \
> >>>> +} while (0)
> >>>> +
> >>>>  #define lockdep_assert_preemption_enabled()                        =
 \
> >>>>  do {                                                               =
         \
> >>>>      WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)   &&             =
 \
> >>>> @@ -659,6 +665,7 @@ do {                                            =
                         \
> >>>>  # define lockdep_assert_irqs_enabled() do { } while (0)
> >>>>  # define lockdep_assert_irqs_disabled() do { } while (0)
> >>>>  # define lockdep_assert_in_irq() do { } while (0)
> >>>> +# define lockdep_assert_no_hardirq() do { } while (0)
> >>>>
> >>>>  # define lockdep_assert_preemption_enabled() do { } while (0)
> >>>>  # define lockdep_assert_preemption_disabled() do { } while (0)
> >>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >>>> index 03ad74d25959..77cb75e63aca 100644
> >>>> --- a/net/core/page_pool.c
> >>>> +++ b/net/core/page_pool.c
> >>>> @@ -587,6 +587,8 @@ static __always_inline struct page *
> >>>>  __page_pool_put_page(struct page_pool *pool, struct page *page,
> >>>>                   unsigned int dma_sync_size, bool allow_direct)
> >>>>  {
> >>>> +    lockdep_assert_no_hardirq();
> >>>> +
> >>>>      /* This allocator is optimized for the XDP mode that uses
> >>>>       * one-frame-per-page, but have fallbacks that act like the
> >>>>       * regular page allocator APIs.
> >>>
> >>> So two points.
> >>>
> >>> First could we look at moving this inside the if statement just befor=
e
> >>> we return the page, as there isn't a risk until we get into that path
> >>> of needing a lock.
> >>>
> >>> Secondly rather than returning an error is there any reason why we
> >>> couldn't just look at not returning page and instead just drop into t=
he
> >>> release path which wouldn't take the locks in the first place? Either
> >>
> >> That is exception path to quickly catch broken drivers and fix them, w=
hy
> >> bother? It's not something we have to live with.
> >
> > My concern is that the current "fix" consists of stalling a Tx ring.
> > We need to have a way to allow forward progress when somebody mixes
> > xdp_frame and skb traffic as I suspect we will end up with a number of
> > devices doing this since they cannot handle recycling the pages in
> > hardirq context.
>
> You could've seen that several vendors already disabled recycling XDP
> buffers when in hardirq (=3D netpoll) in their drivers. hardirq is in
> general not for networking-related operations.

The whole idea behind the netpoll cleanup is to get the Tx buffers out
of the way so that we can transmit even after the system has crashed.
The idea isn't to transmit XDP buffers, but to get the buffers out of
the way in the cases where somebody is combining both xdp_frame and
sk_buff on the same queue due to a limited number of rings being
present on the device.

My concern is that at some point in the near future somebody is going
to have a system crash and instead of being able to get the crash log
message out via their netconsole it is going to get cut off because
the driver stopped cleaning the Tx ring because somebody was also
using it as an XDP redirect destination.

> >
> > The only reason why the skbs don't have the problem is that they are
> > queued and then cleaned up in the net_tx_action. That is why I wonder
> > if we shouldn't look at adding some sort of support for doing
> > something like that with xdp_frame as well. Something like a
> > dev_kfree_pp_page_any to go along with the dev_kfree_skb_any.
>
> I still don't get why we may need to clean XDP buffers in hardirq, maybe
> someone could give me some links to read why we may need this and how
> that happens? netpoll is a very specific thing for some debug
> operations, isn't it? XDP shouldn't in general be enabled when this
> happens, should it?

I think I kind of explained it above. It isn't so much about cleaning
the XDP buffers as getting them off of the ring and out of the way. If
we block a Tx queue because of an XDP buffer then we cannot use that
Tx queue. I would be good with us just deferring the cleanup like we
do with an sk_buff in dev_kfree_skb_irq, the only issue is we don't
have the ability to put them on a queue since they don't have
prev/next pointers.

I suppose an alternative to cleaning them might be to make a mandatory
requirement that you cannot support netpoll and mix xdp_frame and
sk_buff on the same queue. If we enforced that then my concern about
them blocking a queue would be addressed.

> (unrelated: 6:58 AM West Coast, you use to wake up early or traveling?
>  :D)

I am usually up pretty early, especially this time of year. Sunrise
here is 6AM and I am usually up a little before that.. :)
