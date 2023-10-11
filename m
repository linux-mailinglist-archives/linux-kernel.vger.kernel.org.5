Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84C97C5F27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjJKVdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKVdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:33:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B1A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:32:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so541767a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697059977; x=1697664777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TKrYYRaD2RfNLNfOhiIpEBPF24FekdqyFgqdK3sdhAs=;
        b=g9Itb/3gLoAMUfddb6LnLSUqreDyU5pZV6IYZnMgwVqqEk4xj4hSHO3fdk9pWvOlmn
         OydHTKU8qYGqDIpWIl53LFnv86wKBfPIGdXIL5UlUBkk5pmnVhFH54OvTpfVu9uWghXv
         fsnmxE24wIp/pKGJRWOIamk5gyE0tuL1pIOHzA6N1wq6fHbDcyFodjcaJTUWjG9oAdQf
         b9n2rSlnTBgmEg2lKHul2MCKeitn7ecCHRqM5uJKnnTcK9xYigDkBA4Evhok/nJw/OBu
         mTc6lzXXRW7u/FZND32Ls8nCmzKa6o1Vdw4mbNnQCG14oPc7M/4Q/lvsmXR63a7uy/xI
         21uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059977; x=1697664777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKrYYRaD2RfNLNfOhiIpEBPF24FekdqyFgqdK3sdhAs=;
        b=cZ/Xm5rwqaDFdyJzPeJ+UlOtkoTkvx9hAgPTAYnYLUiyTiwY7Ug0iprVhyJ5RzD+Tp
         v0nAj0lDa6SGmx5uGbmpWKJV65htLLtLZkdffgufa6/pGnT65fQZIyCnO8kkSv/qzBST
         MHvcV4Bsdu+15urpqFvM3dMCCbr/GqhkIoO0i17pSkCjmPAbxa6wLCvQQEjWY5qjxIQo
         hVxwc0U6cPYO0jludXZie6r+8eqDMTtbgnlaGXYCPjwkUxUU62hOAzhtN55Nhn089a5K
         rdrRSlABIfPbc3p/vZMxaDwvsFopavcthHsHf6eXLRAsyPq04dRrs8RSEg81fytSNG0t
         XXzA==
X-Gm-Message-State: AOJu0YyVI2PBUE3qsc3E/fPlGdl2H/99re2DVRNyaxHPGFZEvhc6lmbH
        jm2EAlUpTLtYtTyNs03ura2KjzlEtcN7woIsSVY=
X-Google-Smtp-Source: AGHT+IGWr83UShRFhoRHkdEAL+f0mbSDd1IjWXYAqqbw6lg7//IdwJs7vud9FIu4wfMGG+El+tsS8ciDOT8/vuXdPjM=
X-Received: by 2002:a05:6402:b58:b0:53d:d4a0:3154 with SMTP id
 bx24-20020a0564020b5800b0053dd4a03154mr2582378edb.31.1697059977240; Wed, 11
 Oct 2023 14:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 11 Oct 2023 23:32:45 +0200
Message-ID: <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
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
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000001b39a80607779171"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001b39a80607779171
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 9:37=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 11 Oct 2023 at 00:42, Nadav Amit <namit@vmware.com> wrote:
> >
> > You are correct. Having said that, for =E2=80=9Ccurrent" we may be able=
 to do something
> > better, as regardless to preemption =E2=80=9Ccurrent" remains the same,=
 and
> > this_cpu_read_stable() does miss some opportunities to avoid reloading =
the
> > value from memory.
>
> It would be lovely to generate even better code, but that
> this_cpu_read_stable() thing is the best we've come up with. It
> intentionally has *no* memory inputs or anything else that might make
> gcc think "I need to re-do this".

The attached patch makes this_cpu_read_stable a bit better by using
rip-relative addressing. Immediate reduction of text section by 4kB
and also makes the kernel some more PIE friendly.

> For example, instead of using "m" as a memory input, it very
> intentionally uses "p", to make it clear that that it just uses the
> _pointer_, not the memory location itself.
>
> That's obviously a lie - it actually does access memory - but it's a
> lie exactly because of the reason you mention: even when the memory
> location changes due to preemption (or explicit scheduling), it always
> changes back to the the value we care about.
>
> So gcc _should_ be able to CSE it in all situations, but it's entirely
> possible that gcc then decides to re-generate the value for whatever
> reason. It's a cheap op, so it's ok to regen, of course, but the
> intent is basically to let the compiler re-use the value as much as
> possible.
>
> But it *is* probably better to regenerate the value than it would be
> to spill and re-load it, and from the cases I've seen, this all tends
> to work fairly well.

Reading the above, it looks to me that we don't want to play games
with "const aliased" versions of current_task [1], as proposed by
Nadav in his patch series. The current version of
this_cpu_read_stable() (plus the attached trivial patch) is as good as
it can get.

[1] https://lore.kernel.org/lkml/20190823224424.15296-8-namit@vmware.com/

Uros.

--0000000000001b39a80607779171
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnm9o9ol0>
X-Attachment-Id: f_lnm9o9ol0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggZTA0N2EwYmM1NTU0Li5iNzQxNjk0MzRiODUgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC00LDggKzQsMTAgQEAKIAogI2lmZGVmIENPTkZJR19YODZfNjQK
ICNkZWZpbmUgX19wZXJjcHVfc2VnCQlncworI2RlZmluZSBfX3BlcmNwdV9yaXAJCSIoJSVyaXAp
IgogI2Vsc2UKICNkZWZpbmUgX19wZXJjcHVfc2VnCQlmcworI2RlZmluZSBfX3BlcmNwdV9yaXAJ
CSIiCiAjZW5kaWYKIAogI2lmZGVmIF9fQVNTRU1CTFlfXwpAQCAtODUsNyArODcsNyBAQAogI2Rl
ZmluZSBfX215X2NwdV9wdHIocHRyKQkoX19teV9jcHVfdHlwZSgqcHRyKSAqKSh1aW50cHRyX3Qp
KHB0cikKICNkZWZpbmUgX19teV9jcHVfdmFyKHZhcikJKCpfX215X2NwdV9wdHIoJnZhcikpCiAj
ZGVmaW5lIF9fcGVyY3B1X2FyZyh4KQkJX19wZXJjcHVfcHJlZml4ICIlIiAjeAotI2RlZmluZSBf
X2ZvcmNlX3BlcmNwdV9hcmcoeCkJX19mb3JjZV9wZXJjcHVfcHJlZml4ICIlIiAjeAorI2RlZmlu
ZSBfX2ZvcmNlX3BlcmNwdV9hcmcoeCkJX19mb3JjZV9wZXJjcHVfcHJlZml4ICIlIiAjeCBfX3Bl
cmNwdV9yaXAKIAogLyoKICAqIEluaXRpYWxpemVkIHBvaW50ZXJzIHRvIHBlci1jcHUgdmFyaWFi
bGVzIG5lZWRlZCBmb3IgdGhlIGJvb3QK
--0000000000001b39a80607779171--
