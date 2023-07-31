Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8174F76A11C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjGaTWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjGaTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:22:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3FF198
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso706147966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690831344; x=1691436144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3GQbdwLvcWtVcLzrtdmftkuTA3BSuGTxKC7dfPWmfo=;
        b=Ts/6yhyqbGiFW6aCwX48VhZ546zZwJzTk0QWiW1b/29V9ehDjGb4pzasYuzFtBQapf
         J/Vj3r7Pb/F8iPylZLMZyNLV10iVdCnQVM6AoQFGhHbNouNu5gfFXB2M6yuNXTplFhDU
         NGVM/J5K+gCeXnRWR1Hb+JwBKfxwoQfOjSqoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831344; x=1691436144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3GQbdwLvcWtVcLzrtdmftkuTA3BSuGTxKC7dfPWmfo=;
        b=aHeFvyNSJjyS8jUVETc0/Cv2iSUrToVBl8cYra97eTdhe9ikMfZ8yIzKbrdBumztJ4
         zMmU4PL8dcGFiVhZjFNm9dCvnq+zQSrKtwAXtFgWMPUoURNJq3LudR5wkc7uDFTHNwIa
         ABZgJBlKHouGeSEYy5Nlt+VgrWJcNlOsKr8ZO93S5urX1xS/Ub4Dwhbbq7sS952Me7N5
         7Jk/tajFEUGV3dIFAuCVM9BG78KTdTc2o+/OMGqK5OQsVg+y6nbRJWHFI+VtuhR/Y2py
         kwvX/BQ0uFL3fxbDsS7rQO1UVcvsw7ESxogWNEAeLR4rjZAP2WyY6qYQxSJp8n4GSpuG
         QqSQ==
X-Gm-Message-State: ABy/qLbKcNVauBxUz/dC8fioyr6Xhp/A49KWj9xbO/r32iVXyT/UmV+q
        6C4yZcL+zmWzPob6ydHEkxWA4Zs8elJiIp7XbcE1gJmt
X-Google-Smtp-Source: APBJJlH+HIKPDECmEagMdf3mHFQAhoS3rDe5czr+CSSvE6wKCUUgt+qlTCZRPzRYC2HA4R7tzT0AGw==
X-Received: by 2002:a17:906:2009:b0:99b:e04d:3079 with SMTP id 9-20020a170906200900b0099be04d3079mr546193ejo.19.1690831344451;
        Mon, 31 Jul 2023 12:22:24 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709063c0f00b009929ab17be0sm6567812ejg.162.2023.07.31.12.22.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:22:24 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so6361416a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:23 -0700 (PDT)
X-Received: by 2002:a05:6402:406:b0:522:3a37:a463 with SMTP id
 q6-20020a056402040600b005223a37a463mr700776edv.20.1690831343614; Mon, 31 Jul
 2023 12:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org> <ZMdu1YqUI7VIEq1y@alley>
 <CAHk-=wiJSzSkF-FDcHydR61Q3_q4xCiqq37tfXdijaCxsDF86Q@mail.gmail.com> <ZMgIF_6zCqB0LfjN@slm.duckdns.org>
In-Reply-To: <ZMgIF_6zCqB0LfjN@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:22:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGmV6x1brPoROABozj99hrKo031qq8F8K9Mjx2FC6nfw@mail.gmail.com>
Message-ID: <CAHk-=wgGmV6x1brPoROABozj99hrKo031qq8F8K9Mjx2FC6nfw@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Tejun Heo <tj@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, Dave Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 12:14, Tejun Heo <tj@kernel.org> wrote:
>
> PAGE_SIZE is easily available through _SC_PAGE_SIZE, so that particular one
> is never a real problem (and a lot of tools have pre-defined helpers for it
> and similarly important constants) but yeah there are other constants which
> I sometimes wish were available through debug info.

We do have that

   scripts/gdb/linux/constants.py.in

thing. Which seems to be the logical place do deal with this all.

That's where other - and arguably much more fundamental - kernel
#define's are dealt with.

Now, looking at the particular constants that are listed, I get the
feeling that the people who have done that script may be mostly
interested in filesystems, but I don't see why it wouldn't be
appropriate for the workstruct stuff too...

                  Linus
