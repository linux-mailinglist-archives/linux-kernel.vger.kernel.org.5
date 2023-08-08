Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1A77449B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjHHSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjHHSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:24:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938C222D7;
        Tue,  8 Aug 2023 10:36:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26928c430b2so2365317a91.0;
        Tue, 08 Aug 2023 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691516164; x=1692120964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K93XONmDEi8X/W9eYSAr8AD1FRn4ePqFJmaPb6kjhvc=;
        b=TJeyNxoZV4eMzr09+2+Qc8m0d2uvGSpmF8etZ24xecjXCG/3CkjUFxo6thUhhRMUmp
         BY56TxpfXeCJ3ONPeB8q1VWa4x3IGlqTyX0Xnc0UiebYhKVVCtqrgIyZzOEns3Wg1c7R
         JpSGKSZ7Qj/epN8ssc6lYkPQosdMpTYO6wMPMdhP24W+rBjPq9ZbYmOwpHE13gGY1OJ3
         6tZwc4A8uISUqXDk+6S7gvxvCHFEmREHPY19fqY27NCQYAgn4vbN6qXIz+lLNpqRMHzz
         PeVMRJfxcURU+2sM18M7QfijGpvhrqvzwkq5jiUJjQ/QEK1v1O6PRo+GWLxt7dGvA5EX
         Q3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516164; x=1692120964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K93XONmDEi8X/W9eYSAr8AD1FRn4ePqFJmaPb6kjhvc=;
        b=Lblkq7z5biWfzUmHIrNS9d1IfFBBEpHkveZj9/WPoOV2IBubWAf1v1aCChrMN+/V4L
         uaae0h7Bj51xsEa41zr0zHtrNLdPggXOolQujVICwLe9xOP3Iy+oD9hK3+CxG/IUaNGR
         kRH3x8SsO+npqAfMKPt1ESVBrdB95B+tBjkEKFZPmjjyx8ceNsiERQHTPAPA0zV0vAg2
         glezpOwFaYwmsl81HdJ15nkOMGw9C6vMU1ZRqx/cPNrtQnSagAbIG7wy/Kt6hgKq4p/q
         N9f4N8ruMlcyAKhPMWQESFMbf79AayDKQ3qpv2N/6y/J9fYq1f1gV3X5r/deg1xaj4qw
         8MLg==
X-Gm-Message-State: AOJu0Yz707iHS4IKTspsLnHgsecmzCBYS93G3BDZK6LFO+qnATNSYa6O
        XvJSRg3ZSZU/7Tb5gUmKcgJu5MiS5IAAnNK1wRA=
X-Google-Smtp-Source: AGHT+IFOXT/qmKdZXY2Lf+S+rrdfbZAjoh5vfaGE1XAD8It9lpANzelVL8FBdDRuOOXKQ8BzeJs9avflTU6jby7fhxY=
X-Received: by 2002:a17:90a:6aca:b0:268:a691:412f with SMTP id
 b10-20020a17090a6aca00b00268a691412fmr214311pjm.39.1691516164160; Tue, 08 Aug
 2023 10:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <20230804180529.2483231-6-aleksander.lobakin@intel.com> <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
 <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com> <CAKgT0Uc0pLzaOfqFbvd9jFErAbTbsUMNNw5e_XY5NfCnO0=g0g@mail.gmail.com>
 <ca096c35-6ce4-6c1d-7e26-a017348f6ece@intel.com> <CAKgT0UcZspvhYcfiKs90snAfwwb+CMn-vhA62XcSTRiV0BfOqw@mail.gmail.com>
 <8ee66e8f-cada-b492-d23f-e4e15cfef868@intel.com>
In-Reply-To: <8ee66e8f-cada-b492-d23f-e4e15cfef868@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 8 Aug 2023 10:35:27 -0700
Message-ID: <CAKgT0Ud0GFNW8cc+uxaVCEBn-A09SG-4GYNtE6zsCVpfA5HRFA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 8:06=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Tue, 8 Aug 2023 07:52:32 -0700
>
> > On Tue, Aug 8, 2023 at 6:59=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Alexander Duyck <alexander.duyck@gmail.com>
> >> Date: Tue, 8 Aug 2023 06:45:26 -0700
>
> [...]
>
> >>>>> Secondly rather than returning an error is there any reason why we
> >>>>> couldn't just look at not returning page and instead just drop into=
 the
> >>>>> release path which wouldn't take the locks in the first place? Eith=
er
> >>>>
> >>>> That is exception path to quickly catch broken drivers and fix them,=
 why
> >>>> bother? It's not something we have to live with.
> >>>
> >>> My concern is that the current "fix" consists of stalling a Tx ring.
> >>> We need to have a way to allow forward progress when somebody mixes
> >>> xdp_frame and skb traffic as I suspect we will end up with a number o=
f
> >>> devices doing this since they cannot handle recycling the pages in
> >>> hardirq context.
> >>
> >> You could've seen that several vendors already disabled recycling XDP
> >> buffers when in hardirq (=3D netpoll) in their drivers. hardirq is in
> >> general not for networking-related operations.
> >
> > The whole idea behind the netpoll cleanup is to get the Tx buffers out
> > of the way so that we can transmit even after the system has crashed.
> > The idea isn't to transmit XDP buffers, but to get the buffers out of
> > the way in the cases where somebody is combining both xdp_frame and
> > sk_buff on the same queue due to a limited number of rings being
> > present on the device.
>
> I see now, thanks a lot!
>
> >
> > My concern is that at some point in the near future somebody is going
> > to have a system crash and instead of being able to get the crash log
> > message out via their netconsole it is going to get cut off because
> > the driver stopped cleaning the Tx ring because somebody was also
> > using it as an XDP redirect destination.
> >
> >>>
> >>> The only reason why the skbs don't have the problem is that they are
> >>> queued and then cleaned up in the net_tx_action. That is why I wonder
> >>> if we shouldn't look at adding some sort of support for doing
> >>> something like that with xdp_frame as well. Something like a
> >>> dev_kfree_pp_page_any to go along with the dev_kfree_skb_any.
> >>
> >> I still don't get why we may need to clean XDP buffers in hardirq, may=
be
> >> someone could give me some links to read why we may need this and how
> >> that happens? netpoll is a very specific thing for some debug
> >> operations, isn't it? XDP shouldn't in general be enabled when this
> >> happens, should it?
> >
> > I think I kind of explained it above. It isn't so much about cleaning
> > the XDP buffers as getting them off of the ring and out of the way. If
> > we block a Tx queue because of an XDP buffer then we cannot use that
> > Tx queue. I would be good with us just deferring the cleanup like we
> > do with an sk_buff in dev_kfree_skb_irq, the only issue is we don't
> > have the ability to put them on a queue since they don't have
> > prev/next pointers.
> >
> > I suppose an alternative to cleaning them might be to make a mandatory
> > requirement that you cannot support netpoll and mix xdp_frame and
> > sk_buff on the same queue. If we enforced that then my concern about
> > them blocking a queue would be addressed.
>
> I'm leaning more towards this one TBH. I don't feel sole netpoll as
> a solid argument for introducing XDP frame deferred queues :s

That was kind of my line of thought as well. That is why I was
thinking that instead of bothering with a queue it might work just as
well to just throw all recycling out the window and just call put_page
if we are dealing with XDP in netpoll and just force it into the free
path. Then it becomes more of an "_any" type handler.
