Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A07B06A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjI0OXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjI0OXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:23:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28999F9;
        Wed, 27 Sep 2023 07:23:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c60f1a2652so54236685ad.0;
        Wed, 27 Sep 2023 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695824600; x=1696429400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3BWG8oPBKIMl5tdWRYufTwUCrmxCw4HuyKK5y5xuEE=;
        b=XLvjoFKhG/17gMMcQmQTnJOorCl2fPgfv6jLnsbWlK1tOxFPqXund/S7v33qA/fBLJ
         I3RBaoMB9fdlpLNTQCOJYfkQp6v0j1XDVv/+ogVC2ERJKnIMTDb+1ZOn6p0hocx5pZlV
         Vp+3OrTJ0Uq6JURgkmVC3BtjNxzBItocdpIuffCI8+duJtAYMzXMSPmm9aSLAH42PgGx
         XxgdxZTWEnHiEj81Lc+m7MqpwE64HkSLpeqAujaXHFEdX+DiXrgyWUT5LlcqcYaE7hQU
         pKkXx+QfeLm0eMWhEjNwzZwZDAskZ1tRyzlZ1yIoJvKL21SqocqqjPRjTxC95DXCEcal
         p86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824600; x=1696429400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3BWG8oPBKIMl5tdWRYufTwUCrmxCw4HuyKK5y5xuEE=;
        b=ewTtAs5gW6/cjVXo9yPXPhVTayfgC0TeWNCwYrmBh2hl1Fe6sWC417I8mwXtKGVzJs
         Qu3ME33xE5/QOZtDRwjmHI7N8TpcQxhxx+tBbxqR3N+hio0VXzDKNJ4eS5lJUC2nztnB
         Em8Svm44QnsY0Onxkh0fHfjEdE4pNYNyDKZaUO1j41sXfW0f1m0Ui2WcfN4hamn/a5/m
         vvUFteTs5LXJJZmfQ1pjeuF7C+yI3ih7UEIhPIMUOHVilZzq4kXW4urzE8pPk7FRUwpW
         RM5qLcG9iokhNWPYQSpr36HZk//542+ghZO124nY2wBJs0iO81a0cPmmeI4crogvWBGl
         qx5g==
X-Gm-Message-State: AOJu0YxyiF3RnQ6XcVWiewkAQLkrhLJaRc4r/Ke0CGbZ4LYYjNw6rGuK
        RVRwQjb4MC14d8c9k8mBmUw=
X-Google-Smtp-Source: AGHT+IFhCa0TTPpNT0tDTforsake3LWuAPPG9NQAtYiLDzkLyIHq0/HcXziEzkT30AxGecMY3lFUew==
X-Received: by 2002:a17:902:ecca:b0:1c3:432f:9f69 with SMTP id a10-20020a170902ecca00b001c3432f9f69mr3809052plh.23.1695824600466;
        Wed, 27 Sep 2023 07:23:20 -0700 (PDT)
Received: from sol ([118.209.204.34])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170903278c00b001c625acfed0sm5411055plb.44.2023.09.27.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:23:20 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:23:12 +0800
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
Message-ID: <ZRQ60KBtY09uPxp6@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
 <ZRQy795YoPOKsOcz@sol>
 <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:59:34PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 27, 2023 at 09:49:35PM +0800, Kent Gibson wrote:
> > On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:
> > > > On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> > > > > Currently we have a few bitmap calls that are open coded in the library
> > > > > module. Let's convert them to use generic bitmap APIs instead.
> > > > 
> > > > Firstly, I didn't consider using the bitmap module here as, in my mind at
> > > > least, that is intended for bitmaps wider than 64 bits, or with variable
> > > > width. In this case the bitmap is fixed at 64 bits, so bitops seemed more
> > > > appropriate.
> > > > 
> > > > And I would argue that they aren't "open coded" - they are parallelized
> > > > to reduce the number of passes over the bitmap.
> > > > This change serialises them, e.g. the get used to require 2 passes over
> > > > the bitmap, it now requires 3 or 4.  The set used to require 1 and now
> > > > requires 2.
> > > > And there are additional copies that the original doesn't require.
> > > > So your change looks less efficient to me - unless there is direct
> > > > hardware support for bitmap ops??
> > > > 
> > > > Wrt the argument that the serialized form is clearer and more
> > > > maintainable, optimised code is frequently more cryptic - as noted in
> > > > bitmap.c itself, and this code has remained unchanged since it was merged
> > > > 3 years ago, so the only maintenance it has required is to be more
> > > > maintainable??  Ok then.
> > > > 
> > > > Your patch is functionally equivalent and pass my uAPI tests, so 
> > > > 
> > > > Tested-by: Kent Gibson <warthog618@gmail.com>
> > > 
> > > Thanks for testing!
> > 
> > Not a problem - that is what test suites are for.
> > 
> > > > but my preference is to leave it as is.
> > > 
> > > As Yury mentioned we need to look at bitmap APIs and make them possible to have
> > > a compile-time optimizations. With that in mind, I would prefer bitmap APIs
> > > over open-coded stuff which is hardly to be understood (yes, I still point
> > > out that it takes a few hours to me, maybe because I'm stupid enough, to
> > > get what's the heck is going one there, esp. for the == 1 case).
> > 
> > Really?  With all the bits out in the open it seems pretty clear to me.
> > Clearer than scatter/gather in fact.
> 
> Yes, you are biased. :-) Ask some stranger about this code and I am pretty sure
> there will be double-figures percentage of people who can tell that the current
> code is a bit voodoo.
> 

It is the same as yours - just inside out.  i.e. it performs the ops per
selected line, not each op on the whole bitmap of lines.

> > Sure, if there is suitable hardware support then bitmaps COULD be faster
> > than bitops.  But without that, and that is the general case, it will be
> > slower.  Do you have ANY cases where your implementation is currently
> > faster?  Then you would have a stronger case.
> 
> Why do we care here about performance? But if we do, I would check this on
> the 32-bit platform where 64-bit operations somewhat problematic / slow.
> 

Yet you argue that bitmaps could be more performant??  Pick a side!

> If Yury gives an idea about performance tests I can consider to add this
> piece to compare with and we might see the difference.
> 
> > And if you find the existing implementation unclear then the appropriate
> > solution is to better document it, as bitmaps itself does, not replace it
> > with something simpler and slower.
> 
> Documentation will be needed either way. In general statistics it will be 50/50
> who (mis)understands this or new code. Pity that the original author of the code
> hadn't though about documenting this...
> 

And who was the original author?  I forget.

What you mean to say is it is a pity the reviewers at the time were
satisfied with the code as it stands, right?
Cos there is a process here.
As I recall reviewers were more often than not complaining about
pointless comments, not the lack of comments, so the natural bias as the
author is towards under-documenting...

> > > Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> > > allows to work with 512 GPIOs at a time. With your code it will be much harder
> > > to achieve and see what you wrote about maintenance (in that case).
> > 
> > v3 ABI?? libgpiod v2 is barely out the door!
> > Do you have any cases where 64 lines per request is limiting?
> 
> IIRC it was SO question where the OP asks exactly about breaking the 64 lines
> limitation in the current ABI.
> 
> > If that sort of speculation isn't premature optimisation then I don't know
> > what is.
> 
> No, based on the real question / discussion, just have no link at hand.
> But it's quite a niche, I can agree.
> 

Let me know if you find a ref to that discussion - I'm curious.

Cheers,
Kent.

