Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C87CE8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJRUWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:22:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF08A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:22:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso163430a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697660559; x=1698265359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=si+9ASsp5/K6lChVtwpu5ExRbuaOYMu1IyUvA2qgc/c=;
        b=Q+lwgxiowYaKVN0Z1P7/9e2F6ryIx13JkBLjHGASOQIRO39ec5msmgTnzBuOr1z+VL
         mPkZQcMrFNr+VR1M/Q4u7D0mzAH8ef9KGMTtFMSjhza6W4qITDI7ZrNHD5KLWpzAYEiU
         5rVqNnjFuTPprSKB2x8LEs1hJygEaWrQ1nGCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697660559; x=1698265359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si+9ASsp5/K6lChVtwpu5ExRbuaOYMu1IyUvA2qgc/c=;
        b=Ef8/HtaNcFttzNsXz261WCyT18+1xgRov+MTqbmQqOT84vvbhQg2wqPiBbVxX7Iqva
         zQj1xNIVzNIbE+QPAEtgo1FHKkkLcB2Gfogg+A13Ygm+heTMTYV9IagDQLqCpjGoIVLe
         k1md5AmvL954flJ+riQJctC+I5uMSrz2pQc1eLkcTZjQOSfi2dLrFijegjb8zBqqeNpE
         dLNr0TYaYBGF9wiW29VsxzorQ7+ezEImhbCQFjMRAKr2tJ5gMBHNuV/t72fsBlczGPmV
         R42nfNZ7jmk3W+cyLiKOVTaayf6U8MW5QMJBYiRLq1zmnlpT0nd0VPM23seXAyOl6j9X
         2mxA==
X-Gm-Message-State: AOJu0Yyqf3096WIFb3V3PvfPPdAej2r+kiNZjwB2Fialf5gpZ8jb8Q0w
        lbXLzsqhUv1F5Cpm45uaKte0aAUqDWoqIUr81MQFMVvj
X-Google-Smtp-Source: AGHT+IE+567VvLQJUG6eZ93pQOIqEuG0U/0T4lwwbsR8Krm75Xgo7esVdQCia6U18V8/DL6LqPX5VQ==
X-Received: by 2002:a05:6402:42c9:b0:53d:fc49:49e9 with SMTP id i9-20020a05640242c900b0053dfc4949e9mr428349edc.6.1697660558955;
        Wed, 18 Oct 2023 13:22:38 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id fj27-20020a0564022b9b00b005309eb7544fsm3268975edb.45.2023.10.18.13.22.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:22:38 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9c3aec5f326so15182466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:22:38 -0700 (PDT)
X-Received: by 2002:a17:907:1c20:b0:9bd:81c3:2a85 with SMTP id
 nc32-20020a1709071c2000b009bd81c32a85mr5443762ejc.32.1697660557766; Wed, 18
 Oct 2023 13:22:37 -0700 (PDT)
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
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com> <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
In-Reply-To: <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 13:22:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
Message-ID: <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
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

On Wed, 18 Oct 2023 at 12:33, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> This pach works for me:

Looks fine.

But you actually bring up another issue:

> BTW: I also don't understand the comment from include/linux/smp.h:
>
> /*
>  * Allow the architecture to differentiate between a stable and unstable read.
>  * For example, x86 uses an IRQ-safe asm-volatile read for the unstable but a
>  * regular asm read for the stable.

I think the comment is badly worded, but I think the issue may actually be real.

One word: rematerialization.

The thing is, turning inline asm accesses to regular compiler loads
has a *very* bad semantic problem: the compiler may now feel like it
can not only combine the loads (ok), but also possibly rematerialize
values by re-doing the loads (NOT OK!).

IOW, the kernel often has very strict requirements of "at most once"
behavior, because doing two loads might give different results.

The cpu number is a good example of this.

And yes, sometimes we use actual volatile accesses for them
(READ_ONCE() and WRITE_ONCE()) but those are *horrendous* in general,
and are much too strict. Not only does gcc generally lose its mind
when it sees volatile (ie it stops doing various sane combinations
that would actually be perfectly valid), but it obviously also stops
doing CSE on the loads (as it has to).

So the "non-volatile asm" has been a great way to get the "at most
one" behavior: it's safe wrt interrupts changing the value, because
you will see *one* value, not two. As far as we know, gcc never
rematerializes the output of an inline asm. So when you use an inline
asm, you may have the result CSE'd, but you'll never see it generate
more than *one* copy of the inline asm.

(Of course, as with so much about inline asm, that "knowledge" is not
necessarily explicitly spelled out anywhere, and it's just "that's how
it has always worked").

IOW, look at code like the one in swiotlb_pool_find_slots(), which does this:

        int start = raw_smp_processor_id() & (pool->nareas - 1);

and the use of 'start' really is meant to be just a good heuristic, in
that different concurrent CPU's will start looking in different pools.
So that code is basically "cpu-local by default", but it's purely
about locality, it's not some kind of correctness issue, and it's not
necessarily run when the code is *tied* to a particular CPU.

But what *is* important is that 'start' have *one* value, and one
value only. So look at that loop, which hasically does

        do {
                  .. use the 'i' based on 'start' ..
                if (++i >= pool->nareas)
                        i = 0;
        } while (i != start);

and it is very important indeed that the compiler does *not* think
"Oh, I can rematerialize the 'start' value".

See what I'm saying? Using 'volatile' for loading the current CPU
value would be bad for performance for no good reason. But loading it
multiple times would be a *bug*.

Using inline asm is basically perfect here: the compiler can *combine*
two inline asms into one, but once we have a value for 'start', it
won't change, because the compiler is not going to decide "I can drop
this value, and just re-do the inline asm to rematerialize it".

This all makes me worried about the __seg_fs thing.

For 'current', this is all perfect. Rematerializing current is
actually better than spilling and reloading the value.

But for something like raw_smp_processor_id(), rematerializing would
be a correctness problem, and a really horrible one (because in
practice, the code would work 99.9999% of the time, and then once in a
blue moon, it would rematerialize a different value).

See the problem?

I guess we could use the stdatomics to try to explain these issues to
the compiler, but I don't even know what the C interfaces look like or
whether they are stable and usable across the range of compilers we
use.

               Linus
