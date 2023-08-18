Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB717805D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358031AbjHRGNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjHRGMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:12:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3773592
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:12:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so752231e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692339166; x=1692943966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k17LecZQkR5FnBBqAVVrYfSgelENhBd5qnGq5/zqZhc=;
        b=GuMZInSvMka9jx6sMPATR4W1DcsQNyxZbi7o2o53SHgKLk0d3qbgNyH3OebQDdy622
         GREmSk8CtUc9IzIXVjbw9OIn83xFU4g3AAEDd7bK3Rkgy2B+iE9l9B3Ak2E9d06F+TnZ
         uYJzmZSrtc9m8DJqOI+XRp5KbBU/ZV5g+wT7kyoXPsvdeX70iswcdim7kbquzj3mL6ce
         U2ysQ+T/QCx6DcjERJRxT3LZXTARLYM0Fa3eCGSk+lOU/G+ugY/L3TAakb69FYwdbb7n
         YZOEi0xn2i5owpPkLx38Y1Vtdsc9RHQXw0pXNgA5Bx4RIy6A+5vxYsqzBxP+hmjYaxxN
         wntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692339166; x=1692943966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k17LecZQkR5FnBBqAVVrYfSgelENhBd5qnGq5/zqZhc=;
        b=g66919mRMVJMyYOfXaTrdS4AI1JTHfYnx90jDIvVCIf934PKRs3sPOBioU2Oe7OxAY
         YtWdVprMtXCg8xfjvjetuXXfLVNVvpaqYq2cCOXSlop3HbYnvK0CSkq8Lw2JD9SgMQao
         sKnrT3uhGq00goiO5KQqJ9NHpJy6/3+v6s5qZNQUXj6Tkr69qeeDROefMjZECa+HZpoT
         Bwntyj6ByNbOxWUAtqL4WARGxGVALWc8wJxd0e9chzL3sYkoQYalgmCm9k4VmJwOQ4Nq
         y5k0mQ8sGaxu8B8pYot4QItXA1XUo8evTxy02Io9Wp0zL0XPq7bt0nIwd4kWUxAdcof0
         On1A==
X-Gm-Message-State: AOJu0Yx8W9FUnbnWAKAmYxiEBIswnpJhkJiATlgVc3A5IHiHiCR7eYiA
        CYyyzogYQdsbPMUadMu8wHt0uUJHAsYGen1DnojChA==
X-Google-Smtp-Source: AGHT+IGx5YFS7qfg8rzhiiw+9qHifg22wmvkoY5p7YangoYwNqNV8gzzriX7+9DIkhRNrcJAc3/65eICUwZBmjsjK5w=
X-Received: by 2002:a19:ca1d:0:b0:4fe:958:88ac with SMTP id
 a29-20020a19ca1d000000b004fe095888acmr829609lfg.6.1692339165491; Thu, 17 Aug
 2023 23:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org>
In-Reply-To: <20230817165744.73d61fb6@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 18 Aug 2023 09:12:09 +0300
Message-ID: <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 at 02:57, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 17 Aug 2023 19:59:37 +0300 Ilias Apalodimas wrote:
> > > Can we assume the DMA mapping of page pool is page aligned? We should
> > > be, right?
> >
> > Yes
> >
> > > That means we're storing 12 bits of 0 at the lower end.
> > > So even with 32b of space we can easily store addresses for 32b+12b =>
> > > 16TB of memory. "Ought to be enough" to paraphrase Bill G, and the
> > > problem is only in our heads?
> >
> > Do you mean moving the pp_frag_count there?
>
> Right, IIUC we don't have enough space to fit dma_addr_t and the
> refcount, but if we store the dma addr on a shifted u32 instead
> of using dma_addr_t explicitly - the refcount should fit?

struct page looks like this:

unsigned long dma_addr;
union {
      unsigned long dma_addr_upper;
      atomic_long_t pp_frag_count;
};

So, on 32bit platforms with 64bit dma we can't support a frag count at all.
We could either use the lower 12 bits (and have support for 4096 frags
'only') or do what you suggest.
TBH I don't love any of these and since those platforms are rare (or
at least that's what I think), I prefer not supporting them at all.

>
> > I was questioning the need to have PP_FLAG_PAGE_SPLIT_IN_DRIVER
> > overall.  With Yunshengs patches such a platform would allocate a
> > page, so why should we prevent it from splitting it internally?
>
> Splitting it is fine, the problem is that the refcount AKA
> page->pp_frag_count** counts outstanding PP-aware references
> and page->refcount counts PP-unaware references.
>
> If we want to use page->refcount directly we'd need to unmap
> the page whenever drivers calls page_pool_defrag_page().
> But the driver may assume the page is still mapped afterwards.

What I am suggesting here is to not add the new
PP_FLAG_PAGE_SPLIT_IN_DRIVER flag.  If a driver wants to split pages
internally it should create a pool without
PP_FLAG_DMA_SYNC_DEV to begin with.  The only responsibility the
driver would have is to elevate the page refcnt so page pool would not
try to free/recycle it.  Since it won't be able to allocate fragments
we don't have to worry about the rest.

> We can change the API to make this behavior explicit. Although
> IMHO that's putting the burden of rare platforms on non-rare
> platforms which we should avoid.

Yep, agree here.

>
> ** I said it before and I will keep saying this until someone gets
>    angry at me - I really think we should rename this field because
>    the association with frags is a coincidence.

I had similar confusions everytime I had to re-read our code hence git
show 4d4266e3fd32
Any suggestions?

Thanks
/Ilias
