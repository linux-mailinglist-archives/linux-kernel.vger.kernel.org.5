Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6AC7FEA31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbjK3IIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjK3IH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:07:58 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43312A3;
        Thu, 30 Nov 2023 00:08:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70B323200A6E;
        Thu, 30 Nov 2023 03:08:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 30 Nov 2023 03:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1701331679; x=1701418079; bh=VLB9sPty6BA5Y2qKbDnRq6jtN+JfidHBYr5
        ZaRockn8=; b=hJIf7ZAcZbsPzME+ukFyrAttvBXgz/msRrDSSa6ZSH7cxDOHCcw
        ZqhSTPSzgqwA+NLyrR572BsH7w2suneQGutEkrAI0VrYY2qCBwL/+fUAAUWVNaOO
        xTAkV48Am+YBz392u1WRI+xSmmVVd8c8NoHNT/n1CaKtFOpqkStVhNwgUIxCECAy
        xVc4jaFttzdA5kPhcs8V/BMUPoroUvunBcZMjyI6b6S7Ur6S4yeQ3crtW2Uw5XXt
        d0/L8dfBAc1O7fMTWj60PbCbnBhVuBtWnmiTpbPwhjOzhwQCIQt0+P3XqK1dTnrR
        sX9K9CBgYxJl4jU6ZJn51Vahhk0Enod8PNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701331679; x=1701418079; bh=VLB9sPty6BA5Y2qKbDnRq6jtN+JfidHBYr5
        ZaRockn8=; b=DvQ8b9zbCS9bYkg6AeyJ56n/708NSO8xwvQK1KR0+t8h0w6YVrC
        k815wVn1z4Aw+MY4lk1ngMcP/WPM9fxXjJrJ5Tdx7AU/VT7EIWIwid71aohC1sC6
        0KOkeu9MoeL2vNZlszoKu99htogDzCcssv+0oh/fUjXiFmosaLBtXjZprI5nQo5h
        ZwBkG9dYc+LUlBYPvDmzopTvpTJuBHG+Bxqmzc2pkpMj78j0Lv6EZ2vPBLL+CU8m
        leGXp91jU0kKIwvdv7iAJcWwWC4OYazkCAhrmuyVD6UJFhoeWzkupuD5hbIAfyLk
        JtCecsXKGlm5eVBpOvUKeXiR7C4nWL4HaVA==
X-ME-Sender: <xms:30JoZa__NZR7rAS7yNEV9tVLlu07nwMm5PkiMu810gyil11WeWG9cw>
    <xme:30JoZasz_10cKqO6iXgwgfgNACjAG34k3NXt9xSVAvGXCXJoruhcX9KEiyfzNUHNB
    cFLRRZR8d1PWWyM8C0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:30JoZQD6GDEo2WQLYt0vqB3WgSNf3bYLjokeSfdijvvfyK8GYapM2g>
    <xmx:30JoZSfeIRXhadZjWghMZgu0TiVnHsHKE3TqX4jP-lHnUJ-1qNcV-g>
    <xmx:30JoZfNkOkdi6Uw80VA5zRP-aHkXHo68_XkhrgG-dCzyItW6Z3vUxw>
    <xmx:30JoZa2mGqoSvfvjQjoBsrxInzNx_hIFe7MODJJkII69zo4lLtvNqQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F2B9BB60089; Thu, 30 Nov 2023 03:07:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1238-g6cccb1fa34-fm-20231128.002-g6cccb1fa
MIME-Version: 1.0
Message-Id: <4be73872-c1f5-4c31-8201-712c19290a22@app.fastmail.com>
In-Reply-To: <20231129151030.24b807f1d2b43be301a533b7@linux-foundation.org>
References: <20231130075838.05e5bc9b@oak>
 <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
 <ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com>
 <20231129151030.24b807f1d2b43be301a533b7@linux-foundation.org>
Date:   Thu, 30 Nov 2023 09:07:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Stephen Rothwell" <sfr@rothwell.id.au>,
        linux-next <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: linux-next: lots of errors/warnings from the -Werror=missing-prototypes
 addition
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023, at 00:10, Andrew Morton wrote:
> On Wed, 29 Nov 2023 23:51:04 +0100 "Arnd Bergmann" <arnd@arndb.de> wro=
te:
>
>> I did all my testing with CONFIG_WERROR force-enabled, so
>> the bit I missed here is that at least three architectures
>> that are missing fixes also set -Werror: mips, sparc and alpha.
>>=20
>> How about adding a patch to no longer force -Werror for
>> these?
>
> These architectures are doing it wrong, aren't they?  They should be
> using the CONFIG_WERROR infrastructure rather than hard-coding it?  If
> so then sure, a standalone patch to clean that up sounds sounds
> appropriate.=20

Yes, I think we should have already removed them when CONFIG_WERROR
was added in v5.15, the architecture specific logic dates back
to v2.6 times.

> I guess it should precede "Makefile.extrawarn: turn on
> missing-prototypes globally".

