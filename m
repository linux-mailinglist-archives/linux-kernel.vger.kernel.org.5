Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160047A372C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjIQSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbjIQSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:33:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9B94;
        Sun, 17 Sep 2023 11:33:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so60295021fa.3;
        Sun, 17 Sep 2023 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694975616; x=1695580416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94+/FxvYRL5z0MINdWqlWoO6PcgiG12ebXRGY2RbA3c=;
        b=YpWlv62CotP85BRriZex1MK/cjaUKO37bJQR2FYvD+cWq0u5Ho2MNaz7V0X3fC9w3X
         N5ETBWlk7O/lhzL5v3HPLwBo/jNhWOq5lSJ/zST/jzE40vLPLbOJV5pGwW3Nb5RqISj0
         Ek6gmpu5EDvM+pLVPnyNvkGwZlKP7J9a5DcGC7Nxq7v0r8GnKaqPNXClwxgbHKiMfNaK
         PpTbaEsR5GQcM0S3x3A11NfGqrq8udREDPsj+LQ7HUQoVYmUO9u3Ml5L5dkCcbdUpjHG
         A655A1sdelqndzOK5DXKMzG04GG92BTNxJVP6R2y6s97NhZ6reAFyohmUhHwXQY/b+v2
         DwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694975616; x=1695580416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94+/FxvYRL5z0MINdWqlWoO6PcgiG12ebXRGY2RbA3c=;
        b=gCi0oyKGX33g50EtBGYgZs9Nj4M43nO1w/LtQvEvczaFRphrIjApT786qTHiJnSDOY
         OWhmEdwNH8jpQ5WC1yttHsaiVkCxZBI9qq0Mc9uWOaDBYOFwMYEC4zK5XB7IoIzQq4vI
         KaW7RCiK6e9T5irZ/CIoshYBlVv/8eN5hbMA9DMEkJZBcZRn/NHv3thDg2NN1JqNUT2Y
         jzQcwdy9gM3DxrdfH6cQ9g45b7r5M3c/fiVhXL1iTImoac6csEkLaceoNEg+urqqH/KH
         GQ+0IDIqUXMiBXNXQCJsBNz7HTceIsmjTnYpwJyglIh0f5zGxTZRQa+rnK5phrO3HHHR
         QdUQ==
X-Gm-Message-State: AOJu0YxqAaiPyqd5JZe2Gf1SJAXxX5wDIgQHU52WF5jQ0ntv6A2KYl6u
        pujbEufZ8MXiCcy6mi9MtlQtUUAJ0KxjWjpavZU=
X-Google-Smtp-Source: AGHT+IEAqVCO24/yV3IOBUR7EBJjELoeuQrlITDjnfmVUmHEVhh/76YbH+5KZqgPraartsrbcFHr4FVs2E3Isx9+q0I=
X-Received: by 2002:a05:6512:39c9:b0:501:c996:1996 with SMTP id
 k9-20020a05651239c900b00501c9961996mr7721960lfu.67.1694975615672; Sun, 17 Sep
 2023 11:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230906185941.53527-1-ubizjak@gmail.com> <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
 <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com> <CAFULd4YLzRWmXG2DHeRHYY33FrX+wNOVfQFyms5Mki1mmn0VZA@mail.gmail.com>
In-Reply-To: <CAFULd4YLzRWmXG2DHeRHYY33FrX+wNOVfQFyms5Mki1mmn0VZA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 17 Sep 2023 20:33:24 +0200
Message-ID: <CAFULd4baw7wC7hemfqcGirkFVHihcnG+_a9RRQGga+CatpEagA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Content-Type: multipart/mixed; boundary="0000000000007a68fa06059243b2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007a68fa06059243b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now also with the patch attached.

Uros.

