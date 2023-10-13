Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4777C8514
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJMLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:53:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB5BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:53:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso3756463a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697198022; x=1697802822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5wBQDCPhCWlWzMxSldR9pNHTZGfP5MCipasrlMdn8s=;
        b=WmgDiWTHm0HI7ulXprXIHWb7GNlKrsRONGYtMbGSL+HIDcqVpWqx0mD5sCi5L54EpW
         VcZ7hVG9zR25qnymWxhTJyyK/3/yYJYFDox6K/2G5MfFo+CWpx5LQ6NdmvSDnin9sXAL
         /SN4WCFU/Up4InF3mYGjs7Q74yEkx4gNbF446A7Wf7yb9EEawO/8d+3WBs3lIM/kNFFC
         QtqrHEdvVTjFX2hBZD47L1HqPMj5L9k+0jbEBNo1dKsW9D9qMGvsf2mAY80y7vvhWdMA
         l00qTgJe1o6VKaZSghJcILSSCbZ4JgAQ3nwyOlTezIOo4BgkfatS1tIbo0HHnrkniq5u
         eGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697198022; x=1697802822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5wBQDCPhCWlWzMxSldR9pNHTZGfP5MCipasrlMdn8s=;
        b=usANt4GFlpcuENNaYY/b/NtQBJ/hPl+mycYuEk56xk0pIGygMneM6hLorRu5AHJzjC
         YvyR81T+vPzq6Mui5Eykq/f6yi8c8Vr+ll0NWTjiKSdjXSosrQRz2lNfmhLMAiVINAUi
         59zXYIFoKqUBFl94hEaBi/Gh3q04HegbYNlqkc6qjOFn9IHzT1b3/TFlTfnZ9/lrHSzB
         P+CljvjmZvmpivXHsOFKAV9grpeOYGiaIfMam7KyhzNlJVuPfMDwzPUHPrnkAcyS/OgM
         NHRcTCjNf7bRfi3W1BFdEf/dYaGqt8abgW5ZZvZs+jBJzpAKOmS35GvC2e8uC2NF0zNw
         ulXQ==
X-Gm-Message-State: AOJu0YyIPE4+kuwQ/q0KUVxkLldCUwVzr5HMjmipuKfI5LPK3XVLNLsA
        EZQnCe/tXYdwGJcMERixGFRr16xxnCx70haF1LY=
X-Google-Smtp-Source: AGHT+IHb2pf+k0xAu2OvrRj07ctQjh/+hl3g0aurPnzxfeVQ1ZmvI2bxZZgR34qNJW2aqFRzJMcDaF1InY6arf+aRXc=
X-Received: by 2002:a05:6402:3228:b0:53d:b7e7:301b with SMTP id
 g40-20020a056402322800b0053db7e7301bmr7470667eda.24.1697198022179; Fri, 13
 Oct 2023 04:53:42 -0700 (PDT)
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
 <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com>
 <CAFULd4ZdfUQszrp6hKzKXosj0-yzizx+-4BZG7SzEpZPCdUFuA@mail.gmail.com> <CAFULd4Y5JocT9yRwS0Zkro-pAHihmOHP2D8fMLR29j8_Gy_nNA@mail.gmail.com>
In-Reply-To: <CAFULd4Y5JocT9yRwS0Zkro-pAHihmOHP2D8fMLR29j8_Gy_nNA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 13 Oct 2023 13:53:29 +0200
Message-ID: <CAFULd4ZfdWchq9nAQ-YGoaS9OjM-=4Lnd5YbDmrUipbtRgDdTg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000039dbe6060797b562"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000039dbe6060797b562
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 11:38=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Thu, Oct 12, 2023 at 8:01=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Thu, Oct 12, 2023 at 7:47=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, 12 Oct 2023 at 10:10, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > The fix seems to be a simple one-liner, ie just
> > > >
> > > > -       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")  =
     \
> > > > +       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")  =
     \
> > >
> > > Nope. That doesn't work at all.
> > >
> > > It turns out that we're not the only ones that didn't know about the
> > > 'a' modifier.
> > >
> > > clang has also never heard of it in this context, and the above
> > > one-liner results in an endless sea of errors, with
> > >
> > >      error: invalid operand in inline asm: 'movq %gs:${1:a}, $0'
> > >
> > > Looking around, I think it's X86AsmPrinter::PrintAsmOperand() that is
> > > supposed to handle these things, and while it does have some handling
> > > for 'a', the comment around it says
> > >
> > >     case 'a': // This is an address.  Currently only 'i' and 'r' are =
expected.
> > >
> > > and I think our use ends up just confusing the heck out of clang. Of
> > > course, clang also does this:
> > >
> > >     case 'P': // This is the operand of a call, treat specially.
> > >         PrintPCRelImm(MI, OpNo, O);
> > >         return false;
> > >
> > > so clang *already* generates those 'current' accesses as PCrelative, =
and I see
> > >
> > >         movq    %gs:pcpu_hot(%rip), %r13
> > >
> > > in the generated code.
> > >
> > > End result: clang actually generates what we want just using 'P', and
> > > the whole "P vs a" is only a gcc thing.

Maybe we should go with what Clang expects. %a with "i" constraint is
also what GCC handles, because

=E2=80=98i=E2=80=99: An immediate integer operand (one with constant value)=
 is
allowed. This includes symbolic constants whose values will be known
only at assembly time or later.

Attached patch patches both cases: the generated code for
mem_encrypt_identity.c does not change while the change in
percpu.h brings expected 4kB code size reduction. I think this is the
correct solution that will work for both compilers.

Uros.

