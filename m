Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5A77857D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjHKCeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHKCeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B470171D;
        Thu, 10 Aug 2023 19:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50CE64FC1;
        Fri, 11 Aug 2023 02:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE632C433C9;
        Fri, 11 Aug 2023 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691721250;
        bh=XDIgMqA5lKyO/ubvawrMSVC+sUkTDuB6xZ8mKIdykUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sYP68CyktzyOxS/wa7/9wOnLtgSfpC2X2yNPr/lrriB5bLG3TW8ENlR2fg1Ro2ARK
         dEz1vBYLXnsuKWxqDStupSqjYgNff38fezgCdMtfSBnwO5Eb2ze8m1p2RAKX/fxNV9
         KoofCyqksa4kGZjDeXO4l9qZxde1j3sr2g8KlguuPxItAROs3GXiHuEUmnfnjv7yC/
         8MH+B7I4CVeIeUEmYRVB9WBHrt69NTBWx27lxkEdBYfSZooIBHO9cM8hz9ouQT0vOq
         4rbMAx6OXsnuoNKz9+yxaKtiQXjuTcUTU8eXtUctMzDTHBFNIr36xcg5XNZCjqM77w
         G7aSFCICiqY6A==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so1939363a12.2;
        Thu, 10 Aug 2023 19:34:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLBLDDMe4jZJavCMecsEwaWs/facRcLefv2NTvzOiYXbkAxJF6
        p1ZabiBKIioDATj4VHTAyQt9yyzvFdAj6SYstiw=
X-Google-Smtp-Source: AGHT+IEnqjvcSn23NP/Xog+5jYU/WwU0DlX7OoUcmrw7UAS3Yin6cNRKnlrEXUlReBzVnqyFMY18eJvmcMz3248V2Fw=
X-Received: by 2002:a05:6402:1ac7:b0:523:f4c:afe7 with SMTP id
 ba7-20020a0564021ac700b005230f4cafe7mr550503edb.38.1691721247675; Thu, 10 Aug
 2023 19:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-17-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-17-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Aug 2023 10:33:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRdbXOEBNPN14y_ZUwBJ15qBG929BDspk0sqPo2sn=L-Q@mail.gmail.com>
Message-ID: <CAJF2gTRdbXOEBNPN14y_ZUwBJ15qBG929BDspk0sqPo2sn=L-Q@mail.gmail.com>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Youling Tang <tangyouling@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xin Li <xin3.li@intel.com>, Nhat Pham <nphamcs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, Arnd, I will clean them up for the csky part.

On Thu, Aug 10, 2023 at 10:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I have cleaned up the -Wmissing-prototypes warnings for most of the major=
 architectures
> as well as all drivers that get enabled for CONFIG_COMPILE_TEST, so now t=
hese should be
> close to fixed on x86, arm, arm64, powerpc, s390, and riscv.
>
> The other architectures tend to have a lot of these warning in architectu=
re specific
> code, primarily from functions that are only called from assembler code a=
nd do
> not otherwise need a declaration but still cause a warning without one. O=
ther cases
> are simply functions that should just be static or are missing an #includ=
e statement.
>
> In order to be able to turn the warning on globally by default without br=
eaking all
> these architectures, add a list of exceptions for architecture directorie=
s that
> can revert back to the old behavior of not warning based on a new
> CONFIG_WNO_MISSING_PROTOTYPES option.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Below is the full list of warnings I see in defconfig builds for referenc=
e, these
> do not need to be part of the changelog.
>
> arch/alpha/include/asm/core_t2.h:465:20: error: no previous prototype for=
 't2_readb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:476:21: error: no previous prototype for=
 't2_readw' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:491:21: error: no previous prototype for=
 't2_readl' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:502:21: error: no previous prototype for=
 't2_readq' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:515:22: error: no previous prototype for=
 't2_writeb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:526:22: error: no previous prototype for=
 't2_writew' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:541:22: error: no previous prototype for=
 't2_writel' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:550:22: error: no previous prototype for=
 't2_writeq' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:562:31: error: no previous prototype for=
 't2_ioportmap' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:567:31: error: no previous prototype for=
 't2_ioremap' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:573:21: error: no previous prototype for=
 't2_is_ioaddr' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:578:21: error: no previous prototype for=
 't2_is_mmio' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for=
 't2_ioread16' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for=
 't2_ioread32' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for=
 't2_ioread64' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for=
 't2_ioread8' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for=
 't2_iowrite16' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for=
 't2_iowrite32' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for=
 't2_iowrite64' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for=
 't2_iowrite8' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/core_t2.h:614:33: error: no previous prototype for=
 't2_iounmap' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:115:30: error: no previous prototype for =
