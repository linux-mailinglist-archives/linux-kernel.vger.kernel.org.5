Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7B7B3D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 01:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjI2XoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Xn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:43:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71DF3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 16:43:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so112314905ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696031035; x=1696635835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxXRgVO4X0oKRg65wlMjf/8hMDTc8L5/nBKtcjEkozU=;
        b=Hmj/u6JX3APrdAtp+lWft1v2b2K7cwvLYfnu+z8b3s1WYhckbuHMr1IBmkzPir84R3
         OAavnQIx9fgd/xcemBXRDE/upbNAdSLRlMyRXMsxKRzbg/ZLzjopNvNYTGqGeiPnE0in
         MNE9wzIU6E9nvj8sf2u8oxRs7Br/+50ZuWb9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696031035; x=1696635835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxXRgVO4X0oKRg65wlMjf/8hMDTc8L5/nBKtcjEkozU=;
        b=ulb6O+uL9iuq69nM+c/Z/bmejDttbHODBA8FUj/rkMC7EkMwRhgjfkmWd9IPHqmg74
         YfAxVLD3MjEpoVMClVYEAsucCgE5vEXGrhCAlPqa1G5GllD3qgx8x5pGms7NGOtQsaw4
         ZNx21MniwKGdzZWWly6nKijcW3fX9iky8PEMYfY211if3+YmrtQj8Ooqr3Z6PF6flr3H
         3/z9TAoOVWOAcztCJ3m71w5BcY4kG9NM3jBARQHj9tDa2JUF1ZdXxVWfRZCOtxE/bufj
         RIVTnDf6APvKAF8gIOcNyYKJiAX6ExwUCGm9SzR4FQEQ6rgCGvc8tESQXlKMy21H5rYb
         zGuw==
X-Gm-Message-State: AOJu0Yz60ejuw7Mo8hEH+n+GZiaLpxHOV5BBO7nTC91o9Jg3dhES5w76
        ldyAK33WJ3ZYdUl1vhsMBHrIzQ==
X-Google-Smtp-Source: AGHT+IFoyjufbN/+tXciMnWrLm1gtDSKSS/anCouRumZaJShGMHHhX6IW7ptFVzMTxsQrVkg++m9jw==
X-Received: by 2002:a17:903:25d4:b0:1c6:112f:5d02 with SMTP id jc20-20020a17090325d400b001c6112f5d02mr4765528plb.55.1696031035416;
        Fri, 29 Sep 2023 16:43:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c5076ae6absm17466616plg.126.2023.09.29.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 16:43:54 -0700 (PDT)
Date:   Fri, 29 Sep 2023 16:43:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md/md-linear: Annotate struct linear_conf with
 __counted_by
Message-ID: <202309291643.BF67044DA@keescook>
References: <20230915200328.never.064-kees@kernel.org>
 <169601526973.3013632.16756928162777602693.b4-ty@chromium.org>
 <CAPhsuW6RfCryssufHjWHRdUGCh2DywnNNtidZ-UxEWvwo4gcbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6RfCryssufHjWHRdUGCh2DywnNNtidZ-UxEWvwo4gcbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:40:13PM -0700, Song Liu wrote:
> On Fri, Sep 29, 2023 at 12:21 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, 15 Sep 2023 13:03:28 -0700, Kees Cook wrote:
> > > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > > attribute. Flexible array members annotated with __counted_by can have
> > > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > > functions).
> > >
> > > As found with Coccinelle[1], add __counted_by for struct linear_conf.
> > > Additionally, since the element count member must be set before accessing
> > > the annotated flexible array member, move its initialization earlier.
> > >
> > > [...]
> >
> > Applied to for-next/hardening, thanks!
> >
> > [1/1] md/md-linear: Annotate struct linear_conf with __counted_by
> >       https://git.kernel.org/kees/c/9add7681e09b
> 
> Hmm..
> 
> Jens pulled this into his for-next branch and for-6.7/block branch
> earlier today:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=e887544d7620f1d3cef017e45df7bc625182caff
> 
> Do we need to do anything about this (drop one of them)?

Whoops! Sorry, I hadn't seen it picked up. I'll drop it from my tree.
Thanks!

-Kees

-- 
Kees Cook
