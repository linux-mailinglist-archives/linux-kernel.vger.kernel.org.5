Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB97D0024
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjJSRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJSRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:05:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14629E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:05:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso849505366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697735116; x=1698339916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm/2QOfM9irmajMCaFY4p3i8HvYauigLtvCG4Z2Kmm4=;
        b=A3mncOwRv8Y9dE6gYPr31AezZfDMar1nqhq6tyLqIYtXq6enhA08iagA98HZRvySU/
         BlX7MBVzw+m7vOqmfCGWHw038nNq9DklZ4QiHGJsq7j7qtJj9CZKZDNOVN7ff99KeCze
         yWpIlDP8LfapvBtEVrZrMWK3FvizkjUG7hxTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735116; x=1698339916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gm/2QOfM9irmajMCaFY4p3i8HvYauigLtvCG4Z2Kmm4=;
        b=Q77Ci/5HSanGoG9ti2i3CERFKb78oE9zrZ9hdv/ztZSIhakdK6afb5r5Ke3u/CZNnr
         A4P+6Kl1XEjr8CUlRKiUUbtmIX4FboaRo1tAXFcozhY1DrB2kPn9VHjzsGbi8k06jzxO
         AuzDIbJ10Iou19dICoMPzhWLy0CLKwcsq/E59qT3tc9P0efVhqxaeAw+F7yNGAHuUfid
         annl2+9jRV6C8dMDdITu0HLJVunxX/J4LkYOJ7LxbsGuzE4XXfKiPu7Rwcxe3d5owdsP
         WWnNwZwqvS61dhQ/bKg4sho2r9y9wNahTHjXJShvac4JjWme21vTHbQMnqSxfJXfk6iD
         wCJw==
X-Gm-Message-State: AOJu0YwWhDYqj1Qog1l5Znk+FuIEpW+CN7YzQ3mr9aN1BXQZ6EWUFKO2
        g9bTcx+zM2nZShYxi8Dxqob/K/X/AyPg1Uc06c/5+NHo
X-Google-Smtp-Source: AGHT+IGHYJv/NOaYCK04DdrWs8yKywzAFF4O2YIeRANNs1G3+rLFsRN46zibIPbLT5G3bJdo9yNoyw==
X-Received: by 2002:a17:907:1c0b:b0:9ae:420e:739b with SMTP id nc11-20020a1709071c0b00b009ae420e739bmr2566211ejc.46.1697735115757;
        Thu, 19 Oct 2023 10:05:15 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id i22-20020a1709064ed600b00992f2befcbcsm3965075ejv.180.2023.10.19.10.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:05:15 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9c75ceea588so162266166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:05:14 -0700 (PDT)
X-Received: by 2002:a17:907:25c7:b0:9bf:b6f5:3a08 with SMTP id
 ae7-20020a17090725c700b009bfb6f53a08mr2069860ejc.52.1697735114627; Thu, 19
 Oct 2023 10:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com> <20231019085432.GQ33217@noisy.programming.kicks-ass.net>
In-Reply-To: <20231019085432.GQ33217@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 10:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg98L2qaw1U-7NDFQi6dOK=CRO6H-1q1LXuEh348Dk=2Q@mail.gmail.com>
Message-ID: <CAHk-=wg98L2qaw1U-7NDFQi6dOK=CRO6H-1q1LXuEh348Dk=2Q@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, 19 Oct 2023 at 01:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> seqlock actually wants rmb even today, the pattern is:

That's the pattern today, and yes, it makes superficial sense, but no,
it's not a "really wants" issue.

>     do {
>         seq = load-seq
>         rmb
>         load-data
>         rmb
>     } while (seq != re-load-seq)
>
> we specifically only care about loads, and the data loads must be
> between the sequence number loads.
>
> As such, load-acquire is not a natural match.

You are correct that "rmb" _sounds_ logical. We do, after all, want to
order reads wrt each other.

So rmb is the obvious choice.

But the thing is, "read_acquire" actually does that too.

So if you do

        seq = load_acquire(orig_seq);
        load-data

then that acquire actually makes that first 'rmb' pointless. Acquire
already guarantees that all subsequent memory operations are ordered
wrt that read.

And 'acquire' is likely faster than 'rmb' on sane modern architectures.

On x86 it doesn't matter (rmb is a no-op, and all loads are acquires).

But on arm64, for example, you can do a 'ld.acq' in one instruction
and you're done - while a rmb then ends up being a barrier (ok, the
asm mnemonics are horrible: it's not "ld.acq", it's "ldar", but
whatever - I like arm64 as an architecture, but I think they made the
standard assembly syntax pointlessly and actively hostile to humans).

Of course then microarchitectures may end up doing basically the same
thing, but at least technically the 'load acquire' is likely more
targeted and more optimized.

The second rmb is then harder to change, and that is going to stay an
rmb ( you could say "do an acquire on the last data load, but that
doesn't fit the sane locking semantics of a sequence lock).

But I do think our sequence counters would be better off using
"smp_load_acquire()" for that initial read.

Of course, then the percpu case doesn't care about the SMP ordering,
but it should still use an UP barrier to make sure things don't get
re-ordered. Relying on our "percpu_read()" ordering other reads around
it is *wrong*.

             Linus
