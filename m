Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916778BD55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjH2DpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjH2Dol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:44:41 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62829185
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:44:37 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44d56d26c32so1636712137.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693280676; x=1693885476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqcUbH9hIGcnPoS3fppKH8QG8QcyR0eYRS8HblAviIk=;
        b=JBFh+amdqrbu/Quzf66y9HakrHu+BNfwizOQldijq5iu0MxHrSLH/JKWtGme+qVztW
         ouM3HXJKlbilZo9M9ug6xKIw2dp7gF4WTvSpFYh9Pl6ySERj4QDPLi1cVcAYXUvRuZky
         gJGeKsFsvZ9LYo7Td+AA64RjPDnGWFLc2g8u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693280676; x=1693885476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqcUbH9hIGcnPoS3fppKH8QG8QcyR0eYRS8HblAviIk=;
        b=dysCUQjqjKY00UCnKvv/GynG+YyTD5o3R6Cd3Okqk5lFOzxX7CEKKWNdLetbNinDo8
         l0a3cdKmLBH83aLIiqF0hiZqtc2i+ogg2ZUQovmFKMtZqlXOcw+opcP0ZaXc/UOKUkJX
         mlKS4dzG13W+hByUglX/Rqb6M9BMpPYzCP/3Wbb2Pez6tzPXRMKS0APicFB0foJYAfu6
         SgKJ3ybm38CWLpaBukh97QDSJiJSS7aYyLPa6lR/kQngXG4Gw2HW/4fpdGiQtwlE7j25
         xAlZWghdeotmZBoTP4vW2aj0VpUhhRY1ndjcH0e4is1dhtR8IsMyUjYOO9eSFtGQc4aZ
         gNVg==
X-Gm-Message-State: AOJu0YyyLPCC/vhlatfQiv5waJwxttNtpoAvqMGNU5iRUHx5ko+iRsJg
        fP44I4y/HbwqYkFsxEjt140wTQ==
X-Google-Smtp-Source: AGHT+IH6xnH52WG2VxqoPOI/jZVN06R2/o3+lXHAS3sKEu/hsv6mqJaHlxyRsZftHz6U/SPR5Vx2WQ==
X-Received: by 2002:a67:eb0d:0:b0:44d:453c:a838 with SMTP id a13-20020a67eb0d000000b0044d453ca838mr21564942vso.5.1693280676369;
        Mon, 28 Aug 2023 20:44:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qe15-20020a17090b4f8f00b00262eb0d141esm7877457pjb.28.2023.08.28.20.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 20:44:35 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:44:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
Message-ID: <202308282035.5AFD431B@keescook>
References: <202308281119.10472FC7@keescook>
 <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org>
 <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:44:02PM -0700, Linus Torvalds wrote:
> The only thing that is new is the kernel pstore implementation. Why
> was this not a problem before? The warning existed back then too, but
> I never actually got it.

Right -- if the compression method from before was different, it'll fail
now. (i.e. we removed everything but zlib.)

> I get the feeling that you are overlooking that basic fact.

That's why I was wondering about the prior config; it could confirm the
default compression algo. But digging around it seems like zlib is the
default in the F37 kernel config. I'll keep looking; there is clearly
some combination I don't know.

I remain concerned about why there are 124. That's a LOT, and without
prior warnings, I don't know why systemd-pstore wasn't removing them.
Can you send me "ls -la /sys/fs/pstore" ? Maybe they aren't a dump type
that systemd knows about.

I will try to reproduce this with an F37 image...

-- 
Kees Cook
