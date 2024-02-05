Return-Path: <linux-kernel+bounces-52373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CB84973E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FA71F22632
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7014282;
	Mon,  5 Feb 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rMvh53PR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8otuE/B"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31D1426B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127351; cv=none; b=fevI7KG6YEEWYBVIePSI4hvgDJOjviyb8i/JdtK+Rm/5eL2pIrxMas5ncMtl4+g9NWT/JRfQvaKgvoTc7mVVKgv3MCrcT+g1WuTQ8TSt9WG26b/B45Mh72m0WMdhlB/NAxaMAuU38WSu0l2p/iZnTRFkxlEy1GAGxYt0F2UqvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127351; c=relaxed/simple;
	bh=RE925lmrTN46q5uxL6/B+2Wt/4/4f4Wo1AXATendHFI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dApXcAIwggy+HAxW/RF2vriioBmrlpMU8/wJ0q9snBMyWNXnuB0AFclrUlUv7SA453DNi6H3ZFRzw+J7jAuqtjRLIPIlg/t9j3A1sXMHG+tFdj9riAcWCqa6JkeNG/dPOpnAR4eH/717UBgFjC3CHU8Y1XrIyO7o/0FIsojYrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rMvh53PR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8otuE/B; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AA68D5C0109;
	Mon,  5 Feb 2024 05:02:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 05 Feb 2024 05:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707127348;
	 x=1707213748; bh=71ZuiyPuLoLtSePbfj3fsGKQETE1wQmqWlZnyQ+YngQ=; b=
	rMvh53PRtXsYOaAwhaW5E4RGlpEjT20uu4a9OXU7Un+adYliMKB+B6dYn3Xw02h8
	MixXgyaW0/hU2GDXaZTJIsV7SvKWtWwOy1nzmLgkNWXpcOx31DUnX+/tEAg6EauW
	Pa2VLht+WRyDcnRZNtYAP2YS4LDqu8tLWF0izSHk+Jbe22+aH10bHLkFBw3gsbt0
	VO2slJlDtuq4aHfdLcMHZaeY0IOt20HB6YdncyErjeTLucSAABIU4NSwxXsFRKXo
	X1mM1yXLyQiDs4MN83ItDaKbI1st/2cDOBFnMgFqtzdG7bv6AXxIMnuZCxsOcu+F
	VynVFlNk14CSDVjfhIkFtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707127348; x=
	1707213748; bh=71ZuiyPuLoLtSePbfj3fsGKQETE1wQmqWlZnyQ+YngQ=; b=S
	8otuE/BIHMEvYwxIII+ZfxHSzPAFyOIfjcdJL42Htr7/8mxEJ0x47QSFWpOjiT10
	LaC1p5MKDoAVlrZ6eLXizvra2YhbYz141U0l5zkVzGPX0MjSHdU4IVvYDIbIcC+2
	VyxfoPFyUjvjZZAvfKwae3XkOSQGk0KBBsljPun7Vcli98eKVMbV6+eqSucItD1x
	9ICtO4ZPSGi8iK0Tedu1Dtfd/QgQkNwFpOYEm4fs2c5v0k8vixMM/bwvywiGAAss
	KbVXHNBYCdIN/aof8mLXDWhhcc/FyW/An7VRS8sGYmDbWgglPfSITRlhSN7maIui
	zUArMt1DeMrjI3JclS4BA==
X-ME-Sender: <xms:MrLAZTCARh-jfIbQJPNNxLApTD37PGNDsYLIjtYVKy7z-2-o60h9iA>
    <xme:MrLAZZjQZbyzP8Iae4qKHe729khnmgvNsBWt4AzvBwp1pCQ51BfYGhKnew8eQZ36z
    Q-AEhdCwhdDKVWUzog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:MrLAZem4QsSm8SJH91shQ7UFaF49X9FXBYviTk8sKlckNBFDKq3tog>
    <xmx:MrLAZVx9OUwNPoPXksTDN8M9chRx1bbGJMPE4bO0gvwQ-YrPFsPVxA>
    <xmx:MrLAZYTMLrBmuV1uKYQYeYf1l9pinHcIezcd1Ys355f2uwepqPj4pA>
    <xmx:NLLAZR-tWDgKOozjiHkia6U-KKU5dXWNHArV3BIzDdNdmSht2xBniw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AB8C2B6008F; Mon,  5 Feb 2024 05:02:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86ae775b-b3ab-45db-9541-95fcc0e17b5e@app.fastmail.com>
In-Reply-To: <f00582bf4d19b539cc1427706ee9a07fd3992bc3.camel@gmail.com>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
 <CACRpkdYDmx9qrkCo5mad_w1e0MKNYrVirg=qi+R4Q907SLdRwg@mail.gmail.com>
 <f00582bf4d19b539cc1427706ee9a07fd3992bc3.camel@gmail.com>
Date: Mon, 05 Feb 2024 10:02:06 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>
Cc: "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Russell King" <linux@armlinux.org.uk>, "Wu, Aaron" <Aaron.Wu@analog.com>,
 "Olof Johansson" <olof@lixom.net>, "Lee Jones" <lee@kernel.org>,
 "Ralf Baechle" <ralf@linux-mips.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 01/39] ARM: ep93xx: Add terminator to gpiod_lookup_table
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024, at 09:42, Alexander Sverdlin wrote:
> Hi Arnd and all,
>
> On Fri, 2024-01-19 at 00:52 +0100, Linus Walleij wrote:
>> On Thu, Jan 18, 2024 at 9:22=E2=80=AFAM Nikita Shubin via B4 Relay
>> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>>=20
>> > From: Nikita Shubin <nikita.shubin@maquefel.me>
>> >=20
>> > Without the terminator, if a con_id is passed to gpio_find() that
>> > does not exist in the lookup table the function will not stop loopi=
ng
>> > correctly, and eventually cause an oops.
>> >=20
>> > Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
>> > Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>>=20
>> Sorry, my bug...
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Cc: stable@vger.kernel.org
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>
> Arnd, could you please take this into arm-soc?
> I can send a PR, but this probably makes little sense for one patch?

I'm travelling at the moment, but can take it when I get back.

If you want to be sure it doesn't get lost, please send the
patch (with the Acks) to soc@kernel.org and it will end up
in patchwork.

   Arnd

