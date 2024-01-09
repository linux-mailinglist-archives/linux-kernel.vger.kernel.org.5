Return-Path: <linux-kernel+bounces-20428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7126C827EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13983B20BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2263B9;
	Tue,  9 Jan 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YamSfekn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isZB8Vf2"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789412912
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 69F935C02D8;
	Tue,  9 Jan 2024 01:19:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 01:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704781147; x=1704867547; bh=i2E0GYQGCU
	nukc1Xm2CUnNLh1yKk7Vr1Uo5Z8zGq0O8=; b=YamSfeknz2EVajGJWpKi/+fSQc
	S/xhY4fkku5oq/4N1cyPBjKoGPARMcjxDp8th9UGD0z8sKNyJ1YfJ6DM17z7sxSL
	HO1KFt1EZ3d/hE70mHOG706fhP76ugYn/G25BI3UvG1xOiGcavEOFwy4y2LbGZpE
	VvDox5Lat8XlZRFVAofWsrwyOxRmY43evhG8pnMLN00230JpwvICRKe86trf/DEh
	ujcAJ/CR0aW89rqJM1nU2cSwUbJrDw63mLNqmmBwlRruItEXQ5ZtowNJwP/0bGME
	3c0iQsWOl6IJj9f5bEmNsbwI8NtGrMW2nDhp9lSp1inLoDERBW64TtqmSF6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704781147; x=1704867547; bh=i2E0GYQGCUnukc1Xm2CUnNLh1yKk
	7Vr1Uo5Z8zGq0O8=; b=isZB8Vf21ChqCRootrre9JTBLbgE9pMGz3oek4oNAfmH
	MbVwn1XjRN3+n9Jio3r/Ii5RwAz7/6Ykb5y1ymSGw6Bp+GCVdJIv+TlmOmlNJK9/
	k36xh7zs31oKjQkbwY7jOMyIZIolc5EUZzOBOhzMqy+fpAydJOcd2ovRdX9vmYO2
	+lq9+OVruUPPeU60319cMeLj3YEn1TmsLZypmv4uCuQ197t62kEI6eDOJL22jnNQ
	Xtq4eA8oGoy3aDbs2HhFgE6Q+PELya6eHOG+Jw1AADPWbab34uODEiAFmHQZEwGy
	saVQG68oz5nFloV4mG/3QEFWJINlUF0fM4YMOC6AiA==
X-ME-Sender: <xms:WuWcZXwQsDs7SwaN8jaDprUaNua4mYvgekaF2O6d8w6bV1XwHkL_-A>
    <xme:WuWcZfSIDJugd_WAhX2m2C0bPHSPQYYL_H4DIIN7CsX5qWnzooVMH_4Ic-UpRD06O
    WEebcpBbOHSKgkSF1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehkedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WuWcZRXgsRdYduJV9N0H1uIdLO4DqZpaprLY1UIIoDZJemswEIK8vQ>
    <xmx:WuWcZRizTvSO-lt3STFPtwhY7gE_lzzZxU_Ku41wAg4ahKYvXajMBg>
    <xmx:WuWcZZCVzeCUyPC1BYB8-Zun65vP0mfK25KDic7NHbReuWwK5DrQIg>
    <xmx:W-WcZd6rBAUsue_m_wW9j5jSrIDXNSXTpHYRiiMXhjU8dAX55ox7Gg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 84DE8B6008D; Tue,  9 Jan 2024 01:19:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f2e8df4-d8bb-4eff-8e70-0ac38736bd74@app.fastmail.com>
In-Reply-To: <20240108174330.472996-2-leobras@redhat.com>
References: <20240108174330.472996-2-leobras@redhat.com>
Date: Tue, 09 Jan 2024 07:18:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leonardo Bras" <leobras@redhat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Kees Cook" <keescook@chromium.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Mark Brown" <broonie@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Guo Hui" <guohui@uniontech.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Content-Type: text/plain

On Mon, Jan 8, 2024, at 18:43, Leonardo Bras wrote:
> Currently some parts of the codebase will test for CONFIG_COMPAT before
> testing is_compat_task().
>
> is_compat_task() is a inlined function only present on CONFIG_COMPAT.
> On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:
>
>  #define is_compat_task() (0)
>
> Since we have this define available in every usage of is_compat_task() for
> !CONFIG_COMPAT, it's unnecessary to keep the ifdefs, since the compiler is
> smart enough to optimize-out those snippets on CONFIG_COMPAT=n
>
> This requires some regset code as well as a few other defines to be made
> available on !CONFIG_COMPAT, so some symbols can get resolved before
> getting optimized-out.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
> Changes since v1:
> - Move some regset code and other defines outside of CONFIG_COMPAT
> - Closes: 
> https://lore.kernel.org/oe-kbuild-all/202401061219.Y2LD7LTx-lkp@intel.com/
> Link: 
> https://lore.kernel.org/all/20240105041458.126602-3-leobras@redhat.com/

Looks good to me, and did not cause any regressions in an overnight
randconfig build loop.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

