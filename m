Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F181129E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379167AbjLMNRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbjLMNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:17:46 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36322AB;
        Wed, 13 Dec 2023 05:17:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c210e34088so5643593a12.2;
        Wed, 13 Dec 2023 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702473472; x=1703078272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KhFWIv693FrFNXy1wxTzy6P4wGplYo8sfcTZnDhyq0Q=;
        b=BCF2fxchDLFaNB21/glU/Ncw92and6asYPqoZr8XNrM6gf6yckeY4ht06cGY8Dr47e
         DcYBJ3ApVfw3PRNqVd7//GbZ1RVYl+kFZ/V/5Zj0AeNk8a3Hn5gNr4KF8iWv1sQSWSlp
         8oDvtkwJHt3ssqChotYQy68sCIAzdL3KrHmX5ILqIEgjuyNPPTfDYuwHSCAyVQ5hPpb4
         WK8EnWWpUFWT0B5kABN3wOoG4pQJojySri/QWJH4g6UY+yoXoSq8DqM/m+HcMy6dxcHx
         w9WUbJMf9F94ZqYeTJFz1hfZYW/O4hJc3XhxWvFXY+IKcKBBQkJ3K8tRbb9NygRtFgLw
         TTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473472; x=1703078272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhFWIv693FrFNXy1wxTzy6P4wGplYo8sfcTZnDhyq0Q=;
        b=T/kRzON25UUvcv3D0zK+FvIeqZIykkEPhP0BXClDkKMPd69TI+BlfM336DFWgExxCa
         NYedg14gFLewgK+LbG8uXw3jvf1Bn77kbxM4GDQFEgTw7Z9whXidwgZGaOZIoNUQUn+r
         kHJDQjjSOEWHRkNDn5xeCB3j3ysCbvSLE7Pg4/e+O5IG3qmqLe9AYDKHj3eJLkzT+7/J
         TltffURv3lpBgbaMfgAm14R2QzFUJyiHyHOcKUjmLqS3n3ppPumBFAdt4eA/HhKCKGf3
         TZavWfaKsDOkbifZkvhT7K2mzJg860qtCENDcZBus+6wqjwMMMnE0l/cP2mvf4YgKMIl
         Z3xA==
X-Gm-Message-State: AOJu0YyV6a68tRI82PvsRcOQwEhakrqx1xiheFRFeweJ/qmh8GVIMaWb
        9CIsV1QkOrXvIrzCAt517cM=
X-Google-Smtp-Source: AGHT+IGB8hDFzv/mvPiYgA4wJj6Y5z2/GSEOWmS28c/9doXtxeXFg0BxZMGuFdkzdD3stULDwa4u0A==
X-Received: by 2002:a17:902:e54b:b0:1d0:796c:b06d with SMTP id n11-20020a170902e54b00b001d0796cb06dmr9321996plf.7.1702473472506;
        Wed, 13 Dec 2023 05:17:52 -0800 (PST)
Received: from rigel (194-223-186-106.tpgi.com.au. [194.223.186.106])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902759500b001d326103500sm5243110pll.277.2023.12.13.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:17:52 -0800 (PST)
Date:   Wed, 13 Dec 2023 21:17:47 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH 0/4] gpiolib: cdev: relocate debounce_period_us
Message-ID: <ZXmu-2AB0s-T5pF9@rigel>
References: <20231212054253.50094-1-warthog618@gmail.com>
 <CAMRc=Me90Lu7Duc8-4xSfDcHQd6M7+0t0O8FAa6jiizp-OO5=Q@mail.gmail.com>
 <ZXjzjOtKFoMRhKA-@rigel>
 <CAMRc=Me1czOqnJUG3sth6kZh=G+iXAHp7HHL1u-Oy3=MwkCPug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me1czOqnJUG3sth6kZh=G+iXAHp7HHL1u-Oy3=MwkCPug@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:03:40AM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 13, 2023 at 12:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Tue, Dec 12, 2023 at 06:09:00PM +0100, Bartosz Golaszewski wrote:
>
> [snip]
>
> > >
> > > Patches 2-4 look fine, I was about to review patch 1 in detail but I
> > > thought I'd just throw this one in here before we commit to a specific
> > > solution.
> > >
> > > For some reason I thought this would not work but I'm now considering
> > > it as an alternative approach: is there anything wrong with adding
> > > struct kref to struct line, allocating it separately per-line when
> > > gpio_chardev_data is created, referencing it from struct linereq when
> > > the line is being requested, and dropping the reference from
> > > gpio_chardev_data and linereq when either is being removed? Other than
> > > the increased number of allocations?
> > >
> >
> > The collection of struct line always has to be global, right, as both
> > gpio_chardev_data and linereq are ephemeral.  e.g. if one process requests
> > a line and another checks the lineinfo, those will have distinct
> > gpio_chardev_data.
> >
>
> Strictly speaking at least the supplemental info has to be globally
> accessible. But I get your point.
>
> > But the key issue is that the linereq and struct line lifetimes are
> > strictly tied - a struct line does not live beyond the containing linereq.
>
> I was thinking about decoupling one from the other actually.
>

I was also headed down that path - making the supplemental info for each
line distinct from the struct line.  But then I realised that the lifetime
is strictly tied to the linereq, as per the struct line, and there was no
benefit in a separate object - just more overhead.

Cheers,
Kent.

