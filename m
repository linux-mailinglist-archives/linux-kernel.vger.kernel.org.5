Return-Path: <linux-kernel+bounces-19839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE15A82750E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E451C22AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64C537F3;
	Mon,  8 Jan 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eLMqCnP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="53g7yn4e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0552F86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EFC6F5C031A;
	Mon,  8 Jan 2024 11:26:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 11:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704731206; x=1704817606; bh=eeIzoqxrLX
	o1KH8BIqbi+bTf8TyIf0sMlfYqbdxX6QQ=; b=eLMqCnP2BUFKyAsVgX1rOKjFDV
	S4KTs1mPwq7THeA/it05hV74OvJykOS2Ujskkn0Ts3NirCjUIMXkMf/QJuTlBydQ
	0z229j2CYF1edy8Yeumj0noQqTYJ88fNAGEldPqeIoGHkkvQKveP9cRRJLGlvN0a
	eHy4mtyZd4Y3eLNnJaBbvJsOkRmvxyg6litoOungLvIA2FAS6dmSU57eD76piW9T
	8iqwB1s0yESSTg3haVNSrMl8PHf11QxXj2yvl4/r7j0yIGHupOOLfD/Seg60TRnH
	e2P3DUnVLIn7OQv3lMnGvjE+h3A7thi5s5hzs3hyAqN7jR3mrCIKeAt+yJBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704731206; x=1704817606; bh=eeIzoqxrLXo1KH8BIqbi+bTf8TyI
	f0sMlfYqbdxX6QQ=; b=53g7yn4eUzL7WZbr/n2CLy6X06nxW3hQkQOhlf5MdIMV
	PZadsxw2um0gDWTEJeWqjsj/C5IEt3WJCRRA6UcO9Sj42CVQuijH3WOYr9TuDlqy
	t2QwiHJZS6tNsenQQXvOmkWh9Ieayb6HjwNawg0inUWZZzDn/DIfCHbrUwxIPE7U
	kQnFV3kox04ZKdUj2BBN6LcAjp6cUspt1G43MZxG+1TAQc64lsdyCIylRaPgi45b
	uPrTART495RqYGjpnY6JT1aHRGhwA1ChAq9ZnuynUnjIQeEiQdwfKSwiieeY3lCz
	b9g/YE8YJRV99Wa5GwwN8xp0ygDOFccLJq0fDNL7Kg==
X-ME-Sender: <xms:RiKcZccYzu5UJIiAnmlTejzLHbsMvQ1bOKFK4n9YqX8AqWR46tkVfQ>
    <xme:RiKcZeNybYlNwM0VLuzXoiJWC7H2lGSkktbb5ajQYNPqm9Q5AB6kG_7ERNY0wKWRV
    ZfxCiOtTKGJdKSfV4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RiKcZdg0dpPmSUT5KPhS74g1Br4bpkVW3IdBP67yyZSL5JL-MDGhtA>
    <xmx:RiKcZR_80Uh0XaalCc1_dcYihXtnBvXBPlIJVYO52DpiMXWX64Hu9g>
    <xmx:RiKcZYv3wzRh1qN4NxgUa5H2wOVHV_HfrEq5XnZvcf9NFjOojjcc1g>
    <xmx:RiKcZd979eDY3v0TMTje9A75FEUAZlORVQe3J16suh7xrerh1vrJTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5C0BFB6008F; Mon,  8 Jan 2024 11:26:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6278e066-a443-4055-9e5c-b13dea5909de@app.fastmail.com>
In-Reply-To: <ZZwdKjsNj95wlTk4@LeoBras>
References: <20240105041458.126602-3-leobras@redhat.com>
 <ZZgAtntCQFKbsGiW@FVFF77S0Q05N>
 <112ae7d5-61b2-4887-a56f-35ea7c3b1bfa@app.fastmail.com>
 <ZZwPxNNc5pXr9kPi@LeoBras> <ZZwdKjsNj95wlTk4@LeoBras>
Date: Mon, 08 Jan 2024 17:26:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leonardo Bras" <leobras@redhat.com>
Cc: "Mark Rutland" <mark.rutland@arm.com>, "Oleg Nesterov" <oleg@redhat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Guo Hui" <guohui@uniontech.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Content-Type: text/plain

On Mon, Jan 8, 2024, at 17:04, Leonardo Bras wrote:
> On Mon, Jan 08, 2024 at 12:07:48PM -0300, Leonardo Bras wrote:
>> On Fri, Jan 05, 2024 at 03:38:05PM +0100, Arnd Bergmann wrote:
>> > 
>> > I suspect it's enough to remove all of the other
>> > "#ifdef CONFIG_COMPAT" checks in this file and rely on
>> > dead code elimination to remove the rest, but there might
>> > be additional problems if some extern declarations are
>> > hidden in an #ifdef as well.
>
> I could remove all CONFIG_COMPAT ifdefs from this file, and for compiling 
> it required a few extra defines (in other files) to be moved outside of
> their #ifdef CONFIG_COMPAT. Those being:
>
>  #define VFP_STATE_SIZE         ((32 * 8) + 4)
>  #define VFP_FPSCR_STAT_MASK    0xf800009f
>  #define VFP_FPSCR_CTRL_MASK    0x07f79f00
>
>  #define COMPAT_ELF_NGREG               18
>  typedef unsigned int                   compat_elf_greg_t;
>  typedef compat_elf_greg_t              compat_elf_gregset_t[COMPAT_ELF_NGREG];
> 
>
> OTOH, the size of the final arch/arm64/kernel/ptrace.o went from 44768 to 
> 56328 bytes, which I understand to be undesired.

Right, unfortunately it seems that compat_arch_ptrace() is
globally visible and consequently not dropped by the compiler
in dead code elimination.

> A different (and simpler) solution is to have an empty struct in case of 
> !CONFIG_COMPAT, that will be optimized out in compile-time:
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 9f8781f1fdfda..d2f275d8a3e6e 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2107,6 +2107,9 @@ long compat_arch_ptrace(struct task_struct 
> *child, compat_long_t request,
> 
>         return ret;
>  }
> +#else
> +static const struct user_regset_view user_aarch32_view = {};
> +static const struct user_regset_view user_aarch32_ptrace_view = {};
>  #endif /* CONFIG_COMPAT */
> 
>  const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>
> With this the patch will build successfully and arch/arm64/kernel/ptrace.o 
> will be able to keep it's original size.
>
> Arnd, is that ok?

I don't see it being worth it if you add extra unused lines
in order to remove one more #ifdef. I would either leave the
task_user_regset_view() function unchanged here, or (if this
works) move the #ifdef down a few lines so the existing
user_regset_view structures can be shared:

@@ -1595,7 +1595,6 @@ static const struct user_regset_view user_aarch64_view = {
        .regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_COMPAT
 enum compat_regset {
        REGSET_COMPAT_GPR,
        REGSET_COMPAT_VFP,
@@ -1852,6 +1851,7 @@ static const struct user_regset_view user_aarch32_ptrace_view = {
        .regsets = aarch32_ptrace_regsets, .n = ARRAY_SIZE(aarch32_ptrace_regsets)
 };
 
+#ifdef CONFIG_COMPAT
 static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
                                   compat_ulong_t __user *ret)
 {


     Arnd

