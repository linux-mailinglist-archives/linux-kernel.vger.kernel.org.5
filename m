Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805647CC3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbjJQNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjJQNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:03:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E2B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:03:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c53c5f7aaaso6697251fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697547796; x=1698152596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXs0q9mBXE4NFA1doT5CaGDIU8NXELScS6cZ9XMNR7U=;
        b=rPx00GwRt9Lbt7IyotlZsRbO/ONXH9XpNJcRUe4wSiqSVFAYeusc9IcWO2Ht6Jw7E3
         FAPbRwqZN0tgSTa5BqTu6W/cKslNRW81Lr+RNw2MdBYzE2FhsAEVPJZGz/fmzMcTjtE2
         0v/mMGnqPiiADHYICj3JY9XeL2ROckUJr9ee66NS/PSf+bXBN5enukZ7gdKi7eQ6V6+n
         7yt68+AgsduvXXov4GJ7qP0ub/EBzrdUDqOyhbNZx8jZeA6Z1you4/9cGvyt9oN1gsjI
         HbK/5q0SDiPnbpse7E9fwu3FBS3Yak5fq0RO1shhwM54DTGTXsqGgYjINfaGiVo1aWUs
         XTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547796; x=1698152596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXs0q9mBXE4NFA1doT5CaGDIU8NXELScS6cZ9XMNR7U=;
        b=HNV4tB/mppioIp5kc3U23hABmvITj1pp1Ulz1ZmLP3ohQRjOUJ4Lj+NoCqmZuK8juV
         FssNKESRz0rJE2r9C7wFeSV+sX73ffdqYXDPiyDqWRitN/GsuizwDREZSJMouyvJywvD
         85rKIU5ZzEqQItKim7mYhcuLpJ6RQ9ov5cRE/M7cgngYPLWe+LdjwhJA55vWESFGMVPm
         GPTq+qNopT8YHQ9gb7be4hFNi9VOdsMrFflORc6pf9M7lfuBMSYCjq++60ikPWhniLP2
         JLEfOEjoKS9TTxTw0NH8CW0hTC/4lxE+UsF5tLBas0vw8gQqjtsuIp71AyLSET4yGPeF
         JCFw==
X-Gm-Message-State: AOJu0Yz2+F8HMi4SIBO/nVoC+bUFTFnRXX09zaHa1IhGMg+eLwFxXRDa
        2kBf208ws251lhsk5Qoycc0Ig74LsiB1/LV9mk6Hqw==
X-Google-Smtp-Source: AGHT+IF++YlDi1NoCe1h+WHq9g3qbnOigxmvB0ZYJcTY0RXDaQmwTSmc/On4WuvZ0sl+dk+2o8fU+tqucPcC/vLewDI=
X-Received: by 2002:a19:7417:0:b0:502:d743:9fc4 with SMTP id
 v23-20020a197417000000b00502d7439fc4mr1822904lfe.37.1697547796528; Tue, 17
 Oct 2023 06:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231013064827.61135-2-linyunsheng@huawei.com> <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
 <e738b0b9-6c60-b971-7fd9-0ec1b14dda3c@huawei.com>
In-Reply-To: <e738b0b9-6c60-b971-7fd9-0ec1b14dda3c@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 17 Oct 2023 16:02:40 +0300
Message-ID: <CAC_iWjLYZWUt9RFkAMR8=2amscbOUqXbVP8n8oiXHGsXw-ZKCA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunsheng

On Tue, 17 Oct 2023 at 15:53, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/10/17 20:17, Ilias Apalodimas wrote:
> >>
> >
> > That looks fine wrt what we discussed with Jakub,
> >
> > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Thanks. What about other patches in this series? Could you take
> some time to review them too?

Yes I will, I was on nonstop trips, and was a bit cumbersome to
review/test.  Also, there Plumbers is in a month, and I have an idea I
need to discuss with Jakub about adding page pool patches to a CI.
That should make the whole process a bit faster

Thanks
/Ilias
>
> >
> > .
> >