On Sun, Sep 17, 2023 at 8:31=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Fri, Sep 15, 2023 at 6:45=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 15 Sept 2023 at 04:25, tip-bot2 for Uros Bizjak
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > Several places in mm/slub.o improve from e.g.:
> > >
> > [...]
> > >
> > > to:
> > >
> > >     53bc:       48 8d 4a 40             lea    0x40(%rdx),%rcx
> > >     53c0:       49 8b 1c 07             mov    (%r15,%rax,1),%rbx
> > >     53c4:       4c 89 f8                mov    %r15,%rax
> > >     53c7:       48 8d 37                lea    (%rdi),%rsi
> > >     53ca:       e8 00 00 00 00          call   53cf <...>
> > >                         53cb: R_X86_64_PLT32     this_cpu_cmpxchg16b_=
emu-0x4
> > >     53cf:       75 bb                   jne    538c <...>
> >
> > Honestly, if y ou care deeply about this code sequence, I think you
> > should also move the "lea" out of the inline asm.
>
> I have to say that the above asm code was shown mostly as an example
> of the improvement, to illustrate how the compare sequence at the end
> of the cmpxchg loop gets eliminated. Being a fairly mechanical change,
> I didn't put much thought in the surrounding code.
>
> > Both
> >
> >     call this_cpu_cmpxchg16b_emu
> >
> > and
> >
> >     cmpxchg16b %gs:(%rsi)
> >
> > are 5 bytes, and I suspect it's easiest to just always put the address
> > in %rsi - whether you call the function or not.
> >
> > It doesn't really make the code generation for the non-call sequence
> > worse, and it gives the compiler more information (ie instead of
> > clobbering %rsi, the compiler knows what %rsi contains).
> >
> > IOW, something like this:
> >
> > -       asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call
> > this_cpu_cmpxchg16b_emu", \
> > +       asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",          =
 \
> > ...
> > -                   "c" (new__.high)                                   =
 \
> > -                 : "memory", "rsi");                                  =
 \
> > +                   "c" (new__.high),                                  =
 \
> > +                   "S" (&_var)                                   \
> > +                 : "memory");                                         =
 \