'jensen_local_inb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:120:22: error: no previous prototype for =
'jensen_local_outb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:126:30: error: no previous prototype for =
'jensen_bus_inb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:135:22: error: no previous prototype for =
'jensen_bus_outb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:155:20: error: no previous prototype for =
'jensen_inb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:163:22: error: no previous prototype for =
'jensen_outb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:171:21: error: no previous prototype for =
'jensen_inw' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:181:21: error: no previous prototype for =
'jensen_inl' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:187:21: error: no previous prototype for =
'jensen_inq' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:193:22: error: no previous prototype for =
'jensen_outw' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:200:22: error: no previous prototype for =
'jensen_outl' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:207:22: error: no previous prototype for =
'jensen_outq' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:218:20: error: no previous prototype for =
'jensen_readb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:230:21: error: no previous prototype for =
'jensen_readw' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:242:21: error: no previous prototype for =
'jensen_readl' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:250:21: error: no previous prototype for =
'jensen_readq' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:263:22: error: no previous prototype for =
'jensen_writeb' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:271:22: error: no previous prototype for =
'jensen_writew' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:279:22: error: no previous prototype for =
'jensen_writel' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:287:22: error: no previous prototype for =
'jensen_writeq' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:297:31: error: no previous prototype for =
'jensen_ioportmap' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:302:31: error: no previous prototype for =
'jensen_ioremap' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:308:21: error: no previous prototype for =
'jensen_is_ioaddr' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:313:21: error: no previous prototype for =
'jensen_is_mmio' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for =
'jensen_ioread16' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for =
'jensen_ioread32' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for =
'jensen_ioread64' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for =
'jensen_ioread8' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for =
'jensen_iowrite16' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for =
'jensen_iowrite32' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for =
'jensen_iowrite64' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for =
'jensen_iowrite8' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:348:33: error: no previous prototype for =
'jensen_iounmap' [-Werror=3Dmissing-prototypes]
> arch/alpha/include/asm/jensen.h:92:22: error: no previous prototype for '=
jensen_set_hae' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/bugs.c:19:9: error: no previous prototype for 'cpu_show=
_meltdown' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/bugs.c:28:9: error: no previous prototype for 'cpu_show=
_spectre_v1' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/bugs.c:37:9: error: no previous prototype for 'cpu_show=
_spectre_v2' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/console.c:39:1: error: no previous prototype for 'locat=
e_and_init_vga' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/console.c:72:1: error: no previous prototype for 'find_=
console_vga_hose' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/core_cia.c:284:1: error: no previous prototype for 'cia=
_pci_tbi_try2' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/core_cia.c:580:1: error: no previous prototype for 'cia=
_save_srm_settings' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/core_cia.c:606:1: error: no previous prototype for 'cia=
_restore_srm_settings' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/core_lca.c:481:1: error: no previous prototype for 'lca=
_clock_print' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/core_lca.c:498:1: error: no previous prototype for 'lca=
_get_clock' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/core_lca.c:508:1: error: no previous prototype for 'lca=
_clock_fiddle' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/io.c:654:1: error: no previous prototype for 'scr_memcp=
yw' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/irq.c:96:1: error: no previous prototype for 'handle_ir=
q' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/irq_alpha.c:45:1: error: no previous prototype for 'do_=
entInt' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/pci.c:285:1: error: no previous prototype for 'pcibios_=
claim_one_bus' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/ptrace.c:322:26: error: no previous prototype for 'sysc=
all_trace_enter' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/ptrace.c:334:1: error: no previous prototype for 'sysca=
ll_trace_leave' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/signal.c:205:1: error: no previous prototype for 'do_si=
greturn' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/signal.c:233:1: error: no previous prototype for 'do_rt=
_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/signal.c:523:1: error: no previous prototype for 'do_wo=
rk_pending' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/smc37c669.c:2434:1: error: no previous prototype for 'S=
MC37c669_dump_registers' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/smc37c669.c:2467:13: error: no previous prototype for '=
SMC669_Init' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/smc37c93x.c:238:12: error: no previous prototype for 'S=
MC93x_Init' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/srmcons.c:272:1: error: no previous prototype for 'regi=
ster_srm_console' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/srmcons.c:282:1: error: no previous prototype for 'unre=
gister_srm_console' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/sys_nautilus.c:131:1: error: no previous prototype for =
'nautilus_machine_check' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/sys_nautilus.c:201:1: error: no previous prototype for =
'nautilus_init_pci' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/sys_nautilus.c:82:1: error: no previous prototype for '=
nautilus_kill_arch' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/sys_sio.c:312:1: error: no previous prototype for 'sio_=
kill_arch' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/traps.c:210:1: error: no previous prototype for 'do_ent=
Arith' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/traps.c:232:1: error: no previous prototype for 'do_ent=
IF' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/traps.c:399:1: error: no previous prototype for 'do_ent=
Dbg' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/traps.c:435:1: error: no previous prototype for 'do_ent=
Una' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/traps.c:720:1: error: no previous prototype for 'do_ent=
UnaUser' [-Werror=3Dmissing-prototypes]
> arch/alpha/kernel/traps.c:975:1: error: no previous prototype for 'trap_i=
nit' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/checksum.c:145:9: error: no previous prototype for 'ip_fas=
t_csum' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/checksum.c:163:8: error: no previous prototype for 'csum_p=
artial' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/checksum.c:180:9: error: no previous prototype for 'ip_com=
pute_csum' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/checksum.c:45:9: error: no previous prototype for 'csum_tc=
pudp_magic' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/checksum.c:54:8: error: no previous prototype for 'csum_tc=
pudp_nofold' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/fpreg.c:129:1: error: no previous prototype for 'alpha_rea=
d_fp_reg_s' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/fpreg.c:186:1: error: no previous prototype for 'alpha_wri=
te_fp_reg_s' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/fpreg.c:20:1: error: no previous prototype for 'alpha_read=
_fp_reg' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/fpreg.c:75:1: error: no previous prototype for 'alpha_writ=
e_fp_reg' [-Werror=3Dmissing-prototypes]
> arch/alpha/lib/memcpy.c:153:8: error: no previous prototype for 'memcpy' =
[-Werror=3Dmissing-prototypes]
> arch/alpha/mm/fault.c:85:1: error: no previous prototype for 'do_page_fau=
lt' [-Werror=3Dmissing-prototypes]
> arch/alpha/mm/init.c:261:1: error: no previous prototype for 'srm_paging_=
stop' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/ctx_sw.c:21:1: error: no previous prototype for '__switch=
_to' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/devtree.c:20:21: error: no previous prototype for 'arc_ea=
rly_base_baud' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/irq.c:42:6: error: no previous prototype for 'arch_do_IRQ=
' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/kprobes.c:193:15: error: no previous prototype for 'arc_k=
probe_handler' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/ptrace.c:344:16: error: no previous prototype for 'syscal=
l_trace_entry' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/ptrace.c:358:17: error: no previous prototype for 'syscal=
l_trace_exit' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/setup.c:498:13: error: no previous prototype for 'handle_=
uboot_args' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/signal.c:401:6: error: no previous prototype for 'do_sign=
al' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/signal.c:434:6: error: no previous prototype for 'do_noti=
fy_resume' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/stacktrace.c:116:1: error: no previous prototype for 'arc=
_unwind_core' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:110:6: error: no previous prototype for 'do_non_s=
wi_trap' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:141:6: error: no previous prototype for 'do_inste=
rror_or_kprobe' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:68:48: error: no previous prototype for 'do_privi=
lege_fault' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:69:44: error: no previous prototype for 'do_exten=
sion_fault' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:70:48: error: no previous prototype for 'insterro=
r_is_error' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:71:52: error: no previous prototype for 'do_memor=
y_error' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:72:42: error: no previous prototype for 'trap_is_=
brkpt' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:73:44: error: no previous prototype for 'do_misal=
igned_error' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:74:56: error: no previous prototype for 'do_trap5=
_error' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:79:5: error: no previous prototype for 'do_misali=
gned_access' [-Werror=3Dmissing-prototypes]
> arch/arc/kernel/traps.c:93:6: error: no previous prototype for 'do_machin=
e_check_fault' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/cache.c:1085:22: error: no previous prototype for 'arc_ioc_se=
tup' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/cache.c:1147:13: error: no previous prototype for 'arc_cache_=
init_master' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/cache.c:584:15: error: no previous prototype for 'slc_op_rgn'=
 [-Werror=3Dmissing-prototypes]
> arch/arc/mm/cache.c:647:15: error: no previous prototype for 'slc_op_line=
' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/fault.c:72:6: error: no previous prototype for 'do_page_fault=
' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/init.c:35:13: error: no previous prototype for 'arc_get_mem_s=
z' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/init.c:83:13: error: no previous prototype for 'setup_arch_me=
mory' [-Werror=3Dmissing-prototypes]
> arch/arc/mm/tlb.c:392:6: error: no previous prototype for 'create_tlb' [-=
Werror=3Dmissing-prototypes]
> arch/arc/mm/tlb.c:723:6: error: no previous prototype for 'do_tlb_overlap=
_fault' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/ptrace.c:320:16: error: no previous prototype for 'sysca=
ll_trace_enter' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/ptrace.c:336:17: error: no previous prototype for 'sysca=
ll_trace_exit' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/setup.c:116:34: error: no previous prototype for 'csky_s=
tart' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/signal.c:255:17: error: no previous prototype for 'do_no=
tify_resume' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:150:15: error: no previous prototype for 'do_tra=
p_unknown' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:152:15: error: no previous prototype for 'do_tra=
p_zdiv' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:154:15: error: no previous prototype for 'do_tra=
p_buserr' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:157:17: error: no previous prototype for 'do_tra=
p_misaligned' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:168:17: error: no previous prototype for 'do_tra=
p_bkpt' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:187:17: error: no previous prototype for 'do_tra=
p_illinsn' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:210:17: error: no previous prototype for 'do_tra=
p_fpe' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:220:17: error: no previous prototype for 'do_tra=
p_priv' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:230:17: error: no previous prototype for 'trap_c=
' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_in=
it' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototype =
for '__vdso_clock_gettime64' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototype =
for '__vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototype =
for '__vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype f=
or '__vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fa=
ult' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/acpi.c:715:5: error: no previous prototype for 'acpi_map=
_cpu2node' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/cyclone.c:18:13: error: no previous prototype for 'cyclo=
ne_setup' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/cyclone.c:38:12: error: no previous prototype for 'init_=
cyclone_clock' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/efi.c:971:1: error: no previous prototype for 'find_memm=
ap_space' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/elfcore.c:10:12: error: no previous prototype for 'elf_c=
ore_extra_phdrs' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/elfcore.c:15:5: error: no previous prototype for 'elf_co=
re_write_extra_phdrs' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/elfcore.c:44:5: error: no previous prototype for 'elf_co=
re_write_extra_data' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/elfcore.c:63:8: error: no previous prototype for 'elf_co=
re_extra_data_size' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/iosapic.c:265:1: error: no previous prototype for 'kexec=
_disable_iosapic' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/irq.c:128:6: error: no previous prototype for 'fixup_irq=
s' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/irq_ia64.c:429:1: error: no previous prototype for 'ia64=
_handle_irq' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/irq_ia64.c:512:6: error: no previous prototype for 'ia64=
_process_pending_intr' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/irq_ia64.c:587:1: error: no previous prototype for 'regi=
ster_percpu_irq' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/mca.c:1284:1: error: no previous prototype for 'ia64_mca=
_handler' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/mca.c:504:1: error: no previous prototype for 'search_mc=
a_table' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/mca.c:607:1: error: no previous prototype for 'ia64_mca_=
register_cpev' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/mca_drv.c:156:1: error: no previous prototype for 'mca_h=
andler_bh' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/mca_drv.c:768:12: error: no previous prototype for 'mca_=
external_handler_init' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/mca_drv.c:782:13: error: no previous prototype for 'mca_=
external_handler_exit' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/module.c:245:1: error: no previous prototype for 'plt_ta=
rget' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/process.c:156:1: error: no previous prototype for 'conso=
le_print' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/process.c:162:1: error: no previous prototype for 'do_no=
tify_resume_user' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/process.c:405:17: error: no previous prototype for 'ia64=
_clone' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/process.c:559:1: error: no previous prototype for 'cpu_h=
alt' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/ptrace.c:1158:1: error: no previous prototype for 'sysca=
ll_trace_enter' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/ptrace.c:1179:1: error: no previous prototype for 'sysca=
ll_trace_leave' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/ptrace.c:1994:6: error: no previous prototype for 'sysca=
ll_get_arguments' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/sal.c:43:29: error: cast between incompatible function t=
ypes from 'long int (*)(void)' to 'struct ia64_sal_retval (*)(u64, ...)' {a=
ka 'struct ia64_sal_retval (*)(long long unsigned int, ...)'} [-Werror=3Dca=
st-function-type]
> arch/ia64/kernel/salinfo.c:212:1: error: no previous prototype for 'salin=
fo_log_wakeup' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/signal.c:108:1: error: no previous prototype for 'ia64_r=
t_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/smpboot.c:190:1: error: no previous prototype for 'sync_=
master' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/smpboot.c:275:1: error: no previous prototype for 'ia64_=
sync_itc' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/smpboot.c:435:1: error: no previous prototype for 'start=
_secondary' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/smpboot.c:592:5: error: no previous prototype for 'migra=
te_platform_irqs' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/sys_ia64.c:161:1: error: no previous prototype for 'ia64=
_mremap' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/sys_ia64.c:171:1: error: no previous prototype for 'ia64=
_clock_getres' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/sys_ia64.c:71:1: error: no previous prototype for 'ia64_=
getpriority' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/sys_ia64.c:85:1: error: no previous prototype for 'sys_g=
etpagesize' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/sys_ia64.c:91:1: error: no previous prototype for 'ia64_=
brk' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/time.c:260:6: error: no previous prototype for 'ia64_ini=
t_itm' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/traps.c:101:11: error: no previous prototype for 'ia64_b=
ad_break' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/traps.c:35:1: error: no previous prototype for 'trap_ini=
t' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/traps.c:387:1: error: no previous prototype for 'ia64_il=
legal_op_fault' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/traps.c:416:1: error: no previous prototype for 'ia64_fa=
ult' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/traps.c:43:1: error: no previous prototype for 'die' [-W=
error=3Dmissing-prototypes]
> arch/ia64/kernel/traps.c:93:1: error: no previous prototype for 'die_if_k=
ernel' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/unaligned.c:1314:1: error: no previous prototype for 'ia=
64_handle_unaligned' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/uncached.c:177:15: error: no previous prototype for 'unc=
ached_alloc_page' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/uncached.c:218:6: error: no previous prototype for 'unca=
ched_free_page' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/unwind.c:1449:59: error: suggest braces around empty bod=
y in an 'else' statement [-Werror=3Dempty-body]
> arch/ia64/kernel/unwind.c:2314:1: error: no previous prototype for 'sys_g=
etunwind' [-Werror=3Dmissing-prototypes]
> arch/ia64/kernel/unwind.c:862:56: error: suggest braces around empty body=
 in an 'else' statement [-Werror=3Dempty-body]
