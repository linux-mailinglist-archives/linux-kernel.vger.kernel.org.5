Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34307B4F02
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjJBJZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjJBJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:25:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455FA4;
        Mon,  2 Oct 2023 02:25:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5859b06509cso2061975a12.2;
        Mon, 02 Oct 2023 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696238713; x=1696843513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qXBB0HN9EE99f58WPeeJJXkwIcpeq4j/UjdEMsKhjw=;
        b=HW/t03TraU2l+PsoVrnL1idz2UWo9Jk86iLHAgjbKidGXH46NZlD8D2VhMm+mCfavW
         Bh3+7FJzTR1nsOyeMJ25go/MIcfh8ZOO0Pz0kw8C0GsCYU9ZzqSLuVxRY1zEFxrTolg9
         MvwPfljt+Ds17ROUgm1J3WbOrq+ISZqSXRiG/akeLct3ezdykAa51QDg3eWlYVYHRN3D
         UpZ9UR4GzsCMHf9u2zJIWazpQQeH2lbhaiTm6OMUqkUpf51G6glHSNsEIy7jqB2QFRpZ
         9WAAPsrFvvPPoHndr6AhWp44C+AcBrMs8uTBe14zF/7IvPG33Mfz2a9bk+yVqN9NixIm
         jfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238713; x=1696843513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qXBB0HN9EE99f58WPeeJJXkwIcpeq4j/UjdEMsKhjw=;
        b=WXMmjFLaVFFA6B3ZyK+852dNuFBlEVu+BlzrldDKmAMa2HOPQ5H7Uln9fBGdkZp2g+
         fKUj31AMhxDkngozUyOltbZiR6DDTar+8XhD+5oIuLufmJ+YnC7f+UJMaGTS3Unr+T2J
         s7oFT1KeQfb/r9rADf8PNj/1x7Tlr+Ddu7pPBYv8ooa1VKtlJq+l3MzfjS/eoKS7MoX9
         qlFu8JzGDs8+aqekO98QoIOragMFGlfiF1OKU27pmHxSA7y20o1Ds9vD+S0WqOTqjCli
         U2DjzDR8RHz+1i3DJHCv43NYmNdGlJBywzlvDUYnzatmoy9s7tfWFBY2S6IazqnaSXH+
         wTNg==
X-Gm-Message-State: AOJu0YywfkL404E3jr/sqVAXvw8Su8qxlcYCnrUfFBWMW4OEk1ya6CWE
        ArwZS5WHYdWQ8/IQx0+Wu8s=
X-Google-Smtp-Source: AGHT+IHpK5n4dWXV9/SW5f/QoW/AwH52cbiDur8cY38t2xxx74IiU+CRIJ4NkW2HkfVGIR26i63yIQ==
X-Received: by 2002:a17:90a:d513:b0:274:9200:3973 with SMTP id t19-20020a17090ad51300b0027492003973mr8047443pju.36.1696238713240;
        Mon, 02 Oct 2023 02:25:13 -0700 (PDT)
Received: from sol ([118.209.204.34])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b00279060a0fccsm6387016pje.9.2023.10.02.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:25:12 -0700 (PDT)
Date:   Mon, 2 Oct 2023 17:25:05 +0800
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
Message-ID: <ZRqMcSffA7V77mqW@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
 <ZRQdQnL5VbX659cl@smile.fi.intel.com>
 <ZRQy795YoPOKsOcz@sol>
 <ZRQ1RpHEapodQ0xU@smile.fi.intel.com>
 <ZRQ60KBtY09uPxp6@sol>
 <ZRqHx+Ihcxor2Jz4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRqHx+Ihcxor2Jz4@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 12:05:11PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 27, 2023 at 10:23:12PM +0800, Kent Gibson wrote:
> > On Wed, Sep 27, 2023 at 04:59:34PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 27, 2023 at 09:49:35PM +0800, Kent Gibson wrote:
> > > > On Wed, Sep 27, 2023 at 03:17:06PM +0300, Andy Shevchenko wrote:
> > > > > On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:
> 
> ...
> 
> > > > > Yet, it opens a way to scale this in case we might have v3 ABI that let's say
> > > > > allows to work with 512 GPIOs at a time. With your code it will be much harder
> > > > > to achieve and see what you wrote about maintenance (in that case).
> > > > 
> > > > v3 ABI?? libgpiod v2 is barely out the door!
> > > > Do you have any cases where 64 lines per request is limiting?
> > > 
> > > IIRC it was SO question where the OP asks exactly about breaking the 64 lines
> > > limitation in the current ABI.
> > > 
> > > > If that sort of speculation isn't premature optimisation then I don't know
> > > > what is.
> > > 
> > > No, based on the real question / discussion, just have no link at hand.
> > > But it's quite a niche, I can agree.
> > 
> > Let me know if you find a ref to that discussion - I'm curious.
> 
> Here it is (read comments as well):
> https://stackoverflow.com/questions/76307370/control-gpio-from-linux-userspace-with-linux-gpio-h
> 

That question looks to me to be confusing how many GPIOs can be
requested per request (64) and in total (effectively unlimited) - thinking
they are the same.
That could be due to their desire to use the gpiod_chip_get_all_lines()
convenience function with a chip with more than 64 lines, rather than
because they have an actual need for the lines to be managed in a single
request.

So that doesn't look like a genuine use case to me - just a "what if I
want to do X" question.  Certainly not something that would warrant a v3
ABI.

Cheers,
Kent.

