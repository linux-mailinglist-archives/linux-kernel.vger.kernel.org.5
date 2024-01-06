Return-Path: <linux-kernel+bounces-18628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A2826037
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F071F2274F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A18494;
	Sat,  6 Jan 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="OF5Sk03L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ziUuOqdS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06B8479;
	Sat,  6 Jan 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 213F4580ABB;
	Sat,  6 Jan 2024 10:36:20 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Sat, 06 Jan 2024 10:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1704555380;
	 x=1704562580; bh=KkXeuPbJwMAsHOWM0v+O7BUhvIvgDRLJLuBsAb1FKvk=; b=
	OF5Sk03LoacWo2GABZMZccrHz3EnfFzCXz4PUMZs7XRQTRuVE2ay2FDU9OPs1n7T
	26leMFNPBZ5oVhEb/Vpk5n0HGQIudNueILlH+Xsjcvz59CSLRD4py/JiUwfDFsve
	EBZUCX5G6fdoJXqqGR3PN7E3oudTKxcDx/p2fy1Zza8jyQ7NNC84ogDKLFF1P9w+
	4GfJZBmlBX2i/qEReKss2ifoB6qvOQUFuwaCTgo+4OOYH28BAY4YJUGibQm+85aB
	oo432TPAzzL/p6r0xMtWN6/9Oj6194dvRedlw/uVHC4uvgJiKhLjKw3dmj9vFP+0
	l+bEWxSlthAr3qBzQ0F7Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704555380; x=
	1704562580; bh=KkXeuPbJwMAsHOWM0v+O7BUhvIvgDRLJLuBsAb1FKvk=; b=z
	iUuOqdSrc/n9Y5Q7K5pp8Yqxv01SPmD2/nPeKADzhwL+oAkEcaSUJL00VHDYf7mm
	K0N9AykbPOkLLq6+hhfM4vhf09qBBCet/SxxiHvWwZNgqRi2KCY+p6eT2r+bsAt2
	dwhiiE0jwbbNhPe8iXiGwWDGHf+4FVEj7bElAPqnzzW+zk1n5oYLYAiTIHQwqYl2
	d40IHxWPFKPS4mSBWyZFrvsaTUTYa2+4RKXtGlY2sUbna9/ydOKW6kmvxs0Y5i58
	ZYbyAd4rTOC3cQ4Cwnd3Q8qj/tiYIj/zZLmXOExFTE+FymrXwnEz5osGhauc7nLh
	BBo75HiGAZ3CBQrEWodXw==
X-ME-Sender: <xms:cnOZZZdP0ETqiRoGbXCeIu932mr-b5ypwMxcWD1VOLukQVkYBeo9ww>
    <xme:cnOZZXOpXQ1hEZvUv743_IPXUt6HcIkeKzZim4SGxZfCEbANU8DNYwEN8OwNTPfiO
    FYDpobj7GbRTYYRcRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cnOZZSjQgr7PnCvN9mJjHMC-qT2d9DyQ7aD74qcwCc2UnZOiVAGzpg>
    <xmx:cnOZZS_9eX6PrJRrq-w-HyujUtBW9hkhS9XG7kn04O4it5NPrtDRqw>
    <xmx:cnOZZVvLANms9UdJEoSx479_H7AbCpEUQpAeLPXAwf4BmVSJ7b32jw>
    <xmx:dHOZZe7IWR3TGa4cnOUf0Fh03dBe9rXORrs0673QEUmmuGzJkLautA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D162636A0076; Sat,  6 Jan 2024 10:36:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c8c0eb3-d7d4-4443-ac5f-e0d330a57a8c@app.fastmail.com>
In-Reply-To: <20240105134244.13003-1-maoxiaochuan@loongson.cn>
References: <20240105134244.13003-1-maoxiaochuan@loongson.cn>
Date: Sat, 06 Jan 2024 15:35:58 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "xiaochuan mao" <maoxiaochuan@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip:Correct the offset value of interrupt status register
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B41=E6=9C=885=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=881:42=EF=BC=8CXiaochuan Mao=E5=86=99=E9=81=93=EF=BC=9A
> from 2k500/2k1000 mannual known that the offset value between
> the interrupt status register and the interrupt entry register
> is 0x20.

I recall this offset is a workaround offered by Loongson staff.
INTISR0 register offered by manual is not really functional on
2K1000 MIPS

Could you please investigate with hardware folks?

Thanks
>
> Signed-off-by: Xiaochuan Mao <maoxiaochuan@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c=20
> b/drivers/irqchip/irq-loongson-liointc.c
> index e4b33aed1c97..417b4c91ca67 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -28,7 +28,7 @@
>=20
>  #define LIOINTC_INTC_CHIP_START	0x20
>=20
> -#define LIOINTC_REG_INTC_STATUS	(LIOINTC_INTC_CHIP_START + 0x20)
> +#define LIOINTC_REG_INTC_STATUS	(LIOINTC_INTC_CHIP_START)
>  #define LIOINTC_REG_INTC_EN_STATUS	(LIOINTC_INTC_CHIP_START + 0x04)
>  #define LIOINTC_REG_INTC_ENABLE	(LIOINTC_INTC_CHIP_START + 0x08)
>  #define LIOINTC_REG_INTC_DISABLE	(LIOINTC_INTC_CHIP_START + 0x0c)
> --=20
> 2.17.1

--=20
- Jiaxun