> arch/ia64/lib/checksum.c:38:1: error: no previous prototype for 'csum_tcp=
udp_magic' [-Werror=3Dmissing-prototypes]
> arch/ia64/lib/checksum.c:49:1: error: no previous prototype for 'csum_tcp=
udp_nofold' [-Werror=3Dmissing-prototypes]
> arch/ia64/lib/checksum.c:80:8: error: no previous prototype for 'csum_par=
tial' [-Werror=3Dmissing-prototypes]
> arch/ia64/lib/checksum.c:97:9: error: no previous prototype for 'ip_compu=
te_csum' [-Werror=3Dmissing-prototypes]
> arch/ia64/mm/discontig.c:631:6: error: no previous prototype for 'vmemmap=
_free' [-Werror=3Dmissing-prototypes]
> arch/ia64/mm/extable.c:15:1: error: no previous prototype for 'ia64_handl=
e_exception' [-Werror=3Dmissing-prototypes]
> arch/ia64/mm/fault.c:66:1: error: no previous prototype for 'ia64_do_page=
_fault' [-Werror=3Dmissing-prototypes]
> arch/ia64/mm/init.c:161:1: error: no previous prototype for 'free_initrd_=
mem' [-Werror=3Dmissing-prototypes]
> arch/ia64/mm/init.c:309:6: error: no previous prototype for 'ia64_mmu_ini=
t' [-Werror=3Dmissing-prototypes]
> arch/ia64/mm/tlb.c:369:6: error: no previous prototype for 'ia64_tlb_init=
' [-Werror=3Dmissing-prototypes]
> arch/ia64/pci/pci.c:326:6: error: no previous prototype for 'pcibios_fixu=
p_device_resources' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/acpi.c:284:13: error: no previous prototype for 'ac=
pi_numa_arch_fixup' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/module-sections.c:103:5: error: no previous prototy=
pe for 'module_frob_arch_sections' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/process.c:316:15: error: no previous prototype for =
'arch_align_stack' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/signal.c:1040:6: error: no previous prototype for '=
arch_do_signal_or_restart' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/signal.c:894:14: error: no previous prototype for '=
get_sigframe' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/signal.c:925:17: error: no previous prototype for '=
sys_rt_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/smp.c:501:17: error: no previous prototype for 'sta=
rt_secondary' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/smp.c:559:5: error: no previous prototype for 'setu=
p_profiling_timer' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/syscall.c:40:14: error: no previous prototype for '=
do_syscall' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/time.c:32:13: error: no previous prototype for 'con=
stant_timer_interrupt' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/topology.c:13:5: error: no previous prototype for '=
arch_register_cpu' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/topology.c:27:6: error: no previous prototype for '=
arch_unregister_cpu' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:1012:25: error: no previous prototype for '=
do_reserved' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:1031:17: error: no previous prototype for '=
cache_parity_error' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:1040:25: error: no previous prototype for '=
handle_loongarch_irq' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:1051:25: error: no previous prototype for '=
do_vint' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:373:6: error: no previous prototype for 'sh=
ow_registers' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:438:6: error: no previous prototype for 'fo=
rce_fcsr_sig' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:457:5: error: no previous prototype for 'pr=
ocess_fpemu_return' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:492:25: error: no previous prototype for 'd=
o_fpe' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:519:25: error: no previous prototype for 'd=
o_ade' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:533:25: error: no previous prototype for 'd=
o_ale' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:594:25: error: no previous prototype for 'd=
o_bce' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:683:25: error: no previous prototype for 'd=
o_bp' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:762:25: error: no previous prototype for 'd=
o_watch' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:812:25: error: no previous prototype for 'd=
o_ri' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:907:25: error: no previous prototype for 'd=
o_fpu' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:924:25: error: no previous prototype for 'd=
o_lsx' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:946:25: error: no previous prototype for 'd=
o_lasx' [-Werror=3Dmissing-prototypes]
> arch/loongarch/kernel/traps.c:981:25: error: no previous prototype for 'd=
o_lbt' [-Werror=3Dmissing-prototypes]
> arch/loongarch/mm/fault.c:256:27: error: no previous prototype for 'do_pa=
ge_fault' [-Werror=3Dmissing-prototypes]
> arch/loongarch/mm/hugetlbpage.c:56:5: error: no previous prototype for 'i=
s_aligned_hugepage_range' [-Werror=3Dmissing-prototypes]
> arch/loongarch/mm/ioremap.c:18:7: error: no previous prototype for 'early=
_memremap_ro' [-Werror=3Dmissing-prototypes]
> arch/loongarch/mm/ioremap.c:23:7: error: no previous prototype for 'early=
_memremap_prot' [-Werror=3Dmissing-prototypes]
> arch/loongarch/mm/tlb.c:264:6: error: no previous prototype for 'setup_tl=
b_handler' [-Werror=3Dmissing-prototypes]
> arch/m68k/amiga/amisound.c:48:13: error: no previous prototype for 'amiga=
_init_sound' [-Werror=3Dmissing-prototypes]
> arch/m68k/amiga/amisound.c:71:6: error: no previous prototype for 'amiga_=
mksound' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/config.c:111:5: error: no previous prototype for 'dn_ser=
ial_console_wait_key' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/config.c:118:6: error: no previous prototype for 'dn_ser=
ial_console_write' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/config.c:132:6: error: no previous prototype for 'dn_ser=
ial_print' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/config.c:240:6: error: no previous prototype for 'dn_dum=
my_waitbut' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/dn_ints.c:19:6: error: no previous prototype for 'apollo=
_irq_shutdown' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/dn_ints.c:29:6: error: no previous prototype for 'apollo=
_irq_eoi' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/dn_ints.c:43:13: error: no previous prototype for 'dn_in=
it_IRQ' [-Werror=3Dmissing-prototypes]
> arch/m68k/apollo/dn_ints.c:8:14: error: no previous prototype for 'apollo=
_irq_startup' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/ataints.c:267:13: error: no previous prototype for 'atari=
_init_IRQ' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/atakeyb.c:335:6: error: no previous prototype for 'ikbd_r=
eset' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/atasound.c:36:6: error: no previous prototype for 'atari_=
microwire_cmd' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/atasound.c:53:6: error: no previous prototype for 'atari_=
mksound' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/config.c:883:12: error: no previous prototype for 'atari_=
platform_init' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/stram.c:118:12: error: no previous prototype for 'atari_s=
tram_map_pages' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/time.c:140:5: error: no previous prototype for 'atari_mst=
e_hwclk' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/time.c:199:5: error: no previous prototype for 'atari_tt_=
hwclk' [-Werror=3Dmissing-prototypes]
> arch/m68k/atari/time.c:59:1: error: no previous prototype for 'atari_sche=
d_init' [-Werror=3Dmissing-prototypes]
> arch/m68k/bvme6000/config.c:133:13: error: no previous prototype for 'bvm=
e6000_abort_int' [-Werror=3Dmissing-prototypes]
> arch/m68k/hp300/time.c:101:13: error: no previous prototype for 'hp300_sc=
hed_init' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/ints.c:165:17: error: no previous prototype for 'handle_=
badint' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/process.c:115:16: error: no previous prototype for 'm68k=
_clone' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/process.c:136:16: error: no previous prototype for 'm68k=
_clone3' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/ptrace.c:275:16: error: no previous prototype for 'sysca=
ll_trace_enter' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/ptrace.c:288:17: error: no previous prototype for 'sysca=
ll_trace_leave' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/signal.c:1112:6: error: no previous prototype for 'do_no=
tify_resume' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/signal.c:756:18: error: no previous prototype for 'do_si=
greturn' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/signal.c:783:18: error: no previous prototype for 'do_rt=
_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:378:1: error: no previous prototype for 'sys_=
cacheflush' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:40:17: error: no previous prototype for 'sys_=
mmap2' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:463:1: error: no previous prototype for 'sys_=
atomic_cmpxchg_32' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:564:16: error: no previous prototype for 'sys=
_getpagesize' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:569:26: error: no previous prototype for 'sys=
_get_thread_area' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:574:16: error: no previous prototype for 'sys=
_set_thread_area' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/sys_m68k.c:580:16: error: no previous prototype for 'sys=
_atomic_barrier' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/traps.c:1140:17: error: no previous prototype for 'set_e=
sp0' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/traps.c:1149:17: error: no previous prototype for 'fpsp0=
40_die' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/traps.c:1155:17: error: no previous prototype for 'fpemu=
_signal' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/traps.c:754:17: error: no previous prototype for 'buserr=
_c' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/traps.c:968:6: error: no previous prototype for 'bad_sup=
er_trap' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/vectors.c:51:13: error: no previous prototype for 'base_=
trap_init' [-Werror=3Dmissing-prototypes]
> arch/m68k/kernel/vectors.c:74:13: error: no previous prototype for 'trap_=
init' [-Werror=3Dmissing-prototypes]
> arch/m68k/lib/ashldi3.c:35:1: error: no previous prototype for '__ashldi3=
' [-Werror=3Dmissing-prototypes]
> arch/m68k/lib/ashrdi3.c:35:1: error: no previous prototype for '__ashrdi3=
' [-Werror=3Dmissing-prototypes]
> arch/m68k/lib/lshrdi3.c:35:1: error: no previous prototype for '__lshrdi3=
' [-Werror=3Dmissing-prototypes]
> arch/m68k/lib/muldi3.c:82:1: error: no previous prototype for '__muldi3' =
[-Werror=3Dmissing-prototypes]
> arch/m68k/mac/baboon.c:25:13: error: no previous prototype for 'baboon_in=
it' [-Werror=3Dmissing-prototypes]
> arch/m68k/mac/config.c:961:12: error: no previous prototype for 'mac_plat=
form_init' [-Werror=3Dmissing-prototypes]
> arch/m68k/mac/iop.c:235:13: error: no previous prototype for 'iop_init' [=
-Werror=3Dmissing-prototypes]
> arch/m68k/mac/macboing.c:164:6: error: no previous prototype for 'mac_mks=
ound' [-Werror=3Dmissing-prototypes]
> arch/m68k/mac/misc.c:609:5: error: no previous prototype for 'mac_hwclk' =
[-Werror=3Dmissing-prototypes]
> arch/m68k/mac/oss.c:37:13: error: no previous prototype for 'oss_init' [-=
Werror=3Dmissing-prototypes]
> arch/m68k/mac/psc.c:76:13: error: no previous prototype for 'psc_init' [-=
Werror=3Dmissing-prototypes]
> arch/m68k/mac/via.c:111:13: error: no previous prototype for 'via_init' [=
-Werror=3Dmissing-prototypes]
> arch/m68k/mac/via.c:593:13: error: no previous prototype for 'via_init_cl=
ock' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_arith.c:310:1: error: no previous prototype for 'fp=
_fsglmul' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_arith.c:367:1: error: no previous prototype for 'fp=
_fsgldiv' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:102:1: error: no previous prototype for 'fp_f=
etoxm1' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:112:1: error: no previous prototype for 'fp_f=
etox' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:122:1: error: no previous prototype for 'fp_f=
twotox' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:132:1: error: no previous prototype for 'fp_f=
tentox' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:142:1: error: no previous prototype for 'fp_f=
logn' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:152:1: error: no previous prototype for 'fp_f=
lognp1' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:162:1: error: no previous prototype for 'fp_f=
log10' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:172:1: error: no previous prototype for 'fp_f=
log2' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:182:1: error: no previous prototype for 'fp_f=
getexp' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:203:1: error: no previous prototype for 'fp_f=
getman' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_log.c:29:1: error: no previous prototype for 'fp_fs=
qrt' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:102:1: error: no previous prototype for 'fp_=
ftanh' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:112:1: error: no previous prototype for 'fp_=
fatanh' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:122:1: error: no previous prototype for 'fp_=
fsincos0' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:130:1: error: no previous prototype for 'fp_=
fsincos1' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:138:1: error: no previous prototype for 'fp_=
fsincos2' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:146:1: error: no previous prototype for 'fp_=
fsincos3' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:154:1: error: no previous prototype for 'fp_=
fsincos4' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:162:1: error: no previous prototype for 'fp_=
fsincos5' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:170:1: error: no previous prototype for 'fp_=
fsincos6' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:178:1: error: no previous prototype for 'fp_=
fsincos7' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:22:1: error: no previous prototype for 'fp_f=
sin' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:32:1: error: no previous prototype for 'fp_f=
cos' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:42:1: error: no previous prototype for 'fp_f=
tan' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:52:1: error: no previous prototype for 'fp_f=
asin' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:62:1: error: no previous prototype for 'fp_f=
acos' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:72:1: error: no previous prototype for 'fp_f=
atan' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:82:1: error: no previous prototype for 'fp_f=
sinh' [-Werror=3Dmissing-prototypes]
> arch/m68k/math-emu/fp_trig.c:92:1: error: no previous prototype for 'fp_f=
cosh' [-Werror=3Dmissing-prototypes]
> arch/m68k/mm/fault.c:22:5: error: no previous prototype for 'send_fault_s=
ig' [-Werror=3Dmissing-prototypes]
> arch/m68k/mm/fault.c:68:5: error: no previous prototype for 'do_page_faul=
t' [-Werror=3Dmissing-prototypes]
> arch/m68k/mm/hwtest.c:29:5: error: no previous prototype for 'hwreg_prese=
nt' [-Werror=3Dmissing-prototypes]
> arch/m68k/mm/hwtest.c:62:5: error: no previous prototype for 'hwreg_write=
' [-Werror=3Dmissing-prototypes]
> arch/m68k/mm/motorola.c:418:13: error: no previous prototype for 'paging_=
init' [-Werror=3Dmissing-prototypes]
> arch/m68k/mvme147/config.c:76:13: error: no previous prototype for 'mvme1=
47_init_IRQ' [-Werror=3Dmissing-prototypes]
> arch/m68k/mvme16x/config.c:208:6: error: no previous prototype for 'mvme1=
6x_cons_write' [-Werror=3Dmissing-prototypes]
> arch/m68k/q40/q40ints.c:112:6: error: no previous prototype for 'q40_mkso=
und' [-Werror=3Dmissing-prototypes]
> arch/m68k/q40/q40ints.c:152:6: error: no previous prototype for 'q40_sche=
d_init' [-Werror=3Dmissing-prototypes]
> arch/m68k/q40/q40ints.c:84:13: error: no previous prototype for 'q40_init=
_IRQ' [-Werror=3Dmissing-prototypes]
> arch/m68k/sun3/idprom.c:86:6: error: no previous prototype for 'sun3_get_=
model' [-Werror=3Dmissing-prototypes]
> arch/m68k/sun3x/config.c:29:6: error: no previous prototype for 'sun3_led=
s' [-Werror=3Dmissing-prototypes]
> arch/m68k/sun3x/config.c:42:13: error: no previous prototype for 'config_=
sun3x' [-Werror=3Dmissing-prototypes]
> arch/m68k/sun3x/dvma.c:179:6: error: no previous prototype for 'dvma_unma=
p_iommu' [-Werror=3Dmissing-prototypes]
> arch/m68k/sun3x/prom.c:33:6: error: no previous prototype for 'sun3x_halt=
' [-Werror=3Dmissing-prototypes]
> arch/microblaze/kernel/traps.c:21:6: error: no previous prototype for 'tr=
ap_init' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/ftrace.c:305:6: error: no previous prototype for 'prepar=
e_ftrace_return' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/jump_label.c:93:6: error: no previous prototype for 'jum=
p_label_apply_nops' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/linux32.c:102:20: error: no previous prototype for 'sys3=
2_readahead' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/linux32.c:108:17: error: no previous prototype for 'sys3=
2_sync_file_range' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/linux32.c:118:17: error: no previous prototype for 'sys3=
2_fadvise64_64' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/linux32.c:128:17: error: no previous prototype for 'sys3=
2_fallocate' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/machine_kexec.c:136:1: error: no previous prototype for =
'machine_shutdown' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/machine_kexec.c:152:1: error: no previous prototype for =
'machine_crash_shutdown' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/mips-cm.c:204:13: error: no previous prototype for '__mi=
ps_cm_l2sync_phys_base' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/mips-mt-fpaff.c:157:17: error: no previous prototype for=
 'mipsmt_sys_sched_getaffinity' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/mips-mt-fpaff.c:65:17: error: no previous prototype for =
