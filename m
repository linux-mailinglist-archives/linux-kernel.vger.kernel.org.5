Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E147B65B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjJCJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbjJCJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:40:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE4C6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:40:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50481a0eee7so5017601e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696326049; x=1696930849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6GYoLfhpjKn+Ov/B91dyx3sCIeGji5aj/3JFe9K4TQ8=;
        b=MwXx3CX/2Khx0PyMJNbeEIAG4LSuDyUFvPIPs5X39OsfSs+8bsfV0XLjEZE9pH8/me
         VYyp+AWWy4PxZ0UJuuX3STY/6NzTyncn6JamIs09AieqmCDZYMTRv9E6SiaxT4JLjP21
         PWcLkKpO07qqAENxQtCTicpkqyzqpzaxJL5fTvecms+r95G1LNLs5XlhZn1SshCJP4bJ
         PYrKJD9aP3wZYAL6USlpsfDeUiz2lXbAWdg+W/i4WbJcgjx3mDf9pVSRMW0DEfKPLCTR
         ZBkI8tLgdxE5TL5nV3zfCLeHldMdJ34KOK/fWNp1qTKb7MqpHeCCanKFRiydecfDBZos
         Vxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326049; x=1696930849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GYoLfhpjKn+Ov/B91dyx3sCIeGji5aj/3JFe9K4TQ8=;
        b=ggA76Cy0QFysGri0wZNjzU7u3gZlS6URLTsF/yTS3VZWR5qJDk/BhfemKdWWHoBJAf
         WpX8N01kZ2kwMQVhk46iy79jHF/dhEoJg+/iMg3qT7JYJwv+mtwqbcg0o6OrOPtINjQc
         jPOkZlxdcCOTcp7Rpv7R34UeTmKu8/1Ih9ubAGj4DX6k7ToVfj+CL+NAD18OGLqNabvc
         dVp07KRSHabIm/YrxXfdx/Cue/iff0RTnVq3748EjZVnOXmEwVLidGBFb8OL5lSZd6Nh
         0dWd/xvuscgsYu9jbyyJGqT/cHMCDPwruu/bnDV8E8/nN+fUrCOK9sNgXQ664z94oRjs
         Jtrg==
X-Gm-Message-State: AOJu0Ywz3EY5c6v6rxMRN6z9ZkcwYAxk3OFaqGh4q7bRrwSDra5RiX+9
        ZVQfENKCu0wAM6LOwMlV4FB8EKrLj8z+bBYoMCNPCw==
X-Google-Smtp-Source: AGHT+IFVyhekx4L71P1JPgGuvXrNSgm3tOdnKfCtOCBbpMtiRW1FJxuAE6TseQq+oIs+ZMNtbFTAdDqEYrMsAKVXtYo=
X-Received: by 2002:a05:6512:3d04:b0:500:7aba:4d07 with SMTP id
 d4-20020a0565123d0400b005007aba4d07mr2044702lfv.22.1696326049577; Tue, 03 Oct
 2023 02:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230922091138.18014-1-linyunsheng@huawei.com>
 <20230922091138.18014-2-linyunsheng@huawei.com> <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
In-Reply-To: <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 3 Oct 2023 12:40:13 +0300
Message-ID: <CAC_iWjL8jjZWSMdbZ=LqWKVKLR_3ZYzrBv8RwG+AgMqZWQEyaA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo

On Tue, 3 Oct 2023 at 10:46, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2023-09-22 at 17:11 +0800, Yunsheng Lin wrote:
> > Currently page_pool_alloc_frag() is not supported in 32-bit
> > arch with 64-bit DMA because of the overlap issue between
> > pp_frag_count and dma_addr_upper in 'struct page' for those
> > arches, which seems to be quite common, see [1], which means
> > driver may need to handle it when using fragment API.
> >
> > It is assumed that the combination of the above arch with an
> > address space >16TB does not exist, as all those arches have
> > 64b equivalent, it seems logical to use the 64b version for a
> > system with a large address space. It is also assumed that dma
> > address is page aligned when we are dma mapping a page aligned
> > buffer, see [2].
> >
> > That means we're storing 12 bits of 0 at the lower end for a
> > dma address, we can reuse those bits for the above arches to
> > support 32b+12b, which is 16TB of memory.
> >
> > If we make a wrong assumption, a warning is emitted so that
> > user can report to us.
> >
> > 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
> > 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > CC: Lorenzo Bianconi <lorenzo@kernel.org>
> > CC: Alexander Duyck <alexander.duyck@gmail.com>
> > CC: Liang Chen <liangchen.linux@gmail.com>
> > CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> > CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > CC: Linux-MM <linux-mm@kvack.org>
> > ---
> >  include/linux/mm_types.h        | 13 +------------
> >  include/net/page_pool/helpers.h | 20 ++++++++++++++------
> >  net/core/page_pool.c            | 14 +++++++++-----
> >  3 files changed, 24 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 36c5b43999e6..74b49c4c7a52 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -125,18 +125,7 @@ struct page {
> >                       struct page_pool *pp;
> >                       unsigned long _pp_mapping_pad;
> >                       unsigned long dma_addr;
> > -                     union {
> > -                             /**
> > -                              * dma_addr_upper: might require a 64-bit
> > -                              * value on 32-bit architectures.
> > -                              */
> > -                             unsigned long dma_addr_upper;
> > -                             /**
> > -                              * For frag page support, not supported in
> > -                              * 32-bit architectures with 64-bit DMA.
> > -                              */
> > -                             atomic_long_t pp_frag_count;
> > -                     };
> > +                     atomic_long_t pp_frag_count;
> >               };
> >               struct {        /* Tail pages of compound page */
> >                       unsigned long compound_head;    /* Bit zero is set */
>
> As noted by Jesper, since this is touching the super-critcal struct
> page, an explicit ack from the mm people is required.
>
> @Matthew: could you please have a look?
>
> I think it would be nice also an explicit ack from Jesper and/or Ilias.

I am trying! Unfortunately, it's this time of the year when I have to
travel a lot.  I'll be back in 15 days from now and I will be able to
have a look

Thanks and sorry for the delay
/Ilias

>
> Cheers,
>
> Paolo
>
