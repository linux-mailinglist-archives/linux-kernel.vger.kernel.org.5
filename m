Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E177F158
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348547AbjHQHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348461AbjHQHhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:37:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF932D5F;
        Thu, 17 Aug 2023 00:37:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68878ca7ca0so1637366b3a.0;
        Thu, 17 Aug 2023 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692257827; x=1692862627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULKXK6qR5c9VRBpWLFKmezxiq8+/JqbJFDTXkM6zgIY=;
        b=ZtP8zijoeaZNhyrK2BOvwnFcaXAIBBAvfS34UhePeKzkACjxF3wIlN55Mi+h7MTU3W
         lZZHqFb9n0QrLWraMNHQDriu5uAr0Gvc3ACPuk9aTgYUbXMnvE19Pi8Rhibvp2s7lIJH
         Z+BQF0HSMpZpebLNtzB89ea3qhNTGpNFMI0YD73n8Cr1vlqkfymPfz5NK+BQIxDORFJa
         A9NXFaStzLzyFb8/I6KDUOmXD0R1EbgnNdPyJ4BX8102iseWYuFsi4Wjzsdf6XJCKeRG
         SEA0FHF/mLYBomK4PPLpuBwucWIogaqbbwCr0aqVvlS4qSaAVNmnoiYCjlXtseFS23AS
         iFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257827; x=1692862627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULKXK6qR5c9VRBpWLFKmezxiq8+/JqbJFDTXkM6zgIY=;
        b=OGf6IoHSwd8UsYjT98AaZQ3qQh82Iswg2kuW7/l8IsJLcD+LFF5Z8gDCX7kAxE67Ed
         b+TeL0YxCeo+OL2ifb2LjCsEeP2vYmvA65v8SbJRZ22IXX6FJlMOkqFdMn+C0LDZFu2p
         UCklitz4cuYFeh+CuR/x9mxWidiFIY7XVyAEkpGHST2l49LkGSw/kPbAcGYrL/zr+NxS
         Ve+JCQqSHmGpVhLhEN15ZTBeZt20AZajqVQ4yoz7sBzUTpMfkKhXCdv8uNiLN2L7XoMD
         CO8tTHi6HS4Mu3xDTs8tsPssfqfdeo9DW3SJNWlsOxOUnswMyaAs/zZsvjzJcZucn4xl
         jAOQ==
X-Gm-Message-State: AOJu0Yx4csBXrIorN1z5BopdwRnonkz7uTzte2LgMcmDakzhxzNeVxc+
        9oRSDMszS7Xixncrsi2nTXjmBRU/dps=
X-Google-Smtp-Source: AGHT+IFp+VczPYtP3Lkrr7z+0huyXGBRexY3/CrU2WmTcbxAUUtzsgJARGI0oo0f2z2QG2r0NgEyIw==
X-Received: by 2002:a05:6a20:4ca4:b0:12d:f1ac:e2cd with SMTP id fq36-20020a056a204ca400b0012df1ace2cdmr3073766pzb.32.1692257827512;
        Thu, 17 Aug 2023 00:37:07 -0700 (PDT)
Received: from sol ([220.235.36.234])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b00687260020b1sm781878pfn.72.2023.08.17.00.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 00:37:07 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:37:02 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/5] gpio: cdev: bail out of poll() if the device goes
 down
Message-ID: <ZN3OHqzT3grSdefP@sol>
References: <20230816122032.15548-1-brgl@bgdev.pl>
 <CACRpkdaTUi0r+nY12J8sLxmvfG2xRd+OMngcMiQkr5cqerevtA@mail.gmail.com>
 <ZN2k7gemanIpbyFh@sol>
 <CAMRc=MfwK6_m0N4cZqkpMX0Rka4WnWmtKTjq-cwbTR5+sjw9vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfwK6_m0N4cZqkpMX0Rka4WnWmtKTjq-cwbTR5+sjw9vw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:27:37AM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 17, 2023 at 6:41 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Aug 16, 2023 at 11:41:06PM +0200, Linus Walleij wrote:
> > > On Wed, Aug 16, 2023 at 2:20 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Wake up all three wake queues (the one associated with the character
> > > > device file, the one for V1 line events and the V2 line request one)
> > > > when the underlying GPIO device is unregistered. This way we won't get
> > > > stuck in poll() after the chip is gone as user-space will be forced to
> > > > go back into a new system call and will see that gdev->chip is NULL.
> > > >
> > > > Bartosz Golaszewski (5):
> > > >   gpio: cdev: ignore notifications other than line status changes
> > > >   gpio: cdev: rename the notifier block and notify callback
> > > >   gpio: cdev: wake up chardev poll() on device unbind
> > > >   gpio: cdev: wake up linereq poll() on device unbind
> > > >   gpio: cdev: wake up lineevent poll() on device unbind
> > >
> > > I see why this is needed and while the whole notification chain
> > > is a bit clunky I really cannot think about anything better so:
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> >
> > The issue I have is with the repurposing/reuse of the existing notifier
> > block that sends line changed events to the chardev.
> > Correct me if I'm wrong, but now all line requests will receive those
> > events as well.
> > They have no business receiving those events, and it scales badly.
> >
> > My preference would be for a separate nb for the chip removal to keep
> > those two classes of events distinct.
> >
> 
> I would normally agree if there was a risk of abuse of those
> notifications by drivers but this is all private to gpiolib. And line
> requests that receive line state notifications simply ignore them.
> This isn't a bottleneck codepath IMO so where's the issue? We would be
> using a second notifier head of 40 bytes to struct gpio_device for no
> reason.
> 

Yeah, this is a space/time trade-off, and you've gone with space over
time.  I would select time over space.
40 bytes per device is negligable, and there is never a case where the
line request wants to see a change event - it either relates to a
different request, or it was triggered by the request itself.
Is there an echo in here ;-)?

Cheers,
Kent.

