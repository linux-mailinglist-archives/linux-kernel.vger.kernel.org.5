Return-Path: <linux-kernel+bounces-3303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589B4816AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB411C22A38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2B14271;
	Mon, 18 Dec 2023 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RXMU++xD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmbrQi1j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58213FFF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id AD92E32003F4;
	Mon, 18 Dec 2023 05:12:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 05:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1702894352;
	 x=1702980752; bh=3ZyUug5xi/z8ZT7W43WlY1pfaZKNZzJDM3Pip8YjDvY=; b=
	RXMU++xDlQ6Rrti2xmG4o9C3g0x2w29JWi+1DPsZIbZQqpOijq6KGUk4VFkVoqbu
	bo8RxTXlEzXU+q5uVyr1YuXzdb6CptioQNC2luTSshIUfmn7LtQEvgy/zy6HfdKv
	Lu+CTVLN9tjTF/uxm7rzdCpSO00MLXi3SPQZhk1VXY6iaFUSidResSlBdHwMhf8B
	DeFdwPsTyP5s+LY1BlxwLyyE1E+FGKWhet/pqXsVcjOblxuLBInZhxskLifhM7W1
	9JU8/qVp9v1NcrGu+7OY8l+ZX10s07nr3fb6A6gSIztkv20Vlb6VycgQ3ZACvRX0
	kIRZEizPFlt407k6L0O9TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702894352; x=
	1702980752; bh=3ZyUug5xi/z8ZT7W43WlY1pfaZKNZzJDM3Pip8YjDvY=; b=P
	mbrQi1j0V9yqQ6sVCO9zM4NB7ShsVu5jg6j5DHHIHTvs+WPvNdNl6/xwhrxvTjd4
	eAk6Kvtbj/0AfWGlHa3r7LtFfvMreZvxWwSpYbSkwvfIS9czXlrqF3oe6fEL4CZ7
	c1USfgUc2l1qG8sRnvhKzqIVofRZ2j+W2U5MF1cKXNw9FKZenzMBULtvkdAX8yhK
	MpOQDu+eawyBHdoBRFudmr3ttKvhKc1ks/bQv1SY9N2CVzvxOTCX8cHynM0XMFuT
	nED0/qYShaqLq7g1kIGPL7VD8ALgWXojFbrEh4XTgXENO4pFzW019itgz62VkBGo
	dhyxbM8SxhhA3S+nPfyYg==
X-ME-Sender: <xms:DxuAZfKFQ-TqyMi--2tmDyyc061RA8yyuvMVsKoC5tRz4iZNa_tPbQ>
    <xme:DxuAZTKQJXpNOWc2DuM4mmdIdArMvGMKi41rIxr6e_5dQ9ADAeZVbNAZ8t6HKT3VF
    ppiArc5CgCli_aOkkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DxuAZXupAwMgxNkQC57WBKjtH7vtOQ1vQISgVdB_cRgCyweFmO3f8g>
    <xmx:DxuAZYYXG7833r3lpATp4n90r8R5DXcKDaZKnPHX7QAADG1g3bqSmg>
    <xmx:DxuAZWYsd9WfXx3-KawZOl_CQAIAmNJF6eo2iDMXN_QGWn5qR88oNg>
    <xmx:EBuAZWHFrVeHD0K_gBdaudyAJWuW4fGA0ObOOGkAo9cAC8ouBqUzgQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C010FB6008D; Mon, 18 Dec 2023 05:12:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b091f9d3-14e9-4f2c-bf98-9a207cef412a@app.fastmail.com>
In-Reply-To: <3fb66648-5581-4371-b15e-23e52e6469ba@t-8ch.de>
References: <202312171924.4FozI5FG-lkp@intel.com>
 <3fb66648-5581-4371-b15e-23e52e6469ba@t-8ch.de>
Date: Mon, 18 Dec 2023 10:12:03 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>
Subject: Re: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON
 failed: skb_ext_total_length() > 255
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023, at 17:13, Thomas Wei=C3=9Fschuh wrote:
> +Cc Arnd who was taking care of CFLAGS_GCOV in the past.
>
> On 2023-12-17 19:39:34+0800, kernel test robot wrote:
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202312171924.4FozI5FG=
-lkp@intel.com/
>>=20
>> All errors (new ones prefixed by >>):
>>=20
>>    In file included from <command-line>:
>>    In function 'skb_extensions_init',
>>        inlined from 'skb_init' at net/core/skbuff.c:4848:2:
>> >> include/linux/compiler_types.h:397:45: error: call to '__compileti=
me_assert_810' declared with attribute error: BUILD_BUG_ON failed: skb_e=
xt_total_length() > 255

I tried to count the actual number of bytes and got to a worst case of 2=
00
bytes (for 64-bit machines), but this may have been wrong. I can think o=
f two
possible things that may have caused the problem:

a) there is an actual overflow but gcc fails to realize it without GCOV
b) the compile-time calculation goes wrong and is no longer a constant
   value, so the assertion fails to evaluate

We can probably elinminate a) if you can show that raising the limit does
not avoid the problem.

> [..]
>
> This seems to be a compiler bug/configuration issue.
>
> When I remove the entry for SKB_EXT_MCTP from skb_ext_type_len then the
> error goes away. However this entry works the same as all other entrie=
s.
>
> Also dropping -fno-tree-loop-im *or* -fprofile-arcs from CFLAGS_GCOV
> makes the code compile as-is.
>
> Or switching to a 64bit build...

The -fno-tree-loop-im option would likely stop the loop from getting
unrolled, which is how the skb_ext_total_length() return code is no
longer constant.

Does manually unrolling this loop avoid the problem?

       Arnd

