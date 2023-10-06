Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F27BB2A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjJFHtE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjJFHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:49:02 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E33BE4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:49:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f1dff5298so22269307b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 00:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696578540; x=1697183340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0PtcKDzJDsW5toVlEGvFD3Fant3Vd4B6VHpgV1yH3I=;
        b=CD0fmjATU7bzh7sOBl0nX1VY3R8HJys0xX2y15QPTlkMudSz6fSNUZQId0RXfYm3Nu
         z0V5ycKCtaZTEHhKXV4NJkA/mYX8JqnEF4JOfttWIB4OySPmwndQizJ8ze8pJ2E9G5GG
         t3mEI0o0nqe1NsFXW6Zp52IUnXqcWxEuE8+Fk0h1D3121xjp+X1JNTQyAslUQy9Z//H9
         ASZJAKS2GtLk1/KYJWGmnA9UE+3WmJ/vXorUekwXnci/Y9DRLaLHmxuuPTJ+CrzUWYhc
         Vq0SjOkXhb06dq2Wep07LbeVxQYpucSvzsd8S3JJvmlsRz+GftSkg2MWqIZx3dLUH5Sr
         ByTw==
X-Gm-Message-State: AOJu0YyXwq+3plCWwW/wK9Wlod+I7+mb0F4Dc+BDF6QBK0PFPHkOj+MW
        YYiI8OOnYimPD32js0y1ddaMtADFsZiWKA==
X-Google-Smtp-Source: AGHT+IE7sSFxNA+HNF4+pvDOkgSTcoX+bF2b2XUngc1fkd2caGutDS7R7sUoI6Aq4GyYsso0XLNcsA==
X-Received: by 2002:a0d:e656:0:b0:589:fb69:a4ef with SMTP id p83-20020a0de656000000b00589fb69a4efmr8641884ywe.3.1696578540363;
        Fri, 06 Oct 2023 00:49:00 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id x184-20020a814ac1000000b005869ca8da8esm1103319ywa.146.2023.10.06.00.49.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 00:49:00 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59f1dff5298so22269157b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 00:49:00 -0700 (PDT)
X-Received: by 2002:a0d:dfc6:0:b0:57a:2e83:4daf with SMTP id
 i189-20020a0ddfc6000000b0057a2e834dafmr7779019ywe.32.1696578539932; Fri, 06
 Oct 2023 00:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230925155328.443664-1-arnd@kernel.org> <CAMuHMdWFCSQgsf_0qwdkkAif3zDXM2N-WEymJBa1eeT4N6Ezcw@mail.gmail.com>
 <d5836a46-c614-4270-8473-05c98bbab41f@app.fastmail.com>
In-Reply-To: <d5836a46-c614-4270-8473-05c98bbab41f@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Oct 2023 09:48:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7v-TNV63zrMhFQ62P6zOYomszW7B6VScraszLFj4aMw@mail.gmail.com>
Message-ID: <CAMuHMdU7v-TNV63zrMhFQ62P6zOYomszW7B6VScraszLFj4aMw@mail.gmail.com>
Subject: Re: [PATCH] m68k: asm/io.h: mark mmio read addresses as const
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 9:42 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Mon, Oct 2, 2023, at 15:12, Geert Uytterhoeven wrote:
> > On Mon, Sep 25, 2023 at 5:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>  #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))
> >>  #define out_be16(addr,w) (void)((*(__force volatile u16 *) (unsigned long)(addr)) = (w))
> >
> > Shouldn't a similar change be made to rom_in_{8,be16,le16}()?
>
> Right, these seem to have escaped my regex searches.
>
> > I can do that while applying...
>
> Ok, thanks!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.7 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
