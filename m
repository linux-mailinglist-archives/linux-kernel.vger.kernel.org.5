Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088F7E9951
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjKMJqq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 04:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:46:44 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB410D0;
        Mon, 13 Nov 2023 01:46:41 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-da41acaea52so4271543276.3;
        Mon, 13 Nov 2023 01:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868800; x=1700473600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwzQbtIpe+t3wqED8YWdB5pI957h93jq9NhhCumia7w=;
        b=OygbZ605ujsm19xrEu5PBDjeQR7F4c435VNLCMPVfi0wvJhI7co0M6fYAkoiqmcI1Z
         Yh7F8lyxnMIlcJIDITy/zS0akpMy9J/8BfdbmdbbeFRg8x0v7HA+yXAmeF1qK/JyAMTR
         ksSG7RsWRgVqTX65ogAZTXDDbrONKDwfen7wQlbdf4CvGxF/++pZoXsBCJQvcYIV71ZY
         IiT84o4zK0Ux5eoe0yJWG+nsZsVPj8vq2xYK2MTFVFrBaWZ0xko9Z4/V4nFp3skmvdvn
         o1NplzQC4u4lfYlLGci2Cb0bg9BrQLjuMEalp64YcQ2VqhuzhlYYWZsk4MJxnjXLp6y/
         DdAg==
X-Gm-Message-State: AOJu0Yzc/tuqtIMxf8HSb9ivC9ZTWyMYNXR8nbXkBhp3gZuheTHFpS8D
        SPgYId/NHyImOYHasTrB65IScv6Ik14aeA==
X-Google-Smtp-Source: AGHT+IFXVwV4e0H99wNWhSTg+Q/YTf7vpBF+BUGx/TeF2yPhuDMHqqtuXUZNp6yYoE868yHK+F8azg==
X-Received: by 2002:a25:ad92:0:b0:d86:357:e314 with SMTP id z18-20020a25ad92000000b00d860357e314mr5432430ybi.47.1699868800501;
        Mon, 13 Nov 2023 01:46:40 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id u11-20020a05690201cb00b00d974c72068fsm1446651ybh.4.2023.11.13.01.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:46:39 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so4297454276.0;
        Mon, 13 Nov 2023 01:46:39 -0800 (PST)
X-Received: by 2002:a25:42d2:0:b0:da0:c8d1:5c5 with SMTP id
 p201-20020a2542d2000000b00da0c8d105c5mr5227362yba.41.1699868799056; Mon, 13
 Nov 2023 01:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20231108125843.3806765-18-arnd@kernel.org> <202311090843.b8ISrsV1-lkp@intel.com>
 <87h6lu8ed8.fsf@mail.lhotse>
In-Reply-To: <87h6lu8ed8.fsf@mail.lhotse>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2023 10:46:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxpKwkvU5fcZXLdjRAuaBqj3JxE4JtBcEW55EzidxhCQ@mail.gmail.com>
Message-ID: <CAMuHMdVxpKwkvU5fcZXLdjRAuaBqj3JxE4JtBcEW55EzidxhCQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Nov 10, 2023 at 4:42 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> kernel test robot <lkp@intel.com> writes:
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on next-20231108]
> > [cannot apply to v6.6]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/ida-make-ida_dump-static/20231109-005742
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/20231108125843.3806765-18-arnd%40kernel.org
> > patch subject: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
> > config: powerpc64-randconfig-001-20231109 (https://download.01.org/0day-ci/archive/20231109/202311090843.b8ISrsV1-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311090843.b8ISrsV1-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311090843.b8ISrsV1-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    arch/powerpc/platforms/ps3/gelic_udbg.c:59:1: warning: alignment 1 of 'struct debug_block' is less than 32 [-Wpacked-not-aligned]
> >       59 | } __packed;
> >          | ^
> >>> arch/powerpc/platforms/ps3/gelic_udbg.c:240:6: error: redefinition of 'udbg_shutdown_ps3gelic'
> >      240 | void udbg_shutdown_ps3gelic(void)
> >          |      ^~~~~~~~~~~~~~~~~~~~~~
> >    In file included from arch/powerpc/platforms/ps3/gelic_udbg.c:17:
> >    arch/powerpc/include/asm/ps3.h:520:20: note: previous definition of 'udbg_shutdown_ps3gelic' with type 'void(void)'
> >      520 | static inline void udbg_shutdown_ps3gelic(void) {}
> >          |                    ^~~~~~~~~~~~~~~~~~~~~~
>
> As pointed out by Arnd this is due to there being two symbols that
> control the gelic_udbg.c code.
>
> I don't see the need for PS3GELIC_UDBG, without PPC_EARLY_DEBUG_PS3GELIC
> it just causes gelic_udbg.c to be built, but never called.

My first thought was: PPC_EARLY_DEBUG_PS3GELIC is meant as an early
debugging console, while PS3GELIC_UDBG can be used with xmon later,
but that does not seem to be the case.

> The diff below fixes the error AFAICS.

So your changes on top LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
