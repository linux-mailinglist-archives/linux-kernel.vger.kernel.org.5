Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61347A7470
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjITHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjITHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:40:25 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED5130;
        Wed, 20 Sep 2023 00:40:19 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5712b68dbc0so3735386eaf.1;
        Wed, 20 Sep 2023 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695195618; x=1695800418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y//mcqepO87JWsJ0Vw521wL8mh9/ml4p7g1NN9TJbSU=;
        b=GTXFsL/MDi3BqfWLcElBespBNa1+U6yYKpB/tS+6kE+bKn0vZnfAz1+4M1qmhXLpiM
         RliQTATfRlOiTa0lkSmBpnwY9tLiXWra2VOPUEzm8seDUBZFgEXKRPcWJWEfsbrFwPLM
         2ChAkV/5S0uyUxy6Rapl84cEgCqRSNbIEPaZB067IU0KTqyw3EoWriuJ+ZNJRq2cECQ8
         S7JGiRtQPh7JoJy101ATamfDTiD1phGGTlozYoGyH6IFm/svZeDohB2irbNLi2pvSjgU
         TLVaJxXk6FVbFf/6PUHOfHeemXAPXxKYN7WRlyB4b8RUmLNW6R3LfdIsUIuxmKlqU+Lv
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195618; x=1695800418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y//mcqepO87JWsJ0Vw521wL8mh9/ml4p7g1NN9TJbSU=;
        b=Uaj4Nya6xMxPfKYsHjIwU0F9A7zqnh2ata79U7rEvgomPo7An7yAwhwLjaSQXqp5YT
         b8ftzCLcN0fbFj7X79bPnvzAtzUaL8DS2zL+ezJ13cvXrJD/0nZehr+Rho6i6ljraoFG
         4B3qy83Bp9w8Bn5ygrYUsX2OkYReO4uoZaJXH9/hYYxbWtnmuJSzMK0uFztKcF02mMh1
         b85cF0PN9cEQeDc7zs6dv6yoXVqd9CBWxkOVxqKe3re0FpDJE2LcXjL3AX3RrO6ah4PE
         Pb8szI5xhT1qi5PITCc8zY46+0dAx3CXtGA8weSSkKKANUuZYcu+vAluw4t6LQXxoIsK
         Egng==
X-Gm-Message-State: AOJu0Yz6G4U9lWM4CPz7bRbcoAa9VvXzbQ41XspCfm+xeSwr7BtNwj0x
        tO0yUGC0XRiQyNRj5COqtlf/KqGxQ2BE+j9aibM=
X-Google-Smtp-Source: AGHT+IGrC9bHvDUlxweLsvu/t9RjF0z84NqFOkkMPAU5RvInLk2ooXy9TaJ/PgC9TCQSq+ILRXuDc/Ka6TVeMFlqWSc=
X-Received: by 2002:a4a:2a55:0:b0:570:fdf2:41f0 with SMTP id
 x21-20020a4a2a55000000b00570fdf241f0mr1844775oox.1.1695195617965; Wed, 20 Sep
 2023 00:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230919193948.465340-1-alessandro.carminati@gmail.com> <20230920085251.a4e68173ee2539f695182810@kernel.org>
In-Reply-To: <20230920085251.a4e68173ee2539f695182810@kernel.org>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Wed, 20 Sep 2023 09:39:41 +0200
Message-ID: <CAPp5cGS96hcv3GK5n4EdvA9eGf3YnzkCqL01eZPw_RzHMhPoyQ@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami,

Thank you for the feedback.