'mipsmt_sys_sched_setaffinity' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/mips-mt.c:159:6: error: no previous prototype for 'mips_=
mt_set_cpuoptions' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/mips-mt.c:50:6: error: no previous prototype for 'mips_m=
t_regdump' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:438:5: error: no previous prototype for 'setup_=
sigcontext' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:438:5: error: no previous prototype for 'setup_=
sigcontext' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:515:5: error: no previous prototype for 'restor=
e_sigcontext' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:515:5: error: no previous prototype for 'restor=
e_sigcontext' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:636:17: error: no previous prototype for 'sys_s=
igreturn' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:673:17: error: no previous prototype for 'sys_r=
t_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:673:17: error: no previous prototype for 'sys_r=
t_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:903:17: error: no previous prototype for 'do_no=
tify_resume' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal.c:903:17: error: no previous prototype for 'do_no=
tify_resume' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal32.c:33:16: error: no previous prototype for 'sys3=
2_sigsuspend' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal_n32.c:53:17: error: no previous prototype for 'sy=
sn32_rt_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal_o32.c:154:17: error: no previous prototype for 's=
ys32_rt_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/signal_o32.c:256:17: error: no previous prototype for 's=
ys32_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/smp.c:352:17: error: no previous prototype for 'start_se=
condary' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/smp.c:352:17: error: no previous prototype for 'start_se=
condary' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/smp.c:472:5: error: no previous prototype for 'setup_pro=
filing_timer' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/smp.c:472:5: error: no previous prototype for 'setup_pro=
filing_timer' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/spram.c:194:6: error: no previous prototype for 'spram_c=
onfig' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/spram.c:194:6: error: no previous prototype for 'spram_c=
onfig' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/syscall.c:51:16: error: no previous prototype for 'sysm_=
pipe' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/syscall.c:51:16: error: no previous prototype for 'sysm_=
pipe' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1027:17: error: no previous prototype for 'do_bp=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1027:17: error: no previous prototype for 'do_bp=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1114:17: error: no previous prototype for 'do_tr=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1114:17: error: no previous prototype for 'do_tr=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1151:17: error: no previous prototype for 'do_ri=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1151:17: error: no previous prototype for 'do_ri=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1402:17: error: no previous prototype for 'do_cp=
u' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1402:17: error: no previous prototype for 'do_cp=
u' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1507:17: error: no previous prototype for 'do_ms=
a_fpe' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1507:17: error: no previous prototype for 'do_ms=
a_fpe' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1527:17: error: no previous prototype for 'do_ms=
a' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1527:17: error: no previous prototype for 'do_ms=
a' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1548:17: error: no previous prototype for 'do_md=
mx' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1548:17: error: no previous prototype for 'do_md=
mx' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1560:17: error: no previous prototype for 'do_wa=
tch' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1560:17: error: no previous prototype for 'do_wa=
tch' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1587:17: error: no previous prototype for 'do_mc=
heck' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1587:17: error: no previous prototype for 'do_mc=
heck' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1612:17: error: no previous prototype for 'do_mt=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1612:17: error: no previous prototype for 'do_mt=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1648:17: error: no previous prototype for 'do_ds=
p' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1648:17: error: no previous prototype for 'do_ds=
p' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1656:17: error: no previous prototype for 'do_re=
served' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1656:17: error: no previous prototype for 'do_re=
served' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1832:17: error: no previous prototype for 'cache=
_parity_error' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1832:17: error: no previous prototype for 'cache=
_parity_error' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1880:17: error: no previous prototype for 'do_ft=
lb' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1880:17: error: no previous prototype for 'do_ft=
lb' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1909:17: error: no previous prototype for 'do_gs=
exc' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1909:17: error: no previous prototype for 'do_gs=
exc' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1944:6: error: no previous prototype for 'ejtag_=
exception_handler' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1944:6: error: no previous prototype for 'ejtag_=
exception_handler' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1989:17: error: no previous prototype for 'nmi_e=
xception_handler' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:1989:17: error: no previous prototype for 'nmi_e=
xception_handler' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:370:6: error: no previous prototype for 'show_re=
gisters' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:370:6: error: no previous prototype for 'show_re=
gisters' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:447:17: error: no previous prototype for 'do_be'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:447:17: error: no previous prototype for 'do_be'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:752:17: error: no previous prototype for 'do_ov'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:752:17: error: no previous prototype for 'do_ov'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:874:17: error: no previous prototype for 'do_fpe=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/traps.c:874:17: error: no previous prototype for 'do_fpe=
' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/unaligned.c:1516:17: error: no previous prototype for 'd=
o_ade' [-Werror=3Dmissing-prototypes]
> arch/mips/kernel/unaligned.c:1516:17: error: no previous prototype for 'd=
o_ade' [-Werror=3Dmissing-prototypes]
> arch/mips/kvm/loongson_ipi.c:190:6: error: no previous prototype for 'kvm=
_init_loongson_ipi' [-Werror=3Dmissing-prototypes]
> arch/mips/loongson64/dma.c:25:13: error: no previous prototype for 'plat_=
swiotlb_setup' [-Werror=3Dmissing-prototypes]
> arch/mips/loongson64/pm.c:59:13: error: no previous prototype for 'setup_=
wakeup_events' [-Werror=3Dmissing-prototypes]
> arch/mips/loongson64/pm.c:63:13: error: no previous prototype for 'mach_s=
uspend' [-Werror=3Dmissing-prototypes]
> arch/mips/loongson64/pm.c:67:13: error: no previous prototype for 'mach_r=
esume' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/c-r4k.c:1588:6: error: no previous prototype for 'au1x00_fix=
up_config_od' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/c-r4k.c:1588:6: error: no previous prototype for 'au1x00_fix=
up_config_od' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/c-r4k.c:1703:6: error: no previous prototype for 'r4k_cache_=
init' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/c-r4k.c:1703:6: error: no previous prototype for 'r4k_cache_=
init' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/c-r4k.c:1831:12: error: no previous prototype for 'r4k_cache=
_init_pm' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/c-r4k.c:1831:12: error: no previous prototype for 'r4k_cache=
_init_pm' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/fault.c:323:17: error: no previous prototype for 'do_page_fa=
ult' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/fault.c:323:17: error: no previous prototype for 'do_page_fa=
ult' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/init.c:60:6: error: no previous prototype for 'setup_zero_pa=
ges' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/pgtable-64.c:101:6: error: no previous prototype for 'set_pm=
d_at' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/pgtable-64.c:92:7: error: no previous prototype for 'mk_pmd'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/mm/sc-mips.c:255:5: error: no previous prototype for 'mips_sc_i=
nit' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/tlb-r4k.c:461:12: error: no previous prototype for 'add_temp=
orary_entry' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/tlb-r4k.c:553:6: error: no previous prototype for 'tlb_init'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/mm/tlb-r4k.c:553:6: error: no previous prototype for 'tlb_init'=
 [-Werror=3Dmissing-prototypes]
