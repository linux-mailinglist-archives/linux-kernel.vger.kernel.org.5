Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB16E758334
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGRREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGRREW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:04:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB71FD9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:03:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8a44ee159so36484855ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699808; x=1692291808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GT+sqjsBJCrCFnfjlBO9PEjDZvBphMzEEJkH0X1enOQ=;
        b=XbxFnoY3K8n5MjmOsvk1vk4QDsSBRo9sFeq1bC/f8+42pGBUp6fsTTervq0PZxIP+l
         DkES1cAEdkigXbFnLUe/1wRMUu7ubjc7VeMnQOC+kZDm6Ar6KEq0oYgQN23ShDICrJtM
         vw65u2TXA1cRapOGY1n0QnvfLyge1jraFL/29kP2RGN9Je/zxaNoE2y4h9pel3frgDXt
         RqV6/yISVyARBn6dHG7Y/ruTvDls9BjMZjd9IbF89/XiOVghjc7E/T7kliD6YLtGw3Dv
         vco9SD/kURWosFNKoyoA7po5lUUuexk+kZEEL7qS4aw7Hm+tFF4NNIGzf6HRmjtqkWEP
         f8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699808; x=1692291808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GT+sqjsBJCrCFnfjlBO9PEjDZvBphMzEEJkH0X1enOQ=;
        b=NauJxgP8RCIaLsR55O2zyn3qCf1t7ZkY/CNr4ry06bAFwOSbql2Yp/IiixfVlVSBmq
         CqWi94em+vPQsPpFOQF8A+1iGUYx2/wPURGz3pFK7C/8uYpeGZocOH1E7d1d5cx1XSoU
         BUFA9naV3B1oOZnh/aWofD7VlTE4850K3B8f62K4OufMqrl5HqULQ4+XiZgyZ46qHSws
         PYNlGqZbPts4GnrvCCsGd3SwH5J9ifCN5j0iLXIS70cyX46s/7Ev02fbB6gJ6gD/EalO
         O2JZWvjtOrJyH+hQIhoYld0yaeG26ghb3SSINCOejdIjiC3fEnaqrO4hLK/G7fTj9CeP
         rbiA==
X-Gm-Message-State: ABy/qLYgQs3olS/bh3T49LkE7I53Y70/aL6LU2OVyjmOmGw15VU07jL3
        P2jxavTtIlT/2EDg2/DjSgc=
X-Google-Smtp-Source: APBJJlF/FniITLJA/CjL64d6hguVOAGlCPmAwKTX1K2KiD3CBpmX2EtSlV18R6R4JqrH28iHT0ItqQ==
X-Received: by 2002:a17:902:b68f:b0:1b9:e9f3:44c3 with SMTP id c15-20020a170902b68f00b001b9e9f344c3mr13072448pls.4.1689699807648;
        Tue, 18 Jul 2023 10:03:27 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001a98f844e60sm2091603plb.263.2023.07.18.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:03:27 -0700 (PDT)
Date:   Tue, 18 Jul 2023 10:03:25 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLbF3ZO7TvJGJOeo@yury-ThinkPad>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLVjYzuxlJAQVpIO@yury-ThinkPad>
 <CAG_fn=UPqyFhEMLDz3nhc7fgpCvprLsYrNjUnw3z4KfWCJGTHA@mail.gmail.com>
 <ZLabOHmNQm2EOXWR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLabOHmNQm2EOXWR@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:01:28PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 18, 2023 at 11:30:00AM +0200, Alexander Potapenko wrote:
> > On Mon, Jul 17, 2023 at 5:51 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Mon, Jul 17, 2023 at 01:37:04PM +0200, Alexander Potapenko wrote:
> 
> ...
> 
> > > When nbits == 0, copy-like functions shouldn't touch any memory. See how
> > > other bitmap and find_bit functions hold it.
> > 
> > I think this is different from what other bitmap functions do, but it
> > should be enough to bail out on !nbits, i.e.:
> > 
> >     if (!nbits)
> >         return 0;
> > 
> > You probably meant adding a __builtin_constant_p() (which is used all
> > over the place in bitmap.h), but:

No, I didn't mean that.

> >  - the compiler won't have problem optimizing away the code for a
> > constant nbits=0;

Look at your code, having nbits == 0 in mind:

       const size_t index = BIT_WORD(start);
       const unsigned long offset = start % BITS_PER_LONG;
       const unsigned long space = BITS_PER_LONG - offset;
       unsigned long value_low, value_high;

       if (space >= nbits) // This is always the case
               return (map[index] >> offset) & GENMASK(nbits - 1, 0);
       ...             ^^                      ^^
                       Unconditional fetch     Wshift-count-overflow

Thanks to GENMASK() implementation, you'll be warned by GENMASK_INPUT_CHECK()
if nbits is a compile-time variable. In case of runtime, it's a pure undef,
not mentioning useless, expensive and dangerous fetch.

> >  - we anyway need a dynamic check for the case nbits is not constant
> > (for both bitmap_get_value() and bitmap_set_value(), I assume).
> > 
> > What do you think?

I think that instead of speculations, it's better to cover nbits == 0
with the explicit tests for run- and compile-time. That way you're
always on a safe side.

bitmap_get_val(NULL, 0, 0) shouldn't crash the kernel.
 
> The idea behind is to eliminate the code completely for the cases nbits != 0.
> In your case the dynamic check will be there. That's what we want to avoid.

Alexander is right - we can't avoid testing against 0 if we need to
test for 0... In case of other functions we have inline and outline
implementations, controlled by small_const_nbits().

As you can see, the small_const_nbits() tests against 0 explicitly,
although it's free at compile time. But if nbits == 0, we pick
outline version of a function regardless.

On their turn, outline versions again do their test against nbits == 0,
but most of the time implicitly.

In case of bitmap_set_val, we are touching at max 2 words, and there's
no reason for outline version, so we have to test nbits against 0
inside inline code. 

Having all that in mind, and because nbits == 0 is most likely an
error we'd follow the following rules:
 - no memory must be touched as we're potentially in error condition,
   and pointer may be corrupted;
 - the cost of the check must be as minimal as possible.

So I suggest:

        if (unlikely(nbits == 0))
                return;

For readers that would literally mean: we don't expect that, and we find
it suspicious, but we'll handle that as correct as we can.

By the way, Alexander, please drop that 'const' things. Those are for
pointers or some global variables, not for inline functions with 4
lines of code. (If you think it helps the code to be safe than no - it's
unsafe even with consts.)

Thanks,
Yury
