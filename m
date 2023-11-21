Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7C7F26B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjKUHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKUHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:54:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBED9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:53:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28397a2c402so2711622a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700553239; x=1701158039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n94+xDIkUOqQeszLqyF1GvL8Xx0iP7KzdJ36tDGQoLY=;
        b=FYLLvUEwsMqttI+5JckkwIMcCzZcBLvmmk50zS1nJV09DWpS7lCL8JiIBMFFT96/JI
         4MgRhH8RL1aJu6n66ZZAK/2+c5C0dOkslLtBf3LNJdagfWKzZS3LWPd2f7oNhFz/gHr2
         w/JXCPTDIiU4uIxF8RPUf6O2D7E6ssbHa7i4QdFmgCxqrzfyGg+MtmAqywZX3dx6q0b3
         CfRm0F8+r304/BFzUeTnWMZPeaJfUCQ7HS4kBxlXg/o4mBBhi128XkCh2UHwG8KH7i3T
         HrqshIkW+TT/lr8x9GCwdhrkViRfXRwiCaEd2IXIRLa/tQwIJ4ba0esMlbWrCrLX6NJe
         blFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700553239; x=1701158039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n94+xDIkUOqQeszLqyF1GvL8Xx0iP7KzdJ36tDGQoLY=;
        b=D+IKXwUe4Jgpym1u3XU6rcoGnDVE9FkWRuIoXRXGFuFNN0n0uybk93TatsVEj+iUJQ
         ct64wbintZkTHb5CD+hk4qS7kv8MWVS2QlGfuXyUn4iyCzlnXL5p40x4S+7+Vw29gc6g
         bggVjaqJA7oUl2sOyD702v9qdZUyJ4BP4v5cOtIx6oCOJj79sIhuHJ18m4gMeV4wRxPW
         DTdkMN64bt98W4XVbiEfSm2nK+pk5BYgBqIoExazfakQJW9N2HyQj/Gpy52RULltatf9
         rvNYOUb6a0LdZ+mJqLq04FnDJ7vThSrXZnpaaK+XJNS0V+haPkuIRaCHDtZVka+f44iq
         ORoQ==
X-Gm-Message-State: AOJu0YzgFburpO3TgPbrQmiGx39SJg434TYjFs0/9gViwXcpn6jq1SnC
        pB8s43YkTFRyZhSxStxkMW5wIZBFnh9i6iXBt1dI+Q==
X-Google-Smtp-Source: AGHT+IFEH3g7IKb8uSXGkQLcfDFQGeKgdMM5+Twg24L86I2m/VOT+I8Lea+NYKy/4gFSwZ3WTdUJVHHh1PwvYjXVr94=
X-Received: by 2002:a17:90a:8b01:b0:280:f534:6b9c with SMTP id
 y1-20020a17090a8b0100b00280f5346b9cmr7974497pjn.21.1700553238477; Mon, 20 Nov
 2023 23:53:58 -0800 (PST)
MIME-Version: 1.0
References: <CALrw=nHpRQQaQTP_jZfREgrQEMpS8jBF8JQCv4ygqXycE-StaA@mail.gmail.com>
 <ZVwMzXxWkgonIAfc@MiWiFi-R3L-srv>
In-Reply-To: <ZVwMzXxWkgonIAfc@MiWiFi-R3L-srv>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 21 Nov 2023 07:53:47 +0000
Message-ID: <CALrw=nG8xsYw7XKyL_VMHtKiaBcQCKvC8UVp-C9-BdeN4A1Daw@mail.gmail.com>
Subject: Re: Potential config regression after 89cde455 ("kexec: consolidate
 kexec and crash options into kernel/Kconfig.kexec")
To:     Baoquan He <bhe@redhat.com>, eric_devolder@yahoo.com
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        kernel@xen0n.name, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, frederic@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, samitolvanen@google.com,
        juerg.haefliger@canonical.com, arnd@arndb.de,
        rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        kirill.shutemov@linux.intel.com, anshuman.khandual@arm.com,
        ziy@nvidia.com, masahiroy@kernel.org, ndesaulniers@google.com,
        mhiramat@kernel.org, ojeda@kernel.org, thunder.leizhen@huawei.com,
        xin3.li@intel.com, tj@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, tsi@tuyoix.net,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 1:50=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Eric DeVolder's Oracle mail address is not available anymore, add his
> current mail address he told me.

Thank you!

> On 11/20/23 at 10:52pm, Ignat Korchagin wrote:
> > Good day!
> >
> > We have recently started to evaluate Linux 6.6 and noticed that we
> > cannot disable CONFIG_KEXEC anymore, but keep CONFIG_CRASH_DUMP
> > enabled. It seems to be related to commit 89cde455 ("kexec:
> > consolidate kexec and crash options into kernel/Kconfig.kexec"), where
> > a CONFIG_KEXEC dependency was added to CONFIG_CRASH_DUMP.
> >
> > In our current kernel (Linux 6.1) we only enable CONFIG_KEXEC_FILE
> > with enforced signature check to support the kernel crash dumping
> > functionality and would like to keep CONFIG_KEXEC disabled for
> > security reasons [1].
> >
> > I was reading the long commit message, but the reason for adding
> > CONFIG_KEXEC as a dependency for CONFIG_CRASH_DUMP evaded me. And I
> > believe from the implementation perspective CONFIG_KEXEC_FILE should
> > suffice here (as we successfully used it for crashdumps on Linux 6.1).
> >
> > Is there a reason for adding this dependency or is it just an
> > oversight? Would some solution of requiring either CONFIG_KEXEC or
> > CONFIG_KEXEC_FILE work here?
>
> I searched the patch history, found Eric didn't add the dependency on
> CONFIG_KEXEC at the beginning. Later a linux-next building failure with
> randconfig was reported, in there CONFIG_CRASH_DUMP enabled, while
> CONFIG_KEXEC is disabled. Finally Eric added the KEXEC dependency for
> CRASH_DUMP. Please see below link for more details:
>
> https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@oracle.c=
om/T/#u

Thank you for digging this up. However I'm still confused, because
this is exactly how we configure Linux 6.1 (although we do have
CONFIG_KEXEC_FILE enabled) and we don't have any problems. I believe
we did not investigate this issue properly.

> And besides, the newly added CONFIG_CRASH_HOTPLUG also needs
> CONFIG_KEXEC if the elfcorehdr is allowed to be manipulated when
> cpu/memory hotplug hapened.

This still feels like a regression to me: any crash dump support
should be independent of KEXEC syscalls being present. While probably
the common case (including us) that the crashing kernel and recovery
kernel are the same, they don't have to be. We need kexec syscall in
the crashing kernel, but crashdump support in the recovery kernel (but
the recovery kernel not having the kexec syscalls should be totally
fine). If we do require some code definitions from kexec - at most we
should put them under CONFIG_KEXEC_CORE.

> Thanks
> Baoquan
>
