Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5AE7BB879
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJFNCd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjJFNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:02:17 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA70192;
        Fri,  6 Oct 2023 06:01:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59f7cc71e2eso25983057b3.0;
        Fri, 06 Oct 2023 06:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696597315; x=1697202115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0zfspsBQgNn0ppgGjBprJwMwlx+wA4oWVeHq3pcB3I=;
        b=c+dguzeouJCj2OUZ1ebYrMaMSOD3VevN4at7yhBPGI/6upsp68zBuS2KkXGIh4CrdO
         jvsUwWR3BN2sSVxPXyjocg+P049OsuvnZsEmB92FHZrkL9g+ZWkEhubVjcJK5Ei3+hOM
         mTKdt+Aw4dQpRPzBJ3mvzdMXrVz3DEhzaaHLnwbkT0iw1K/QZq4iKTP+D5o7Zw+sD3nG
         +ovJDcQwH7bkSnCwisQYJplIpjgcK3BFd6ePC+qxDL6s5naKIlJ9pZpfOl/yx7/Lnlbr
         6i3DjyAu60f5Mv8iyOjpY2+tIX4T8GOIqLLpEDlf9NC5i/gHCRY4BqrnA005h8S/Sl07
         J7YA==
X-Gm-Message-State: AOJu0YzNz8E+rMzF+sYadpXsT6SyXhPm+P2m587zWtHEM9vr9KGsZlMK
        nLP3DHR9nRxzoEpLqjmVCryuY901cd3w3Q==
X-Google-Smtp-Source: AGHT+IGhL5z43Lx7vqvAl0+pQm3IhKwd1W9WDPj2vDj4Zbfvn3GN3MAFJSiX91l+xTaFehvhmfFMAw==
X-Received: by 2002:a0d:d690:0:b0:59b:eb64:bcc5 with SMTP id y138-20020a0dd690000000b0059beb64bcc5mr8707950ywd.8.1696597314836;
        Fri, 06 Oct 2023 06:01:54 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id f64-20020a0ddc43000000b0059b20231f1dsm1265692ywe.121.2023.10.06.06.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 06:01:54 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d865854ef96so2221055276.2;
        Fri, 06 Oct 2023 06:01:52 -0700 (PDT)
X-Received: by 2002:a25:f309:0:b0:d81:5240:679f with SMTP id
 c9-20020a25f309000000b00d815240679fmr6690046ybs.16.1696597309661; Fri, 06 Oct
 2023 06:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net> <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com> <87led2wdj0.ffs@tglx>
In-Reply-To: <87led2wdj0.ffs@tglx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Oct 2023 15:01:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRsYNhui=Xh6Hmw5OZpG57uLf4y66L9r_wfAHOqn7prw@mail.gmail.com>
Message-ID: <CAMuHMdXRsYNhui=Xh6Hmw5OZpG57uLf4y66L9r_wfAHOqn7prw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
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

Hi Thomas,

On Tue, Sep 19, 2023 at 9:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Though it just occured to me that there are dragons lurking:
>
> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> arch/um/Kconfig:        select ARCH_NO_PREEMPT
>
> So we have four architectures which refuse to enable preemption points,
> i.e. the only model they allow is NONE and they rely on cond_resched()
> for breaking large computations.

Looks like there is a fifth one hidden: although openrisc does not
select ARCH_NO_PREEMPT, it does not call preempt_schedule_irq() or
select GENERIC_ENTRY?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
