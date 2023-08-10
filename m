Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E6778124
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjHJTPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHJTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:15:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8DF2702;
        Thu, 10 Aug 2023 12:15:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 723B63200945;
        Thu, 10 Aug 2023 15:15:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 15:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691694925; x=1691781325; bh=cD
        RJ70tlUw1f5vvydGZnly44JvjoIjvlKIEtTxRqzOA=; b=BfIaANBPx1NIJxHUY8
        7ivOvwDz9pUturVj8bM/Xs6IgBKscXsONpFc3V/Uznsieh33xb8FD23DUZ1fV2OT
        ClwE5f/0TK0qFDpZGFAstr1dnPDg5APnNidEQoEmK5OBty6TOwndwMepEV4wzs8R
        AdNRtcKedt6eDTjYG77XDEe4bwMwHg/bOYVmRSKsGUiPih/fxA2vgZQTk+4/2H7i
        yCBYznxPMWsTIsr/BQcLiTuGcpQvTo32mkYNLPa9UAyiBzQptlHtA9zaWmkIHAET
        ahFv6nMirNlzUR6BbyaRKQ/BhJNZ+wYjlnQtJTt5aEDroonEcJ0y/K7PzmuJFerA
        Fv8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691694925; x=1691781325; bh=cDRJ70tlUw1f5
        vvydGZnly44JvjoIjvlKIEtTxRqzOA=; b=mcGZj3izxVPRaqh0Ac5Zt1zo1A3p7
        DFYh+1Td5wiN5QF/FcBRZxpITogPc+djwFaQmwPS0liywPzGo3wu7Gip5n9apMt/
        WbgAAs6S61KHm+NUzJB4eSfsik1As8ldtUrI/RzE3Qcu6+VaSiuhCCMZ7ndh3f57
        Z06R6SZCk2+VA9V4wvCWOjA2h1x0BQ+XWyc8vHXUvXtMMRMXmMNbv0RrmGoDn7+A
        RE5PzFtRGKFebpUvYAzX1l9Hmb/Sf6f/8OrhAGxwZ+K/gfuxkFspqSqiMjhFK8Ih
        BVVN60rtfYCdMRErxAjk+/6PR5jX+Cy5sJmRfIoHV3gSt3szZfxf8h3lg==
X-ME-Sender: <xms:TDfVZGcugxX9xNg19w5Sfg0LFsRvY9eBdBAAKew_kEeL1t3SM8Fh2g>
    <xme:TDfVZANodWVi8uy3GkcLwywk1g5cQ8ngsu7fhFynla5RTgOowzMIASVjBPthCdi-M
    zAgj7Ed_7F12SJlyQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TDfVZHhTlCJjXsjt4mV5IwwTSQkSXIx51Ep_onALlgl_9douam3AGA>
    <xmx:TDfVZD_GqEP9GsA7_w5YWfEQS_C3_k74IYvLABNf8vmhGAlxA1CjKg>
    <xmx:TDfVZCvHUBGcawkJEGm_3LM7FD3_w15jn0bry64MHmO9CdP3t5yhTw>
    <xmx:TTfVZKRmJx1wrrxznIrw6Fr3FPPXoM_qgP0qPxTQwnBRb6omP7_z-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99A05B60089; Thu, 10 Aug 2023 15:15:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <9f295a4d-5657-4e4d-8740-eb9a56cee97d@app.fastmail.com>
In-Reply-To: <5bc9d25c-d546-fe94-05cc-41bd5bbbaf67@gmx.de>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
 <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
 <5bc9d25c-d546-fe94-05cc-41bd5bbbaf67@gmx.de>
Date:   Thu, 10 Aug 2023 21:15:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Helge Deller" <deller@gmx.de>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
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
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, at 17:59, Helge Deller wrote:
> On 8/10/23 17:21, Arnd Bergmann wrote:
>> On Thu, Aug 10, 2023, at 16:59, Christophe Leroy wrote:
>>
>> I did send other fixes for microblaze and parisc specific drivers,
>> and I could also send patches for the two defconfig warnings if
>> the maintainers are happy with fixing those but leaving allmodconfig
>> to still warn, but I feel that it's easier for them to just
>> do the last fixes themselves and then remove my hack again.
>>
>> I'll wait for Michal and Helge on these.
>
> Arnd, I like your patch!
> For parisc I've done quite some work during the last few weeks to
> get such warnings sqeezed out, so please drop the hunk for parisc from
> your patch. My plan is to become warning-free before 6.5-final.
>
> This last one:
>      arch/parisc/lib/ucmpdi2.c:12:5: error: no previous prototype for 
> '__ucmpdi2' [-Werror=missing-prototypes]
> I'll take care in the parisc for-next tree.

Sounds good to me, thanks!

     Arnd
