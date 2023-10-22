Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812597D2369
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjJVOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:54:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60637E1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:54:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50797cf5b69so3251308e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697986472; x=1698591272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0Ah1cO2lJiXDFUGG0RJnDjIa5urZ8iO5hsK/cwibK4=;
        b=NJKWCVIy51ZTwTHQqF5jfYrcDdZKwkB0KAYLw6tqRg0K99e0Mie6WwsUuRcr95oJrN
         SELDi2/iS9ji6LLDy2QrB2QqtQgEKoJ1O2bW+BxT/ByuWgfcFJ6xDVbVHBTrxpZ96mwj
         MsmzkV4trP/eOjA8omwKwOKCCQ48xLjhxnK9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697986472; x=1698591272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0Ah1cO2lJiXDFUGG0RJnDjIa5urZ8iO5hsK/cwibK4=;
        b=FF2Fb29tfkMe01aZDA2G1WxC9UDNJjs9mrkx0AYkhoU/6vE7LQHLEnuEES8c1jMJ67
         SR6J5gksIk8wCuejC8fhcREiSbOjdU04gm7LUxU9EAeeL9IRlWOg4FNZVFNrp6F75zqR
         Yzbn2BU0gq2+7G1oHstrRDwgmfhELosxn3JviYz4fhrJUV0nNVkxrsPIC2Pk69h/Xqd6
         CmX2c1JlsJs9nTPcCsp7zstCunziVqtcbd6hy7854m5ny2+i/IJQNJq2083dpNKcCCWi
         ItZGbo1gU3KuhIqAZ7Z8mvo1tBkQ0+j/ZwInYoFvgkNi68ltNqSvhFQ83LbmaK/RB06B
         fImA==
X-Gm-Message-State: AOJu0YxVi7ONcaOotUsqcVhDkJO2HVPMqeQueDYwspvFWL8O5U5RhHut
        BZo444yMz3tpdML2hb9aR/CcMrz9JDPHSZILG/wQwQ==
X-Google-Smtp-Source: AGHT+IFy24qtentPMXZwnDtA/0wLXuBFxf7/tATceAYvqb0l77WhH6u/V+SbtMnh8KO4FJTxyjVATQ==
X-Received: by 2002:ac2:42c1:0:b0:503:3644:4a98 with SMTP id n1-20020ac242c1000000b0050336444a98mr4734524lfl.2.1697986472193;
        Sun, 22 Oct 2023 07:54:32 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id k13-20020a50c8cd000000b0053443c8fd90sm4820207edh.24.2023.10.22.07.54.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 07:54:31 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so3473878a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:54:31 -0700 (PDT)
X-Received: by 2002:a50:9318:0:b0:53e:3d9f:3c74 with SMTP id
 m24-20020a509318000000b0053e3d9f3c74mr4973803eda.14.1697986470852; Sun, 22
 Oct 2023 07:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
 <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
 <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com> <your-ad-here.call-01697980674-ext-9589@work.hours>
In-Reply-To: <your-ad-here.call-01697980674-ext-9589@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Oct 2023 07:54:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizgxqjSk7fhyqPuW7Nkt3qwCkr-WKE2DsRu8tK7CC2Tw@mail.gmail.com>
Message-ID: <CAHk-=wizgxqjSk7fhyqPuW7Nkt3qwCkr-WKE2DsRu8tK7CC2Tw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2023 at 06:18, Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> This might work.

Hmm. Yes.

But let's fix __KERNEL_DIV_ROUND_UP itself while at it.

(And perhaps move it out of the odd location it is in now - its in
<uapi/linux/const.h> for some unfathomable reason)

And maybe we could do a helper like

    #define __if_constexpr(x, a, b) \
        __builtin_choose_expr(__is_constexpr(x), a, b)

since that is one of the main reasons for that __is_constexpr macro
(and _that_ makes sense in the const.h header file).

                 Linus
