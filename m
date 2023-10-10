Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFD7C02C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJJRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJJRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:32:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8793
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:32:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso1017600566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696959159; x=1697563959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgTrmYAWPAtaolxXsvRAmFG1qzvhKpew3qaaETwLwaw=;
        b=JHODYA266mdM/OlhX0VvEtrB0/AoIA7cgiqAGy6FajWfhMRG4EY96GkzAxUPTZ8lC6
         MaH8dBP/oBPx+phQriY++OaoOdMfXqpDZLLE2a0QE05aLQEWv4+7d5FHg55lWCixIP40
         ZjV9BP/DBGC33Z4kO7lSUdD8iz21+0kVohMbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959159; x=1697563959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgTrmYAWPAtaolxXsvRAmFG1qzvhKpew3qaaETwLwaw=;
        b=RylYmGlkVPtWt6/T6Zxwl4HkS9WLCUi2dXZlegJGHY2jeQ/nRjXHG1B2hE9G+KoIMv
         E0eadSau/Ka7XwZjLGryGrTi4oe2wP0sttmjeANb93EjKaBEQy8BVwlJcK7IUSBglj1G
         IVnl/M66qM4z/iPoE4FMGs1SkT9gMD3Uo6NBD0WHrOLK1RA3qwtw18T0abpd4VQbL9zj
         ybXr6AixKQM3U4vmfTG967vHAjpPboah8D0ZAenShLTEtsEBVpuuQuSUnXCWzj0vHTHP
         brF1NhCEXjmuXihGc60nB964f0DvFmUlbZ7o0/uRNOOQvrViO66NQYUG16CAGYR7EdV+
         ci8A==
X-Gm-Message-State: AOJu0YzFyxOTR1BwvBf3WUSFEZmCy2yWFgDnCOWLllJSp6QXnij9x2MN
        Lu3ImsOvEyve5Re7IRFp6Pdd6UmvW7f2K03kgO+RDqDb
X-Google-Smtp-Source: AGHT+IEt4sJYtbCMzZEOFhV3rmIjTqmHuOuDxvW+I1YnVxLIm2YKG259sU90YTPIcU7346ANR3oWgQ==
X-Received: by 2002:a17:906:76d3:b0:9ae:65a5:b6f4 with SMTP id q19-20020a17090676d300b009ae65a5b6f4mr17578201ejn.20.1696959159444;
        Tue, 10 Oct 2023 10:32:39 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906289400b009930042510csm8658686ejd.222.2023.10.10.10.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 10:32:39 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so10285048a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:32:38 -0700 (PDT)
X-Received: by 2002:aa7:df86:0:b0:52a:1d9c:83ff with SMTP id
 b6-20020aa7df86000000b0052a1d9c83ffmr17044118edy.1.1696959158578; Tue, 10 Oct
 2023 10:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com>
In-Reply-To: <20231010164234.140750-1-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Oct 2023 10:32:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
Message-ID: <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 09:43, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Implementing arch_raw_cpu_ptr() in C, allows the compiler to perform
> better optimizations, such as setting an appropriate base to compute
> the address instead of an add instruction.

Hmm. I wonder..

> +       tcp_ptr__ = __raw_cpu_read(, this_cpu_off) + (unsigned long)(ptr); \

Do we really even want to use __raw_cpu_read(this_cpu_off) at all?

On my machines (I tested an Intel 8th gen laptop, and my AMD Zen 2
Threadripper machine), 'rdgsbase' seems to be basically two cycles.

I wonder if we'd be better off using that, rather than doing the load.

Yes, a load that hits in L1D$ will schedule better, so it's "cheaper"
in that sense. The rdgsbase instruction *probably* will end up only
decoding in the first decoder etc. But we're talking single-cycle kind
of effects, and the rdgsbase case should be much better from a cache
perspective and might use fewer memory pipeline resources to offset
the fact that it uses an unusual front end decoder resource...

Yes, yes, we'd have to make it an alternative, and do something like

    static __always_inline unsigned long new_cpu_offset(void)
    {
        unsigned long res;
        asm(ALTERNATIVE(
                        "movq %%gs:this_cpu_off,%0",
                        "rdgsbase %0",
                        X86_FEATURE_FSGSBASE)
                : "=r" (res));
        return res;
    }

but it still seems fairly straightforward. Hmm?

             Linus
