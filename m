Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9B7C5B77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjJKSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:42:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2990
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:42:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so319137a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697049747; x=1697654547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xa3SsozLlYO5ODz73j4kYUYN5qoC1HuM+qYhUOOMgOE=;
        b=RoCAoTHpiCqJGyFKB5ZXefK+1lWK7w+RJVt/TsmUbB5UzSJAh+uMEQoYIXkIReVDCW
         ssT7NFaQ2X8r5lFVbFAk8HL7vw21V8AMeMtjZ5eaSC1zFvWhbtha7bQphppRFJgaiIBF
         qiBl5PIBEIDusnjHsgEs21dJJ5Ghf/0sChS6vFkUEBuEe3kH4XfhZWBG2bybbiJEJ2tj
         hE5f/ls1MsRW205EdaH+2dQwIXx+sLunjnBn3sKgn64Ga+6+Y1NJ5MD/T8dbCe+Vv+pu
         O9eOFiiw7g+sd4JzLxlSKvQN8q0U/lbNFleQgqq46TB+mzEtUi654x6QYNAHHc7yFhdq
         ESjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049747; x=1697654547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xa3SsozLlYO5ODz73j4kYUYN5qoC1HuM+qYhUOOMgOE=;
        b=Pnx5dlwxO29UqFiYsVrG4M1nOrHRZ6apDY8smO5xoqBo5eYPVAbpILAltwnpEgN7KH
         HIacv3uk1ovdxp0s5zD7sM8rFh/6NVDsYWfn+VpSXTnCARLG9yQMZDlPcdnrP2ZfpZH6
         xqJWkmYm2TTdQbEJM77u2dQkCYMvoEt5QKY4u2E9mhRF/sgTT2OBAt/E0SuZ4AQ2ArEs
         nIligifNzXTxJguc1nP3p/PcDptBOVwi9TyQu+1mo1pwJ6T9AnH/ChpywGhvyrhF17XG
         Ae69hQfkyVe7OlWlpSUQ038FI5ClzCqiyXtnBTXpE0Lwe/NiTnE+AWbXQgz+4nxLnlKd
         ugPQ==
X-Gm-Message-State: AOJu0YyGAvSGRVMVq0psgZsUTQqfkGAl+3pXjyVfPURlb0yAMVZz9Qg7
        uVxq2a9htKEisfram5oVtM4vHi1g2IDS14U29f0=
X-Google-Smtp-Source: AGHT+IFNEtK8FfD2w9gqyIzCgoF0pf+00J3O71afhxoUp1po5dulaSkheTdsSYa6ZJAG/imgkzRzDo86rEqVy4gpBXs=
X-Received: by 2002:a05:6402:2072:b0:53d:ec99:271 with SMTP id
 bd18-20020a056402207200b0053dec990271mr1583739edb.33.1697049746888; Wed, 11
 Oct 2023 11:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com> <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
In-Reply-To: <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 11 Oct 2023 20:42:15 +0200
Message-ID: <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000548ea20607752fc2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000548ea20607752fc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 8:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 10 Oct 2023 at 11:41, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Yes, but does it CSE the load from multiple addresses?
>
> Yes, it should do that just right, because the *asm* itself is
> identical, just the offsets (that gcc then adds separately) would be
> different.
>
> This is not unlike how we depend on gcc CSE'ing the "current" part
> when doing multiple accesses of different members off that:
>
>     static __always_inline struct task_struct *get_current(void)
>     {
>         return this_cpu_read_stable(pcpu_hot.current_task);
>     }
>
> with this_cpu_read_stable() being an inline asm that lacks the memory
> component (the same way the fallback hides it by just using
> "%%gs:this_cpu_off" directly inside the asm, instead of exposing it as
> a memory access to gcc).
>
> Of course, I think that with the "__seg_gs" patches, we *could* expose
> the "%%gs:this_cpu_off" part to gcc, since gcc hopefully then can do
> the alias analysis on that side and see that it can CSE the thing
> anyway.
>
> That might be a better choice than __FORCE_ORDER, in fact.
>
> IOW, something like
>
>     static __always_inline unsigned long new_cpu_offset(void)
>     {
>         unsigned long res;
>         asm(ALTERNATIVE(
>                         "movq " __percpu_arg(1) ",%0",
>                         "rdgsbase %0",
>                         X86_FEATURE_FSGSBASE)
>                 : "=3Dr" (res)
>                 : "m" (this_cpu_off));
>         return res;
>     }
>
> would presumably work together with your __seg_gs stuff.
>
> UNTESTED!!

The attached patch was tested on a target with fsgsbase CPUID and
without it. It works!

The patch improves amd_pmu_enable_virt() in the same way as reported
in the original patch submission and also reduces the number of percpu
offset reads (either from this_cpu_off or with rdgsbase) from 1663 to
1571.

