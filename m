Return-Path: <linux-kernel+bounces-62266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B769851DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0771C219B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067447A5C;
	Mon, 12 Feb 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nW+VyRJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZVCs8cW"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D86405F8;
	Mon, 12 Feb 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765284; cv=none; b=B0NPh9RfFfMuhmP5pJuTveY0Ubg5H8k4NbqF3y7RIiZEO8nZCofcqpor/JflM1hkyPzbGusrZe9UGgrnTOnahLHtsMMYL7ymZpJjA2qwbsfPIB/ChI5mUWtzBnfnG2o3A8UfJ9otDzyjyBTLZC9C+tzPW3T54vhjylQac0kIHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765284; c=relaxed/simple;
	bh=VObJ2rct3pw2cbR6hCgheYS2cpTkK2Z4nveT/kYaBF4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W2NDX+A+cJS0KpCoyIBqTu64TXvXG8H3SDcps0ugPzGrEG/9fp+z0sqEFaPg4whq49R4hKuWdhKJs2vFwVqgguiHRTrXPJyM3VDLc+vmtu2+3XFDsWzqZoT0IYqhWkiiHs/afrtowaVNB4LZ8ueb25lCqKmkMcJmkch62oCkJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nW+VyRJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yZVCs8cW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2452513800A5;
	Mon, 12 Feb 2024 14:14:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 12 Feb 2024 14:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707765281;
	 x=1707851681; bh=owswN7XU/Fn0mSvnFsqZqiicnFod/NS5cnjRqcaw1U8=; b=
	nW+VyRJJFFU1Zxtj1eZWKi+KMs2BVX3Z8BA+KwbAyA812Sh6+PcWLAItYIb98btw
	NY8oHmLn/UzMfA/xzunxmaq8Huh7a230fwMqh+x6rJAmkYm8QrtrrtLK87GirL8u
	xVArA6xM1ORyPi/gjCkwOsaN214DgGWT1cfJ5Xu7lGEQbz+0FmYEEkpQFjdJ2w7A
	6EqXM0zJZwz8xQWyLu9GH3/zMvCdx8W5Ggdvw73T06RtPCpomopN8a0qp91yRFCN
	dOKfwHOAlkMAa6rzIdnLYueGHL0i8Y8wZZc186AkZ6NrXaDOy2KIiIqj6xq8pGld
	mehi1NWe3zCevzCya2whlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707765281; x=
	1707851681; bh=owswN7XU/Fn0mSvnFsqZqiicnFod/NS5cnjRqcaw1U8=; b=y
	ZVCs8cWJMmS/foQOdJrpUc7TbWBIaLeICwQTavWekPIalfjX48b8dBEW539Mc93C
	VS8xq+ReDnciLn6eXns6WzMZtZIFeLpjLuYU5/dJLvxccnFTU6a71zYheZTiWbiB
	xsA6Umg20/zfbV2ejxiHbJivyLYFyVTOlA7q8cE1d2Q+eZU9gqI4IjcUWmivaj6g
	9p5Xw5BgnDcMDX1dukXtNVKYvrdK+lBxbpF/pM5Iw41vU2J6u0gDL7xMsIyk8Wf1
	is0fBYmKuGG/QDCdjz9g/mbFci94I3vnNHMG0610usIiQ6XsVg3CFGawxTDjNKcd
	Dp7ixXkFLDA2rSqCpMKEA==
X-ME-Sender: <xms:IG7KZfoXX4N5T5lq4ALykSgSgZ7zogu0GQDjjd59DWI6wh06-fWNBQ>
    <xme:IG7KZZrtdY2nZl5IlC3uAvPSyF4VvBFTUgrB-VfJnIgEXYVORQw2aoqDzs1CubqgC
    glS665VZTkx-KeCRRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IG7KZcPeBrzOTwwpsnH8vneIDZt98fD1SAopAyqNNiwHr1m6B9wBVg>
    <xmx:IG7KZS53t_XSYXsI5-aZ0ahMbIrePfPA6EP3NOgW6xhsxbjorB7xMw>
    <xmx:IG7KZe7W3HIdZ1bFhA2U7kxhuAWhL119lTskO0dw9lHFEndu5sGtfA>
    <xmx:IW7KZRJbyVsb_ls52tp7cqiPAckIN9K9IlBBLfSt8wvAtm5CaBQ9AA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5A778B6008D; Mon, 12 Feb 2024 14:14:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2cacd8dc-6150-4aa2-af9e-830a202fb0a8@app.fastmail.com>
In-Reply-To: <4869921.GXAFRqVoOG@radijator>
References: <20240212111819.936815-1-arnd@kernel.org>
 <20240212124428.GB4593@aspen.lan> <4869921.GXAFRqVoOG@radijator>
Date: Mon, 12 Feb 2024 20:14:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Daniel Thompson" <daniel.thompson@linaro.org>
Cc: "Lee Jones" <lee@kernel.org>, "Jingoo Han" <jingoohan1@gmail.com>,
 "Helge Deller" <deller@gmx.de>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Flavio Suligoi" <f.suligoi@asem.it>, "Hans de Goede" <hdegoede@redhat.com>,
 "Jianhua Lu" <lujianhua000@gmail.com>,
 "Matthew Wilcox" <willy@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: fix LED dependency
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024, at 15:31, Duje Mihanovi=C4=87 wrote:
> On Monday, February 12, 2024 1:44:28 PM CET Daniel Thompson wrote:
>> On Mon, Feb 12, 2024 at 12:18:12PM +0100, Arnd Bergmann wrote:
> I believe this would be the best thing to do here. Making LEDS_EXPRESS=
WIRE=20
> user selectable doesn't make much sense to me as the library is rather=
 low-
> level (a quick grep turns up BTREE as an example of something similar)=
 and IMO=20
> the GPIOLIB dependency should be handled by LEDS_EXPRESSWIRE as it's t=
he one=20
> actually using the GPIO interface (except maybe for KTD2692 as it has =
some=20
> extra GPIOs not present in the other one and thus handles them itself).

Agree, let's do it this way. Maybe the leds-expresswire.c file should
not be in drivers/leds either, but it's already there and I can't think
of a better place for it.so just adapting Kconfig should be enough.

Please add the corresponding Makefile change as well though:

--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -135,7 +135,7 @@ obj-$(CONFIG_CPU_IDLE)              +=3D cpuidle/
 obj-y                          +=3D mmc/
 obj-y                          +=3D ufs/
 obj-$(CONFIG_MEMSTICK)         +=3D memstick/
-obj-$(CONFIG_NEW_LEDS)         +=3D leds/
+obj-y                          +=3D leds/
 obj-$(CONFIG_INFINIBAND)       +=3D infiniband/
 obj-y                          +=3D firmware/
 obj-$(CONFIG_CRYPTO)           +=3D crypto/

Without this, the expresswire library module won't
get built unless NEW_LEDS is enabled.

     Arnd

