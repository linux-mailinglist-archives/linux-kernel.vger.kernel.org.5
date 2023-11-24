Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688C67F766A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjKXOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:37:10 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132B19A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:37:16 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2D543F886
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700836634;
        bh=cGwg+h1mClEhrndjxPbtDVi24ECb38Vx4CjAfkLm3D4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=v3vTFPOOlaL/HNG3ZOrWVK4s4A1WnV10TEx/wATur3FFJpqxZ82KQQ2W16ocI90Rl
         TcIj6UPfhmH7tZpY8cZV/1rgIfo56kOblVjNmUlyC3AvLgnju4seGrxSvGfzc/CkUe
         oAO5yQN6x2SihBbYvubtdnzQXGGjevyIGoaOl6CF8BjxmqiibbN9T1ChD3PkbgXMYX
         gpZ4jNE6oPfYNnwj83oGh/LGgdUB63IiWPvYcNk1AtMhtWGl2ZK3u2vwE4IFVpTxLb
         pL+oaWfIjNtYyrY7I3JpA/W0wWJp4zXEXTeEuEflgoHINEsN2weFOpV4pHCTG7NzVh
         7bKrcjiF6JqsA==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5032ab59eso17268881fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836633; x=1701441433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGwg+h1mClEhrndjxPbtDVi24ECb38Vx4CjAfkLm3D4=;
        b=gFYwtZc0uo2XyLZvI94H10pBQtTMSeLY0c1tmD3GaQe1xOXn/ofZuIdbddKJmbHaOO
         xkq6K7pZ/zUo9jEGApSq7cZ0dDdqQQtTRimTAfPX3DQsxrDbDt0RckCo2GMwD8UMjy17
         yv5ZcsZEuPSQMh43ZRq6MHWrB7PLGAe/YDXVgH4S0iXIeghtxR0PdD23QQ8hf+Ljyyeo
         /ur+Zr6WmnUO1i3ugcxXPXLBQrVEyD4XH/qRD8LKZrYQgL/JbvSgwMM8/8zVc3muNCSm
         5tsn5KylYUfQx4qRf8DMFB5TaG/QXuq0RfnCB0eGC8+643T2Iu/YGNAHsXMiiZY/Adaj
         uXfA==
X-Gm-Message-State: AOJu0YwspAiQqXE2wa+VwTUmyLV/c7hqUxJI2TA7ZT/UoE1uWaK5W3qm
        VM4C1WZfiicdadOwbgA6+wW/7ZbOLhXQbQOEkzsBNlVJVqSYgXELWEEVK/rG0kuupXELIh5fbez
        47r0Dxmr+cCLSJKnaL0OWV1afBHj2XpdgWtJxeOce8C5/wkkcXfqCqZyUMQ==
X-Received: by 2002:a19:8c42:0:b0:509:448a:d with SMTP id i2-20020a198c42000000b00509448a000dmr1952354lfj.31.1700836633234;
        Fri, 24 Nov 2023 06:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoEfY0eVo4yCOZ1JPppE5or+AtqWrtaMSBx5MO4rxigdVW1Rx/L0Gn01Tvw0h7MYG18AyEEtxKjM4yDYQiFJE=
X-Received: by 2002:a19:8c42:0:b0:509:448a:d with SMTP id i2-20020a198c42000000b00509448a000dmr1952334lfj.31.1700836632861;
 Fri, 24 Nov 2023 06:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20231123180246.750674-1-dimitri.ledkov@canonical.com> <87plzzu1w0.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87plzzu1w0.fsf@email.froward.int.ebiederm.org>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Fri, 24 Nov 2023 14:36:36 +0000
Message-ID: <CADWks+aY0jOq6erApu7i0wNVX3uXPbs=Zj7o3XHPMudOkYyeVA@mail.gmail.com>
Subject: Re: [PATCH 0/5] remove the last bits of a.out support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 06:01, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:
>
> > I was working on how linux-libc-dev headers are shipped in Ubuntu and
> > stumbled upon seemingly unused and useless linux/a.out.h header. It
> > seems like it is an accidental leftover at this point.
>
> How do you see that they are unused?
>
> Are they never exported to userspace?
>
> Are there any userspace programs that care?
>
> Performing a quick debian code search I see chromium, qt6, ruby-rogue, hurd,
> bazel_bootstrap, aboot, cde.
>
> I can imagine all kinds of reasons old code could be using headers for a
> historical format.  Some of them are quite legitimate, and some of them
> are quite silly.  If it is old code like aboot it may be that it is
> difficult to test any changes.  If memory serves you have to flash your
> firmware to change/test aboot.
>
> Because showing userspace does not care about the definitions in a file
> is a completely different problem then showing the kernel does not care
> about the definitions I left them, last time I was working in this area.
> Keeping headers that will never change is not cost to the kernel so it
> doesn't hurt us to be nice to historical userspace.
>
> My quick debian code search suggests that there are pieces of userspace
> that still use linux/a.out.h.  Are you seeing something I am not?
> Do all of those pieces of code compile just fine with a.out.h missing?
>

I will recheck the above mentioned things again, but as far as I could
tell up to this point, is that things mostly use a.out.h provided by
glibc.

Separately, I can do this change in a test-rebuild of ubuntu archive
of all packages on amd64,. as that's the only Ubuntu arch that ships
linux/a.out.h.

As far as I can tell, the legacy userspace access to linux/a.out.h can
use glibc's a.out.h instead. But yes, it would be pain, if code
changes are required to things.

> Eric
>
>
> > Dimitri John Ledkov (5):
> >   alpha: remove a.out support from tools/objstrip
> >   alpha: stop shipping a.out.h uapi headers
> >   m68k: stop shipping a.out.h uapi headers

I think above three patches still can be merged in m68k & alpha trees.

> >   x86: stop shipping a.out.h uapi headers
> >   uapi: remove a.out.h uapi header
> >

And these two need further validation now, based on Eric's input.

> >  arch/alpha/boot/tools/objstrip.c    |  52 +-----
> >  arch/alpha/include/uapi/asm/a.out.h |  92 ----------
> >  arch/m68k/include/uapi/asm/a.out.h  |  21 ---
> >  arch/x86/include/uapi/asm/a.out.h   |  21 ---
> >  include/uapi/Kbuild                 |   4 -
> >  include/uapi/linux/a.out.h          | 251 ----------------------------
> >  6 files changed, 6 insertions(+), 435 deletions(-)
> >  delete mode 100644 arch/alpha/include/uapi/asm/a.out.h
> >  delete mode 100644 arch/m68k/include/uapi/asm/a.out.h
> >  delete mode 100644 arch/x86/include/uapi/asm/a.out.h
> >  delete mode 100644 include/uapi/linux/a.out.h



-- 
okurrr,

Dimitri