The only drawback is a larger binary size:

  text    data     bss     dec     hex filename
25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o

that increases by 31k (0.123%), probably due to 1578 rdgsbase alternatives.

I'll prepare and submit a patch for tip/percpu branch.

Uros.


>
>             Linus

--000000000000548ea20607752fc2
Content-Type: text/plain; charset="US-ASCII"; name="cpu_ptr-mainline.diff.txt"
Content-Disposition: attachment; filename="cpu_ptr-mainline.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnm2oyzb0>
X-Attachment-Id: f_lnm2oyzb0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggMzQ3MzRkNzMwNDYzLi44NDUwZmU0YTI3NTMgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC0zMSwxOCArMzEsMzIgQEAKICNkZWZpbmUgX19wZXJjcHVfcHJl
Zml4CQkiJSUiX19zdHJpbmdpZnkoX19wZXJjcHVfc2VnKSI6IgogI2RlZmluZSBfX215X2NwdV9v
ZmZzZXQJCXRoaXNfY3B1X3JlYWQodGhpc19jcHVfb2ZmKQogCi0vKgotICogQ29tcGFyZWQgdG8g
dGhlIGdlbmVyaWMgX19teV9jcHVfb2Zmc2V0IHZlcnNpb24sIHRoZSBmb2xsb3dpbmcKLSAqIHNh
dmVzIG9uZSBpbnN0cnVjdGlvbiBhbmQgYXZvaWRzIGNsb2JiZXJpbmcgYSB0ZW1wIHJlZ2lzdGVy
LgotICovCi0jZGVmaW5lIGFyY2hfcmF3X2NwdV9wdHIocHRyKQkJCQlcCi0oewkJCQkJCQlcCi0J
dW5zaWduZWQgbG9uZyB0Y3BfcHRyX187CQkJXAotCWFzbSAoImFkZCAiIF9fcGVyY3B1X2FyZygx
KSAiLCAlMCIJCVwKLQkgICAgIDogIj1yIiAodGNwX3B0cl9fKQkJCQlcCi0JICAgICA6ICJtIiAo
dGhpc19jcHVfb2ZmKSwgIjAiIChwdHIpKTsJCVwKLQkodHlwZW9mKCoocHRyKSkgX19rZXJuZWwg
X19mb3JjZSAqKXRjcF9wdHJfXzsJXAorI2lmZGVmIENPTkZJR19YODZfNjQKKyNkZWZpbmUgYXJj
aF9yYXdfY3B1X3B0cihwdHIpCQkJCQlcCisoewkJCQkJCQkJXAorCXVuc2lnbmVkIGxvbmcgdGNw
X3B0cl9fOwkJCQlcCisJYXNtIChBTFRFUk5BVElWRSgibW92cSAiIF9fcGVyY3B1X2FyZygxKSAi
LCAlMCIsCVwKKwkJCSAicmRnc2Jhc2UgJTAiLAkJCQlcCisJCQkgWDg2X0ZFQVRVUkVfRlNHU0JB
U0UpCQkJXAorCSAgICAgOiAiPXIiICh0Y3BfcHRyX18pCQkJCQlcCisJICAgICA6ICJtIiAodGhp
c19jcHVfb2ZmKSk7CQkJCVwKKwkJCQkJCQkJXAorCXRjcF9wdHJfXyArPSAodW5zaWduZWQgbG9u
ZykocHRyKTsJCQlcCisJKHR5cGVvZigqKHB0cikpIF9fa2VybmVsIF9fZm9yY2UgKil0Y3BfcHRy
X187CQlcCiB9KQorI2Vsc2UgLyogQ09ORklHX1g4Nl82NCAqLworI2RlZmluZSBhcmNoX3Jhd19j
cHVfcHRyKHB0cikJCQkJCVwKKyh7CQkJCQkJCQlcCisJdW5zaWduZWQgbG9uZyB0Y3BfcHRyX187
CQkJCVwKKwlhc20gKCJtb3ZsICIgX19wZXJjcHVfYXJnKDEpICIsICUwIgkJCVwKKwkgICAgIDog
Ij1yIiAodGNwX3B0cl9fKQkJCQkJXAorCSAgICAgOiAibSIgKHRoaXNfY3B1X29mZikpOwkJCQlc
CisJCQkJCQkJCVwKKwl0Y3BfcHRyX18gKz0gKHVuc2lnbmVkIGxvbmcpKHB0cik7CQkJXAorCSh0
eXBlb2YoKihwdHIpKSBfX2tlcm5lbCBfX2ZvcmNlICopdGNwX3B0cl9fOwkJXAorfSkKKyNlbmRp
ZiAvKiBDT05GSUdfWDg2XzY0ICovCisKICNlbHNlCiAjZGVmaW5lIF9fcGVyY3B1X3ByZWZpeAkJ
IiIKICNlbmRpZgo=
--000000000000548ea20607752fc2--
