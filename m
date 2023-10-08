Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F07BCF7A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbjJHSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjJHSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 14:00:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBCFA3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 11:00:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso4789409a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696788001; x=1697392801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gYm8WKdYe1rvZQ8btuzLZ+Hp15ywPLpv3nLFBvt4dEE=;
        b=CIKDDnLh4DbRPd85YGRdSEpl8B1ptGT83n1AaDrCsRu75v6aWw/wttxaTxmYOl/Gs9
         5M4noT4tNAN3p33WDob+8LTuAyGcdCRc7o0ozJJ5A3ASvx2UVmNUEqtvI1O6lOodMBC4
         qh/9ENfZUbnFQdh7o2Pq/2lNMe7xuoopiZAR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696788001; x=1697392801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYm8WKdYe1rvZQ8btuzLZ+Hp15ywPLpv3nLFBvt4dEE=;
        b=Gm32i5zmelGueP+cCFM+JjWKNRg+ZSSdPREwlhsxa1pwPakkMeWiDg8PEFPYa6ug+a
         sNyU6/VojVrK4ZvPlmAP9cSpTdQ8KDkYXu7ZzNF6Ujgay4Fsis1jf1txk6QErJ/o5E0h
         YRjf/fVjE6TstdvwV3IftWBJiaABzEz2+pri7su8rxcaz7CJQPX9D8fIUc8HZc98GeVg
         6Mc50jttdm+k6N9FAdzNUJ3rDnKTrvmIdkEnX6QpbsZ1G1atx2EhN/cVC9NVNv+DM29d
         NjI+4aY9nQe8JlxakarR/KbHuhiiBXMWgtdNZbRKnNZ/DcDkbF/EKTBh2yxzjqYfLKcI
         QRhQ==
X-Gm-Message-State: AOJu0Yyo6LV9BI3vBSAbb1whq3in7GlkrFyw7pGT93EGIbRTqjUNvpRi
        uJTE52yOYoVnvLb9W/G6/j1wZm/WVE2kRaprU6cjyw==
X-Google-Smtp-Source: AGHT+IHJyCclWn6fIrRNn5BJOYp2jbguBBaJqrPogDzcpT+mJcNXRaK54F1vQFpoPFH2qKY1Gi6AmA==
X-Received: by 2002:a50:fb0c:0:b0:530:8759:a3ac with SMTP id d12-20020a50fb0c000000b005308759a3acmr10041456edq.2.1696788001409;
        Sun, 08 Oct 2023 11:00:01 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7df99000000b0053808d83f0fsm5223469edy.9.2023.10.08.11.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 11:00:00 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9adb9fa7200so837794666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 11:00:00 -0700 (PDT)
X-Received: by 2002:a17:907:2d09:b0:9aa:206d:b052 with SMTP id
 gs9-20020a1709072d0900b009aa206db052mr8482128ejc.27.1696788000334; Sun, 08
 Oct 2023 11:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
In-Reply-To: <20231004145137.86537-5-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Oct 2023 10:59:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
Message-ID: <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 07:51, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> The percpu code mostly uses inline assembly. Using segment qualifiers
> allows to use C code instead, which enables the compiler to perform
> various optimizations (e.g. propagation of memory arguments). Convert
> percpu read and write accessors to C code, so the memory argument can
> be propagated to the instruction that uses this argument.

So apparently this causes boot failures.

It might be worth testing a version where this:

> +#define raw_cpu_read_1(pcp)            __raw_cpu_read(, pcp)
> +#define raw_cpu_read_2(pcp)            __raw_cpu_read(, pcp)
> +#define raw_cpu_read_4(pcp)            __raw_cpu_read(, pcp)
> +#define raw_cpu_write_1(pcp, val)      __raw_cpu_write(, pcp, val)
> +#define raw_cpu_write_2(pcp, val)      __raw_cpu_write(, pcp, val)
> +#define raw_cpu_write_4(pcp, val)      __raw_cpu_write(, pcp, val)

and this

> +#ifdef CONFIG_X86_64
> +#define raw_cpu_read_8(pcp)            __raw_cpu_read(, pcp)
> +#define raw_cpu_write_8(pcp, val)      __raw_cpu_write(, pcp, val)

was all using 'volatile' in the qualifier argument and see if that
makes the boot failure go away.

Because while the old code wasn't "asm volatile", even just a *plain*
asm() is certainly a lot more serialized than a normal access.

For example, the asm() version of raw_cpu_write() used "+m" for the
destination modifier, which means that if you did multiple percpu
writes to the same variable, gcc would output multiple asm calls,
because it would see the subsequent ones as reading the old value
(even if they don't *actually* do so).

That's admittedly really just because it uses a common macro for
raw_cpu_write() and the updates (like the percpu_add() code), so the
fact that it uses "+m" instead of "=m" is just a random odd artifact
of the inline asm version, but maybe we have code that ends up working
just by accident.

Also, I'm not sure gcc re-orders asms wrt each other - even when they
aren't marked volatile.

So it might be worth at least a trivial "make everything volatile"
test to see if that affects anything.

              Linus
