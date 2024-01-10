Return-Path: <linux-kernel+bounces-21964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648E82973B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A3AB2646E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D83FE26;
	Wed, 10 Jan 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="myiiLqUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3aLv+tsR"
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B613FB08;
	Wed, 10 Jan 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 1CEA32B005B1;
	Wed, 10 Jan 2024 05:20:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 05:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704882032;
	 x=1704889232; bh=syE5UlqFQxkc/rlq6eSMNsD1Ft+dm/4kEwr9kygNnZw=; b=
	myiiLqUCaOFNyy0KGz1/79d3HRMOpqenCIcjtVp8MIMXNuuxs7r3pdnpfmWhoqoR
	IQ7N3YbmF9nJffZH4HS8LkIh22Vv3wG2sjpK27f9XTmmoCr2Kc68Xrl4dw5To32W
	7oTNxvKqrQNHtDvW+wa87N9N90pn8A9G+LrTYmcdO105B4Zsmftj7IvnAIh1E8zz
	Q2WU5G/3jk+uFyxgwtiyCxFAwp4RGMAhxKlU9P6WBbVa8LUUGhnX9TdNNUh1DUbx
	zmCG1MYbF7h4hfd2TJzbdJ+Q1Rify5IxLv96YznkO8r5UDdnw/B35FP/X80ijL7V
	BaGn8hEWLg1dYwSkCYndvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704882032; x=
	1704889232; bh=syE5UlqFQxkc/rlq6eSMNsD1Ft+dm/4kEwr9kygNnZw=; b=3
	aLv+tsROFR55+fPEzkAuUR1EYdQ2HX99dqCRlz/JfV2MsJtp0CGFqmB6tAMDy72A
	ZrX+AdDDWBNTrrW7sMzvvfEP8gUJIpMLLtVrp/teui+cU+9KRRCxKXkanMetlfcj
	FBkFKDgNOVxh6ZGz33H1r+Dke653H3inbaS1l5dzm3/T9LKzj/zhFl3mBIhvpN+a
	i/+bZg97tvEz1ahcWMOXb7cxJW8wSehQ2OGnZNijfKOPiOkazb67CX7p6n/QsClV
	xFUVOUH+ktgc0Wsof32P0kt85rwvOomYqUIMGJg3KdbRUBngGNzPJwoAUnUqfuOk
	0otxMsg6CfS2J4mWRF6QA==
X-ME-Sender: <xms:b2-eZfbb8jU7eUbhVM8ptUPbFBsqxwkHmtQmk9r-V5K41TRFTBKjlA>
    <xme:b2-eZebHxIw1Fjp3BqSzuovwQbyqtk2C5hrRG6PAfO8XS-kw0MYGTAjpPxl57hAYq
    -Augo6FuvTHj0uSGNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:b2-eZR8Zym7T_ixwwEfoUeE2EDbxpF4y1T6da7RnK6yyA1qx7ynaAQ>
    <xmx:b2-eZVr4FQ5uhgAwkslmh14i6fuaYanuuxC2M5Z2QAp-pF9q7WvfTw>
    <xmx:b2-eZapet_e5NSzPInuoxvdn0YzOepAI8Xf2d7B8XgPzF98nJjvgIg>
    <xmx:cG-eZeqOJGWBxdm_kxnLomgMKhRJk3BAFc59xS0XCWHMebF1Iw26jJaiRpM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 64819B6008D; Wed, 10 Jan 2024 05:20:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fdf707b9-f39d-4f5a-a8bf-1bcb8cc6594f@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdV8uFKntiMfwwmnFpd4Dcx8vJDwS6r1iBLtkh40N71dbw@mail.gmail.com>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-9-arnd@kernel.org>
 <CAMuHMdV8uFKntiMfwwmnFpd4Dcx8vJDwS6r1iBLtkh40N71dbw@mail.gmail.com>
Date: Wed, 10 Jan 2024 11:20:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 linux-kbuild@vger.kernel.org, "Matt Turner" <mattst88@gmail.com>,
 "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, guoren <guoren@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Greg Ungerer" <gerg@linux-m68k.org>, "Michal Simek" <monstr@monstr.eu>,
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
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 x86@kernel.org, "Helge Deller" <deller@gmx.de>,
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
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-parisc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
 linux-mtd@lists.infradead.org, "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
Subject: Re: [PATCH 08/22] [v2] arch: consolidate arch_irq_work_raise prototypes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024, at 10:03, Geert Uytterhoeven wrote:
> On Wed, Nov 8, 2023 at 2:01=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The prototype was hidden in an #ifdef on x86, which causes a warning:
>>
>> kernel/irq_work.c:72:13: error: no previous prototype for 'arch_irq_w=
ork_raise' [-Werror=3Dmissing-prototypes]
>
> This issue is now present upstream.
>
>> Some architectures have a working prototype, while others don't.
>> Fix this by providing it in only one place that is always visible.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Acked-by: Guo Ren <guoren@kernel.org>
>> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

I've sent out the asm-generic pull request now,
that contains the fix. Thanks for the reminder.

      Arnd

