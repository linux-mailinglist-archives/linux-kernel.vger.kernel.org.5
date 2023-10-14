Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5657C9427
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJNKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNKkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:40:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F148A2;
        Sat, 14 Oct 2023 03:40:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27d18475ed4so2343280a91.0;
        Sat, 14 Oct 2023 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697280037; x=1697884837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RsEJAoB1Qb/L92tv2phSqn46dfaeLgIJxNBCdJ4gMks=;
        b=RvjVr6q/UoGfB7ORu4qohM+VvKWY+jmcqC1apIl9Vc3/ONpRW9PwY2LoGBGioCCpDd
         62ZBgXnk6AsbpIiYC3Yf9xvvAyAcTW/k7nYvSAKq5/O5/JDESQvhVJZntCCow6kBYAZu
         0wYUG5iNZZzWcOoPuM993UKQ3AUGqVqjqBx9QqCflYMQ94gDIj6rs2NhfLjFfXcMXkRl
         /IxYmYnvtXp2zqrv6NxA8CiERXlUvIVJGY6gzRe3vJiOjSH4jAfN/5eViC0lqSA05vzV
         h7DZeg9DgEiQlM0cA4WI0VXvser1yTKqh9P1jgifXQR4TcTW5xDIoJT9uCPd0HZ4rOZr
         kxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280037; x=1697884837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsEJAoB1Qb/L92tv2phSqn46dfaeLgIJxNBCdJ4gMks=;
        b=GfdD/yvhmHstO4WCD1tUUe958tfKysPX0T0q9JfAO/LrgEeL+YK063EafV6a31XbK4
         RupPfNdqxS7aqo5v5IZEAdjUOtCpB26z+Mui30QDsIayYvSv7+JOq1pfENqiQUXLqJP0
         +ILi6xJ1lEc4H2qh0JebGQtdMgQIrEXBlgMIe1vfHwW7g2e3vC3CUv5CQSE0iUq6gbOV
         dhPDgIig24biTOt7+yYoGeChm1FUouK/58V41hiwXrtV6gJF8HBPcU6V4XJFt5QMxps6
         4CimM9cTB2sGVl+01tgKFmb6WhfgMNh8EQBc1w02TvnJzO1MiJw6mRvvCiUAK89aGXZH
         oKXA==
X-Gm-Message-State: AOJu0Yzn5ClHJDgCuD8yFqvLEZSEVZgzHAmGf9bauS170vs3W0dco/v2
        i7/8j5Jo9Bg/CwwwS80t3lOEa7QsFMC/vmfcmpeG4/muvle4Fg==
X-Google-Smtp-Source: AGHT+IFA/YYnKLf36i95N15KnB5iclDMFAXzmT1gJW8fxoe9ZKmb+sns4VORsK1gRUeQYIMAXQ8/zplWPGF3CeO67RI=
X-Received: by 2002:a17:90a:11:b0:27d:5616:9907 with SMTP id
 17-20020a17090a001100b0027d56169907mr1232357pja.46.1697280037450; Sat, 14 Oct
 2023 03:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230930203646.61863-1-bergh.jonathan@gmail.com> <2023100133-exclusive-boss-edc4@gregkh>
In-Reply-To: <2023100133-exclusive-boss-edc4@gregkh>
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
Date:   Sat, 14 Oct 2023 12:40:26 +0200
Message-ID: <CA+MPq=UFbAmuq3rZN0FFNAEdNj3Ju=vLE8wR_ToW3W0bVoxskg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: usb: Fix block comments whose trailing */
 was not on a separate line
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 08:06:06AM +0200, Greg KH wrote:
> On Sat, Sep 30, 2023 at 10:36:46PM +0200, Jonathan Bergh wrote:
> > Fixed various instances where block comments trailing */ where not on a
> > separate line and should be.
> >
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> > ---
> >  drivers/usb/atm/cxacru.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)

Hi Greg, thanks a lot

> Your subject line for these patches is not correct, please fix up.

Thanks, will do.

> And the patches are not properly threaded, what happened in your email
> client?

Ok thanks, I used the same process as last time but will check it out.

> And finally, why make coding style changes outside of drivers/staging/?
> Did you get the maintainer's approval to do so before taking the time?
> Usually most maintainers do not want these so always ask before doing
> so, or just stick with drivers/staging/ to learn how the process works
> first please.

Ok! Thanks! Would you like these patches? I'd be happy to resend
them. Hopefully (like the guy you mentioned in your talk) unless they
screw something up, are seen as making a (postive) contribution!

cheers!
jon


> thanks,
>
> greg k-h
