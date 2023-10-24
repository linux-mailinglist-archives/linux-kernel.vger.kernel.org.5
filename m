Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872497D4A03
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjJXI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJXI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:27:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F2128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:27:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507c78d258fso6016694e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698136052; x=1698740852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yhceSFM1hF3sghD+dtG2lSmmlVSuNVGZPGjZf8ESzpA=;
        b=sYdkngCaxIxVFpRow36WwN4O/t3zWSge5EMhvVmUQsRNXrDSYhlLkNEuuMdsIoT5J1
         Bb3d4wsF3Ho843o3O0I1D5hfmby4DubHYnKDgZibS64GRzc4rm8jQDpT0wbIxOG6n/pl
         bu9lujKq+VE+GIiO8Gk50gGPBLnEehDflSLmoIn61Agn5u66SB0GBPXuPbKHrzDTUWJg
         sSNPZDJz5k2qYkRp2sqzi20Ad3BIN9JjvtgwKBKAjpfhqi1mTRquSFdkTidS2BqgM9rI
         dmPBmVjBPQPNvLXR0+n/CuqP7wa41ZqPKiVV7WAotLvteCYvtP81I3fFOvvX+Z5DNBEO
         YFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136052; x=1698740852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhceSFM1hF3sghD+dtG2lSmmlVSuNVGZPGjZf8ESzpA=;
        b=mVK+Zi73EpS02ZALqtzQ17neCPqpATbcNJ9a1Vs4/r7ZwMQAoqWTE5ZR4c909i6oSC
         uClFjDOMoAkpwYBKUDKBNbFwss0kYYQRw6dq2H/bsDNHZDvKbESQCXruwhpZ/2jx/9PS
         SxN04Alu5mmMkKrKVtHwxHs6qSfmOOlZCTvOf9sN8K/6txQqHTf0FeUhS8Yb2cSae4vN
         1S6PpWvXLTX6BVa4Ri3IYNQEna7/+TKinomywKg1dZoe3a8KMIGpaG5xmBncvES7Gwnn
         YVhBzD4Byc8K55DCGxlOSQ5rPIXqvSSyei88f5fK5OlLhQlkhftl2vR7rTPbOSbDKelQ
         waUg==
X-Gm-Message-State: AOJu0Yx2ObdmOgh4iz4HlR7CqeInBgfToDDisy5PJedkPBODV7jhILoF
        dAF0BkwP5nW0YSOW3/hmebrVtbkZXww9SwVY94LmYw==
X-Google-Smtp-Source: AGHT+IH+ppXE9oWNrw78/puY+ozs8vEdItnvs9Q/9Zcip+MRe8OiG/+W6Q4qeBTs/jJZilq9miabv75lYqkM2xc06q8=
X-Received: by 2002:a19:644d:0:b0:507:9618:dc1f with SMTP id
 b13-20020a19644d000000b005079618dc1fmr7693069lfj.69.1698136052607; Tue, 24
 Oct 2023 01:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231020095952.11055-1-linyunsheng@huawei.com>
 <20231020095952.11055-2-linyunsheng@huawei.com> <ZTZcTrTy9ulPast5@hades> <4da09821-d964-924f-470b-e5c1de18eecf@huawei.com>
In-Reply-To: <4da09821-d964-924f-470b-e5c1de18eecf@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 24 Oct 2023 11:26:56 +0300
Message-ID: <CAC_iWj+JXev-Hyip1KtZv5pCQz6PU9u-d8iU5ZPaAeyVZYeKDg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 1/5] page_pool: unify frag_count handling in page_pool_is_last_frag()
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
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

On Mon, 23 Oct 2023 at 15:27, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/10/23 19:43, Ilias Apalodimas wrote:
> > Hi Yunsheng,
> >
> > [...]
> >
> >> +     * 1. 'n == 1': no need to actually overwrite it.
> >> +     * 2. 'n != 1': overwrite it with one, which is the rare case
> >> +     *              for pp_frag_count draining.
> >>       *
> >> -     * The main advantage to doing this is that an atomic_read is
> >> -     * generally a much cheaper operation than an atomic update,
> >> -     * especially when dealing with a page that may be partitioned
> >> -     * into only 2 or 3 pieces.
> >> +     * The main advantage to doing this is that not only we avoid a atomic
> >> +     * update, as an atomic_read is generally a much cheaper operation than
> >> +     * an atomic update, especially when dealing with a page that may be
> >> +     * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
> >> +     * handling by ensuring all pages have partitioned into only 1 piece
> >> +     * initially, and only overwrite it when the page is partitioned into
> >> +     * more than one piece.
> >>       */
> >> -    if (atomic_long_read(&page->pp_frag_count) == nr)
> >> +    if (atomic_long_read(&page->pp_frag_count) == nr) {
> >> +            /* As we have ensured nr is always one for constant case using
> >> +             * the BUILD_BUG_ON(), only need to handle the non-constant case
> >> +             * here for pp_frag_count draining, which is a rare case.
> >> +             */
> >> +            BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
> >> +            if (!__builtin_constant_p(nr))
> >> +                    atomic_long_set(&page->pp_frag_count, 1);
> >
> > Aren't we changing the behaviour of the current code here? IIRC is
> > atomic_long_read(&page->pp_frag_count) == nr we never updated the atomic
> > pp_frag_count and the reasoning was that the next caller can set it
> > properly.
>
> If the next caller is calling the page_pool_alloc_frag(), then yes,
> because page_pool_fragment_page() will be used to reset the
> page->pp_frag_count, so it does not really matter what is the value
> of page->pp_frag_count when we are recycling a page.
>
> If the next caller is calling page_pool_alloc_pages() directly without
> fragmenting a page, the above code is used to ensure that pp_frag_count
> is always one when page_pool_alloc_pages() fetches a page from pool->alloc
> or pool->ring, because page_pool_fragment_page() is not used to reset the
> page->pp_frag_count for page_pool_alloc_pages() and we have removed the
> per page_pool PP_FLAG_PAGE_FRAG in page_pool_is_last_frag().
>
> As we don't know if the caller is page_pool_alloc_frag() or
> page_pool_alloc_pages(), so the above code ensure the page in pool->alloc
> or pool->ring always have the pp_frag_count being one.


Fair enough, Jakub pulled the series before I managed to ack them, but
that's okay. It's been long overdue apologies. FWIW I went through the
patches and didn't find anything wrong coding-wise

Thanks
/Ilias
>
>
>
> >
> >> +
> >>              return 0;
> >> +    }
> >>
> >>      ret = atomic_long_sub_return(nr, &page->pp_frag_count);
> >>      WARN_ON(ret < 0);
> >> +
> >> +    /* We are the last user here too, reset pp_frag_count back to 1 to
> >> +     * ensure all pages have been partitioned into 1 piece initially,
> >> +     * this should be the rare case when the last two fragment users call
> >> +     * page_pool_defrag_page() currently.
> >> +     */
> >> +    if (unlikely(!ret))
> >> +            atomic_long_set(&page->pp_frag_count, 1);
> >> +
> >>      return ret;
> >>  }
> >>
> >
> >  [....]
> >
> >  Thanks
> >  /Ilias
> >
> > .
> >
