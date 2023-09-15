Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7177A23D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjIOQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjIOQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:45:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B886E69
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:45:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50098cc8967so3795321e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694796335; x=1695401135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJwjiYuT81Vygr2N0E8vRZWFku28/3vgWmNofvmCcbw=;
        b=Zsf17i2BHOg2bqX/csLCyCR4KncD6guhNdeey+swDy2GajbCyni0b9CyCekbnyCxct
         fZukDkB7bS2yeF3CazzZV2xOrO6qWw5SR/Zo9nrfdBhjdkucHrYY2rWwwh5wRqb7KTrr
         oADYr704P5ISNQXfYxGVF1n0jZtF0UmJFC6Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796335; x=1695401135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJwjiYuT81Vygr2N0E8vRZWFku28/3vgWmNofvmCcbw=;
        b=vjSPlRtj1KsLNjbmGFyyDoe1DNTD+CG01Mv40uDVndga2uEgS/ju9liocL1xWqRz2F
         sfxDcGewZo5sAIUubnI/Kbu1p2WZvUH2CAsn0o4+f5UDT7VHsnrJBRvjwok/+YpcntZH
         YnIZciH5B0wShLH+kbg5whAarXQ8RS8N7PWqHTPwJhOCutQx2y1w9TsJkZ1YdmhjIKKD
         XWlJ6A7y3EzBUgVujA0dnsc0H9IVceYJ/Fhs+zbM90HRwqzfGCDiuBTT++9BP89BOdB9
         htXCfs8yB8rG6JxwbZxkHxchV/7AVsvtuflBFbUsJ830zaBpTbQ627kkAM38/mNIBN+n
         uO6Q==
X-Gm-Message-State: AOJu0YxUrfyUPYJxX0VfDCZbzWxR0DpW3FUJ1RyMDs7Ci+nECOcPvCqT
        fEsVAfus6fE2XbTI+wj8/ZUG6T+HzbmdGu9hKPNTGg==
X-Google-Smtp-Source: AGHT+IGBXL/pvbXhnch+112SFJ3ZqaHktYVcTuquRrNnKaYYUZhNK68LTytXD6mbOT2lv8FSeq+N/g==
X-Received: by 2002:ac2:4e02:0:b0:500:b3f2:73e2 with SMTP id e2-20020ac24e02000000b00500b3f273e2mr2159465lfr.50.1694796335029;
        Fri, 15 Sep 2023 09:45:35 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id mf13-20020a170906cb8d00b0099caf5bed64sm2610168ejb.57.2023.09.15.09.45.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:45:33 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a645e54806so289715066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:45:33 -0700 (PDT)
X-Received: by 2002:a17:906:300e:b0:9a6:6c5b:ae0c with SMTP id
 14-20020a170906300e00b009a66c5bae0cmr2000660ejz.23.1694796333328; Fri, 15 Sep
 2023 09:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230906185941.53527-1-ubizjak@gmail.com> <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
In-Reply-To: <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 09:45:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
Message-ID: <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
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

On Fri, 15 Sept 2023 at 04:25, tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> Several places in mm/slub.o improve from e.g.:
>
[...]
>
> to:
>
>     53bc:       48 8d 4a 40             lea    0x40(%rdx),%rcx
>     53c0:       49 8b 1c 07             mov    (%r15,%rax,1),%rbx
>     53c4:       4c 89 f8                mov    %r15,%rax
>     53c7:       48 8d 37                lea    (%rdi),%rsi
>     53ca:       e8 00 00 00 00          call   53cf <...>
>                         53cb: R_X86_64_PLT32     this_cpu_cmpxchg16b_emu-0x4
>     53cf:       75 bb                   jne    538c <...>

Honestly, if y ou care deeply about this code sequence, I think you
should also move the "lea" out of the inline asm.

Both

    call this_cpu_cmpxchg16b_emu

and

    cmpxchg16b %gs:(%rsi)

are 5 bytes, and I suspect it's easiest to just always put the address
in %rsi - whether you call the function or not.

It doesn't really make the code generation for the non-call sequence
worse, and it gives the compiler more information (ie instead of
clobbering %rsi, the compiler knows what %rsi contains).

IOW, something like this:

-       asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call
this_cpu_cmpxchg16b_emu", \
+       asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",           \
...
-                   "c" (new__.high)                                    \
-                 : "memory", "rsi");                                   \
+                   "c" (new__.high),                                   \
+                   "S" (&_var)                                   \
+                 : "memory");                                          \

should do it.

Note that I think this is particularly true of the slub code, because
afaik, the slub code will *only* use the slow call-out.

Why? Because if the CPU actually supports the cmpxchgb16 instruction,
then the slub code won't even take this path at all - it will do the
__CMPXCHG_DOUBLE path, which does an unconditional locked cmpxchg16b.

Maybe I'm misreading it. And no, none of this matters. But since I saw
the patch fly by, and slub.o mentioned, I thought I'd point out how
silly this all is. It's optimizing a code-path that is basically never
taken, and when it *is* taken, it can be improved further, I think.

                   Linus
