Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C207A3729
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjIQSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbjIQSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:31:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E969F;
        Sun, 17 Sep 2023 11:31:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso4532282a12.0;
        Sun, 17 Sep 2023 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694975497; x=1695580297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/xNNmuhkMGe/cn0NgL7z0L+eqJxdRlO1BnUuZ2r/3c=;
        b=bGPu0Trx5rYXJv/Jiwp3Udy9vRiIFzTdRUYph6YAjCxeN41emNhmsD10sSXncY7HEi
         oCZ6Xz2DuR6hxYmHvwJX+f/fZX8u77UCh5vIK4ym2PaFV2fRhnyf30Mw8mvOp5HRJnOO
         3r5bH7nLNGqfcZjK7q5lGXOpisv/j70SZxDBqsdgqxeeYswlePpEbft4bDddBRn/3X7z
         BNnSzL0pgONz/OGKsN8NU9hka/9J6lMx/B8Wk+Ws7LemdbpFAhi+tU+vJjrw9jkzW9vZ
         PVAamyC6lebziaCpjs1IPYH7lE7xv/GBklFmP0Ydd5wJ2/GPXFt7RltFOKLIu36NVh5d
         Jl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694975497; x=1695580297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/xNNmuhkMGe/cn0NgL7z0L+eqJxdRlO1BnUuZ2r/3c=;
        b=DTIUoT9CiY+nA3zpBlpjPdedva67hzGEu8wSV5RnrMMnO6lG5sml9KJAbntesnbNkA
         J574G3D3w8TppoSv/T4CaKJXE55Q9zIHHbL1fnieiwYd3MsnCICk6ns2xm51QYOiE0SP
         tzP85J4AK1jZz00/YIlGpQz0WA+STFNyln0vFG36Nv3eyg/+5Bz05t8RR6xTfgsW4zKV
         uvgbH8Brk0infsfIr+G7+rjc7pL3JlD+pnePiH11ddJR7wGvXefomwwqjawv493lgElN
         opWIDb0i0CKcX0ObMYqU/xNiEYVe+OMvCSEm0jIxasRhdCuKrk/Tj19NfnNhZ0PPmQL8
         0uxw==
X-Gm-Message-State: AOJu0Yxf5S4cjPB4rg25QqfAfW/LPBECCZ2n6fXB3nFx5ReZ+n6x1UxW
        vnLGwO5NjEjwTVFNSjpF8WOx/bbukGwW6V/Q56ETrBb7I9s=
X-Google-Smtp-Source: AGHT+IGgmSg+zBvMeyil+i9ni7Io4UX6nc2KG47hSGIEI0D7ODqFhIJeBWM+C/LxYCf8RNDbvVYk4z7TvzJmnFOci9M=
X-Received: by 2002:aa7:d291:0:b0:52a:5848:c674 with SMTP id
 w17-20020aa7d291000000b0052a5848c674mr5639666edq.12.1694975496547; Sun, 17
 Sep 2023 11:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230906185941.53527-1-ubizjak@gmail.com> <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
 <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
In-Reply-To: <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 17 Sep 2023 20:31:25 +0200
Message-ID: <CAFULd4YLzRWmXG2DHeRHYY33FrX+wNOVfQFyms5Mki1mmn0VZA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 6:45=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 15 Sept 2023 at 04:25, tip-bot2 for Uros Bizjak
> <tip-bot2@linutronix.de> wrote:
> >
> > Several places in mm/slub.o improve from e.g.:
> >
> [...]
> >
> > to:
> >
> >     53bc:       48 8d 4a 40             lea    0x40(%rdx),%rcx
> >     53c0:       49 8b 1c 07             mov    (%r15,%rax,1),%rbx
> >     53c4:       4c 89 f8                mov    %r15,%rax
> >     53c7:       48 8d 37                lea    (%rdi),%rsi
> >     53ca:       e8 00 00 00 00          call   53cf <...>
> >                         53cb: R_X86_64_PLT32     this_cpu_cmpxchg16b_em=
u-0x4
> >     53cf:       75 bb                   jne    538c <...>
>
> Honestly, if y ou care deeply about this code sequence, I think you
> should also move the "lea" out of the inline asm.

