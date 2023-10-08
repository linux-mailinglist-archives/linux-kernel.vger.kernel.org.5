Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01BF7BD021
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjJHUsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJHUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:48:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C73B3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 13:48:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b95622c620so714365666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696798105; x=1697402905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EtpbtXNTgAw7A9FVCfs/xfeaX4QpnPrPy9XfoZ2+es4=;
        b=WPOmpQ0S9yxEyZiLtiYGXneklbJ0Caf69y0jqR681QLCJEr8s+btHyfcgYE0FXXuOv
         AELHiLj8YlGvXmfWwEEM33Dp3MN/K+K2xSf0yqudT0Duk/Vy/SkWo7kO9KUvP0m2zBAk
         iwLPL3iGvb6tr4WfGMhgBOtaFb8FV20Sk9qJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696798105; x=1697402905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtpbtXNTgAw7A9FVCfs/xfeaX4QpnPrPy9XfoZ2+es4=;
        b=D2pW2lq8L6TV7gkrIvYd0ymvz7mppzQ1wCX0Pk3usTGpWvdfqGgSeujg9d2EnmXvMn
         BOI9tpAb6XpliwAeKFBtT50/S6o29KiR569bOMqDp6BKwudDQPszuBQtlhYRCkfY//W1
         c0NMFwJnZgJu1YFl0LLkCshgM8Js3nk8lS8i+jz3lJzSfLDAN0x2GSXTsAvUbR+r9eTK
         wtv35Cb2Qf5/xazrXJPduEpcmFQn/4r93KXN+dCb7+n6okPQN4uI5Zp9Te7geJLc7dWD
         NRpGz+2nFl1iVvAwZzY+Bn9mE7MQum9Rx7KggKEz/MYc3jho0Z00HO611sj3TwBx4EIQ
         1V9w==
X-Gm-Message-State: AOJu0Yxziuw5W/zfhOoo7E8v2S7v2+MMXwJirgg/z0jTsb1G0/wHlsB8
        74Nfw9scgW6BLHSdrCtLf5Fo23cLjZAk24qg2U6Z3xwq
X-Google-Smtp-Source: AGHT+IEmRufz59W/5dW5KSOac6qO0luvL5iQcYBriJGKOA0gP5q1+FFzxYTFdclPuJXFB+mrXAPREA==
X-Received: by 2002:a17:906:2254:b0:9b9:4509:d575 with SMTP id 20-20020a170906225400b009b94509d575mr12277549ejr.2.1696798105707;
        Sun, 08 Oct 2023 13:48:25 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b009b2c9476726sm5920332eju.21.2023.10.08.13.48.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 13:48:25 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-307d20548adso3574145f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 13:48:24 -0700 (PDT)
X-Received: by 2002:adf:e8cc:0:b0:322:da1f:60d9 with SMTP id
 k12-20020adfe8cc000000b00322da1f60d9mr12676506wrn.47.1696798104195; Sun, 08
 Oct 2023 13:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com> <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
In-Reply-To: <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Oct 2023 13:48:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
Message-ID: <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2023 at 13:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Your dump does end up being close to a %gs access:

Bah. I should have looked closer at the instructions before the oops.

Because I think that's exactly the problem here. That's the KASAN
checks that have been added, and we have this insane code:

>   10: 48 c7 c0 10 73 02 00 mov    $0x27310,%rax
>   17: 48 ba 00 00 00 00 00 movabs $0xdffffc0000000000,%rdx
>   1e: fc ff df
>   21: 48 c1 e8 03          shr    $0x3,%rax
>   25:* 80 3c 10 00          cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction

Look how both %rax and %rdx are constants, yet then gcc has generated
that crazy "shift a constant value right by three bits, and then use
an addressing mode to add it to another constant".

And that 0xdffffc0000000000 constant is KASAN_SHADOW_OFFSET.

So what I think is going on is trivial - and has nothing to do with ordering.

I think gcc is simply doing a KASAN check on a percpu address.

Which it shouldn't do, and didn't use to do because we did the access
using inline asm.

But now that gcc does the accesses as normal (albeit special address
space) memory accesses, the KASAN code triggers on them too, and it
all goes to hell in a handbasket very quickly.

End result: those percpu accessor functions need to disable any KASAN
checking or other sanitizer checking. Not on the percpu address,
because that's not a "real" address, it's obviously just the offset
from the segment register.

We have some other cases like that, see __read_once_word_nocheck().

And gcc should probably not have generated such code in the first
place, so arguably this is a bug with -fsanitize=kernel-address. How
does gcc handle the thread pointers with address sanitizer? Does it
convert them into real pointers first, and didn't realize that it
can't do it for __seg_gs?

               Linus
