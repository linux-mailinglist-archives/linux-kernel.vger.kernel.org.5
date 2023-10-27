Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534927D8DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbjJ0Dvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Dv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:51:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AC198;
        Thu, 26 Oct 2023 20:51:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5859d13f73dso1347087a12.1;
        Thu, 26 Oct 2023 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698378685; x=1698983485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XyIEM0d5aPJyRsG/Mv/heXNjjDCRH+fj3WqLUfTb2c=;
        b=bdRvz9hbXU+vnk1U0YIg9PXM0CqOfZgNG0TOLopqlUroXnKlL3usy+yfL4K6LnMN29
         lNnEaVLUmcFdmXsRcrYKDrdtZuB73RKZRQKht6Lxy0wdt7ycQEDwWZJn4rjfAIerZwP2
         hQjgLgMPxi08e7Vnh9z4pjWUjIXWVLBqcPgjr6Y6f18vDJGJZ/ADLeJ+RQMjuMmGfq6m
         Uqcpvnw5PXp0QYyaDsLwOWgyMvsmTp0rnUl4+xD2aaB3dTYpFZn+O0E3iX/fO0v9EpEb
         sag/bAqMaRnCl8FQnKlnXWcm/l4eCYsxU4cAkp7aSqFGlas0IUtS0w6pB1VT01SXNcGu
         pU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698378685; x=1698983485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XyIEM0d5aPJyRsG/Mv/heXNjjDCRH+fj3WqLUfTb2c=;
        b=dvdykE9NV8jQ675qELIX5kTWauqaqbDR3Zx2P9QzyWpMQjBoEgF+0iXE66qEkg63nn
         4h1YOncKNXhJZOhgfj7iya4MFhRz08NU9Cfn/XqTixR0Jan9qzEyxKHUCAkIADDmpyzG
         0cAKevt+buLES/kHjY1Wfw69X/LR+kmIgWOJ6ognIs9EQEBBdk8k2YSUuegrRdgF1dB1
         arbpPdBTsSnVqScVpXGgp7eA8HzKoHZYHXVQmFlNkryYUPZCe0n/MUcaWcVF/xSEI/p8
         twYjyhr6+Uw3hHWzwoaiAy66Jow7XV84vmE7Ws5qQ9jM0nUnMOGb8DenmaVo95nlUSVF
         VlhA==
X-Gm-Message-State: AOJu0YySjJXXVp3rj4vIakgaooW/CXDJ9UxNSlaW1EcOyXrtN0Ogrsha
        0TEGRlVEbu6Tt7ZK9+S1Xgw8bdyTUMVLZw==
X-Google-Smtp-Source: AGHT+IEwmWBLyvNIJWUor782XVkhqx5XlxuPJweOG6kixg7XjGXbVG4aFxXT6sRpina/iMGTnZY0jw==
X-Received: by 2002:a05:6a20:4401:b0:179:faa1:46ba with SMTP id ce1-20020a056a20440100b00179faa146bamr2129276pzb.35.1698378685375;
        Thu, 26 Oct 2023 20:51:25 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id pv8-20020a17090b3c8800b0028005766068sm951749pjb.53.2023.10.26.20.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:51:24 -0700 (PDT)
Date:   Thu, 26 Oct 2023 20:51:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <ZTszoD6fhLvCewXn@yury-ThinkPad>
References: <202310251458.48b4452d-oliver.sang@intel.com>
 <374465d3-dceb-43b1-930e-dd4e9b7322d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374465d3-dceb-43b1-930e-dd4e9b7322d2@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:18:00AM +0200, Rasmus Villemoes wrote:
> On 25/10/2023 09.18, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 3.7% improvement of will-it-scale.per_thread_ops on:
> 
> So with that, can we please just finally say "yeah, let's make the
> generic bitmap library functions correct

They are all correct already.

> and usable in more cases"

See below.

> instead of worrying about random micro-benchmarks that just show
> you-win-some-you-lose-some.

That's I agree. I don't worry about either +2% or -3% benchmark, and
don't think that they alone can or can't justificate such a radical
change like making all find_bit functions volatile, and shutting down
a newborn KCSAN.

Keeping that in mind, my best guess is that Jan's and Misrad's test
that shows +2% was against stable bitmaps; and what robot measured
is most likely against heavily concurrent access to some bitmap in
the kernel.

I didn't look at both tests sources, but that at least makes some
sense, because if GCC optimizes code against properly described
memory correctly, this is exactly what we can expect.

> Yes, users will have to treat results from the find routines carefully
> if their bitmap may be concurrently modified. They do. Nobody wins if
> those users are forced to implement their own bitmap routines for their
> lockless algorithms.

Again, I agree with this point, and I'm trying to address exactly this.

I'm working on a series that introduces lockless find_bit functions
based on existing FIND_BIT() engine. It's not ready yet, but I hope
I'll submit it in the next merge window.

https://github.com/norov/linux/commits/find_and_bit

Now that we've got a test that presumably works faster if find_bit()
functions are all switched to be volatile, it would be great if we get
into details and understand:
 - what find_bit function or functions gives that gain in performance;
 - on what bitmap(s);
 - is the reason in concurrent memory access (guess yes), and if so,
 - can we refactor the code to use lockless find_and_bit() functions
   mentioned above;
 - if not, how else can we address this.

If you or someone else have an extra time slot to get deeper into
that, I'll be really thankful. 

Thanks,
Yury
