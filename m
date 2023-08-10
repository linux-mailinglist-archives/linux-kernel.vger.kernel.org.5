Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1166777C07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjHJPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjHJPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:21:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9C90;
        Thu, 10 Aug 2023 08:21:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 59DCC32002F9;
        Thu, 10 Aug 2023 11:21:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 11:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691680887; x=1691767287; bh=2Q9/wkZuAqGaPUlwVeMbpzA59zc+JfHIktY
        O4gpFXEA=; b=ZCcOvD/TT/PSev+2Dyu9ZRKhlD4q/bxEv5m+kvnNStn5eSszZWm
        w9D5rrEsvkBLmz306pN0MqgCBrkdacFLlP0rSRb/WNaZNJc5uMDd5iDiMN+uBXYv
        GJOyPmA70xOSVNmpH/ET30WSOY/HTl7/mzDWPBLgMgllw73V+Wv/UFpDGv0WYEPU
        jtUByC4uRRJ9OjRPV5CNx4fob5dB60qcHFbzeHEg6+R6a57BUKfeNUoGYWovUIwx
        vkeit7Rlnxv0zWR6jkbC368cwJlumjjVa75wl8kXhsl3JJ4muOCtwGQNk5fIhkuq
        znkzlDD0Cg6bRbITDLIDSH2A0JKt/5wgXSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691680887; x=1691767287; bh=2Q9/wkZuAqGaPUlwVeMbpzA59zc+JfHIktY
        O4gpFXEA=; b=mms0pG75QfEGRdY/ORQ0MstTvMIXTCXtbdJmNVVzt+DPpXNBlxD
        +5UMexA4voHGOBrQCEgGvYUXvBBPVnElQGSTKN9uQ8of7OyWgnvQiBUp3C/yIlpy
        T8an/+4gYsr+5skEsqiLG48DUKeq8u9j9UtmpBVUujkjk2ll6C5FtSa5b+haekJ9
        OYWWYQ7A6PKlUtSVrMal7TiMysf/suC9L/GvlijFC/9PWaapAgwmMSMO0BPq04x/
        L0g0JH5xn86tizCEsedGoJzcSUulJHdXcLb6W1ZtqmRKS99y2tntFCSMjAa6TicL
        b1YxAem1VYQEPfpVW+ue+k4iDarYNL+9IGQ==
X-ME-Sender: <xms:dgDVZIXZFhxPSMTfGHMu_-j2HVQVYW5vHFeTdOtr8BoWT28-RIF6yg>
    <xme:dgDVZMk3uqFfDMn82mnb43VO29EJCPpp4plX5mMJRz932dNS5aFn-4w3AV_XBb3jl
    0mvSPPdywvSiJb_y1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dgDVZMauFN35ddea0SKuU1yYRyrapWXPaaGMByK8EiIaJYRLkYpkFg>
    <xmx:dgDVZHW6P84vUGMSkVGacaT3VuYhP0-MSZOmlRLNtYFc3x20Qf70Cw>
    <xmx:dgDVZClGx6gZNd8wTSf4DZdU-Y0BptPuYTUp1iefJsadxxAKOn6JuA>
    <xmx:dwDVZBqV2y_X_7ikf2dZGac6q82UL0zULTX42gbZsO_CIPAMrcH-BQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 47DE4B60089; Thu, 10 Aug 2023 11:21:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
In-Reply-To: <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
Date:   Thu, 10 Aug 2023 17:21:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
        "Brian Cain" <bcain@quicinc.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Jonas Bonn" <jonas@southpole.se>,
        "Stafford Horne" <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Chris Zankel" <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Youling Tang" <tangyouling@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Zhen Lei" <thunder.leizhen@huawei.com>,
        "Xin Li" <xin3.li@intel.com>, "Nhat Pham" <nphamcs@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, at 16:59, Christophe Leroy wrote:
> Le 10/08/2023 =C3=A0 16:19, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> I have cleaned up the -Wmissing-prototypes warnings for most of the m=
ajor architectures
>> as well as all drivers that get enabled for CONFIG_COMPILE_TEST, so n=
ow these should be
>> close to fixed on x86, arm, arm64, powerpc, s390, and riscv.
>>=20
>> The other architectures tend to have a lot of these warning in archit=
ecture specific
>> code, primarily from functions that are only called from assembler co=
de and do
>> not otherwise need a declaration but still cause a warning without on=
e. Other cases
>> are simply functions that should just be static or are missing an #in=
clude statement.
>>=20
>> In order to be able to turn the warning on globally by default withou=
t breaking all
>> these architectures, add a list of exceptions for architecture direct=
ories that
>> can revert back to the old behavior of not warning based on a new
>> CONFIG_WNO_MISSING_PROTOTYPES option.
>
> Some architectures only have a few of those errors/warnings.
>
> For instance microblaze and parisc only have one each. Isn't it better=20
> to fix them rather then turn the errors off ?

The list was only the 'defconfig' warnings, there are a couple more
that I saw with 'allmodconfig', and I'm sure there are even more
when dealing with other random configurations.

I did send other fixes for microblaze and parisc specific drivers,
and I could also send patches for the two defconfig warnings if
the maintainers are happy with fixing those but leaving allmodconfig
to still warn, but I feel that it's easier for them to just
do the last fixes themselves and then remove my hack again.

I'll wait for Michal and Helge on these.

> Others like loongarch which is a recent actively maintained=20
> architecture, I'd expect the 30 errors to be easy to fix.

Agreed, they probably are.

> Many of the alpha ones seems to be brought by your commit e19d4ebc536d=20
> ("alpha: add full ioread64/iowrite64 implementation")

As far as I can see, those already existing before that patch, though
I did touch the same lines there.

In the end it's a matter of where to stop, as there are endless
configurations to test if I want to do a complete job. I drew the
line between powerpc (which I tried to fix) and mips (which I left
alone), mainly because the powerpc side was already exhausting
and mips has even more obscure configurations. The other ones on
the list are all less actively maintained than these two.

     Arnd
