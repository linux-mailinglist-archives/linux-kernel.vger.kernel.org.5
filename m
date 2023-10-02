Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33A7B4F44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjJBJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjJBJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:42:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC03391;
        Mon,  2 Oct 2023 02:42:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c60a514f3aso113957465ad.3;
        Mon, 02 Oct 2023 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696239767; x=1696844567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKWths37TuzuxqmK8rBu5qlLw0gJAvBT78PBFmf+dIk=;
        b=bOZpgJjAnJv5A4a+wEUKazFqnbBkAonWC/ub0eyK/omjqx5sP3vACWMFW/KfcTl027
         HMCzspYzefJ5m8LiUELGEq0RnKu+622nDG1EOE6+giH1QrR+0So8XUEkRT4ofPcXrPrH
         +9nNJ/UcFFQVpIfJKzjxrw+Sk+cvuuqUevIQmWL+zB2ckmEnEsiYFMMMuVtTczy3UlDG
         xU9TJAtLpNbrmujcOvXnezE/rR2pXNJu8cjnGhy6lMXiuxa+mOUQGJyAkcoUcil5E1Ue
         iqriVqUybQFuF04gXWfCQma8KaZhwy5WV9jrRU3w6VJiehD5hXjGDc4Tt6odOIo46CZ0
         GFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696239767; x=1696844567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKWths37TuzuxqmK8rBu5qlLw0gJAvBT78PBFmf+dIk=;
        b=qCQERiumSQ9hRKBPNj10EAYM/ujOM20NAvc0LZMv7oMtIW1m2zqOlhw7jvdff95v7P
         OkmgXzD446ZkPeLoyRa4UpIyFKZa4HAKZmJaT1pINobaTGNayFr45gOuC8gFRneLPKal
         Wd3Qfqp5UEBcLlyVPY3niaY5kkAD3/ir+DKLbc/+h8DlVlq9ORrzXp07/x8cqE9LFTeU
         Q3mBw953HOO8Lv5TWovhJwaXtSA2s806oZkLw90bCATi6RR8sn6PziQ3lI88JgQuLvMh
         HroPN/fkISHhvHwyoWB/0vDcHMCLsuQ+byLkTXSNrvyy4pfeS++kz+FxMhUbWiMoEFM7
         4V1A==
X-Gm-Message-State: AOJu0YyVC6aqKhkHxBj6kKl2IPfeWv4ajd1sLAcxCjILUE8pS21LfcIf
        jHrVMQTc/V3r7Z6AxZtCPItkDgSFvBCgPw==
X-Google-Smtp-Source: AGHT+IGJRJII6BjYEQve6vgOr3S4LQS11bujKYeGSJcS7jCV7mIKL7MxFT3lrUmNtDNzIvbuu1uF2A==
X-Received: by 2002:a17:902:d2ce:b0:1c3:ed30:ce0a with SMTP id n14-20020a170902d2ce00b001c3ed30ce0amr14783738plc.19.1696239766662;
        Mon, 02 Oct 2023 02:42:46 -0700 (PDT)
Received: from sol ([118.209.204.34])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001c73701bd17sm7901033plb.4.2023.10.02.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:42:46 -0700 (PDT)
Date:   Mon, 2 Oct 2023 17:42:39 +0800
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
Message-ID: <ZRqQj3l/2qfD/sJ4@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
 <ZRQy795YoPOKsOcz@sol>
 <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
 <ZRQ60KBtY09uPxp6@sol>
 <ZRqHx+Ihcxor2Jz4@smile.fi.intel.com>
 <ZRqMcSffA7V77mqW@sol>
 <ZRqOJsTAdjN4BsQf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRqOJsTAdjN4BsQf@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 12:32:22PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 02, 2023 at 05:25:05PM +0800, Kent Gibson wrote:
> > On Mon, Oct 02, 2023 at 12:05:11PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 27, 2023 at 10:23:12PM +0800, Kent Gibson wrote:
> > > > On Wed, Sep 27, 2023 at 04:59:34PM +0300, Andy Shevchenko wrote:
> > > > > On Wed, Sep 27, 2023 at 09:49:35PM +0800, Kent Gibson wrote:
> > > > > > On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> > > > > > > On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:
> 
> ...
> 
> > > > > > > Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> > > > > > > allows to work with 512 GPIOs at a time. With your code it will be much harder
> > > > > > > to achieve and see what you wrote about maintenance (in that case).
> > > > > > 
> > > > > > v3 ABI?? libgpiod v2 is barely out the door!
> > > > > > Do you have any cases where 64 lines per request is limiting?
> > > > > 
> > > > > IIRC it was SO question where the OP asks exactly about breaking the 64 lines
> > > > > limitation in the current ABI.
> > > > > 
> > > > > > If that sort of speculation isn't premature optimisation then I don't know
> > > > > > what is.
> > > > > 
> > > > > No, based on the real question / discussion, just have no link at hand.
> > > > > But it's quite a niche, I can agree.
> > > > 
> > > > Let me know if you find a ref to that discussion - I'm curious.
> > > 
> > > Here it is (read comments as well):
> > > https://stackoverflow.com/questions/76307370/control-gpio-from-linux-userspace-with-linux-gpio-h
> > > 
> > 
> > That question looks to me to be confusing how many GPIOs can be
> > requested per request (64) and in total (effectively unlimited) - thinking
> > they are the same.
> > That could be due to their desire to use the gpiod_chip_get_all_lines()
> > convenience function with a chip with more than 64 lines, rather than
> > because they have an actual need for the lines to be managed in a single
> > request.
> > 
> > So that doesn't look like a genuine use case to me - just a "what if I
> > want to do X" question.  Certainly not something that would warrant a v3
> > ABI.
> 
> Sure, and I'm not talking about v3 ABI to go for, see the word "might" in my
> reply in the first paragraph of this message.
> 

Ok, so your original point was pure speculation.

Cheers,
Kent.

