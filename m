Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05BB7D4F44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjJXL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJXL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:57:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3937BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:56:58 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2f4a5ccebso2961880b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698148618; x=1698753418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eR6QNBIHwR7YaDUpZPrEaTwM70RiKpQcsd/wVpp07CY=;
        b=KQQT9LGC3RrHxMN5ed3pwDSSf4dWjCK9oX0vY05Q5F/PeN+q4CvVDKhc8ufYAiTmkn
         Dee8nxNeYgr/MyY+Y4zCK22Hq6iBDkeYBdM2bc2Iu0CJGsRTYFmQvZUB2dYQdBP4TB7q
         AaZ4neaCDrdjNlxtcTBnqd/KyrGi1W+V1DeDczLSUzdgMhweAzQILO2zkyR5Uvsz5tta
         3ximHRGv/iDSi1sKQraAInkXIYqJ+sH/4acksXz9PAQ4MaEVncC1tkwEq9SWvbfvas9e
         cGxNGAopNXmg1UZXe0l5TWCjbLf8AK/OHgp635CVHgpgWiFnME7x8ZuEJFAAwjGL/9+G
         60Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698148618; x=1698753418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eR6QNBIHwR7YaDUpZPrEaTwM70RiKpQcsd/wVpp07CY=;
        b=Gr96Xd0ZPqMTRWFpgfYlCF7GdyCXQ99Yxz+WrFq9bjvrKLziyT3CHWZxK07Fh9ABye
         we4NtRE50aa1nRDbFpj58E7fGb1ggpqciHlf8OtAUe2KfdrmN8L7G5Z3jOcSzKEKaW4p
         yK2juwUfraz79VYxE3yxiaSqqt23xnPqAkZFmm0sljh224b6G0GJwKWeJgokFbYeQtlI
         FbOnfFEKuq6U/llVEKHW9cVvD+EE5UIetLVXLYWIrRiWZAdAWxpocQM1N7KRLzKeYpCL
         bbRZMk/79gq/Bdthyva7nFGpOrNzTNG8AICmYc/kkOSjWCcNdEYlUg4mUJj0GSKmGVfb
         qZ5g==
X-Gm-Message-State: AOJu0Yym0CFRP881Jbz7Nkch3Yhzf9vSinvpb8OEDy7EzxutwLmK6HOq
        yP0RKXEZOnvUV9mnC56v0GH+7ajuq4iqBsu9/t2uig==
X-Google-Smtp-Source: AGHT+IEuPEDNk8b8g7YAAKyQb6trNkY+cz1cDEz1O8MbM44KC+nw2woHJr2DgJD+7D7AWdpK46bHVmAt0RFRUe6w+SY=
X-Received: by 2002:a05:6808:8fc:b0:3a4:3b56:72b2 with SMTP id
 d28-20020a05680808fc00b003a43b5672b2mr13290727oic.8.1698148617977; Tue, 24
 Oct 2023 04:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231023102327.3074212-1-glider@google.com> <20231023102327.3074212-2-glider@google.com>
 <ZTbcXEe74q6jG4XZ@yury-ThinkPad>
In-Reply-To: <ZTbcXEe74q6jG4XZ@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 24 Oct 2023 13:56:18 +0200
Message-ID: <CAG_fn=XZdT7k4fr7G5+-+DC9Oon-3y2PenyZomSiObbc4M=GQw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +static void __init test_bitmap_write_perf(void)
> > +{
> > +     DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> > +     unsigned int cnt, nbits, i;
> > +     unsigned long val = 0xfeedface;
> > +     ktime_t time;
> > +
> > +     bitmap_zero(bitmap, TEST_BIT_LEN);
> > +     time = ktime_get();
> > +     for (cnt = 0; cnt < 5; cnt++) {
> > +             for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
> > +                     for (i = 0; i < TEST_BIT_LEN; i++) {
> > +                             if (i + nbits > TEST_BIT_LEN)
> > +                                     break;
> > +                             bitmap_write(bitmap, val, i, nbits);
> > +                     }
> > +             }
> > +     }
> > +     time = ktime_get() - time;
> > +     pr_err("Time spent in %s:\t%llu\n", __func__, time);
>
> For the perf part, can you add the output example to the commit
> message, and compare numbers with non-optimized for-loop()?
>

I don't understand the purpose of this comparison.
It is evident that bitmap_write() is faster than the non-optimized
loop doing BITS_PER_LONG reads and writes of a single bit.
It is moot how much faster the current implementation is, because the
loop implementation is just a concept describing the behavior of
bitmap_write().

My understanding was that the performance tests will help if someone
decides to optimize bitmap_write() further - in that case they would
be able to compare the performance before and after their changes.
But I fail to see how it helps to compare the current implementation
to something that is a priori slower.