--00000000000039dbe6060797b562
Content-Type: text/plain; charset="US-ASCII"; name="memref-2.diff.txt"
Content-Disposition: attachment; filename="memref-2.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnojvewg0>
X-Attachment-Id: f_lnojvewg0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggNjBlYTc3NTVjMGZlLi4xMmYzN2I5NTFmYTcgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC0xNzUsOSArMTc1LDkgQEAgZG8gewkJCQkJCQkJCVwKICNkZWZp
bmUgcGVyY3B1X3N0YWJsZV9vcChzaXplLCBvcCwgX3ZhcikJCQkJXAogKHsJCQkJCQkJCQlcCiAJ
X19wY3B1X3R5cGVfIyNzaXplIHBmb192YWxfXzsJCQkJCVwKLQlhc20oX19wY3B1X29wMl8jI3Np
emUob3AsIF9fZm9yY2VfcGVyY3B1X2FyZyhQW3Zhcl0pLCAiJVt2YWxdIikJXAorCWFzbShfX3Bj
cHVfb3AyXyMjc2l6ZShvcCwgX19mb3JjZV9wZXJjcHVfYXJnKGFbdmFyXSksICIlW3ZhbF0iKSBc
CiAJICAgIDogW3ZhbF0gX19wY3B1X3JlZ18jI3NpemUoIj0iLCBwZm9fdmFsX18pCQkJXAotCSAg
ICA6IFt2YXJdICJwIiAoJihfdmFyKSkpOwkJCQkJXAorCSAgICA6IFt2YXJdICJpIiAoJihfdmFy
KSkpOwkJCQkJXAogCSh0eXBlb2YoX3ZhcikpKHVuc2lnbmVkIGxvbmcpIHBmb192YWxfXzsJCQlc
CiB9KQogCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jIGIv
YXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYwppbmRleCBkNzNhZWIxNjQxN2YuLjJi
MWUwZTc4MWY5ZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHku
YworKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jCkBAIC0zNDYsOSArMzQ2
LDkgQEAgdm9pZCBfX2luaXQgc21lX2VuY3J5cHRfa2VybmVsKHN0cnVjdCBib290X3BhcmFtcyAq
YnApCiAJICogV2UncmUgcnVubmluZyBpZGVudGl0eSBtYXBwZWQsIHNvIHdlIG11c3Qgb2J0YWlu
IHRoZSBhZGRyZXNzIHRvIHRoZQogCSAqIFNNRSBlbmNyeXB0aW9uIHdvcmthcmVhIHVzaW5nIHJp
cC1yZWxhdGl2ZSBhZGRyZXNzaW5nLgogCSAqLwotCWFzbSAoImxlYSBzbWVfd29ya2FyZWEoJSVy
aXApLCAlMCIKKwlhc20gKCJsZWEgJWExLCAlMCIKIAkgICAgIDogIj1yIiAod29ya2FyZWFfc3Rh
cnQpCi0JICAgICA6ICJwIiAoc21lX3dvcmthcmVhKSk7CisJICAgICA6ICJpIiAoc21lX3dvcmth
cmVhKSk7CiAKIAkvKgogCSAqIENhbGN1bGF0ZSByZXF1aXJlZCBudW1iZXIgb2Ygd29ya2FyZWEg
Ynl0ZXMgbmVlZGVkOgpAQCAtNTgyLDE1ICs1ODIsMTUgQEAgdm9pZCBfX2luaXQgc21lX2VuYWJs
ZShzdHJ1Y3QgYm9vdF9wYXJhbXMgKmJwKQogCSAqIGlkZW50aXR5IG1hcHBlZCwgc28gd2UgbXVz
dCBvYnRhaW4gdGhlIGFkZHJlc3MgdG8gdGhlIFNNRSBjb21tYW5kCiAJICogbGluZSBhcmd1bWVu
dCBkYXRhIHVzaW5nIHJpcC1yZWxhdGl2ZSBhZGRyZXNzaW5nLgogCSAqLwotCWFzbSAoImxlYSBz
bWVfY21kbGluZV9hcmcoJSVyaXApLCAlMCIKKwlhc20gKCJsZWEgJWExLCAlMCIKIAkgICAgIDog
Ij1yIiAoY21kbGluZV9hcmcpCi0JICAgICA6ICJwIiAoc21lX2NtZGxpbmVfYXJnKSk7Ci0JYXNt
ICgibGVhIHNtZV9jbWRsaW5lX29uKCUlcmlwKSwgJTAiCisJICAgICA6ICJpIiAoc21lX2NtZGxp
bmVfYXJnKSk7CisJYXNtICgibGVhICVhMSwgJTAiCiAJICAgICA6ICI9ciIgKGNtZGxpbmVfb24p
Ci0JICAgICA6ICJwIiAoc21lX2NtZGxpbmVfb24pKTsKLQlhc20gKCJsZWEgc21lX2NtZGxpbmVf
b2ZmKCUlcmlwKSwgJTAiCisJICAgICA6ICJpIiAoc21lX2NtZGxpbmVfb24pKTsKKwlhc20gKCJs
ZWEgJWExLCAlMCIKIAkgICAgIDogIj1yIiAoY21kbGluZV9vZmYpCi0JICAgICA6ICJwIiAoc21l
X2NtZGxpbmVfb2ZmKSk7CisJICAgICA6ICJpIiAoc21lX2NtZGxpbmVfb2ZmKSk7CiAKIAlpZiAo
SVNfRU5BQkxFRChDT05GSUdfQU1EX01FTV9FTkNSWVBUX0FDVElWRV9CWV9ERUZBVUxUKSkKIAkJ
YWN0aXZlX2J5X2RlZmF1bHQgPSB0cnVlOwo=
--00000000000039dbe6060797b562--
