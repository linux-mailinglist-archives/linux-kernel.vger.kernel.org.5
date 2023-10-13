Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C87C8250
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjJMJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjJMJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AD95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:38:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so3341835a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697189894; x=1697794694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrzadSgsgTlC4uFU2lvzbmqnsROGfT+yADAPxLvJUbc=;
        b=Pfbs7NoInWO6/jaxpi3xTSQoVdUqFnQxOpCODoAWd+ypoSBz2xwHaSkpSRuZ/1rZxY
         f74fqcHMTw+IHNZj1+qpWQ2lKcPxtM1wSrDnWVebDLtoj1c/yBvruBx0oUYZZyOzjJcv
         AIdw9VY0GyeqUfww4KNAc++WTy7xBDq7D3GJJSRHBFUS6L+1xM1ckQuRh10cglfkYf90
         z1yOLqRXkfw+n6HDsrSc7Ekk0yW9p0ncORONUiHRWAF2g6i+iSC99hI14iuFmFJfOzbz
         lp3zcgyiSIXD6AKTSfcFKaw0Vf9Ve137DYxBg6sFaxrkS7Id9G58lJa7R1gRnO/bcRhB
         Mtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189894; x=1697794694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrzadSgsgTlC4uFU2lvzbmqnsROGfT+yADAPxLvJUbc=;
        b=HpNNPYmjW42qe8FFhw2aUZQDIfrwmILSW21bLvn6XE9F7KeWHpBzqp7wBJomg2jhR6
         5dEH3j8rxtXncMLURjQJhGDd6TSW4ISyKZuWHBQePZuHMDRzg9F1H9wPOzN62rpf1dgW
         CYcRFlHlBiBXkwxAUgzqi5zjz6jRJStGsOUZwSKTYBOzFtz6ZJk5hLXMJz2hodZsATph
         IaL1A/mdfRYOt5Cw9cQzE+EqlJKsHDu2PyzcnN6U+Bq2HhDYEqGXRSU6C5XxQbd9n2NK
         TPHwCKibukYUpnCjNwOdYU9ijf1OfT33neX4uxvHaSrKdYTscCFIEp9cF/Myqrx8MSkK
         dmJw==
X-Gm-Message-State: AOJu0Yz96hWTQVb7eeYV+hs64HyhZuaP02ZHT+yzJ8+4DUZ4TqxjFMnN
        0bTL/8BKX4AB4QvmLjdpiwNJcwMDkp/eBWP0+jw=
X-Google-Smtp-Source: AGHT+IFC2l0dKbmk5L2CWl20eFCVR64gyKwMwVR09fBSniA03uVOaJWiajBSO8N2uxjKcZQlGHdp+YwS0+MCAYapzwk=
X-Received: by 2002:a50:ee84:0:b0:532:bed7:d0dd with SMTP id
 f4-20020a50ee84000000b00532bed7d0ddmr25307669edr.5.1697189893461; Fri, 13 Oct
 2023 02:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com>
 <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
 <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com> <CAFULd4ZdfUQszrp6hKzKXosj0-yzizx+-4BZG7SzEpZPCdUFuA@mail.gmail.com>
In-Reply-To: <CAFULd4ZdfUQszrp6hKzKXosj0-yzizx+-4BZG7SzEpZPCdUFuA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 13 Oct 2023 11:38:01 +0200
Message-ID: <CAFULd4Y5JocT9yRwS0Zkro-pAHihmOHP2D8fMLR29j8_Gy_nNA@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="000000000000b76f50060795d072"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b76f50060795d072
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 8:01=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Thu, Oct 12, 2023 at 7:47=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 12 Oct 2023 at 10:10, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > The fix seems to be a simple one-liner, ie just
> > >
> > > -       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")    =
   \
> > > +       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")    =
   \
