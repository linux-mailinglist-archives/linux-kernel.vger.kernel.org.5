Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4647802A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356709AbjHRARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356750AbjHRARB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:17:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEDA8;
        Thu, 17 Aug 2023 17:16:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdf98a6086so3297005ad.0;
        Thu, 17 Aug 2023 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692317819; x=1692922619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5onGe27PYWXY5feppiX4Og6jliCYrlu5W1AmgdqqR3Y=;
        b=GFPSBJbLg90nHHqIId3Z18W1uROTvrvhOHQ419XIG+kTMz2rEfkp5RS0a19lfH4kge
         w9pUYvMxRyWtuc/ZQ5gIfxDIFhHBX5npNnH4O1q/CwPIH0pnwLfL3qK5SFsRcznRErJG
         7DJHapf6SRwZMyNtK5O2tFTj4U0SU5rxTfFPrNhZ7M8YYOc7N1zShmneiztmGi4JgGt3
         6CnTyO1L4A0swIrDRx6958GQAsWIhhVurFgKyWFrtNqPmYACibv8pJ+2PSHbwtP+XaSD
         tjgLjJzhWfvQKUPWHPB5pgkMfpZ+NOwR3XOgVzXWduYhhGAtb0jOwS8SDV+bgrw+XSI0
         EBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317819; x=1692922619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5onGe27PYWXY5feppiX4Og6jliCYrlu5W1AmgdqqR3Y=;
        b=Ni4y5Zu1bz6KQwC8SCbqkc8PCAvKqLY4+bFIN3oueZdVLsb1Z3rF4Jypj3uGR0Bazl
         Ko4UhmRfLzCGpHs3JeOQiDXvzu32DXR5d9E2ajJ755k7oh0hm4ZhJrRMqomgKtc0sh/r
         1rSAt0Q0kaWSA4oQe47C/RYbGyEeN7X8ohqQrzsA+1pv67KCDamjvjNnLztSKd9qL9fu
         UNhqbY1oX5or4Xwf3M1aCqcuvDliDzM0xToC6H+stL4nctOjkayuwZHVZVgOnhzEcd3E
         ZQA/MasURJRraz1nsKnEsd9Y0hNZzcdHvtqZqe3GXzgBXJh8EfobFKDnAC/Rn2GudBA1
         GNuw==
X-Gm-Message-State: AOJu0Yw4N8qU502jja1xP38EKT2jawYE2ZfWXfP2MoIKGdh/GbJ+4+X4
        7CUtdhKeZk0F0O9nT7s+thk/cp91P+4=
X-Google-Smtp-Source: AGHT+IHwlqZvwQsAcMSZDc1ZWl4BMT6yk0u8koWEIxhKqVkD6/vj9zdqSJpcMKswFKKzRhcxmsRUVQ==
X-Received: by 2002:a17:902:ee4d:b0:1b5:64a4:be8b with SMTP id 13-20020a170902ee4d00b001b564a4be8bmr998634plo.35.1692317819256;
        Thu, 17 Aug 2023 17:16:59 -0700 (PDT)
Received: from sol ([220.235.36.234])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001bde12178b4sm359188plj.33.2023.08.17.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 17:16:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 08:16:53 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes
 down
Message-ID: <ZN64daYL7xVgo5wS@sol>
References: <20230817184958.25349-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817184958.25349-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:49:52PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Wake up all three wake queues (the one associated with the character
> device file, the one for V1 line events and the V2 line request one)
> when the underlying GPIO device is unregistered. This way we won't get
> stuck in poll() after the chip is gone as user-space will be forced to
> go back into a new system call and will see that gdev->chip is NULL.
> 
> v1 -> v2:
> - not much is left from v1, this time we don't repurpose the existing
>   gpio_device notifier but add a new one so that cdev structures don't
>   get unwanted events
> 
> Bartosz Golaszewski (6):
>   gpiolib: rename the gpio_device notifier
>   gpio: cdev: open-code to_gpio_chardev_data()
>   gpiolib: add a second blocking notifier to struct gpio_device
>   gpio: cdev: wake up chardev poll() on device unbind
>   gpio: cdev: wake up linereq poll() on device unbind
>   gpio: cdev: wake up lineevent poll() on device unbind
> 
>  drivers/gpio/gpiolib-cdev.c | 101 ++++++++++++++++++++++++++++++------
>  drivers/gpio/gpiolib.c      |   7 +--
>  drivers/gpio/gpiolib.h      |   9 ++--
>  3 files changed, 94 insertions(+), 23 deletions(-)
> 

I'm happier with this version.

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
