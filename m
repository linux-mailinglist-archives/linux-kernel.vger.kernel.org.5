Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA697CE911
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjJRUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjJRUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:34:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E990EF7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:34:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99de884ad25so1171260266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697661282; x=1698266082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iR5fccMdFmWM7UuROlGRgDSCnsuRPDsroqebJRQmpUE=;
        b=a5LKEv4f9Qqcd5tOEPntyB5ff7hKYVRsd1XCi4QYmGlcyyrjrJujU30JCvkF4iHNPi
         ZD0TonI87yWy4MO8Mcu20gwS0YFCxDrZYcdRtc4g6AtxC/edM7fOAxKfYC8tEE9SQOvg
         E+6OPCRUbKMDnjrBOQifKjLaSdTO2x5hakMTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661282; x=1698266082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR5fccMdFmWM7UuROlGRgDSCnsuRPDsroqebJRQmpUE=;
        b=aDWSfAtBVGwyvupH07Ia0uEsdoP/0svVKCFaXiB76wf4wuSZrrT9p1wAts/iR0+6Fn
         iVQ63aK489Lo5RYvdDMa/YAxJ+WXTj7n5CEUdj4U+t9bAPc2uTvKG86E97nUB5O4MKyQ
         g+BWlo0FA9GindRac0w/MOfPyvC0BI0efoMYMoUBZ4NfZPP0ZKEWIsB+3Alc9Vyncwbg
         Kt80tw2Ye1SnCe2u4ClZHeBqBejkc7XVy0u3YI8iV7WsFF2POcgr4qMQNZoPN99MjVzJ
         GBUoc6/Z1uIlchKI+Zsu4ihZ2A53tC437JhwpAGrtXJAyB2zOV3uUsqcu1hiokeEP0tC
         OHlw==
X-Gm-Message-State: AOJu0Yyir9ZeNhtT5NJZHzxCBQsFnefE4lRiUxrHtv1AZIIQ1sC0lRc9
        Q0EhKcJfXQrHcjELlOcdrixu+58ySPVdFW3zIJzG0VmL
X-Google-Smtp-Source: AGHT+IG3UEbb9a1Le0IsWePf9YvFDfSAConTAQp4Cr2+fitUsfq6GHGABpfMspPDbP8XwTUSA7v3iQ==
X-Received: by 2002:a17:906:db07:b0:9b8:b683:5837 with SMTP id xj7-20020a170906db0700b009b8b6835837mr210372ejb.46.1697661281967;
        Wed, 18 Oct 2023 13:34:41 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709063b4300b009b9aa8fffdasm2273373ejf.131.2023.10.18.13.34.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:34:41 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99de884ad25so1171255566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:34:41 -0700 (PDT)
X-Received: by 2002:a17:907:7211:b0:9b8:5b0d:b55a with SMTP id
 dr17-20020a170907721100b009b85b0db55amr254124ejc.54.1697661280825; Wed, 18
 Oct 2023 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com> <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 13:34:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
Message-ID: <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, 18 Oct 2023 at 13:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, sometimes we use actual volatile accesses for them
> (READ_ONCE() and WRITE_ONCE()) but those are *horrendous* in general,
> and are much too strict. Not only does gcc generally lose its mind
> when it sees volatile (ie it stops doing various sane combinations
> that would actually be perfectly valid), but it obviously also stops
> doing CSE on the loads (as it has to).

Note, in case you wonder what I mean by "lose its mind", try this
(extremely stupid) test program:

    void a(volatile int *i) { ++*i; }
    void b(int *i) { ++*i; }

and note that the non-volatile version does

    addl $1, (%rdi)

but the volatile version then refuses to combine the read+write into a
rmw instruction, and generates

    movl (%rdi), %eax
    addl $1, %eax
    movl %eax, (%rdi)

instead.

Sure, it's correct, but it's an example of how 'volatile' ends up
disabling a lot of other optimizations than just the "don't remove the
access".

Doing the volatile as one rmw instruction would still have been very
obviously valid - it's still doing a read and a write. You don't need
two instructions for that.

I'm not complaining, and I understand *why* it happens - compiler
writers very understandably go "oh, I'm not touching that".

I'm just trying to point out that volatile really screws up code
generation even aside from the "access _exactly_ once" issue.

So using inline asm and relying on gcc doing (minimal) CSE will then
generate better code than volatile ever could, even when we just use a
simple 'mov" instruction. At least you get that basic combining
effect, even if it's not great.

And for memory ops, *not* using volatile is dangerous when they aren't stable.

              Linus
