Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4348D77FC72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353792AbjHQRAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353805AbjHQRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:00:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE22D67
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:00:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe11652b64so12500340e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692291613; x=1692896413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HzWFuUiwmjTArnOAh04WG3dlDugXiORSBHNiTqgRyl4=;
        b=wCVCuabfCpuzdOJguyhLNnKNGmKv2elJrSr74FE2LreiTJAQW/Hj8ZFqcAQXwXGw5S
         561Vvo1ToqOiL0YuQMUv2U9U60D8ym+yxFPBYXpG+HBkS/9RIPDYZ2jW+SpJct44tKmD
         tt1bCBQPaRGOhAYFM5Nj/wdoKVyWNkPwNT+7vTFy7JzZsuaEGZGG5xYTzJWQIOzaGqO0
         MQa18wzWuuGM/23QvuMwr9tVsCfCAD10pt9CEYq/9tuk24StqBcUU/egouuKv2n/qgZR
         jy7HRFNfRK+YOWP8PTtBeR0xwAfJ47K2MYg57y4dMvUGr126sfmaDgNq0PLDxmWnf0Vx
         zNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291613; x=1692896413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzWFuUiwmjTArnOAh04WG3dlDugXiORSBHNiTqgRyl4=;
        b=VEXoX7C+5OqI8NPmjF475NGsErTrxQdXbVo3bX1e2Gv/M4BFuCQFoIvAVYh0hj7hZD
         hyexr5lsJQvkTMp4PrH2FfIgvcgbcbu/MSRSZqVQnVwGLcZEsGqS9y9/Pd5aWVgyJq1e
         liJ8QfHExVxbGbVw+C4Gmwtwidi7yLuxhDO23aMFS7YDR6/SMpRjX7FEpl7lNY51VN5q
         NuhGI0qA+43Ofk2syehsA63PJCpH9hsiPQXFEMcC06L+dAdUP2zxMvkzpCYbJ+QniyGt
         OIBgEt4wQER7uS0HWIGQ3iBcFz2ldGszx6ejTMYjHn3wraJIjdIx7fu3++yofivm5iAD
         a1eA==
X-Gm-Message-State: AOJu0Yzr8rTCLJz6iobUqAE+un10Yj5C97ZxLtJj73vm05iOEO2kOcDe
        NQWTe5taA1loK9KEuX/D1e8KpQpIkCc6TIWGZnbzVg==
X-Google-Smtp-Source: AGHT+IFQutPOg+NOkZPJDGNGDURbkonRFuWocVa0Ell2GSQDJBihcX1ZfG9EQKhZuO5MbhjQLGQ86PB8TMt6jOmiI1M=
X-Received: by 2002:a05:6512:3288:b0:4fd:d538:b97b with SMTP id
 p8-20020a056512328800b004fdd538b97bmr3627878lfe.29.1692291613161; Thu, 17 Aug
 2023 10:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org>
In-Reply-To: <20230817091554.31bb3600@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 17 Aug 2023 19:59:37 +0300
Message-ID: <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Thu, 17 Aug 2023 at 19:15, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 17 Aug 2023 16:57:16 +0300 Ilias Apalodimas wrote:
> > Why should we care about this?  Even an architecture that's 32-bit and
> > has a 64bit DMA should be allowed to split the pages internally if it
> > decides to do so.  The trick that drivers usually do is elevate the
> > page refcnt and deal with that internally.
>
> Can we assume the DMA mapping of page pool is page aligned? We should
> be, right?

Yes

> That means we're storing 12 bits of 0 at the lower end.
> So even with 32b of space we can easily store addresses for 32b+12b =>
> 16TB of memory. "Ought to be enough" to paraphrase Bill G, and the
> problem is only in our heads?

Do you mean moving the pp_frag_count there?  I was questioning the
need to have PP_FLAG_PAGE_SPLIT_IN_DRIVER overall.  With Yunshengs
patches such a platform would allocate a page, so why should we
prevent it from splitting it internally?

Thanks
/Ilias
>
> Before we go that way - Mina, are the dma-buf "chunks" you're working
> with going to be fragment-able? Or rather can driver and/or core take
> multiple references on a single buffer?