I already have a collection of patches to fix up known
-Wmissing-prototype warnings across architectures in the
asm-generic tree, so I'll add this patch there:

commit bdef96eb0b89dfa80992312a8e3b2613bf178ae5
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Nov 30 00:07:07 2023 +0100

    arch: turn off -Werror for architectures with known warnings
   =20
    A couple of architectures enable -Werror for their own files regardl=
ess
    of CONFIG_WERROR but also have known warnings that fail the build
    with -Wmissing-prototypes enabled by default:
   =20
    arch/alpha/lib/memcpy.c:153:8: error: no previous prototype for 'mem=
cpy' [-Werror=3Dmissing-prototypes]
    arch/alpha/kernel/irq.c:96:1: error: no previous prototype for 'hand=
le_irq' [-Werror=3Dmissing-prototypes]
    arch/mips/kernel/signal.c:673:17: error: no previous prototype for =E2=
=80=98sys_rt_sigreturn=E2=80=99 [-Werror=3Dmissing-prototypes]
    arch/mips/kernel/signal.c:636:17: error: no previous prototype for =E2=
=80=98sys_sigreturn=E2=80=99 [-Werror=3Dmissing-prototypes]
    arch/mips/kernel/syscall.c:51:16: error: no previous prototype for =E2=
=80=98sysm_pipe=E2=80=99 [-Werror=3Dmissing-prototypes]
    arch/mips/mm/fault.c:323:17: error: no previous prototype for =E2=80=
=98do_page_fault=E2=80=99 [-Werror=3Dmissing-prototypes]
    arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for =E2=
=80=98init_vdso_image=E2=80=99 [-Wmissing-prototypes]v
    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previo=
us prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-=
prototypes]
    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototy=
pe for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for =E2=
=80=98prom_cif_init=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for =
=E2=80=98prom_get_mmu_ihandle=E2=80=99 [-Wmissing-prototypes]
   =20
    This appears to be an artifact from the times when this architecture
    code was better maintained that most device drivers and before CONFI=
G_WERROR
    was added. Now it just gets in the way, so remove all of these.
   =20
    Powerpc and x86 both still have their own Kconfig options to enable =
-Werror
    for some of their files. These architectures are better maintained t=
han most
    and the options are easy to disable, so leave those untouched.
   =20
    Reported-by: Stephen Rothwell <sfr@rothwell.id.au>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 1cc74f7b50ef..6a779b9018fd 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -4,7 +4,6 @@
 #
=20
 asflags-y :=3D $(KBUILD_CFLAGS)
-ccflags-y :=3D -Werror
=20
 # Many of these routines have implementations tuned for ev6.
 # Choose them iff we're targeting ev6 specifically.
diff --git a/arch/alpha/mm/Makefile b/arch/alpha/mm/Makefile
index bd770302eb82..101dbd06b4ce 100644
--- a/arch/alpha/mm/Makefile
+++ b/arch/alpha/mm/Makefile
@@ -3,6 +3,4 @@
 # Makefile for the linux alpha-specific parts of the memory manager.
 #
=20
-ccflags-y :=3D -Werror
-
 obj-y	:=3D init.o fault.o
diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index af2967bffb73..e2d623621a00 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -1,10 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# Fail on warnings - also for files referenced in subdirs
-# -Werror can be disabled for specific files using:
-# CFLAGS_<file.o> :=3D -Wno-error
-ifeq ($(W),)
-subdir-ccflags-y :=3D -Werror
-endif
=20
 # platform specific definitions
 include $(srctree)/arch/mips/Kbuild.platforms
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 1ce4d5028c86..58ea4ef9b622 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -5,7 +5,6 @@
 #
=20
 asflags-y :=3D -ansi
-#ccflags-y :=3D -Werror
=20
 # Undefine sparc when processing vmlinux.lds - it is used
 # And teach CPP we are doing $(BITS) builds (for this case)
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 80b07bbe4978..59669ebddd4e 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -3,7 +3,6 @@
 #
=20
 asflags-y :=3D -ansi -DST_DIV0=3D0x02
-#ccflags-y :=3D -Werror
=20
 lib-$(CONFIG_SPARC32) +=3D ashrdi3.o
 lib-$(CONFIG_SPARC32) +=3D memcpy.o memset.o
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index a199484e131f..809d993f6d88 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -3,7 +3,6 @@
 #
=20
 asflags-y :=3D -ansi
-#ccflags-y :=3D -Werror
=20
 obj-$(CONFIG_SPARC64)   +=3D ultra.o tlb.o tsb.o
 obj-y                   +=3D fault_$(BITS).o
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 397b79af77f7..a1adc75d8055 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -3,7 +3,6 @@
 # Linux.
 #
 asflags :=3D -ansi
-ccflags :=3D -Werror
=20
 lib-y                 :=3D bootstr_$(BITS).o
 lib-y                 +=3D init_$(BITS).o