> >
> > Nope. That doesn't work at all.
> >
> > It turns out that we're not the only ones that didn't know about the
> > 'a' modifier.
> >
> > clang has also never heard of it in this context, and the above
> > one-liner results in an endless sea of errors, with
> >
> >      error: invalid operand in inline asm: 'movq %gs:${1:a}, $0'
> >
> > Looking around, I think it's X86AsmPrinter::PrintAsmOperand() that is
> > supposed to handle these things, and while it does have some handling
> > for 'a', the comment around it says
> >
> >     case 'a': // This is an address.  Currently only 'i' and 'r' are ex=
pected.
> >
> > and I think our use ends up just confusing the heck out of clang. Of
> > course, clang also does this:
> >
> >     case 'P': // This is the operand of a call, treat specially.
> >         PrintPCRelImm(MI, OpNo, O);
> >         return false;
> >
> > so clang *already* generates those 'current' accesses as PCrelative, an=
d I see
> >
> >         movq    %gs:pcpu_hot(%rip), %r13
> >
> > in the generated code.
> >
> > End result: clang actually generates what we want just using 'P', and
> > the whole "P vs a" is only a gcc thing.
>
> Ugh, this isn't exactly following Clang's claim that "In general,
> Clang is highly compatible with the GCC inline assembly extensions,
> allowing the same set of constraints, modifiers and operands as GCC
> inline assembly."

For added fun I obtained some old clang:

$ clang --version
clang version 11.0.0 (Fedora 11.0.0-3.fc33)

and tried to compile this:

int m;
__seg_gs int n;

void foo (void)
{
  asm ("# %a0 %a1" :: "p" (&m), "p" (&n));
  asm ("# %P0 %P1" :: "p" (&m), "p" (&n));
}

clang-11:

       # m n
       # m n

clang-11 -fpie:

       # m(%rip) n(%rip)
       # m n

clang-11 -m32:

       # m n
       # m n

gcc:

       # m(%rip) n(%rip)
       # m n

gcc -fpie:

       # m(%rip) n(%rip)
       # m n

gcc -m32:

       # m n
       # m n

Please find attached a patch that should bring some order to this
issue. The patch includes two demonstration sites, the generated code
for mem_encrypt_identity.c does not change while the change in
percpu.h brings expected 4kB code size reduction.

Uros.

