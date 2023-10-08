Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D917BD059
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbjJHVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjJHVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:41:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A159D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 14:41:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so6934918a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696801312; x=1697406112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e3K46u8zfExXHmFTfWuyAKJzhx6jk+xJTytgfR+yIjo=;
        b=XpOW50MFUDY07srGFNRQqq9kLTxSdT+ZX9sk69hGV/h+QQpETK2g21NeiYsGJjP41P
         0qkfA1XaNtgllkK8PfpSSuab8R3w2jgSGVeoXMJbv0q1J3E5gxnAdfXrqj1H3DYSKedd
         ikC1k/Cewb3toWVNjJ8t860qMwTcCuupb5Ajnuclb+2pY3etSDnEx+6R89XeP6zQ9pJj
         0kfe6Y/gqlbcvuylj2Ak9tCT0Z4rioayVlXF1r4TwjAB7hpP+pyoHhsAU8A6VVpU3jkM
         XuMUm7wrGsAIbVMOhSO4oK+CMvd7J0I6ODB9z8fBysNsxoXGEiEywEmPmj0LrNtmun0c
         9Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696801312; x=1697406112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3K46u8zfExXHmFTfWuyAKJzhx6jk+xJTytgfR+yIjo=;
        b=i8nzmEQdY/mUUat7JajNcSgu2U/NSoEbpTMYoVzvVM2eZlgMpCga6w+anrORp/YerZ
         1q+Ewih02poK/2ERsTSLOqSqNgrydspCq2BawgkZlERK/Gup626yRdweNHksrljLTtCn
         fTRDo7D7Fqcka1JuY2X0uiwi0EEDJVbrd67aoHtkrvUNED3JiSJLSPx8YeNN8JstQyMx
         rRFEhhwyG9Mwj1zzHV7yRYxoDiiNHc0ouwQ45OoOT+KF6tQ9GYO1u8Oe/WvInWxocBy2
         REHUax4uE9X7Hv8ZikhraMlkpEJoaZslGBimwUpIclcbkFIf1+E6WL1is/mvCx2AvxU8
         g3hA==
X-Gm-Message-State: AOJu0Yy2JlG+qdu0T191bvUr91JAfhqFJvOLYPf5+Ha4UP71NFOyFYgo
        yYGWtQxL/G1urtR9FaeLUpNex+qUu3VS2IzTT04=
X-Google-Smtp-Source: AGHT+IGfG4ey7ihGRTh6+BdSjIa4JZuFeIoHji73ClnD7tfBHtMrhN0OYHzD1I2cPfsvyfjIFNzY7euoTOPdax29kNA=
X-Received: by 2002:aa7:da99:0:b0:52c:164:efe5 with SMTP id
 q25-20020aa7da99000000b0052c0164efe5mr11480003eds.39.1696801311680; Sun, 08
 Oct 2023 14:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com> <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
In-Reply-To: <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 8 Oct 2023 23:41:39 +0200
Message-ID: <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000007005cf06073b57cd"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007005cf06073b57cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 8, 2023 at 10:48=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 8 Oct 2023 at 13:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Your dump does end up being close to a %gs access:
>
> Bah. I should have looked closer at the instructions before the oops.
>
> Because I think that's exactly the problem here. That's the KASAN
> checks that have been added, and we have this insane code:
>
> >   10: 48 c7 c0 10 73 02 00 mov    $0x27310,%rax
> >   17: 48 ba 00 00 00 00 00 movabs $0xdffffc0000000000,%rdx
> >   1e: fc ff df
> >   21: 48 c1 e8 03          shr    $0x3,%rax
> >   25:* 80 3c 10 00          cmpb   $0x0,(%rax,%rdx,1) <-- trapping inst=
ruction
>
> Look how both %rax and %rdx are constants, yet then gcc has generated
> that crazy "shift a constant value right by three bits, and then use
> an addressing mode to add it to another constant".

Hm, the compiler knows perfectly well how to make compound addresses,
but all this KASAN stuff is a bit special.

> And that 0xdffffc0000000000 constant is KASAN_SHADOW_OFFSET.
>
> So what I think is going on is trivial - and has nothing to do with order=
ing.
>
> I think gcc is simply doing a KASAN check on a percpu address.
>
> Which it shouldn't do, and didn't use to do because we did the access
> using inline asm.
>
> But now that gcc does the accesses as normal (albeit special address
> space) memory accesses, the KASAN code triggers on them too, and it
> all goes to hell in a handbasket very quickly.

Yes, I can confirm that. The failing .config from Linux Kernel Test
project works perfectly well after KASAN has been switched off.

So, the patch to fix the issue could be as simple as the one attached
to the message.

> End result: those percpu accessor functions need to disable any KASAN
> checking or other sanitizer checking. Not on the percpu address,
> because that's not a "real" address, it's obviously just the offset
> from the segment register.
>
> We have some other cases like that, see __read_once_word_nocheck().
>
> And gcc should probably not have generated such code in the first
> place, so arguably this is a bug with -fsanitize=3Dkernel-address. How
> does gcc handle the thread pointers with address sanitizer? Does it
> convert them into real pointers first, and didn't realize that it
> can't do it for __seg_gs?

I don't know this part of the compiler well, but it should not touch
non-default namespaces. I'll file a bug report there.

Thanks,
Uros.

--0000000000007005cf06073b57cd
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnhzjzd30>
X-Attachment-Id: f_lnhzjzd30

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnCmluZGV4IGVj
YjI1Njk1NDM1MS4uMWVkZjRhNWI5M2NhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9LY29uZmlnCisr
KyBiL2FyY2gveDg2L0tjb25maWcKQEAgLTIzOTMsNyArMjM5Myw3IEBAIGNvbmZpZyBDQ19IQVNf
TkFNRURfQVMKIAogY29uZmlnIFVTRV9YODZfU0VHX1NVUFBPUlQKIAlkZWZfYm9vbCB5Ci0JZGVw
ZW5kcyBvbiBDQ19IQVNfTkFNRURfQVMgJiYgU01QCisJZGVwZW5kcyBvbiBDQ19IQVNfTkFNRURf
QVMgJiYgU01QICYmICFLQVNBTgogCiBjb25maWcgQ0NfSEFTX1NMUwogCWRlZl9ib29sICQoY2Mt
b3B0aW9uLC1taGFyZGVuLXNscz1hbGwpCg==
--0000000000007005cf06073b57cd--
