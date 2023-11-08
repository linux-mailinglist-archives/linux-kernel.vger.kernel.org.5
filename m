Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4E7E5FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjKHVKX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHVKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:10:21 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8524D2580;
        Wed,  8 Nov 2023 13:10:19 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5b499b18b28so2133447b3.0;
        Wed, 08 Nov 2023 13:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477818; x=1700082618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bav5/FGayyEQonBNC4kdS6ICDtnFE4p01QngumR4dg4=;
        b=ipwWhpKRdtmh+Uh6VvmrxWywQK9Q9c1fyFkHq6ayzI/hoFkgARWPYRg7X4Xr3FzFLR
         c4G6aiTPD+wkruVmz3pRfMeLBmbpqO1HbwzQp4tUQVnIizUPo3zNjom/4AuV0V7+Lg1Q
         1q2cR3Bc7acbJnBJAdgxckR6G4u8qQqFdLJQUhvqW9CnjOyzfYL5qlagBwnqD3iSFzxX
         hLlVOnE+vbEnX/JObB4UNFIFfF1D3iTiEXAcT7nrWqwHy5qDkup5xZtILGCe101g17cK
         ZlFVoDUFUg/44K/H2HkkdNaJ+cf8Lf6IaDGVg6jg8le3yrun8Gaw6WQCOZvtSmRDk7oS
         KPQg==
X-Gm-Message-State: AOJu0Ywm+iqe0tYvEdAkpz+r3ecFqCmZWws2QYyTyarGcn3EjMhys9Br
        ncbDEwLWhmrkVazpI4Yn0jrK87BUX3QC0w==
X-Google-Smtp-Source: AGHT+IF0f+EnWpL39uPcb0Isgr8GcwJ2K7wJjaLgpat0Vo/euboSWtRuvVqOY1mQa+U4sJvOqCYELw==
X-Received: by 2002:a0d:c042:0:b0:5a7:ba51:9c1b with SMTP id b63-20020a0dc042000000b005a7ba519c1bmr2761143ywd.37.1699477818216;
        Wed, 08 Nov 2023 13:10:18 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id o14-20020a81de4e000000b005956b451fb8sm7201882ywl.100.2023.11.08.13.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 13:10:16 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5b31c5143a0so1848457b3.3;
        Wed, 08 Nov 2023 13:10:16 -0800 (PST)
X-Received: by 2002:a0d:f3c2:0:b0:59b:54b5:7d66 with SMTP id
 c185-20020a0df3c2000000b0059b54b57d66mr2960037ywf.34.1699477816210; Wed, 08
 Nov 2023 13:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20231108125843.3806765-1-arnd@kernel.org> <20231108125843.3806765-11-arnd@kernel.org>
 <CAMuHMdXgdn_cMq0YeqPu3sUeM5cEYbCoodxu8XwCGiRJ-vFsyw@mail.gmail.com> <e7753f82-c3de-48fc-955d-59773222aaa9@app.fastmail.com>
In-Reply-To: <e7753f82-c3de-48fc-955d-59773222aaa9@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Nov 2023 22:10:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7VfiSA9+wSJYYQkBN2=4E9HsFJRV6j8ffioe0=MFd8A@mail.gmail.com>
Message-ID: <CAMuHMdV7VfiSA9+wSJYYQkBN2=4E9HsFJRV6j8ffioe0=MFd8A@mail.gmail.com>
Subject: Re: [PATCH 10/22] microblaze: include linux/cpu.h for trap_init() prototype
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        guoren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Nov 8, 2023 at 10:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Nov 8, 2023, at 21:42, Geert Uytterhoeven wrote:
> > On Wed, Nov 8, 2023 at 2:01 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Microblaze runs into a single -Wmissing-prototypes warning when that is
> >> enabled:
> >>
> >> arch/microblaze/kernel/traps.c:21:6: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
> >>
> >> Include the right header to avoid this.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Thanks for your patch!
> >
> >>  arch/alpha/kernel/traps.c      | 1 +
> >>  arch/csky/include/asm/traps.h  | 2 --
> >>  arch/csky/kernel/traps.c       | 1 +
> >>  arch/m68k/coldfire/vectors.c   | 3 +--
> >>  arch/m68k/coldfire/vectors.h   | 3 ---
> >
> > Ah, so this is where the m68k changes listed in the cover letter are
> > hiding ;-)
> >
> >>  arch/microblaze/kernel/traps.c | 1 +
> >>  arch/sparc/kernel/traps_32.c   | 1 +
> >>  arch/sparc/kernel/traps_64.c   | 1 +
> >>  arch/x86/include/asm/traps.h   | 1 -
> >>  arch/x86/kernel/traps.c        | 1 +
> >>  10 files changed, 7 insertions(+), 8 deletions(-)
> >>  delete mode 100644 arch/m68k/coldfire/vectors.h
> >
> > Obviously the non-microblaze changes should be spun off in separate
> > patches.
>
> I messed up one of my rebases here and accidentally sent
> the wrong changelog text. My intention was to have the
> combined patch but with this text:
>
>     arch: include linux/cpu.h for trap_init() prototype
>
>     some architectures run into a -Wmissing-prototypes warning
>     for trap_init()
>
>     arch/microblaze/kernel/traps.c:21:6: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
>
>     Include the right header to avoid this consistently, removing
>     the extra declarations on m68k and x86 that were added as local
>     workarounds already.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That makes sense, although it's hard to combine this with "my preference
would be for the patches to make it through the respective subsystem
maintainer trees"...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
