Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5407AAAC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjIVHum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjIVHuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:50:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55382FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:50:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6586739cfeeso9062426d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695369031; x=1695973831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8IjNtHtQv+1LrNf3EaPvoTWjbGccdREsCK+hvIYp0r0=;
        b=HuuptYykEgawEYs2KupWH+5HoTaqw/CZ+uaSR97rEBm7M0mXjWC55DdzJVSBfxJDGr
         G6v5V5+ytCyUrcpTK6oXOP7YNsjtJwx3e3l9NYKEZPwIAUtiMUXp6CUrUpU5JxiVQ9TR
         XHF2uv4boaHRPUrKi3cisL+vpPe/IZeon/jS036XQIeJfwtxCwcE3ZJwHdQk2cIW0Eli
         x8CzIfFLZc8diH/MlzjP0g/GVJfN/j7nEeSjiFO02Whote2I+ZcbVeSSLQfbzAsPK/0l
         8bu/ZpZYtcjtNaeEpYNsaHuu6eMIZgqZUaPVxL6DM1TAjYwZZaIMpuQA7br2KUYbn8Ny
         5K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369031; x=1695973831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IjNtHtQv+1LrNf3EaPvoTWjbGccdREsCK+hvIYp0r0=;
        b=jmeYocxnOVijjXFL/MBss5FhuElZJnQUNjXapLfcGrHuy9KKkS1zjDOQspuF9Xo/WT
         Y00J+Iq1ez7NN5sRg2BCJeluR+DplzYCgBClGavdzuyZE/DR5gb9m/ojX8HQIIXNSCQV
         iaDqsQjIkAaFvQD5FOPgpfkeWQ0X1W9jvEXfTITrIorogCRjVt2UFwStKjk0Ves2IFgC
         SK1ZIkXo0YHIBcMf0TGJQitIfgDL99nAEmye8wLoVb5zcPu341ytW5Myr5rHnd7HdE9D
         cEDnbmXQ4FNp6N7skOJkyLX9jwMgC2e0H4er183u6zw+CR7Z4Xad6Y5cIMzs6L0FKtAS
         46Mg==
X-Gm-Message-State: AOJu0YytG0yeVFf7rQz9mY0xCVaZFBrT9ITXZFL1KZZJGoo46tvP1wnM
        KSuA+lLTZWfdoat09g/mSNxmVzcuQw+tgjcLzNG6cg==
X-Google-Smtp-Source: AGHT+IFMsKR88GCyuYV7PS69SbQe1IC5OCAQJo3R0UV/mBBlV1Y0m9d7lKn+vt77gQiC0J1KjKsKDTcZsxWT+pv6Pog=
X-Received: by 2002:a05:6214:4b04:b0:658:4fbc:6938 with SMTP id
 pj4-20020a0562144b0400b006584fbc6938mr7156233qvb.42.1695369031363; Fri, 22
 Sep 2023 00:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad> <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
 <ZMG29WmwQFVgTSCv@yury-ThinkPad> <CAG_fn=VrPJj6YowHNki5RGAAs8qvwZpUVN4K9qw=cf4aW7Qw9A@mail.gmail.com>
 <ZM1XlUbAJ7Qpd6OO@yury-ThinkPad>
In-Reply-To: <ZM1XlUbAJ7Qpd6OO@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 09:49:55 +0200
Message-ID: <CAG_fn=XH3KSpM6nD6kCs6ZVsv5irqih8dK-X0EnnMAAQkEKGXg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK. Can you put a comment explaining this? Or maybe would be even
> better to use BITMAP_LAST_WORD_MASK() here:
>
>          mask = BITMAP_LAST_WORD_MASK(nbits);
>          value &= mask;
>          ...
>          map[index] &= (fit ? (~mask << offset)) :

I changed GENMASK to BITMAP_LAST_WORD_MASK here, and I think it's
self-explanatory now, WDYT?
