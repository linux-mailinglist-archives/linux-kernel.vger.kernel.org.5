Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9A7E5FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjKHVHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:07:47 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC20EA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:07:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 15DEC5808D9;
        Wed,  8 Nov 2023 16:07:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 08 Nov 2023 16:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1699477660; x=1699484860; bh=D9PBCL8QJKdjrKS2aPJfuUQXeRbWRMeFHOK
        ckMk8fx4=; b=32beSgpe4JW/41MI9lwE9Ijo4clBZDCZcdz5W29GlXfmeBdloGs
        Pj6zClFpI3rBEASL5bt2BJ0z9kSHXoRmNM9S3ZUV9IpU6H2SlzHeojjwyK38ubdm
        rc5I6AbHQO428z+GTudTpXj84wN1iHyD5B4xrh7Xg9+/lOsXO8mWGmiOw0oEtT95
        59tIeWQXJ0PMlmbTe9oPGJNjvuF2Q00g7Aup3KvWuYCehPghEdVuK62ANt1RCDNX
        P59SJAJQv8a5rR+mmaJ00cjQiQKIVXVSq/NkJ5Ceh2lpGohzfDFoxucwi0IF29D/
        556O8j5asu9BGmdizp+cE+MTUaFBWLNaDZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699477660; x=1699484860; bh=D9PBCL8QJKdjrKS2aPJfuUQXeRbWRMeFHOK
        ckMk8fx4=; b=kjlV4oVb2NP4EXVJD0KYm4LTALqMkDnrU92/a5IM2DxqbQWjsi+
        IwdXxoSa3WEs4VZrlHH4JbCKkIL0G8Pwij1126xSe7hG/IMqOBcu3RQxvqgsEHsb
        pcFM0Ua1NE3OwtwEsNMc4jlmhSYjBeK+x0Ed/W7Rlf03UIZVqr2B+d0ryicP7Tub
        QSkOlA0efMsPA3XcbslixipIgl/+8P6M15YEgB0c0t6f8ouEUKSI2KL0MYB9RUr3
        hoiEAHdJCFrsG/Y/a3llxHIutnrnDvRz3cIbj7RF5co+2MINYEdgACq/D/uqzlpo
        r0L8iW3NWB7AxkztwyKFHjpLOPBdYiLEhJA==
X-ME-Sender: <xms:m_hLZQw4_GjcfbThT_vbWtFC1jg247Lu0E-xxAcura-dvGHI0kyRtw>
    <xme:m_hLZUTBxKjGHnkabv1F9oTzwRz5Y87A_Eif-kfMyvanmifw9H6wOpvDuy8X5HtkK
    Zp2U-M3JmHcVR-PhU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:m_hLZSW6ebv1Nls-lv6APr_ihVG7HATMnEZKUQ2lPJN14ImeSnqatA>
    <xmx:m_hLZejrECVMz1a28xI-eZZXTwB4qMex3E04bXgkhXhjxa6Uy3_eWg>
    <xmx:m_hLZSCmSuJkW1zFZoPx2zdR5BRKPmHS1VpT2dl_7ti0xOUBuc0gGw>
    <xmx:nPhLZa5R9gGZF0aG1bP9Mvi7bGv6CIQdVEBpyyHzpDHDqjyICYNx-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48539B60089; Wed,  8 Nov 2023 16:07:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <e7753f82-c3de-48fc-955d-59773222aaa9@app.fastmail.com>
In-Reply-To: <CAMuHMdXgdn_cMq0YeqPu3sUeM5cEYbCoodxu8XwCGiRJ-vFsyw@mail.gmail.com>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-11-arnd@kernel.org>
 <CAMuHMdXgdn_cMq0YeqPu3sUeM5cEYbCoodxu8XwCGiRJ-vFsyw@mail.gmail.com>
Date:   Wed, 08 Nov 2023 22:07:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, guoren <guoren@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Geoff Levand" <geoff@infradead.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, x86@kernel.org,
        "Helge Deller" <deller@gmx.de>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Timur Tabi" <timur@kernel.org>,
        "Kent Overstreet" <kent.overstreet@linux.dev>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "Anil S Keshavamurthy" <anil.s.keshavamurthy@intel.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
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
Subject: Re: [PATCH 10/22] microblaze: include linux/cpu.h for trap_init() prototype
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023, at 21:42, Geert Uytterhoeven wrote:
>
> On Wed, Nov 8, 2023 at 2:01=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Microblaze runs into a single -Wmissing-prototypes warning when that =
is
>> enabled:
>>
>> arch/microblaze/kernel/traps.c:21:6: warning: no previous prototype f=
or 'trap_init' [-Wmissing-prototypes]
>>
>> Include the right header to avoid this.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your patch!
>
>>  arch/alpha/kernel/traps.c      | 1 +
>>  arch/csky/include/asm/traps.h  | 2 --
>>  arch/csky/kernel/traps.c       | 1 +
>>  arch/m68k/coldfire/vectors.c   | 3 +--
>>  arch/m68k/coldfire/vectors.h   | 3 ---
>
> Ah, so this is where the m68k changes listed in the cover letter are
> hiding ;-)
>
>>  arch/microblaze/kernel/traps.c | 1 +
>>  arch/sparc/kernel/traps_32.c   | 1 +
>>  arch/sparc/kernel/traps_64.c   | 1 +
>>  arch/x86/include/asm/traps.h   | 1 -
>>  arch/x86/kernel/traps.c        | 1 +
>>  10 files changed, 7 insertions(+), 8 deletions(-)
>>  delete mode 100644 arch/m68k/coldfire/vectors.h
>
> Obviously the non-microblaze changes should be spun off in separate
> patches.

I messed up one of my rebases here and accidentally sent
the wrong changelog text. My intention was to have the
combined patch but with this text:

    arch: include linux/cpu.h for trap_init() prototype
   =20
    some architectures run into a -Wmissing-prototypes warning
    for trap_init()
   =20
    arch/microblaze/kernel/traps.c:21:6: warning: no previous prototype =
for 'trap_init' [-Wmissing-prototypes]
   =20
    Include the right header to avoid this consistently, removing
    the extra declarations on m68k and x86 that were added as local
    workarounds already.
   =20
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>


I made the same mistake with the "arch: add do_page_fault prototypes"
patch that was missing an explanation.

      Arnd
