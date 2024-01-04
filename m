Return-Path: <linux-kernel+bounces-17203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3578249B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC931F24E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F851EB25;
	Thu,  4 Jan 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GqgKWDGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ttUZcSHw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5E1E516
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 55ED75C013C;
	Thu,  4 Jan 2024 15:44:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Jan 2024 15:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704401058; x=1704487458; bh=vxMtzvPMQK
	d1SiZacsZyfWzRtiMATjf/63voQ2li8VE=; b=GqgKWDGSjf+o89/ZfSg5ye798L
	UxTrE7QcH3I0GCosFtX/9yacxell1/4rzznVyTJFrtpGtlHyMGnF02j+26vyRlYL
	5pJyaRtxz8m2kTC1nd+IKeg5ZfpuQeMqFm8qofiHYO9Mh5jbRxmA55OB55/v0/YQ
	3g/O8Rnwdtl1MQPZtM+sZ8LOg4ZblbuJIiHrd+wtjRenx4fRILk0nzcyFNjgP4Nw
	YablXV5aGDbf1Ennxd4PkgW8909josANAkqdygvHRjgVFsQ627AE0TP9FhRWvW7B
	zZe8kCHVeC3UpL4wiChnRSOzIzjrry9aknT3Yj73SCOwAyYMHFa0g0xI2l9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704401058; x=1704487458; bh=vxMtzvPMQKd1SiZacsZyfWzRtiMA
	Tjf/63voQ2li8VE=; b=ttUZcSHwR64wPlT9m++LhG15pGFMrud7o9jpHDOPsbGE
	uv0KGOze1kJb/NMzAG40DkllRE2uTsH/P1UAQq/cznvm5n9x2VpVH7iiTWGPMVOG
	urfQhLVGGUuP7b/CkMUPvaG8gkxiYyF0aKlTdZtT7CGF+zjhHyLKIR/IsUiSG10y
	OQiMcuFaVh5kzrNu5L+SW3e1omrkAo4SaStNp/DJ5b0+O2jAm2COgXvmAAEdz5xh
	d3jk5ijFE4W4FvIBkU6NDAv5prIjhCbFmGIYQmJcugdY78KMNcX6vhN784LpvFBE
	6mJAwilBdxphO3j1AgmN+LCl9R1umieSGlspu+PIyA==
X-ME-Sender: <xms:oRiXZQI5hozwCOwofw6VHE5hok8qmC60LFMKBD2dNmEKRY62YiV6QA>
    <xme:oRiXZQIuLP5LpO3LcKykpviEalWt4batmX2dLhhGBFmT6TSV2Yg8EOi9dCSts9bl1
    CRgNBJAJx6uNS_Wn2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oRiXZQu7XQfhU6inEydOBBU_ZVLGARcOwQ5VItG885T2n-MMznEoiA>
    <xmx:oRiXZdbx-5WVYUFe2E9_yoKUDD_p4zKXlUq-HKfNUdviRPsUSAi7IQ>
    <xmx:oRiXZXYAGPkflnTZbDMPDsNDBRxJc5OPOUKf5_LFqcyPHKng4YkKsg>
    <xmx:ohiXZRk06f53l-YGOqrzb8cn0BGKwmKhB2_Rq9xallaqZEgzD68y7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B617AB60092; Thu,  4 Jan 2024 15:44:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8412ce8a-7016-4f65-99d3-ce472a75d8cd@app.fastmail.com>
In-Reply-To: <20240104192433.109983-2-leobras@redhat.com>
References: <20240104192433.109983-2-leobras@redhat.com>
Date: Thu, 04 Jan 2024 21:43:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leonardo Bras" <leobras@redhat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Teo Couprie Diaz" <teo.coupriediaz@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Guo Hui" <guohui@uniontech.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] arm64: add compile-time test into is_compat_task()
Content-Type: text/plain

On Thu, Jan 4, 2024, at 20:24, Leonardo Bras wrote:
> Currently some parts of the codebase will test for CONFIG_COMPAT before
> testing is_compat_task(), probably in order to avoid a run-time test into
> the task structure, while other parts of codebase will just test even when
> the option is not compiled in.
>
> Since is_compat_task() is an inlined function, it would be helpful to add a
> !CONFIG_COMPAT version of the helper, allowing compile-time optimization.
>
> With this, the compiler is able to understand in build-time that
> is_compat_task() will always return 0, and optimize-out some of the extra
> code introduced by the option.
>
> This allows optimizing-out code when the option is not selected, and
> otherwise removing a lot #ifdefs that were introduced, making the code
> more clean.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

This looks like a useful cleanup to me, with one change:

> ---
>  arch/arm64/include/asm/compat.h | 5 +++++
>  arch/arm64/kernel/ptrace.c      | 6 ++----
>  arch/arm64/kernel/syscall.c     | 5 +----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index ae904a1ad5293..3cc61cbbb9062 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -100,6 +100,11 @@ long compat_arm_syscall(struct pt_regs *regs, int scno);
> 
>  #else /* !CONFIG_COMPAT */
> 
> +static inline int is_compat_task(void)
> +{
> +	return 0;
> +}
> +

I think this bit is not even needed as long as users
include linux/compat.h rather than asm/compat.h, as there
is already a macro definition in the common file:

 #define is_compat_task() (0)


    Arnd

