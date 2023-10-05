Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAE7BA6B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjJEQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjJEQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE897D99
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:41:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so1045403a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696491665; x=1697096465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub4SbvJZIBTTOm+vLGBixykTBKO190h0Hw/1II6U3Uo=;
        b=jfxuozjSS18Qamq3q+F9gv2Pe18aCSNMwRo+dXWI1zHtUWedMxUghU5a8ophiu0/rt
         1IAjyh+MlW+NvzdJXRRJo2U3v0hkXvuSNbYEdfyt3IpNHrz1zQzrM6hxjBLf5E/CFv3n
         XxLtvaAB1PxPWvuHe7Hzm5vg5hckmaR97nPGnOJ0fQV8FCpiwQkUlMQCPR07w5r0aTWP
         0o5+lAdhjSGQ4MVdS7aVGcjKVWrnL4BOQKpAmpod5bmbpDvco/bVN58NiqSfX5pAp9vZ
         Mlux6U1zdYy+cfewW3KcU4AcqaxPr8Z+eSV8YifolpCnB4mHQ4p9i26mJLjbPJpGSv0j
         ILzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696491665; x=1697096465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub4SbvJZIBTTOm+vLGBixykTBKO190h0Hw/1II6U3Uo=;
        b=ljO5LiSyRetOHp3niXT5peHk1sVkFzFx1pyNTCLLslZlbsq02+ABJfSVR1NkFx1MQQ
         qM7THNuPEDy/uXrYZYgmsIyuGnVAEm98GK4KXLSkKBje7EsABWU6tUYq7AueFFxO/o6p
         QcNGMqzjJRo8azvRcMea4QtPN0rnFTIm2bYJPi3/Ry/5Rcgo7Ei5gO5KYYsCuYd7xaFu
         30+o7NmULSq8LUROteSgqEV7VwzbI+KWdkLz7ArZ8KYocBgPt/oX7cM9cE3hYkWWNuK2
         MgWP7Nt8q4IHYuLER452RTm95wAEaVIL7o0sqsb4yx58a0AjFiVoUfJz+mqpnGQr5rzK
         9R6Q==
X-Gm-Message-State: AOJu0YwItYh9VXJSJUU3BU4GhFVSY5safcTqAxN9quaPRofXenSekwIa
        pQPnzCw2hM/V/+ZsMchPSE75lzyy+/FZ3VVFasFqCMcYkOht94gn
X-Google-Smtp-Source: AGHT+IErQcgdKNtK4XX8ekD+Xwwaeho/9xnlOvmTebarOxF39xMwtLcco0lLKIBAVBOoyw6zmpEX1YruVxy3fRBtwbU=
X-Received: by 2002:aa7:d489:0:b0:523:37ff:1170 with SMTP id
 b9-20020aa7d489000000b0052337ff1170mr3770181edr.16.1696491664488; Thu, 05 Oct
 2023 00:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <ZR2U4DLycLT5xFH6@gmail.com> <20231004192404.31733-1-ubizjak@gmail.com>
 <ZR5gaXIE50J0oCeH@gmail.com>
In-Reply-To: <ZR5gaXIE50J0oCeH@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 5 Oct 2023 09:40:53 +0200
Message-ID: <CAFULd4Zz1w6OBgCn4oKCp2u5AUO4kKd-aBSpaKV=T__iYEdmsA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 9:06=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > The percpu code mostly uses inline assembly. Using segment qualifiers
> > allows to use C code instead, which enables the compiler to perform
> > various optimizations (e.g. propagation of memory arguments). Convert
> > percpu read and write accessors to C code, so the memory argument can
> > be propagated to the instruction that uses this argument.
>
> >    text    data     bss     dec     hex filename
> > 25508862        4386540  808388 30703790        1d480ae vmlinux-vanilla=
.o
> > 25500922        4386532  808388 30695842        1d461a2 vmlinux-new.o
>
> Ok, this all looks like a pretty nice optimization.

This is just the beginning, named AS enables several other
optimizations, as can be seen in Nadav's original patch series. If we
want to make the kernel PIE, then we have to get rid of the absolute
address in percpu_stable_op (AKA this_cpu_read_stable). We can use
__raw_cpu_read, but PATCH 7/7 [1] optimizes even further.

> As discussed previously, I've created a new tip:x86/percpu topic branch
> for this, based on tip:x86/asm that carries the other percpu patches.
> This branch will be merged in v6.8, best-case scenario.
>
> Also note that I lowered the version cutoff from GCC 13.1 to 12.1, for
> the simple selfish reason to include my own daily systems in test coverag=
e.
>
> Is there any known bug fixed in the GCC 12.1 ... 13.1 version range that
> could make this approach problematic?

Not that I know of. I have done all of the work with GCC 12.3.1 (the
default Fedora 37 compiler) and additionally tested with GCC 13.2.1
(Fedora 38). I have made the patched kernel the default kernel on my
main workstation, and haven't encountered any problems since I
installed it a week ago.

If there are any problems encountered with the compiler, we (the GCC
compiler authors) can and will fix them promptly. I'd push for all
supported GCC versions, but maybe not just yet ;)

[1] https://lore.kernel.org/lkml/20190823224424.15296-8-namit@vmware.com/

Uros.