Il giorno mer 20 set 2023 alle ore 01:52 Masami Hiramatsu
<mhiramat@kernel.org> ha scritto:
>
> On Tue, 19 Sep 2023 19:39:48 +0000
> "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com> wrote:
>
> > It is not uncommon for drivers or modules related to similar peripherals
> > to have symbols with the exact same name.
> > While this is not a problem for the kernel's binary itself, it becomes an
> > issue when attempting to trace or probe specific functions using
> > infrastructure like ftrace or kprobe.
> >
> > The tracing subsystem relies on the `nm -n vmlinux` output, which provides
> > symbol information from the kernel's ELF binary. However, when multiple
> > symbols share the same name, the standard nm output does not differentiate
> > between them. This can lead to confusion and difficulty when trying to
> > probe the intended symbol.
> >
> >  ~ # cat /proc/kallsyms | grep " name_show"
> >  ffffffff8c4f76d0 t name_show
> >  ffffffff8c9cccb0 t name_show
> >  ffffffff8cb0ac20 t name_show
> >  ffffffff8cc728c0 t name_show
> >  ffffffff8ce0efd0 t name_show
> >  ffffffff8ce126c0 t name_show
> >  ffffffff8ce1dd20 t name_show
> >  ffffffff8ce24e70 t name_show
> >  ffffffff8d1104c0 t name_show
> >  ffffffff8d1fe480 t name_show
> >
> > kas_alias addresses this challenge by enhancing symbol names with
> > meaningful suffixes generated from the source file and line number
> > during the kernel build process.
> > These newly generated aliases provide tracers with the ability to
> > comprehend the symbols they are interacting with when utilizing the
> > ftracefs interface.
> > This approach may also allow for the probing by name of previously
> > inaccessible symbols.
> >
> >  ~ # cat /proc/kallsyms | grep gic_mask_irq
> >  ffffd15671e505ac t gic_mask_irq
> >  ffffd15671e505ac t gic_mask_irq@drivers_irqchip_irq_gic_c_167
> >  ffffd15671e532a4 t gic_mask_irq
> >  ffffd15671e532a4 t gic_mask_irq@drivers_irqchip_irq_gic_v3_c_407
> >  ~ #
> >
> > Changes from v1:
> > - Integrated changes requested by Masami to exclude symbols with prefixes
> >   "_cfi" and "_pfx".
> > - Introduced a small framework to handle patterns that need to be excluded
> >   from the alias production.
> > - Excluded other symbols using the framework.
> > - Introduced the ability to discriminate between text and data symbols.
> > - Added two new config symbols in this version: CONFIG_KALLSYMS_ALIAS_DATA,
> >   which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, which
> >   excludes all filters and provides an alias for each duplicated symbol.
> >
> > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carminati@gmail.com/
> >
> > Changes from v2:
> > - Alias tags are created by querying DWARF information from the vmlinux.
> > - The filename + line number is normalized and appended to the original
> >   name.
> > - The tag begins with '@' to indicate the symbol source.
> > - Not a change, but worth mentioning, since the alias is added to the
> >   existing list, the old duplicated name is preserved, and the livepatch
> >   way of dealing with duplicates is maintained.
> > - Acknowledging the existence of scenarios where inlined functions
> >   declared in header files may result in multiple copies due to compiler
> >   behavior, though it is not actionable as it does not pose an operational
> >   issue.
> > - Highlighting a single exception where the same name refers to different
> >   functions: the case of "compat_binfmt_elf.c," which directly includes
> >   "binfmt_elf.c" producing identical function copies in two separate
> >   modules.
> >
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/
> >
> > Changes from v3:
> > - kas_alias was rewritten in Python to create a more concise and
> >   maintainable codebase.
> > - The previous automation process used by kas_alias to locate the vmlinux
> >   and the addr2line has been replaced with an explicit command-line switch
> >   for specifying these requirements.
> > - addr2line has been added into the main Makefile.
> > - A new command-line switch has been introduced, enabling users to extend
> >   the alias to global data names.
> >
> > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carminati@gmail.com/
> >
> > NOTE:
> > About the symbols name duplication that happens as consequence of the
> > inclusion compat_binfmt_elf.c does, it is evident that this corner is
> > inherently challenging the addr2line approach.
> > Attempting to conceal this limitation would be counterproductive.
> >
> > compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't help
> > but report all functions and data declared by that file, coming from
> > binfmt_elf.c.
> >
> > My position is that, rather than producing a more complicated pipeline
> > to handle this corner case, it is better to fix the compat_binfmt_elf.c
> > anomaly.
> >
> > This patch does not deal with the two potentially problematic symbols
> > defined by compat_binfmt_elf.c
>
> Hi, it looks good but if I build with O=<build dir>, I have this error.
>
> /ksrc/linux/scripts/link-vmlinux.sh: 176: scripts/kas_alias.py: not found
>
> Maybe something wrong with setting the path?

You're spot on.
Switching from C to Python for kas_alias has this little quirk where it
doesn't end up in the target script directory anymore. So, if you're using
a specific target build directory, you'll have to hunt down the script in
the source tree. I'll sort this out once I've collected all the feedback.

Regards
Alessandro
