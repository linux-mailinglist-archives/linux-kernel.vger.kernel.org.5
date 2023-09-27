Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8657AFB57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjI0Gsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Gsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:48:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A282D6;
        Tue, 26 Sep 2023 23:48:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-277564f049dso4297673a91.1;
        Tue, 26 Sep 2023 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695797317; x=1696402117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuwAtYX6gqnY1oBY5U9XN8rrNUG8GpTYVOL7/kcBiJo=;
        b=Tv+WsoGW9nQHd0VtLE1xPqn5/hO0gvlA8tmzTz4YaW62O3+smGZtIrAlJLS2D/q6s7
         thXEs4FWLt1gSr/e6oYqJj163OrBUvdDw+3oKaG2VCDcj2hAv9xwBoqmsqmb13SYBhPA
         QxXhLXoDt51EuP9xgA4XBPHkFeaTHY1fINcF+syVAG6H05X0tixXw6DfXxDEDh7iq32Z
         3AqZ/QkxacfjiAxAO9guoj/ljJzRDvP/DkbZYWnxfmHCcdf9StCgDx0rGgy5+V5DJ8OU
         YfH6BXkBjYbTQ6ew7DdYzWLxWNrSP501E6Fx8vhPUA9Lm0jCgbvILQUzjJcBwOmTZiX9
         Avjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695797317; x=1696402117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuwAtYX6gqnY1oBY5U9XN8rrNUG8GpTYVOL7/kcBiJo=;
        b=d6Beld0AE1Qh5T+5xU6VORKrHUT1Yg0EBvvaXKrD/jJrJu26ubT5GJYcnrKtz67BLo
         ZWNzjnrENThokApGftHUf3VOitSWSb/L9sMTJQug/qJJ1FEBOD2a/OnVac0nJvdreKsh
         eAOT+FBk7QS33M0dNiX0zJBXF6CGqYRnyGB6tzAg5APfRzyrP+FKuLWFCYEJ6tMFOI3J
         uLAQPpijYQFRBW/gCOuIlNiOcl8uSbPxdhlLspu3HTonIq/FgbafBJxm9NOPt7Ab6zb5
         dykkIRhlYFPUGcyaT5aMGa1mYPUBl6Vscl4l70LtZ1gwL/FEx0qyFlObsmOW2gF/wgig
         /7OQ==
X-Gm-Message-State: AOJu0YzPKx4gtAThsF7kVaZPQXvbaPTvmOAWQkCDxIPzcuZGwgWJi587
        a8uUcj0DaglYFTaKv2XjK14=
X-Google-Smtp-Source: AGHT+IFc8NZ42fyNpLIIUEAYBXpQjn58ccKZ/e7Jnkl0mwVBMEdJyOqn8C+M6jS1N/1ancR56WQRDg==
X-Received: by 2002:a17:90a:f40f:b0:274:e8e0:1503 with SMTP id ch15-20020a17090af40f00b00274e8e01503mr837496pjb.16.1695797316632;
        Tue, 26 Sep 2023 23:48:36 -0700 (PDT)
Received: from sol (60-242-83-31.tpgi.com.au. [60.242.83.31])
        by smtp.gmail.com with ESMTPSA id gf4-20020a17090ac7c400b0026f919ff9a1sm12522329pjb.10.2023.09.26.23.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 23:48:36 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:48:28 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZRPQPL97T2DXbAHv@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZRN7FRWvZnmpDD/v@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRN7FRWvZnmpDD/v@yury-ThinkPad>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:46:07PM -0700, Yury Norov wrote:
> On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> > Currently we have a few bitmap calls that are open coded in the library
> > module. Let's convert them to use generic bitmap APIs instead.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > +	bitmap_from_arr64(mask, &lv->mask, GPIO_V2_LINES_MAX);
> > +	bitmap_from_arr64(bits, &lv->bits, GPIO_V2_LINES_MAX);
> > +
> > +	num_set = bitmap_gather(vals, bits, mask, lr->num_lines);
> 
> It looks like GPIO_V2_LINES_MAX is always 64, and so I wonder: is
> my understanding correct that all bits in ->mask and ->bits beyond
> lr->num_lines are clear?
> 

The lv fields come from userspace and so cannot be guaranteed to be
zeroed beyond lr->num_lines.  Any set bits beyond that must be ignored,
one way or another.

> If so, you can seemingly pass the GPIO_V2_LINES_MAX instead of
> lr->num_lines, and that way it will be small_cons_nbits()-optimized.
> 

But that would be decidedly non-optimal for the most common case where
lr->num_lines == 1.

Cheers,
Kent.