--000000000000b76f50060795d072
Content-Type: text/plain; charset="US-ASCII"; name="memref.diff.txt"
Content-Disposition: attachment; filename="memref.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnof0qsl0>
X-Attachment-Id: f_lnof0qsl0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NvbXBpbGVyLmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9jb21waWxlci5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAw
MDAwMC4uMzdjOWRlYTUwYmU2Ci0tLSAvZGV2L251bGwKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vY29tcGlsZXIuaApAQCAtMCwwICsxLDE2IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMCAqLworI2lmbmRlZiBfX0FTTV9YODZfQ09NUElMRVJfSAorI2RlZmluZSBfX0FT
TV9YODZfQ09NUElMRVJfSAorCisvKgorICogU3Vic3RpdHV0ZSBhIG1lbW9yeSByZWZlcmVuY2Us
IHdpdGggdGhlIGFjdHVhbAorICogb3BlcmFuZCB0cmVhdGVkIGFzIHRoZSBhZGRyZXNzLgorICov
CisKKyNpZmRlZiBfX2NsYW5nX18KKyNkZWZpbmUgX19tZW1yZWYoeCkJCSIlUCIgI3gKKyNlbHNl
CisjZGVmaW5lIF9fbWVtcmVmKHgpCQkiJWEiICN4CisjZW5kaWYKKworI2VuZGlmIC8qIF9fQVNN
X1g4Nl9DT01QSUxFUl9IICovCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJj
cHUuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCmluZGV4IDYwZWE3NzU1YzBmZS4u
OTJiOGQ2MGEzYmY1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaApAQCAtMjYsNiArMjYsNyBAQAogCiAj
aW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgvc3RyaW5naWZ5Lmg+Cisj
aW5jbHVkZSA8YXNtL2NvbXBpbGVyLmg+CiAKICNpZmRlZiBDT05GSUdfU01QCiAKQEAgLTcxLDcg
KzcyLDcgQEAKICNkZWZpbmUgX19teV9jcHVfcHRyKHB0cikJKF9fbXlfY3B1X3R5cGUoKnB0cikg
KikodWludHB0cl90KShwdHIpCiAjZGVmaW5lIF9fbXlfY3B1X3Zhcih2YXIpCSgqX19teV9jcHVf
cHRyKCZ2YXIpKQogI2RlZmluZSBfX3BlcmNwdV9hcmcoeCkJCV9fcGVyY3B1X3ByZWZpeCAiJSIg
I3gKLSNkZWZpbmUgX19mb3JjZV9wZXJjcHVfYXJnKHgpCV9fZm9yY2VfcGVyY3B1X3ByZWZpeCAi
JSIgI3gKKyNkZWZpbmUgX19mb3JjZV9wZXJjcHVfbWVtcmVmKHgpIF9fZm9yY2VfcGVyY3B1X3By
ZWZpeCBfX21lbXJlZih4KQogCiAvKgogICogSW5pdGlhbGl6ZWQgcG9pbnRlcnMgdG8gcGVyLWNw
dSB2YXJpYWJsZXMgbmVlZGVkIGZvciB0aGUgYm9vdApAQCAtMTc1LDcgKzE3Niw3IEBAIGRvIHsJ
CQkJCQkJCQlcCiAjZGVmaW5lIHBlcmNwdV9zdGFibGVfb3Aoc2l6ZSwgb3AsIF92YXIpCQkJCVwK
ICh7CQkJCQkJCQkJXAogCV9fcGNwdV90eXBlXyMjc2l6ZSBwZm9fdmFsX187CQkJCQlcCi0JYXNt
KF9fcGNwdV9vcDJfIyNzaXplKG9wLCBfX2ZvcmNlX3BlcmNwdV9hcmcoUFt2YXJdKSwgIiVbdmFs
XSIpCVwKKwlhc20oX19wY3B1X29wMl8jI3NpemUob3AsIF9fZm9yY2VfcGVyY3B1X21lbXJlZihb
dmFyXSksICIlW3ZhbF0iKSBcCiAJICAgIDogW3ZhbF0gX19wY3B1X3JlZ18jI3NpemUoIj0iLCBw
Zm9fdmFsX18pCQkJXAogCSAgICA6IFt2YXJdICJwIiAoJihfdmFyKSkpOwkJCQkJXAogCSh0eXBl
b2YoX3ZhcikpKHVuc2lnbmVkIGxvbmcpIHBmb192YWxfXzsJCQlcCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRf
aWRlbnRpdHkuYwppbmRleCBkNzNhZWIxNjQxN2YuLjY3NjhmNTg2YWI1MSAxMDA2NDQKLS0tIGEv
YXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYworKysgYi9hcmNoL3g4Ni9tbS9tZW1f
ZW5jcnlwdF9pZGVudGl0eS5jCkBAIC00Myw2ICs0Myw3IEBACiAKICNpbmNsdWRlIDxhc20vc2V0
dXAuaD4KICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4KKyNpbmNsdWRlIDxhc20vY29tcGlsZXIu
aD4KICNpbmNsdWRlIDxhc20vY21kbGluZS5oPgogI2luY2x1ZGUgPGFzbS9jb2NvLmg+CiAjaW5j
bHVkZSA8YXNtL3Nldi5oPgpAQCAtNTgyLDEzICs1ODMsMTMgQEAgdm9pZCBfX2luaXQgc21lX2Vu
YWJsZShzdHJ1Y3QgYm9vdF9wYXJhbXMgKmJwKQogCSAqIGlkZW50aXR5IG1hcHBlZCwgc28gd2Ug
bXVzdCBvYnRhaW4gdGhlIGFkZHJlc3MgdG8gdGhlIFNNRSBjb21tYW5kCiAJICogbGluZSBhcmd1
bWVudCBkYXRhIHVzaW5nIHJpcC1yZWxhdGl2ZSBhZGRyZXNzaW5nLgogCSAqLwotCWFzbSAoImxl
YSBzbWVfY21kbGluZV9hcmcoJSVyaXApLCAlMCIKKwlhc20gKCJsZWEgIiBfX21lbXJlZigxKSAi
LCAlMCIKIAkgICAgIDogIj1yIiAoY21kbGluZV9hcmcpCiAJICAgICA6ICJwIiAoc21lX2NtZGxp
bmVfYXJnKSk7Ci0JYXNtICgibGVhIHNtZV9jbWRsaW5lX29uKCUlcmlwKSwgJTAiCisJYXNtICgi
bGVhICIgX19tZW1yZWYoMSkgIiwgJTAiCiAJICAgICA6ICI9ciIgKGNtZGxpbmVfb24pCiAJICAg
ICA6ICJwIiAoc21lX2NtZGxpbmVfb24pKTsKLQlhc20gKCJsZWEgc21lX2NtZGxpbmVfb2ZmKCUl
cmlwKSwgJTAiCisJYXNtICgibGVhICIgX19tZW1yZWYoMSkgIiwgJTAiCiAJICAgICA6ICI9ciIg
KGNtZGxpbmVfb2ZmKQogCSAgICAgOiAicCIgKHNtZV9jbWRsaW5lX29mZikpOwogCg==
--000000000000b76f50060795d072--
