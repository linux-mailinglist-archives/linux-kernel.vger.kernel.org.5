Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A42776B04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHIVeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:34:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5981718
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:34:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so232580a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691616846; x=1692221646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iIlg09/o+V9YySZ28EHl+yYYW7hFmteKq8vY4umYpI=;
        b=U1T2v1Fw9lLzHXJCG1ro/qy7iG/FamiILIXkTj7K4+sWR2ZTGr9oAeCbZB2DMOQbIK
         zWdXrZfBUt3HxpV/BG04yVUpGx7WGopeLaEg7NAUnJ+SUZDTqeJXM5DHBeosIxGlQ5Ry
         meR6H4oYjTmYJMpnrRL4lkTm52eR9nqM/dHeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691616846; x=1692221646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iIlg09/o+V9YySZ28EHl+yYYW7hFmteKq8vY4umYpI=;
        b=F5/KM+T6tXFdzf9331LF9qSSs2J6E6Bku376YbdCOamss0hnx+j+Z6w92zBbr5ZvpW
         nwO/TZFvmekg22C88zMjf2P/ww/z8OU95clOaTNQizvuY1V644ZfKqI6Q1qAe6H73fik
         a5MsYHqnvTwsFoEY9dK7VlGpw6G5DXAzmnSEfMR/H+/hYWlEITjBqUM0IMWBqK7Xe5Sf
         hk5k/QEdc66go2xnkP59pPDmY6LAtEhedyeL7lLaDcmBgwKiab+tMshWpFGk1eKNQdIF
         tgxzBCOuwhwiXGT87zsiHRj0B3yNYhcWrb/KReUzItUTpssiTbLLdPiwWAxvR0y29O1C
         tawA==
X-Gm-Message-State: AOJu0YyM1arzl/8AvZ9ZcWfuS+Ebtugj1KTbUnIRrHLVq5mbewSQemnz
        QZ76BaGJrwwJautlds59lr/KJqcf/1ydcc/0gNe0zuxB
X-Google-Smtp-Source: AGHT+IGPwpwusPfnixwv+lZNpZ9WY0LvxrDquezBWvFiCoQ1Uo2IjCXYWl5Xr3JNBvIqHFQh29HMtQ==
X-Received: by 2002:a17:906:8a45:b0:99c:7134:ab6e with SMTP id gx5-20020a1709068a4500b0099c7134ab6emr299968ejc.38.1691616846394;
        Wed, 09 Aug 2023 14:34:06 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b0099cd008c1a4sm31752ejb.136.2023.08.09.14.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 14:34:06 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bfcf4c814so42676166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 14:34:05 -0700 (PDT)
X-Received: by 2002:a17:906:304e:b0:99b:d4f5:a518 with SMTP id
 d14-20020a170906304e00b0099bd4f5a518mr311174ejd.13.1691616845596; Wed, 09 Aug
 2023 14:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230809202356.357339-1-andrew.cooper3@citrix.com>
In-Reply-To: <20230809202356.357339-1-andrew.cooper3@citrix.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 14:33:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiic4XViHp0=0pjLnQALRpfda+naY0ysZdK6Fia86hh2w@mail.gmail.com>
Message-ID: <CAHk-=wiic4XViHp0=0pjLnQALRpfda+naY0ysZdK6Fia86hh2w@mail.gmail.com>
Subject: Re: [PATCH] x86/AMD: Fix ASM constraints in amd_clear_divider()
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 13:24, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> DIV writes its results into %eax and %edx, meaning that they need to be output
> constraints too.  It happens to be benign in this case as the registers don't
> change value, but the compiler should still know.
>
> Fixes: 77245f1c3c64 ("x86/CPU/AMD: Do not leak quotient data after a division by 0")

As mentioned earlier (html, not on list), I think it was intentional
and this "fix" doesn't really fix anything.

A comment might be good, of course, if this really bothers somebody.

That said, if the code wanted to be *really* clever, it could have done

        asm volatile(ALTERNATIVE("", "div %0", X86_BUG_DIV0)
                     :: "a" (1), "d" (0));

instead. One less register used, and the same "no change to register
state" approach.

Of course, who knows what early-out algorithm the divider uses, and
maybe it's cheaper to do 0/1 than it is to do 1/1. Not that I think we
should care. The main reason to be cute here would be just to be cute.

That said, if you were to use this pattern in *real* code (as opposed
to in that function that will never be called in reality because
nobody divides by zero in real code), the register clobbers might be
useful just to make sure the compiler doesn't re-use a zero register
content that is then behind the latency of the dummy divide. But
again, this particular code really doesn't _matter_ in that sense.

               Linus
