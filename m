Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1237779E11
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjHLICe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:02:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F591FE6;
        Sat, 12 Aug 2023 01:02:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 15CFE5C0056;
        Sat, 12 Aug 2023 04:02:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 04:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691827352; x=1691913752; bh=B7
        pOJdGFDOf/BCasjh0dVOxmA3Mm35lZV2aH6kqC0w8=; b=bWL46N0sK4mIYpWzoj
        J/+e+b8Mu9CpgyBLRhbmW/TyuCEnsAuKlS4X0lT5efId871OmOj5YcYmYg00NGPd
        IcAELxQotBSuJ/90jbsZktoCZaBeDjcMja4UE7PY/KJ9BQxHMR8ttw19gadY4pLD
        wcpu71/4NgDXLZF/K7TzADQEKciG8tdFwEV+hn9mwnLC982sMNooAap2Ahr2ic02
        OX1TDcc92+mLu+noqL+P1+HfjKrPOssbrzLOWiTlGBYyQ2X6xUoDe8FH5hLbs8Zs
        FmxsgM31F6ThFZX8SA1a+xBdVxbX9hhX71mg/b6+C5V15wIo2qBJ6zjh3xckiJob
        8oqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691827352; x=1691913752; bh=B7pOJdGFDOf/B
        Casjh0dVOxmA3Mm35lZV2aH6kqC0w8=; b=tJ1h5kA/J6E62tVerAQCZa0aQUiLa
        dZExElcAFIrHaz4IwM7Ow1ltkUruuCWsOJCyh1z7aQtGI+w5HaBlSmZ+g3sMPCda
        xubPC3utl1cj6/nHtnBh0zC5LTFR+KNkRg4EMhDLuERXDLZ4Aw4RkebGXJaIBZ2z
        wqa854o60Ce1tMXNWniimZ3W3nrC3twAjPDF+DoFqhA6k/7W4Q8yP6gpTqTX3H4D
        A1+7oickvOZ3pG8fapNcg2rld2K7G5tar0BTq01+PtwsrthFpU9JUN88b64SrWxE
        i+I6EhM3NmuwXev5m6HLAkhNfUxNiuURcXLhz5qvBlOtnzaNWe1YrJFpg==
X-ME-Sender: <xms:lDzXZLww55is2QMPDYjjRVLtLyoZjTnXsReClk3fNJpNGvX9Yp4KaA>
    <xme:lDzXZDTEfg0QqMlQN_EwpPTwY-rhr-gEjTSPzFsEPH9b0QutV4uC-Wz-TzUkje1U5
    ZrIr9BbeyiIc8d0k6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lDzXZFWakJL6bP1C3CtyxCernVmFFVA4usDlWrWHbJV80fBcqyEDdQ>
    <xmx:lDzXZFiAeZOhiK_1-3IRnA4TAG5simqdV9x1oAOMfe9e2PDVwrLUpQ>
    <xmx:lDzXZNB5btGQ4E1l2bsVvCFcQWx3QMH1JlzzDkSwKyzK6IOlyrvoAw>
    <xmx:mDzXZB1rv3zksY1BwcCii-YiQW0PH8eBdJskrEe3ags7tVQfE3dKGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3DD63B60089; Sat, 12 Aug 2023 04:02:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <13f9c06a-f840-4010-ae2f-97d8b2883e76@app.fastmail.com>
In-Reply-To: <ZNaVYh2qi0VQQKWf@antec>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org> <ZNaVYh2qi0VQQKWf@antec>
Date:   Sat, 12 Aug 2023 10:02:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stafford Horne" <shorne@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, "Matt Turner" <mattst88@gmail.com>,
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
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, "Borislav Petkov" <bp@alien8.de>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
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
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023, at 22:09, Stafford Horne wrote:
> On Thu, Aug 10, 2023 at 04:19:34PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>

>> arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
>> arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]
>
> I'll try to get these fixed for 6.6.  I was looking at them recently but did not
> actually make any changes and just put on my TODO.  Your series moves it up in
> priority and it should be easy to get the fixes out.

Thanks!

Since we already have the majority of architecture maintainers stepping
in to fix the warnings, I wonder if I should just drop my patch 16/17
completely and let the others handle it as well rather than shutting up
the warnings. Only the asm-offsets change is really needed to compile
test most of the kernel even with CONFIG_WERROR, and without that this
is just some harmless output.

    Arnd
