Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4157FE3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbjK2WvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2WvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:51:20 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C79131;
        Wed, 29 Nov 2023 14:51:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B2E415C00E0;
        Wed, 29 Nov 2023 17:51:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 Nov 2023 17:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1701298285; x=1701384685; bh=hymbYnH7yBTU095q+Rpr8C3/PL7MWg2ZZiC
        sQheOnPM=; b=Cz/StN9Iu7r4NeHR5S3yK5tLch72h6ftqi0P/J1cD0CeXLvke/n
        YxRC5LkIBi8HcxioXEaogz070YMrDrCS9o5aozmYNMQZ0s9DErYkG41tidlQsxW7
        5cKT7fzW6VLEH5FcAkMU04UoFRbpiTms7PId6LENCmCuZh71Kr1seupSUeBLdPXK
        0rriQsfErDNQbBgt75VhaqIiYFerMaBwkTSFBEYn/830tC9RiJIPnaYciEjL09gu
        nHrjE+KNzrId5yH5EiCj2ux6anm3qI42GsrRjZgoeadvtvHa1AX8MN9X9C51uY/4
        37EFFY6o9P3/KiEhUksijOwZdC4tPHg4EHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701298285; x=1701384685; bh=hymbYnH7yBTU095q+Rpr8C3/PL7MWg2ZZiC
        sQheOnPM=; b=mkb7rkOvp7rCN9ZMDuOpyYmwAY98eoW5+FScnSM21NT2qJXuQ4t
        IuvxQVxa4JzjOR9250RrV7YbSlv8JdNMa673Ld24qci3ZhR7JjtFGx/4xDB9qVWB
        2MEOy+rht6FCMR+uapH1YmSnfCsr6ZXDSqbugWTiFMZhMu/vstqTrGgVO1kMs75E
        S/e+WNo1UeHdWZ41XhoLIcCyaEtJV6+JaTAdmP7hfCh4jFIZFScAE4B9UFp9xhZc
        3Xrjw5TYs6ezHxiObaY7+fvQ8fwY3WCEVwmdYl1bZNCArfEstE4SkwRH09gsBCN6
        ejm5qmxpQWysNRY2fh/4FRgam55OqqKKjOg==
X-ME-Sender: <xms:bcBnZfH4mgrPVVPHw6itwlqK6_txjv876ZShPEOgz2znlDOGcvp7Jg>
    <xme:bcBnZcWgxoMidP4zCTDC_XYLiKXpE4LlLvxROzBcp8hAZhk-BLWgHipMVBC0y2AjZ
    ydkcw5QPx2Trf0mt-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bcBnZRLK_5Ju7VIIDYpmIwneevKgQFe0qU6zEmc_-6c3V7814ZPZew>
    <xmx:bcBnZdGh8I_ifdVT0_l8wJxPiPSerL85mBpaLCyIKZSop666cqkN-g>
    <xmx:bcBnZVVwxiEUrE_XvOP7l-tx_gnGTpNxtPzenmcEqI8-6XkGm0DHYA>
    <xmx:bcBnZTc62CcpiyKK65CwugnmbC6v4zBO4Sg8hAFvq7dbKamcbtkxeQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EC40B60089; Wed, 29 Nov 2023 17:51:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com>
In-Reply-To: <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
References: <20231130075838.05e5bc9b@oak>
 <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
Date:   Wed, 29 Nov 2023 23:51:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>
Cc:     linux-next <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: linux-next: lots of errors/warnings from the -Werror=missing-prototypes
 addition
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023, at 22:10, Andrew Morton wrote:
> On Thu, 30 Nov 2023 07:58:38 +1100 Stephen Rothwell <sfr@rothwell.id.a=
u> wrote:
>
>> Hi all,
>>=20
>> please see the kernelci results here:
>>=20
>> https://lore.kernel.org/all/656732fc.170a0220.49447.2c19@mx.google.co=
m/
>
> And I'm not seeing a lot of fixing activity for these.  Arnd, do you
> think it was just too soon?

I was aware that a couple of architectures get new warnings,
and a previous version of my patch series turned -Wmissing-prototypes
off for those architectures.

Since most other architecture maintainers had already fixed all
the warnings after that series, my hope was that this would
happen for the rest as well.

I did all my testing with CONFIG_WERROR force-enabled, so
the bit I missed here is that at least three architectures
that are missing fixes also set -Werror: mips, sparc and alpha.

How about adding a patch to no longer force -Werror for
these?

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


I'll also follow up with patches for the top warnings on mips
and arc, which should make most of the currently failing builds
clean again even with CONFIG_WERROR:

    37   arch/mips/kernel/signal.c:903:17: error: no previous prototype =
for =E2=80=98do_notify_resume=E2=80=99 [-Werror=3Dmissing-prototypes]
    37   arch/mips/kernel/signal.c:673:17: error: no previous prototype =
for =E2=80=98sys_rt_sigreturn=E2=80=99 [-Werror=3Dmissing-prototypes]
    37   arch/mips/kernel/signal.c:515:5: error: no previous prototype f=
or =E2=80=98restore_sigcontext=E2=80=99 [-Werror=3Dmissing-prototypes]
    37   arch/mips/kernel/signal.c:438:5: error: no previous prototype f=
or =E2=80=98setup_sigcontext=E2=80=99 [-Werror=3Dmissing-prototypes]
    34   arch/mips/kernel/signal.c:636:17: error: no previous prototype =
for =E2=80=98sys_sigreturn=E2=80=99 [-Werror=3Dmissing-prototypes]
    11   arch/mips/kernel/syscall.c:51:16: error: no previous prototype =
for =E2=80=98sysm_pipe=E2=80=99 [-Werror=3Dmissing-prototypes]
    8    arch/mips/mm/fault.c:323:17: error: no previous prototype for =E2=
=80=98do_page_fault=E2=80=99 [-Werror=3Dmissing-prototypes]
    12   arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype=
 for 'syscall_trace_enter' [-Wmissing-prototypes]
    5    arch/arc/kernel/kprobes.c:193:15: warning: no previous prototyp=
e for 'arc_kprobe_handler' [-Wmissing-prototypes]

      Arnd
