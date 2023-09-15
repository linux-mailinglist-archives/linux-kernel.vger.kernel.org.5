Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21737A2440
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjIORFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjIORFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:05:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450592700
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:04:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso2239136f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694797469; x=1695402269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygwFlgRkW+SZwTXzXvL+Qfa5clStUbHzlN7b9EM5/oI=;
        b=EkebDpzU39nqNQej7wDQruu43J5sZzmve9qGE3xTEMhYOn+hiV/EJKphw/uy7sJcsp
         AdYJ9Dvt9OYnGTb7G/djghZCtx8VzdyHHef/mLIbPncaJdtZhPEzFJG3YEjp8fXgsVHb
         wNBXFbnnSuzGncI4VCFFVyx8niYn/MTWvXlmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797469; x=1695402269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygwFlgRkW+SZwTXzXvL+Qfa5clStUbHzlN7b9EM5/oI=;
        b=XIMAoIBz6+TQ3LjwegOHHbUDkNpC7Pn4rmg2jZTvh+mXGX2Pj8shfK4ae3lGiXgt2X
         BYayXMje9xgNPitOcNrlePNfwiWQe7wcSVa61ON9OGfROH6ANLKL3U3iOSMRu7OYwIWz
         PmAdvfxJyd1v9n61yp4vRajj7pHZhlTXa81gNcbbTAOzWKto+ote/UnAeL9XP1gWbwse
         kAGcfUUkBK8RB4OMU99n5nze+YXdJRUYdlVKPL4b9a9xFxnXfj3OAjTyZTXFsLNl+oA9
         QbZR5TZmSXi7P+GQs5PVz98YW4oNzO/HRZh7SmDWzeAbbbQRhsu9bWlEM51h9Y7vnrWO
         2XvA==
X-Gm-Message-State: AOJu0YzIp9QzoqN8HAUJvf9VKJ3cqs0PLHrfbMqsWFNJz1yYg+6fcm0D
        RQZVZJ1JEjclqHRjHyjPRfXuvezYiRRANEzzdzSwpbaH
X-Google-Smtp-Source: AGHT+IFFFRdVdKvBSV5l4T1qtpdH6HpkqAY+nTo2fJdbXzoOi7/idUsHte33iI9/4XPVDpV8sBsJcw==
X-Received: by 2002:adf:ce11:0:b0:31f:edca:b8d8 with SMTP id p17-20020adfce11000000b0031fedcab8d8mr1772984wrn.13.1694797469343;
        Fri, 15 Sep 2023 10:04:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id w21-20020a056402129500b0052c9f1d3cfasm2515538edv.84.2023.09.15.10.04.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 10:04:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so2869741a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:04:28 -0700 (PDT)
X-Received: by 2002:aa7:da03:0:b0:52e:1d58:a709 with SMTP id
 r3-20020aa7da03000000b0052e1d58a709mr1618992eds.40.1694797468151; Fri, 15 Sep
 2023 10:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
In-Reply-To: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 10:04:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
Message-ID: <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 02:56, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> __free() got some usage and some of the usage is buggy:

Yeah, that's sad.

I think the '__free(kfree)' thing should *only* be used in the form

        struct obj *p __free(kfree) = kmalloc(...);

which is what our docs mention. Anything else is simply buggy.

But how do we *notice* this?

I do want to stress how I was unhappy about this conversion to begin with

    https://lore.kernel.org/lkml/CAHk-=wigZt6kVkY0HU1j_LJ5H1KzwPiYnwwk6CbqXqT=sGenjg@mail.gmail.com/

but I reacted to the wrong issue.

This stuff needs to be done *way* more carefully.

              Linus
