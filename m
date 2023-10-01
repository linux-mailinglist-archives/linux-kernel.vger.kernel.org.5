Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1424D7B4996
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjJAUae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJAUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 16:30:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FE6BD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 13:30:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso1873794066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696192224; x=1696797024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4UIa9Ejjfrtgzd3sj6bMjsMzc6hS9g1BCxnyrZfaWR0=;
        b=YafTmrYb6wsEwnI8NEKa9ohTMghXmZGR88kn5EVOfXJAzB4zCQSCtcscKtDRw6GQSX
         ImNS5wvLoBMiS0juZldQvA7NpBIVCiYdHWdtOeo3IcFAKxKTQaiHMft+tCgssBafg5iD
         gmV0Rb/inl5R2jfKR+i1GXAHL16nZQ5gGxF4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696192224; x=1696797024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UIa9Ejjfrtgzd3sj6bMjsMzc6hS9g1BCxnyrZfaWR0=;
        b=UJ2rIF+ZoB2+BgYP+dWceLN02R9Df29cEgSPir/hV6UrWSMJ+/ibNLbrzNVFyuztMa
         K8KJ67fuuSIeR46zGKkM3cT4dbogu2jnLOy+fqcmmqKYXKyg7ac3c3d/adXxVit+jWrh
         k0NQjqAu70FLdf0sSJAghCgTSxHaVTbye2lbu29w2VJVS3mR7FiZtXhuNiqkYfm1OOv/
         iUCqPOL7d9m0eVohBL3kITk8Hm0CUTLPLrlMIzmuIIzBR6AvoZW7ET2C0WYwhbjZc8K9
         Ab1k9EJZZ1YlJe6v4wx7mcG0qgUxuRZezzRAP6bs8vrTfSC12W+LLR09ONjyMzH7lomp
         e0qw==
X-Gm-Message-State: AOJu0YxWfU0u1Dws1kjF8LkfWGUXMIvrETgPsYBMiXjVf0dn6x8Ieb9G
        lZRZTWmBJv3dKbRF6TZVrfVwGxGUI2Sx1nNmWenzPQ==
X-Google-Smtp-Source: AGHT+IGr1BIWYwHFTCPgqi6ZaW3wQ7AaGRBo1C/7ztVslEX38Ozh4vF5ZJRQAXk9ueY7+YEysqnASg==
X-Received: by 2002:a17:906:74ca:b0:9b2:94a8:df5 with SMTP id z10-20020a17090674ca00b009b294a80df5mr8799495ejl.35.1696192223876;
        Sun, 01 Oct 2023 13:30:23 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090635c300b0098951bb4dc3sm15619739ejb.184.2023.10.01.13.30.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 13:30:23 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso14496202f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:30:23 -0700 (PDT)
X-Received: by 2002:adf:ec03:0:b0:31f:e1b4:5846 with SMTP id
 x3-20020adfec03000000b0031fe1b45846mr8996993wrn.53.1696192223123; Sun, 01 Oct
 2023 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com> <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
In-Reply-To: <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Oct 2023 13:30:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgycD7=dtGwHEBi8dVyv3Fy2yWzv_bGe9zY0QwTn2BWTA@mail.gmail.com>
Message-ID: <CAHk-=wgycD7=dtGwHEBi8dVyv3Fy2yWzv_bGe9zY0QwTn2BWTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Sun, 1 Oct 2023 at 13:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 1 Oct 2023 at 12:53, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Regarding x86 target specific code, the same functionality used for
> > explicit address space is used internally to handle __thread
> > qualifier.
>
> Ok, that's interesting, in that __thread is certainly widely used so
> it will have seen testing.

.. but I just checked that the __thread case *does* work with my
stupid test-case, so clearly the "__thread" coverage ends up being
very different from something like __seg_fs.

The difference? For __thread, gcc and clang know how to get the
beginning of the thread area (the equivalent of our kernel
this_cpu_ptr() macro), so now the compiler knows how to turn a
__thread pointer into a "normal" pointer, and can just do memcpy.

But for __seg_fs and __seg_gs, the compiler doesn't know how to do
that, and then ends up just flailing wildly.

If the structure is small enough to be done as individual moves, both
gcc and clang do ok. But anything else is just a complete shit-show.

If they both errored out reliably and legibly, that would be one
thing. But gcc just silently generates garbage, and clang errors out
with 60+ lines of internal compiler backtrace.

             Linus
