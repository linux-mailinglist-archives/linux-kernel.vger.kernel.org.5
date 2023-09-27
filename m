Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54BF7B05CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjI0Ntr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI0Ntp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:49:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCA911D;
        Wed, 27 Sep 2023 06:49:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d2441b95so8484704b3a.1;
        Wed, 27 Sep 2023 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695822583; x=1696427383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Aw5E5IBdNowjjS4PH7xoOgoqlu9/7i3Bf6Q6v3vpo4=;
        b=fXeRQRBY+zCNC1Q8Xz9y4tWoBOF8rC3o6FrWWhS8Q3Z9v9MuQyLKqiSAxw9cYm4RVU
         oqXovOSKCvj3rmlJvcxPpD80j19nuTe7fW7xoIL21epx6UT4VMnHaigE9ABl1o3UzuZA
         L16rtXmxdhrnJDTP+YJTnsy5TiRjzDSI/ugZrWfpcEJDjQbttglsexfU21VBdRiDBbQ0
         T7tYdXiuUzdZRO/0IxELZl9x3NbhrAiP5Xk6X1QcT5TLIGnyZSf4uRdiBukuYVRs2drH
         i2m4jRTN+NNRzBxGeFt4TnVU+jlNsTWtL0G9qOUzORxhCSg4TiEk+AzIIaW9c7C975SX
         K0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822583; x=1696427383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Aw5E5IBdNowjjS4PH7xoOgoqlu9/7i3Bf6Q6v3vpo4=;
        b=kxCH0yUZJV8ZaFRDkBHEDpzEIH2dKnOX9O4dVLin0JGwIe75I0P7KA37TBV3WxTfOD
         vGgu3R4Y+p68d3FpeYiNFqjWttFNJw5YIXUvObNGPP0mqwCTjgZhXDADWbh3Pe6uwSAy
         bAOq6+cwUGaSyC5NAyc5IONHkPDFZvo1jQCTyTOTNuhbYU/j0wWo03u0l/w7m4gk85I2
         4D57lJj3Y7ZT71yTWEuw1u8YWyGFZg9FyxgAhmnP8bNINgVzMbwPwMTLjHgQng66pxZj
         Kunqwv0bYQHeYwHl7iBbpcvWAMGzFxLpQH0MnEGLhz+LMooSLQd6H3hyCt+cgTd6AaDg
         8Zbw==
X-Gm-Message-State: AOJu0YykJYDqKJEKiJZqfAK+fWjVivh6SmdCrIt4ZKJCytkHPa0KnJXZ
        uBj03jEal8l4xu8b6sfRxuY=
X-Google-Smtp-Source: AGHT+IG/evsQgn7DeYX5iik16MARw8RfmoTuwvd81Rkjd5uGTbhh8UnGs20mcGZ5gNA/VOOeDNWxgg==
X-Received: by 2002:a05:6a20:734e:b0:13e:90aa:8c8b with SMTP id v14-20020a056a20734e00b0013e90aa8c8bmr3270011pzc.4.1695822583550;
        Wed, 27 Sep 2023 06:49:43 -0700 (PDT)
Received: from sol ([118.209.204.34])
        by smtp.gmail.com with ESMTPSA id c16-20020aa781d0000000b00686edf28c22sm11779046pfn.87.2023.09.27.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:49:43 -0700 (PDT)
Date:   Wed, 27 Sep 2023 21:49:35 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZRQy795YoPOKsOcz@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQdQnL5VbX659cl@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:
> > On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> > > Currently we have a few bitmap calls that are open coded in the library
> > > module. Let's convert them to use generic bitmap APIs instead.
> > 
> > Firstly, I didn't consider using the bitmap module here as, in my mind at
> > least, that is intended for bitmaps wider than 64 bits, or with variable
> > width. In this case the bitmap is fixed at 64 bits, so bitops seemed more
> > appropriate.
> > 
> > And I would argue that they aren't "open coded" - they are parallelized
> > to reduce the number of passes over the bitmap.
> > This change serialises them, e.g. the get used to require 2 passes over
> > the bitmap, it now requires 3 or 4.  The set used to require 1 and now
> > requires 2.
> > And there are additional copies that the original doesn't require.
> > So your change looks less efficient to me - unless there is direct
> > hardware support for bitmap ops??
> > 
> > Wrt the argument that the serialized form is clearer and more
> > maintainable, optimised code is frequently more cryptic - as noted in
> > bitmap.c itself, and this code has remained unchanged since it was merged
> > 3 years ago, so the only maintenance it has required is to be more
> > maintainable??  Ok then.
> > 
> > Your patch is functionally equivalent and pass my uAPI tests, so 
> > 
> > Tested-by: Kent Gibson <warthog618@gmail.com>
> 
> Thanks for testing!
> 

Not a problem - that is what test suites are for.

> > but my preference is to leave it as is.
> 
> As Yury mentioned we need to look at bitmap APIs and make them possible to have
> a compile-time optimizations. With that in mind, I would prefer bitmap APIs
> over open-coded stuff which is hardly to be understood (yes, I still point
> out that it takes a few hours to me, maybe because I'm stupid enough, to
> get what's the heck is going one there, esp. for the == 1 case).
> 

Really?  With all the bits out in the open it seems pretty clear to me.
Clearer than scatter/gather in fact.

Sure, if there is suitable hardware support then bitmaps COULD be faster
than bitops.  But without that, and that is the general case, it will be
slower.  Do you have ANY cases where your implementation is currently
faster?  Then you would have a stronger case.

And if you find the existing implementation unclear then the appropriate
solution is to better document it, as bitmaps itself does, not replace it
with something simpler and slower.

> Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> allows to work with 512 GPIOs at a time. With your code it will be much harder
> to achieve and see what you wrote about maintenance (in that case).
> 

v3 ABI?? libgpiod v2 is barely out the door!
Do you have any cases where 64 lines per request is limiting?
If that sort of speculation isn't premature optimisation then I don't know
what is.

Cheers,
Kent.
