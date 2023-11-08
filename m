Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBEC7E5754
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjKHNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjKHNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:02:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3D1FC3;
        Wed,  8 Nov 2023 05:02:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B392C433AB;
        Wed,  8 Nov 2023 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448550;
        bh=FgQWzkXF32qk/tCKQVUHf66ICQzLmXK/yCMtqaYVSN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATCV0SJUwSUIUcmIUsNFO1nBVzSdvp/LWTE5vG4buRgpe3Rwh1Y3dyl+cAW9SJEPK
         LgX1p25vA4s2+ADl72IXSQOOTjzHz5keTaVsHX8pgaq1IEPWWxeKlMtMVMVaC2vQKe
         Ws6+2JIfEnZ/R4XXaQ+IRWTmsubg+Hdo1lbZXemwfoXinRx3ZmHg94gmpjM/za6cnA
         1ZY2IWqHrjYbCn3e3pFdfryRLkTz+IvcfC2uUzHfAFoLwSxsHbxMw7BDYe27fzcOJI
         /AFASuBgsZvOI7gHnDAux0k0HCEaJF6CKhwJwUqhhusQZYHGKC4wMrmpGOYPfPqRmz
         7w6Vzgrt36F+g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
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
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
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
Subject: [PATCH 14/22] arch: add missing prepare_ftrace_return() prototypes
Date:   Wed,  8 Nov 2023 13:58:35 +0100
Message-Id: <20231108125843.3806765-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The prototype for prepare_ftrace_return() is architecture specific and
can't be in a global header. Since it's normally called from assembly,
it doesn't really need a prototype, but we get a warning if it's missing:

arch/csky/kernel/ftrace.c:147:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]
arch/microblaze/kernel/ftrace.c:22:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]
arch/mips/kernel/ftrace.c:305:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]

Add the prototypes for the three architectures that don't already have
one in asm/ftrace.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/ftrace.h       | 4 ++++
 arch/microblaze/include/asm/ftrace.h | 1 +
 arch/mips/include/asm/ftrace.h       | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
index 9b86341731b6..fd215c38ef27 100644
--- a/arch/csky/include/asm/ftrace.h
+++ b/arch/csky/include/asm/ftrace.h
@@ -26,5 +26,9 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 struct dyn_arch_ftrace {
 };
+
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_CSKY_FTRACE_H */
diff --git a/arch/microblaze/include/asm/ftrace.h b/arch/microblaze/include/asm/ftrace.h
index 6a92bed37794..4ca38b92a3a2 100644
--- a/arch/microblaze/include/asm/ftrace.h
+++ b/arch/microblaze/include/asm/ftrace.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
 extern void ftrace_call_graph(void);
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr);
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index db497a8167da..dc025888f6d2 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -85,6 +85,10 @@ struct dyn_arch_ftrace {
 };
 
 #endif /*  CONFIG_DYNAMIC_FTRACE */
+
+void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
+			   unsigned long fp);
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_MIPS_FTRACE_H */
-- 
2.39.2