I have to say that the above asm code was shown mostly as an example
of the improvement, to illustrate how the compare sequence at the end
of the cmpxchg loop gets eliminated. Being a fairly mechanical change,
I didn't put much thought in the surrounding code.

> Both
>
>     call this_cpu_cmpxchg16b_emu
>
> and
>
>     cmpxchg16b %gs:(%rsi)
>
> are 5 bytes, and I suspect it's easiest to just always put the address
> in %rsi - whether you call the function or not.
>
> It doesn't really make the code generation for the non-call sequence
> worse, and it gives the compiler more information (ie instead of
> clobbering %rsi, the compiler knows what %rsi contains).
>
> IOW, something like this:
>
> -       asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call
> this_cpu_cmpxchg16b_emu", \
> +       asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",           \
> ...
> -                   "c" (new__.high)                                    \
> -                 : "memory", "rsi");                                   \
> +                   "c" (new__.high),                                   \
> +                   "S" (&_var)                                   \
> +                 : "memory");                                          \
>
> should do it.

Yes, and the above change improves slub.o assembly from (current tip
tree with try_cmpxchg patch applied):

    53b3:    41 8b 44 24 28           mov    0x28(%r12),%eax
    53b8:    49 8b 3c 24              mov    (%r12),%rdi
    53bc:    48 8d 4a 40              lea    0x40(%rdx),%rcx
    53c0:    49 8b 1c 07              mov    (%r15,%rax,1),%rbx
    53c4:    4c 89 f8                 mov    %r15,%rax
    53c7:    48 8d 37                 lea    (%rdi),%rsi
    53ca:    e8 00 00 00 00           call   53cf <kmem_cache_alloc+0x9f>
            53cb: R_X86_64_PLT32    this_cpu_cmpxchg16b_emu-0x4
    53cf:    75 bb                    jne    538c <kmem_cache_alloc+0x5c>

to:

    53b3:    41 8b 44 24 28           mov    0x28(%r12),%eax
    53b8:    49 8b 34 24              mov    (%r12),%rsi
    53bc:    48 8d 4a 40              lea    0x40(%rdx),%rcx
    53c0:    49 8b 1c 07              mov    (%r15,%rax,1),%rbx
    53c4:    4c 89 f8                 mov    %r15,%rax
    53c7:    e8 00 00 00 00           call   53cc <kmem_cache_alloc+0x9c>
            53c8: R_X86_64_PLT32    this_cpu_cmpxchg16b_emu-0x4
    53cc:    75 be                    jne    538c <kmem_cache_alloc+0x5c>

where an effective reg-reg move "lea (%rdi), %rsi" at 537c gets
removed. And indeed, GCC figures out that %rsi holds the address of
the variable and emits:

   5:    65 48 0f c7 0e           cmpxchg16b %gs:(%rsi)

alternative replacement.

Now, here comes the best part: We can get rid of the %P modifier. With
named address spaces (__seg_gs), older GCCs had some problems with %P
and emitted "%gs:foo" instead of foo, resulting in "Warning: segment
override on `lea' is ineffectual" assembly warning. With the proposed
change, we use:

--cut here--
int __seg_gs g;

void foo (void)
{
  asm ("%0 %1" :: "m"(g), "S"(&g));
}
--cut here--

and get the desired assembly:

       movl    $g, %esi
       %gs:g(%rip) %rsi

The above is also in line with [1], where it is said that
"[__seg_gs/__seg_fs] address spaces are not considered to be subspaces
of the generic (flat) address space." So, cmpxchg16b_emu.S must use
%gs to apply segment base offset, which it does.

> Note that I think this is particularly true of the slub code, because
> afaik, the slub code will *only* use the slow call-out.
>
> Why? Because if the CPU actually supports the cmpxchgb16 instruction,
> then the slub code won't even take this path at all - it will do the
> __CMPXCHG_DOUBLE path, which does an unconditional locked cmpxchg16b.
>
> Maybe I'm misreading it. And no, none of this matters. But since I saw
> the patch fly by, and slub.o mentioned, I thought I'd point out how
> silly this all is. It's optimizing a code-path that is basically never
> taken, and when it *is* taken, it can be improved further, I think.

True, but as mentioned above, the slub.o code was used to illustrate
the effect of the patch. The new locking primitive should be usable in
a general way and could be also used in other places.

[1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-=
Address-Spaces

Uros.
