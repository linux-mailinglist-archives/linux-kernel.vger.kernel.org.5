Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816177E5F71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjKHUrs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 15:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:47:46 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711AD1FFA;
        Wed,  8 Nov 2023 12:47:44 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d3260385b5so91416a34.0;
        Wed, 08 Nov 2023 12:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699476463; x=1700081263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYbfzdavLbBO2X96qC9Jj/xBig9KkpEQ+EQytSx8qtw=;
        b=jxZXyhycDBZofRN6lFaNZdM9e9glMdkC32bKh7sv3faWX7iyY989dO6JNJP24JWv+O
         5lt5etOEdYJIBwRdhdvP/3Va6j49GD3WJHPUVSYCWvz/F0dEWSWrwCX62+Q/yLSb7gWp
         a2f4z4Fxy02FB1XmIfAx+Cu0QhpjnNPe3h6bBRGw/P8zyhKAdYy7P+nTJFAsB1QH+QMo
         mL8B9Zdko5+OeqOC9GkY8suOs7717ncjpHT3Pp0K4G1pYZi/HXiWbpWAnwRRK4TTNhb1
         2L21AB9QBJexk8wpcts1NM6f9H9hlkTmujDKzGOuXFCLWj/W5WWUK/ozP6f6ll7x4UV5
         xJhg==
X-Gm-Message-State: AOJu0YyK8jHyBMQQYVTneCNBeXJUgqdcUyGumIlb2fqRugzIG6pPECvV
        F2Yn6om3zSdd27SSbZ6tpstKIijcFa/sdA==
X-Google-Smtp-Source: AGHT+IHIZ3vqBGEL4YIXgb9YVKDU6Z0f2fdmz4hDjS3gRZ4no7WRaRn4WReex2R9i4sGarkpZsf7Fg==
X-Received: by 2002:a05:6830:2691:b0:6c4:6af2:ea72 with SMTP id l17-20020a056830269100b006c46af2ea72mr1947153otu.3.1699476463583;
        Wed, 08 Nov 2023 12:47:43 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id v2-20020a056830090200b006b9cc67386fsm1975626ott.66.2023.11.08.12.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 12:47:43 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b587bd1a63so622308b6e.1;
        Wed, 08 Nov 2023 12:47:43 -0800 (PST)
X-Received: by 2002:a81:4756:0:b0:59f:699b:c3b3 with SMTP id
 u83-20020a814756000000b0059f699bc3b3mr5987326ywa.0.1699476150732; Wed, 08 Nov
 2023 12:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20231108125843.3806765-1-arnd@kernel.org> <20231108125843.3806765-11-arnd@kernel.org>
In-Reply-To: <20231108125843.3806765-11-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Nov 2023 21:42:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgdn_cMq0YeqPu3sUeM5cEYbCoodxu8XwCGiRJ-vFsyw@mail.gmail.com>
Message-ID: <CAMuHMdXgdn_cMq0YeqPu3sUeM5cEYbCoodxu8XwCGiRJ-vFsyw@mail.gmail.com>
Subject: Re: [PATCH 10/22] microblaze: include linux/cpu.h for trap_init() prototype
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
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
        "David S. Miller" <davem@davemloft.net>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Nov 8, 2023 at 2:01 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Microblaze runs into a single -Wmissing-prototypes warning when that is
> enabled:
>
> arch/microblaze/kernel/traps.c:21:6: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
>
> Include the right header to avoid this.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

>  arch/alpha/kernel/traps.c      | 1 +
>  arch/csky/include/asm/traps.h  | 2 --
>  arch/csky/kernel/traps.c       | 1 +
>  arch/m68k/coldfire/vectors.c   | 3 +--
>  arch/m68k/coldfire/vectors.h   | 3 ---

Ah, so this is where the m68k changes listed in the cover letter are
hiding ;-)

>  arch/microblaze/kernel/traps.c | 1 +
>  arch/sparc/kernel/traps_32.c   | 1 +
>  arch/sparc/kernel/traps_64.c   | 1 +
>  arch/x86/include/asm/traps.h   | 1 -
>  arch/x86/kernel/traps.c        | 1 +
>  10 files changed, 7 insertions(+), 8 deletions(-)
>  delete mode 100644 arch/m68k/coldfire/vectors.h

Obviously the non-microblaze changes should be spun off in separate
patches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