> >
> > should do it.
>
> Yes, and the above change improves slub.o assembly from (current tip
> tree with try_cmpxchg patch applied):
>
>     53b3:    41 8b 44 24 28           mov    0x28(%r12),%eax
>     53b8:    49 8b 3c 24              mov    (%r12),%rdi
>     53bc:    48 8d 4a 40              lea    0x40(%rdx),%rcx
>     53c0:    49 8b 1c 07              mov    (%r15,%rax,1),%rbx
>     53c4:    4c 89 f8                 mov    %r15,%rax
>     53c7:    48 8d 37                 lea    (%rdi),%rsi
>     53ca:    e8 00 00 00 00           call   53cf <kmem_cache_alloc+0x9f>
>             53cb: R_X86_64_PLT32    this_cpu_cmpxchg16b_emu-0x4
>     53cf:    75 bb                    jne    538c <kmem_cache_alloc+0x5c>
>
> to:
>
>     53b3:    41 8b 44 24 28           mov    0x28(%r12),%eax
>     53b8:    49 8b 34 24              mov    (%r12),%rsi
>     53bc:    48 8d 4a 40              lea    0x40(%rdx),%rcx
>     53c0:    49 8b 1c 07              mov    (%r15,%rax,1),%rbx
>     53c4:    4c 89 f8                 mov    %r15,%rax
>     53c7:    e8 00 00 00 00           call   53cc <kmem_cache_alloc+0x9c>
>             53c8: R_X86_64_PLT32    this_cpu_cmpxchg16b_emu-0x4
>     53cc:    75 be                    jne    538c <kmem_cache_alloc+0x5c>
>
> where an effective reg-reg move "lea (%rdi), %rsi" at 537c gets
> removed. And indeed, GCC figures out that %rsi holds the address of
> the variable and emits:
>
>    5:    65 48 0f c7 0e           cmpxchg16b %gs:(%rsi)
>
> alternative replacement.
>
> Now, here comes the best part: We can get rid of the %P modifier. With
> named address spaces (__seg_gs), older GCCs had some problems with %P
> and emitted "%gs:foo" instead of foo, resulting in "Warning: segment
> override on `lea' is ineffectual" assembly warning. With the proposed
> change, we use:
>
> --cut here--
> int __seg_gs g;
>
> void foo (void)
> {
>   asm ("%0 %1" :: "m"(g), "S"(&g));
> }
> --cut here--
>
> and get the desired assembly:
>
>        movl    $g, %esi
>        %gs:g(%rip) %rsi
>
> The above is also in line with [1], where it is said that
> "[__seg_gs/__seg_fs] address spaces are not considered to be subspaces
> of the generic (flat) address space." So, cmpxchg16b_emu.S must use
> %gs to apply segment base offset, which it does.
>
> > Note that I think this is particularly true of the slub code, because
> > afaik, the slub code will *only* use the slow call-out.
> >
> > Why? Because if the CPU actually supports the cmpxchgb16 instruction,
> > then the slub code won't even take this path at all - it will do the
> > __CMPXCHG_DOUBLE path, which does an unconditional locked cmpxchg16b.
> >
> > Maybe I'm misreading it. And no, none of this matters. But since I saw
> > the patch fly by, and slub.o mentioned, I thought I'd point out how
> > silly this all is. It's optimizing a code-path that is basically never
> > taken, and when it *is* taken, it can be improved further, I think.
>
> True, but as mentioned above, the slub.o code was used to illustrate
> the effect of the patch. The new locking primitive should be usable in
> a general way and could be also used in other places.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Name=
d-Address-Spaces
>
> Uros.

--0000000000007a68fa06059243b2
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lmnsp9lt0>
X-Attachment-Id: f_lmnsp9lt0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggYTg3ZGI2MTQwZmUyLi4zMzFhOWQ0ZGNlODIgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC0yNDIsMTQgKzI0MiwxNSBAQCBkbyB7CQkJCQkJCQkJXAogCW9s
ZF9fLnZhciA9IF9vdmFsOwkJCQkJCVwKIAluZXdfXy52YXIgPSBfbnZhbDsJCQkJCQlcCiAJCQkJ
CQkJCQlcCi0JYXNtIHF1YWwgKEFMVEVSTkFUSVZFKCJsZWFsICVQW3Zhcl0sICUlZXNpOyBjYWxs
IHRoaXNfY3B1X2NtcHhjaGc4Yl9lbXUiLCBcCisJYXNtIHF1YWwgKEFMVEVSTkFUSVZFKCJjYWxs
IHRoaXNfY3B1X2NtcHhjaGc4Yl9lbXUiLAkJXAogCQkJICAgICAgImNtcHhjaGc4YiAiIF9fcGVy
Y3B1X2FyZyhbdmFyXSksIFg4Nl9GRUFUVVJFX0NYOCkgXAogCQkgIDogW3Zhcl0gIittIiAoX3Zh
ciksCQkJCQlcCiAJCSAgICAiK2EiIChvbGRfXy5sb3cpLAkJCQkJXAogCQkgICAgIitkIiAob2xk
X18uaGlnaCkJCQkJCVwKIAkJICA6ICJiIiAobmV3X18ubG93KSwJCQkJCVwKLQkJICAgICJjIiAo
bmV3X18uaGlnaCkJCQkJCVwKLQkJICA6ICJtZW1vcnkiLCAiZXNpIik7CQkJCQlcCisJCSAgICAi
YyIgKG5ld19fLmhpZ2gpLAkJCQkJXAorCQkgICAgIlMiICgmX3ZhcikJCQkJCQlcCisJCSAgOiAi
bWVtb3J5Iik7CQkJCQkJXAogCQkJCQkJCQkJXAogCW9sZF9fLnZhcjsJCQkJCQkJXAogfSkKQEAg
LTI3MSw3ICsyNzIsNyBAQCBkbyB7CQkJCQkJCQkJXAogCW9sZF9fLnZhciA9ICpfb3ZhbDsJCQkJ
CQlcCiAJbmV3X18udmFyID0gX252YWw7CQkJCQkJXAogCQkJCQkJCQkJXAotCWFzbSBxdWFsIChB
TFRFUk5BVElWRSgibGVhbCAlUFt2YXJdLCAlJWVzaTsgY2FsbCB0aGlzX2NwdV9jbXB4Y2hnOGJf
ZW11IiwgXAorCWFzbSBxdWFsIChBTFRFUk5BVElWRSgiY2FsbCB0aGlzX2NwdV9jbXB4Y2hnOGJf
ZW11IiwJCVwKIAkJCSAgICAgICJjbXB4Y2hnOGIgIiBfX3BlcmNwdV9hcmcoW3Zhcl0pLCBYODZf
RkVBVFVSRV9DWDgpIFwKIAkJICBDQ19TRVQoeikJCQkJCQlcCiAJCSAgOiBDQ19PVVQoeikgKHN1
Y2Nlc3MpLAkJCQlcCkBAIC0yNzksOCArMjgwLDkgQEAgZG8gewkJCQkJCQkJCVwKIAkJICAgICIr
YSIgKG9sZF9fLmxvdyksCQkJCQlcCiAJCSAgICAiK2QiIChvbGRfXy5oaWdoKQkJCQkJXAogCQkg
IDogImIiIChuZXdfXy5sb3cpLAkJCQkJXAotCQkgICAgImMiIChuZXdfXy5oaWdoKQkJCQkJXAot
CQkgIDogIm1lbW9yeSIsICJlc2kiKTsJCQkJCVwKKwkJICAgICJjIiAobmV3X18uaGlnaCksCQkJ
CQlcCisJCSAgICAiUyIgKCZfdmFyKQkJCQkJCVwKKwkJICA6ICJtZW1vcnkiKTsJCQkJCQlcCiAJ
aWYgKHVubGlrZWx5KCFzdWNjZXNzKSkJCQkJCQlcCiAJCSpfb3ZhbCA9IG9sZF9fLnZhcjsJCQkJ
CVwKIAlsaWtlbHkoc3VjY2Vzcyk7CQkJCQkJXApAQCAtMzA5LDE0ICszMTEsMTUgQEAgZG8gewkJ
CQkJCQkJCVwKIAlvbGRfXy52YXIgPSBfb3ZhbDsJCQkJCQlcCiAJbmV3X18udmFyID0gX252YWw7
CQkJCQkJXAogCQkJCQkJCQkJXAotCWFzbSBxdWFsIChBTFRFUk5BVElWRSgibGVhcSAlUFt2YXJd
LCAlJXJzaTsgY2FsbCB0aGlzX2NwdV9jbXB4Y2hnMTZiX2VtdSIsIFwKKwlhc20gcXVhbCAoQUxU
RVJOQVRJVkUoImNhbGwgdGhpc19jcHVfY21weGNoZzE2Yl9lbXUiLAkJXAogCQkJICAgICAgImNt
cHhjaGcxNmIgIiBfX3BlcmNwdV9hcmcoW3Zhcl0pLCBYODZfRkVBVFVSRV9DWDE2KSBcCiAJCSAg
OiBbdmFyXSAiK20iIChfdmFyKSwJCQkJCVwKIAkJICAgICIrYSIgKG9sZF9fLmxvdyksCQkJCQlc
CiAJCSAgICAiK2QiIChvbGRfXy5oaWdoKQkJCQkJXAogCQkgIDogImIiIChuZXdfXy5sb3cpLAkJ
CQkJXAotCQkgICAgImMiIChuZXdfXy5oaWdoKQkJCQkJXAotCQkgIDogIm1lbW9yeSIsICJyc2ki
KTsJCQkJCVwKKwkJICAgICJjIiAobmV3X18uaGlnaCksCQkJCQlcCisJCSAgICAiUyIgKCZfdmFy
KQkJCQkJCVwKKwkJICA6ICJtZW1vcnkiKTsJCQkJCQlcCiAJCQkJCQkJCQlcCiAJb2xkX18udmFy
OwkJCQkJCQlcCiB9KQpAQCAtMzM4LDcgKzM0MSw3IEBAIGRvIHsJCQkJCQkJCQlcCiAJb2xkX18u
dmFyID0gKl9vdmFsOwkJCQkJCVwKIAluZXdfXy52YXIgPSBfbnZhbDsJCQkJCQlcCiAJCQkJCQkJ
CQlcCi0JYXNtIHF1YWwgKEFMVEVSTkFUSVZFKCJsZWFxICVQW3Zhcl0sICUlcnNpOyBjYWxsIHRo
aXNfY3B1X2NtcHhjaGcxNmJfZW11IiwgXAorCWFzbSBxdWFsIChBTFRFUk5BVElWRSgiY2FsbCB0
aGlzX2NwdV9jbXB4Y2hnMTZiX2VtdSIsCQlcCiAJCQkgICAgICAiY21weGNoZzE2YiAiIF9fcGVy
Y3B1X2FyZyhbdmFyXSksIFg4Nl9GRUFUVVJFX0NYMTYpIFwKIAkJICBDQ19TRVQoeikJCQkJCQlc
CiAJCSAgOiBDQ19PVVQoeikgKHN1Y2Nlc3MpLAkJCQlcCkBAIC0zNDYsOCArMzQ5LDkgQEAgZG8g
ewkJCQkJCQkJCVwKIAkJICAgICIrYSIgKG9sZF9fLmxvdyksCQkJCQlcCiAJCSAgICAiK2QiIChv
bGRfXy5oaWdoKQkJCQkJXAogCQkgIDogImIiIChuZXdfXy5sb3cpLAkJCQkJXAotCQkgICAgImMi
IChuZXdfXy5oaWdoKQkJCQkJXAotCQkgIDogIm1lbW9yeSIsICJyc2kiKTsJCQkJCVwKKwkJICAg
ICJjIiAobmV3X18uaGlnaCksCQkJCQlcCisJCSAgICAiUyIgKCZfdmFyKQkJCQkJCVwKKwkJICA6
ICJtZW1vcnkiKTsJCQkJCQlcCiAJaWYgKHVubGlrZWx5KCFzdWNjZXNzKSkJCQkJCQlcCiAJCSpf
b3ZhbCA9IG9sZF9fLnZhcjsJCQkJCVwKIAlsaWtlbHkoc3VjY2Vzcyk7CQkJCQkJXAo=
--0000000000007a68fa06059243b2--