> arch/mips/mm/tlbex.c:2547:6: error: no previous prototype for 'build_tlb_=
refill_handler' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/tlbex.c:2547:6: error: no previous prototype for 'build_tlb_=
refill_handler' [-Werror=3Dmissing-prototypes]
> arch/mips/mm/uasm.c:421:5: error: no previous prototype for 'uasm_in_comp=
at_space_p' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:14:5: error: no previous prototype for '__=
vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:14:5: error: no previous prototype for '__=
vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:14:5: error: no previous prototype for '__=
vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__=
vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__=
vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__=
vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:36:5: error: no previous prototype for '__=
vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:36:5: error: no previous prototype for '__=
vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:36:5: error: no previous prototype for '__=
vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:42:5: error: no previous prototype for '__=
vdso_clock_gettime64' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:42:5: error: no previous prototype for '__=
vdso_clock_gettime64' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:42:5: error: no previous prototype for '__=
vdso_clock_gettime64' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:50:5: error: no previous prototype for '__=
vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:64:5: error: no previous prototype for '__=
vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/mips/vdso/vgettimeofday.c:72:5: error: no previous prototype for '__=
vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/irq.c:19:17: error: no previous prototype for 'do_IRQ' =
[-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/misaligned.c:66:17: error: no previous prototype for 'h=
andle_unaligned_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/process.c:152:6: error: no previous prototype for 'dump=
' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/process.c:253:16: error: no previous prototype for 'nio=
s2_clone' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/process.c:34:6: error: no previous prototype for 'arch_=
cpu_idle' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/process.c:43:6: error: no previous prototype for 'machi=
ne_restart' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/process.c:54:6: error: no previous prototype for 'machi=
ne_halt' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/process.c:66:6: error: no previous prototype for 'machi=
ne_power_off' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/setup.c:107:24: error: no previous prototype for 'nios2=
_boot_init' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/signal.c:101:16: error: no previous prototype for 'do_r=
t_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/signal.c:302:16: error: no previous prototype for 'do_n=
otify_resume' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/sys_nios2.c:21:16: error: no previous prototype for 'sy=
s_cacheflush' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/sys_nios2.c:57:16: error: no previous prototype for 'sy=
s_getpagesize' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/time.c:200:13: error: no previous prototype for 'timer_=
interrupt' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:109:17: error: no previous prototype for 'break=
point_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:147:17: error: no previous prototype for 'handl=
e_illegal_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:154:17: error: no previous prototype for 'handl=
e_supervisor_instr' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:161:17: error: no previous prototype for 'handl=
e_diverror_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:168:17: error: no previous prototype for 'unhan=
dled_exception' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:183:17: error: no previous prototype for 'handl=
e_trap_1_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:188:17: error: no previous prototype for 'handl=
e_trap_2_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:193:17: error: no previous prototype for 'handl=
e_trap_3_c' [-Werror=3Dmissing-prototypes]
> arch/nios2/kernel/traps.c:32:6: error: no previous prototype for 'die' [-=
Werror=3Dmissing-prototypes]
> arch/nios2/lib/memcpy.c:160:7: error: no previous prototype for 'memcpy' =
[-Werror=3Dmissing-prototypes]
> arch/nios2/lib/memcpy.c:194:7: error: no previous prototype for 'memcpyb'=
 [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/dma-mapping.c:21:6: error: no previous prototype for 'arch_=
sync_dma_for_device' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/dma-mapping.c:45:6: error: no previous prototype for 'arch_=
sync_dma_for_cpu' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/dma-mapping.c:63:6: error: no previous prototype for 'arch_=
dma_prep_coherent' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/dma-mapping.c:70:7: error: no previous prototype for 'arch_=
dma_set_uncached' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/fault.c:43:17: error: no previous prototype for 'do_page_fa=
ult' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/pgtable.c:53:8: error: no previous prototype for 'pgd_alloc=
' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/pgtable.c:68:13: error: no previous prototype for 'pagetabl=
e_init' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/tlb.c:167:6: error: no previous prototype for 'dump_tlb_lin=
e' [-Werror=3Dmissing-prototypes]
> arch/nios2/mm/tlb.c:208:6: error: no previous prototype for 'dump_tlb' [-=
Werror=3Dmissing-prototypes]
> arch/nios2/mm/tlb.c:216:6: error: no previous prototype for 'flush_tlb_pi=
d' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/process.c:100:6: error: no previous prototype for 'a=
rch_cpu_idle' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/process.c:240:21: error: no previous prototype for '=
__switch_to' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/ptrace.c:191:17: error: no previous prototype for 'd=
o_syscall_trace_enter' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/ptrace.c:210:17: error: no previous prototype for 'd=
o_syscall_trace_leave' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/signal.c:227:5: error: no previous prototype for 'do=
_signal' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/signal.c:293:1: error: no previous prototype for 'do=
_work_pending' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/signal.c:68:17: error: no previous prototype for '_s=
ys_rt_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/time.c:111:25: error: no previous prototype for 'tim=
er_interrupt' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:146:6: error: no previous prototype for 'nom=
mu_dump_state' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:221:17: error: no previous prototype for 'di=
e' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:239:17: error: no previous prototype for 'un=
handled_exception' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:246:17: error: no previous prototype for 'do=
_fpe_trap' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:268:17: error: no previous prototype for 'do=
_trap' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:273:17: error: no previous prototype for 'do=
_unaligned_access' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:286:17: error: no previous prototype for 'do=
_bus_fault' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:462:17: error: no previous prototype for 'do=
_illegal_instruction' [-Werror=3Dmissing-prototypes]
> arch/openrisc/kernel/traps.c:67:6: error: no previous prototype for 'show=
_registers' [-Werror=3Dmissing-prototypes]
> arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page=
_fault' [-Werror=3Dmissing-prototypes]
> arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init=
' [-Werror=3Dmissing-prototypes]
> arch/parisc/lib/ucmpdi2.c:12:5: error: no previous prototype for '__ucmpd=
i2' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/cpu/init.c:99:29: error: no previous prototype for 'l2_cac=
he_init' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/cpu/init.c:99:29: error: no previous prototype for 'l2_cac=
he_init' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/cpu/sh4/fpu.c:389:6: error: no previous prototype for 'flo=
at_raise' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/cpu/sh4/fpu.c:394:5: error: no previous prototype for 'flo=
at_rounding_mode' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/hw_breakpoint.c:135:5: error: no previous prototype for 'a=
rch_bp_generic_fields' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/hw_breakpoint.c:135:5: error: no previous prototype for 'a=
rch_bp_generic_fields' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/return_address.c:49:7: error: no previous prototype for 'r=
eturn_address' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/return_address.c:49:7: error: no previous prototype for 'r=
eturn_address' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/sys_sh.c:58:16: error: no previous prototype for 'sys_cach=
eflush' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/sys_sh.c:58:16: error: no previous prototype for 'sys_cach=
eflush' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/traps_32.c:735:6: error: no previous prototype for 'per_cp=
u_trap_init' [-Werror=3Dmissing-prototypes]
> arch/sh/kernel/traps_32.c:735:6: error: no previous prototype for 'per_cp=
u_trap_init' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/cache-sh2.c:85:13: error: no previous prototype for 'sh2_cache=
_init' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/cache-sh4.c:384:13: error: no previous prototype for 'sh4_cach=
e_init' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/fault.c:389:27: error: no previous prototype for 'do_page_faul=
t' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/flush-sh4.c:106:13: error: no previous prototype for 'sh4__flu=
sh_region_init' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/nommu.c:76:13: error: no previous prototype for 'kmap_coherent=
_init' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/nommu.c:80:7: error: no previous prototype for 'kmap_coherent'=
 [-Werror=3Dmissing-prototypes]
> arch/sh/mm/nommu.c:86:6: error: no previous prototype for 'kunmap_coheren=
t' [-Werror=3Dmissing-prototypes]
> arch/sh/mm/pgtable.c:10:6: error: no previous prototype for 'pgd_ctor' [-=
Werror=3Dmissing-prototypes]
> arch/sh/mm/pgtable.c:32:8: error: no previous prototype for 'pgd_alloc' [=
-Werror=3Dmissing-prototypes]
> arch/sh/mm/pgtable.c:37:6: error: no previous prototype for 'pgd_free' [-=
Werror=3Dmissing-prototypes]
> arch/sh/mm/tlbex_32.c:22:1: error: no previous prototype for 'handle_tlbm=
iss' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/adi_64.c:124:21: error: no previous prototype for 'find=
_tag_store' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/adi_64.c:156:21: error: no previous prototype for 'allo=
c_tag_store' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/adi_64.c:299:6: error: no previous prototype for 'del_t=
ag_store' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/pci_sun4v.c:258:15: error: no previous prototype for 'd=
ma_4v_iotsb_bind' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/setup_64.c:615:13: error: no previous prototype for 'al=
loc_irqstack_bootmem' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/time_64.c:880:20: error: no previous prototype for 'sch=
ed_clock' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/traps_32.c:366:6: error: no previous prototype for 'tra=
p_init' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/traps_64.c:2034:6: error: no previous prototype for 'do=
_mcd_err' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/traps_64.c:2152:6: error: no previous prototype for 'su=
n4v_nonresum_error_user_handled' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/traps_64.c:252:6: error: no previous prototype for 'is_=
no_fault_exception' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/traps_64.c:2839:13: error: no previous prototype for 't=
rap_init' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/uprobes.c:237:17: error: no previous prototype for 'upr=
obe_trap' [-Werror=3Dmissing-prototypes]
> arch/sparc/lib/cmpdi2.c:6:11: error: no previous prototype for '__cmpdi2'=
 [-Werror=3Dmissing-prototypes]
> arch/sparc/lib/ucmpdi2.c:5:11: error: no previous prototype for '__ucmpdi=
2' [-Werror=3Dmissing-prototypes]
> arch/sparc/mm/init_64.c:2644:6: error: no previous prototype for 'vmemmap=
_free' [-Werror=3Dmissing-prototypes]
> arch/sparc/prom/misc_64.c:165:5: error: no previous prototype for 'prom_g=
et_mmu_ihandle' [-Werror=3Dmissing-prototypes]
> arch/sparc/prom/p1275.c:52:6: error: no previous prototype for 'prom_cif_=
init' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vclock_gettime.c:254:1: error: no previous prototype for =
'__vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vclock_gettime.c:282:1: error: no previous prototype for =
'__vdso_clock_gettime_stick' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vclock_gettime.c:307:1: error: no previous prototype for =
'__vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vclock_gettime.c:343:1: error: no previous prototype for =
'__vdso_gettimeofday_stick' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: error: no previous prot=
otype for '__vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: error: no previous prot=
otype for '__vdso_clock_gettime_stick' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: error: no previous prot=
otype for '__vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: error: no previous prot=
otype for '__vdso_gettimeofday_stick' [-Werror=3Dmissing-prototypes]
> arch/sparc/vdso/vma.c:246:12: error: no previous prototype for 'init_vdso=
_image' [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/irq.c:34:17: error: no previous prototype for 'do_IRQ'=
 [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/ptrace.c:545:5: error: no previous prototype for 'do_s=
yscall_trace_enter' [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/setup.c:244:13: error: no previous prototype for 'init=
_arch' [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/signal.c:246:17: error: no previous prototype for 'xte=
nsa_rt_sigreturn' [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/signal.c:525:6: error: no previous prototype for 'do_n=
otify_resume' [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/stacktrace.c:263:15: error: no previous prototype for =
'return_address' [-Werror=3Dmissing-prototypes]
> arch/xtensa/kernel/traps.c:484:13: error: no previous prototype for 'trap=
_init' [-Werror=3Dmissing-prototypes]
> arch/xtensa/mm/fault.c:87:6: error: no previous prototype for 'do_page_fa=
ult' [-Werror=3Dmissing-prototypes]
> arch/xtensa/platforms/iss/network.c:204:16: error: no previous prototype =
for 'tuntap_protocol' [-Werror=3Dmissing-prototypes]
> arch/xtensa/platforms/iss/network.c:444:6: error: no previous prototype f=
or 'iss_net_user_timer_expire' [-Werror=3Dmissing-prototypes]
>
>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: x86@kernel.org
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-next@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/alpha/Kbuild                  |  2 ++
>  arch/alpha/lib/Makefile            |  1 +
>  arch/arc/Kbuild                    |  2 ++
>  arch/csky/Kbuild                   |  2 ++
>  arch/hexagon/Kbuild                |  2 ++
>  arch/ia64/Kbuild                   |  2 ++
>  arch/ia64/lib/Makefile             |  1 +
>  arch/loongarch/Kbuild              |  2 ++
>  arch/m68k/Kbuild                   |  2 ++
>  arch/m68k/lib/Makefile             |  1 +
>  arch/microblaze/Kbuild             |  2 ++
>  arch/mips/Kbuild                   |  2 ++
>  arch/mips/boot/compressed/Makefile |  3 ++-
>  arch/nios2/Kbuild                  |  2 ++
>  arch/nios2/lib/Makefile            |  1 +
>  arch/openrisc/Kbuild               |  2 ++
>  arch/parisc/Kbuild                 |  2 ++
>  arch/parisc/lib/Makefile           |  1 +
>  arch/sh/Kbuild                     |  2 ++
>  arch/sh/boot/compressed/Makefile   |  1 +
>  arch/sparc/Kbuild                  |  2 ++
>  arch/sparc/lib/Makefile            |  1 +
>  arch/sparc/prom/Makefile           |  1 +
>  arch/xtensa/Kbuild                 |  2 ++
>  arch/xtensa/boot/lib/Makefile      |  2 ++
>  init/Kconfig                       | 10 ++++++++++
>  26 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/Kbuild b/arch/alpha/Kbuild
> index 345d79df24bb9..283cb9d5b022c 100644
> --- a/arch/alpha/Kbuild
> +++ b/arch/alpha/Kbuild
> @@ -4,3 +4,5 @@ obj-$(CONFIG_MATHEMU)   +=3D math-emu/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
> index 1cc74f7b50efb..09e0be65caa93 100644
> --- a/arch/alpha/lib/Makefile
> +++ b/arch/alpha/lib/Makefile
> @@ -5,6 +5,7 @@
>
>  asflags-y :=3D $(KBUILD_CFLAGS)
>  ccflags-y :=3D -Werror
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  # Many of these routines have implementations tuned for ev6.
>  # Choose them iff we're targeting ev6 specifically.
> diff --git a/arch/arc/Kbuild b/arch/arc/Kbuild
> index b94102fff68b4..9bc728209f747 100644
> --- a/arch/arc/Kbuild
> +++ b/arch/arc/Kbuild
> @@ -4,3 +4,5 @@ obj-y +=3D mm/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
> index 0621eaea41962..1d4322ebc95e5 100644
> --- a/arch/csky/Kbuild
> +++ b/arch/csky/Kbuild
> @@ -4,3 +4,5 @@ obj-y +=3D kernel/ mm/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
> index 8421baba13518..9aceffc706d4a 100644
> --- a/arch/hexagon/Kbuild
> +++ b/arch/hexagon/Kbuild
> @@ -1,2 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y +=3D kernel/ mm/ lib/
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/ia64/Kbuild b/arch/ia64/Kbuild
> index e77cc76d228cd..69e3c2dadde0e 100644
> --- a/arch/ia64/Kbuild
> +++ b/arch/ia64/Kbuild
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y                          +=3D kernel/ mm/
>  obj-$(CONFIG_IA64_SGI_UV)      +=3D uv/
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/ia64/lib/Makefile b/arch/ia64/lib/Makefile
> index 081fcba01dc0c..03999c9f19bb3 100644
> --- a/arch/ia64/lib/Makefile
> +++ b/arch/ia64/lib/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Makefile for ia64-specific library routines..
>  #
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  lib-y :=3D io.o __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o           =
 \
>         __divdi3.o __udivdi3.o __moddi3.o __umoddi3.o                   \
> diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> index b01f5cdb27e03..f3b89e5f79050 100644
> --- a/arch/loongarch/Kbuild
> +++ b/arch/loongarch/Kbuild
> @@ -5,3 +5,5 @@ obj-y +=3D vdso/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
> index 7762af9f6defe..b2abbf427e8f2 100644
> --- a/arch/m68k/Kbuild
> +++ b/arch/m68k/Kbuild
> @@ -18,3 +18,5 @@ obj-$(CONFIG_M68KFPU_EMU)     +=3D math-emu/
>  obj-$(CONFIG_M68000)           +=3D 68000/
>  obj-$(CONFIG_COLDFIRE)         +=3D coldfire/
>  obj-$(CONFIG_VIRT)             +=3D virt/
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
> index eca17f14b4d5e..3aea84ffa0db2 100644
> --- a/arch/m68k/lib/Makefile
> +++ b/arch/m68k/lib/Makefile
> @@ -3,6 +3,7 @@
>  #
>  # Makefile for m68k-specific library files..
>  #
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  lib-y  :=3D ashldi3.o ashrdi3.o lshrdi3.o muldi3.o \
>            memcpy.o memset.o memmove.o
> diff --git a/arch/microblaze/Kbuild b/arch/microblaze/Kbuild
> index 077a0b8e96157..b2799946ae01d 100644
> --- a/arch/microblaze/Kbuild
> +++ b/arch/microblaze/Kbuild
> @@ -6,3 +6,5 @@ obj-y                   +=3D boot/dts/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index af2967bffb73d..484cfda563b68 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -28,3 +28,5 @@ endif
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compress=
ed/Makefile
> index 6cc28173bee89..58be7966d839f 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -11,9 +11,10 @@
>  # Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University
>  # Author: Wu Zhangjin <wuzhangjin@gmail.com>
>  #
> -
>  include $(srctree)/arch/mips/Kbuild.platforms
>
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
> +
>  # set the default size of the mallocing area for decompressing
>  BOOT_HEAP_SIZE :=3D 0x400000
>
> diff --git a/arch/nios2/Kbuild b/arch/nios2/Kbuild
> index fc2952edd2dec..5f79d266fd4ef 100644
> --- a/arch/nios2/Kbuild
> +++ b/arch/nios2/Kbuild
> @@ -4,3 +4,5 @@ obj-y +=3D kernel/ mm/ platform/ boot/dts/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/nios2/lib/Makefile b/arch/nios2/lib/Makefile
> index 9d5bf1df520c1..9acc5a98760fa 100644
> --- a/arch/nios2/lib/Makefile
> +++ b/arch/nios2/lib/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Makefile for Nios2-specific library files.
>  #
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  lib-y +=3D delay.o
>  lib-y +=3D memcpy.o
> diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
> index b0b0f2b03f872..ba60f445bf429 100644
> --- a/arch/openrisc/Kbuild
> +++ b/arch/openrisc/Kbuild
> @@ -4,3 +4,5 @@ obj-y +=3D boot/dts/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/parisc/Kbuild b/arch/parisc/Kbuild
> index a6d3b280ba0c2..b825fb5cf9226 100644
> --- a/arch/parisc/Kbuild
> +++ b/arch/parisc/Kbuild
> @@ -3,3 +3,5 @@ obj-y   +=3D mm/ kernel/ math-emu/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/parisc/lib/Makefile b/arch/parisc/lib/Makefile
> index 7b197667faf6c..348a286ab68fe 100644
> --- a/arch/parisc/lib/Makefile
> +++ b/arch/parisc/lib/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Makefile for parisc-specific library files
>  #
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  lib-y  :=3D lusercopy.o bitops.o checksum.o io.o memset.o memcpy.o \
>            ucmpdi2.o delay.o
> diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
> index 056efec72c2a0..df2cf06eea5f6 100644
> --- a/arch/sh/Kbuild
> +++ b/arch/sh/Kbuild
> @@ -7,3 +7,5 @@ obj-$(CONFIG_HD6446X_SERIES)    +=3D cchips/hd6446x/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/M=
akefile
> index b5e29f99c02c8..25000003c94eb 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -4,6 +4,7 @@
>  #
>  # create a compressed vmlinux image from the original vmlinux
>  #
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  OBJECTS :=3D head_32.o misc.o cache.o piggy.o \
>             ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
> diff --git a/arch/sparc/Kbuild b/arch/sparc/Kbuild
> index 71cb3d934bf6c..320a4092b334e 100644
> --- a/arch/sparc/Kbuild
> +++ b/arch/sparc/Kbuild
> @@ -12,3 +12,5 @@ obj-$(CONFIG_SPARC64) +=3D vdso/
>
>  # for cleaning
>  subdir- +=3D boot
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index 063556fe2cb1d..2a5cba8e68dfd 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -4,6 +4,7 @@
>
>  asflags-y :=3D -ansi -DST_DIV0=3D0x02
>  ccflags-y :=3D -Werror
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  lib-$(CONFIG_SPARC32) +=3D ashrdi3.o
>  lib-$(CONFIG_SPARC32) +=3D memcpy.o memset.o
> diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
> index 397b79af77f7b..0a82ebb014130 100644
> --- a/arch/sparc/prom/Makefile
> +++ b/arch/sparc/prom/Makefile
> @@ -4,6 +4,7 @@
>  #
>  asflags :=3D -ansi
>  ccflags :=3D -Werror
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
>
>  lib-y                 :=3D bootstr_$(BITS).o
>  lib-y                 +=3D init_$(BITS).o
> diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
> index fd12f61745bad..f01d1ca727b97 100644
> --- a/arch/xtensa/Kbuild
> +++ b/arch/xtensa/Kbuild
> @@ -1,2 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y +=3D kernel/ mm/ platforms/ boot/dts/
> +
> +subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-protot=
ypes -Wno-missing-declarations
> diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefil=
e
> index 0378a22a08e33..a9f1c1e139389 100644
> --- a/arch/xtensa/boot/lib/Makefile
> +++ b/arch/xtensa/boot/lib/Makefile
> @@ -8,6 +8,8 @@ zlib    :=3D inffast.c inflate.c inftrees.c
>  lib-y  +=3D $(zlib:.c=3D.o) zmem.o
>
>  ccflags-y      :=3D -I $(srctree)/lib/zlib_inflate
> +ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) :=3D -Wno-missing-prototypes -W=
no-missing-declarations
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_inflate.o =3D -pg
>  CFLAGS_REMOVE_zmem.o =3D -pg
> diff --git a/init/Kconfig b/init/Kconfig
> index 639e8a3363c30..80cd67c0d7fa4 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -170,6 +170,16 @@ config WERROR
>
>           If in doubt, say Y.
>
> +config WNO_MISSING_PROTOTYPES
> +       bool "Hide -Wmissing-prototype warnings in arch code"
> +       default WERROR || !COMPILE_TEST
> +       help
> +         Some architectures have not yet eliminated all warnings for
> +         missing prototypes in their core code and will produce a lot
> +         of output for these. Ideally these should all be addresszed
> +         by individual bugfix patches, but in the meantime saying 'y'
> +         will skip that output.
> +
>  config UAPI_HEADER_TEST
>         bool "Compile test UAPI headers"
>         depends on HEADERS_INSTALL && CC_CAN_LINK
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
