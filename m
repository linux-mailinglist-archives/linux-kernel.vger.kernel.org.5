Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE307E5EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjKHThk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:37:38 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A12110;
        Wed,  8 Nov 2023 11:37:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 223605C0161;
        Wed,  8 Nov 2023 14:37:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 08 Nov 2023 14:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1699472254; x=1699558654; bh=TuAUBn+gwTzKKR6XAwbb0F/b3IHOZTvECkt
        LGe4hx4g=; b=PVJG0o98fC7yGsJH3sLFWLS+9Qx45Aa3k0AGLNvE4iDwkqaceBW
        XZLRDqMmpCEHXquT1zQYScvNXd4eFiZyAtjoRjC3QWtNZOucnQ3GRTh/zjfYqojg
        xY9G8VaiSFmuC0QnwASeFW9XRGklNCjRffmsgQPaFkFMWEKnLgXtljAhaoZ+Dp3Z
        ITLhLCDK3h/nf3EJl7u9IGqdgWJXc3GVv9DhBbb8mikD3+bkYeKCD6jOquE7kGmW
        gqruVplLrrj8J7p5W9M1WA4plVKElu5x2dneV5gbfKt2ucnxyQLLA1P4r+ShnvgB
        pEvYx/RT5MzDfvVoP2e6WvM8zleSJv2rjpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699472254; x=1699558654; bh=TuAUBn+gwTzKKR6XAwbb0F/b3IHOZTvECkt
        LGe4hx4g=; b=U/JqjTCz/h3IQ++lzZ5k8jtpbeusB266pDr1L3Hft6La3fmnhwr
        /LJsZrB8F82dw9h7/xG0MAzARGMef1QlMZAgJeel6Im46SEUWRvxhElW5s8faJ4X
        Ad3/hpEImp3GP89CROhLk4ZG2Qg45+3fjCWJ8EwSQpxMV/Z95IucdLqTGa9GSsIq
        kztOg7yaGL6ag62mHdQhK6IbmCcq0khjSmD6qrlps6IIPZkMntxbC9FDvwPRQKu0
        h+TkBA27Vmg6B/3sIN2atWgMB3EeSc8v2GRCWQ7W7nI2bG7uM1xclF5p80XxDhvW
        5RBFMoZm9PIAFZUndUWzE3dbolhTMRRYf5w==
X-ME-Sender: <xms:feNLZTUCHLdljQqIP27dqpWV08PT-wDnllyCjEli72YETbK1NbeW0Q>
    <xme:feNLZbmqumcmLurbnml0CfOzDJyonxkOCRJb4GKn5wAEvv0G8GHTklorI6poq2k6u
    wJSDH7shmdDr2RMOfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:feNLZfY-yafopr-sU9ycJya1Opeh2hSa2kufxX29BrL8NULP2COA1w>
    <xmx:feNLZeU-7OKTvbZY15zn_Yxp5RZSGox92A_EWBzOo_eJs75k-wazww>
    <xmx:feNLZdlJeKxypZiByBP2nGKTGjpvAdWCUHGVpSjKlpol8pO6mY-4KA>
    <xmx:fuNLZYqzN9iRsNvbAOHK7jaVDdFmcHcsmlWFbwFXb6X2evL7ax3SyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 421A9B60089; Wed,  8 Nov 2023 14:37:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <d94de5b8-db92-4055-9484-f2666973c02a@app.fastmail.com>
In-Reply-To: <ecedb0f1-9543-35c6-18bd-723e6bf21173@csgroup.eu>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-16-arnd@kernel.org>
 <ecedb0f1-9543-35c6-18bd-723e6bf21173@csgroup.eu>
Date:   Wed, 08 Nov 2023 20:37:12 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Cc:     "Matt Turner" <mattst88@gmail.com>,
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
        "Geoff Levand" <geoff@infradead.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "Helge Deller" <deller@gmx.de>,
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
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023, at 19:31, Christophe Leroy wrote:
> Le 08/11/2023 =C3=A0 13:58, Arnd Bergmann a =C3=A9crit=C2=A0:

> powerpc has functions doing more or less the same, they are called=20
> __c_kernel_clock_gettime() and alike with their prototypes siting in=20
> arch/powerpc/include/asm/vdso/gettimeofday.h
>
> Should those prototypes be moved to include/vdso/gettime.h too and=20
> eventually renamed, or are they considered too powerpc specific ?

I don't actually know, my initial interpretation was that
these function names are part of the user ABI for the vdso,
but I never looked closely enough at how vdso works to
be sure what the actual ABI is.

If __c_kernel_clock_gettime() etc are not part of the user-facing
ABI, I think renaming them for consistency with the other
architectures would be best.

     Arnd
