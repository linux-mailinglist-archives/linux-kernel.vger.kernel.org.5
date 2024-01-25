Return-Path: <linux-kernel+bounces-38323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228483BE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406FFB328A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D87C1C686;
	Thu, 25 Jan 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pT5t6XNC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evG7OJS/"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6671BF27;
	Thu, 25 Jan 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176073; cv=none; b=sE7A7oP5PfHJZZhjTfxa57uPUSkDn5xK6ETQ1/NW8s/DrhAfCypzJc9Ka9DyQnmkowCceRD0W65rTFab+Y4i4VBhdFlUdLNbcJYqOpjMAL2ljZdYsMeg2r0IpgtOo+s9RhVdI+mm1H/NdEPCnbaJgKywrUcPWlmiGiJqMP8vsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176073; c=relaxed/simple;
	bh=wslJCg8jfytZ1WiAXzz32rNxa1Tk7vAnqdLkBNxfwBQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IIy2sKfOsTw/hplYUYtAwQlENW84yaENXC4VeETed1ZBTonaz/kDwqrd0nujEgl+K0CIRhMtYHbqXAkakmdopwqODfIJtmcy5f4LswIyUA3cc6tnbFVdW1o6SCFkVt5nX0cVmQ+k04kKHikM7YfFQS7Ml0X90c3lzqF3AMxNvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pT5t6XNC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evG7OJS/; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 6462A3200B93;
	Thu, 25 Jan 2024 04:47:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 25 Jan 2024 04:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706176067;
	 x=1706262467; bh=mb3IjZO1TLQGSBUw+X8d/Uo1arnDQaLRERIeKnxPXPU=; b=
	pT5t6XNCvucDFGDoSiVGjDxdUeYViJ1f3Yn9uDgSBmC90j0P3ALHYU46+fR5e4PX
	MbWXmDVWnMeiLXmzYgOhcG4o/YlFhKDqNcK6Y7dK6Gtd9ZYOjPq6/rY58w6y6y0I
	xkWMSn5JFYKshtzJaW3IzUwPRq+UEqHW7WNWP1jvjVLWvLRsroKtr04R5BQqh2Xs
	2L6lpDBxwrqFQWko0mAfoHuxqX0Cw2Km28JZRccprFZqugiddNQJ4OJ14e6YSlLy
	MjOBoFfYq4xD9aux+V+ug3Y1FzND035GceGIOPWO66KeaD/dMGDg2Qw6HgVBn3NI
	AiqzYlPz9fWVc2i4Gn4DZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706176067; x=
	1706262467; bh=mb3IjZO1TLQGSBUw+X8d/Uo1arnDQaLRERIeKnxPXPU=; b=e
	vG7OJS/HerVcSX/1CG8/BXIriwUaQ3g8dMSLDCDOC/J1wgrqAAxVnYPl0RlLqNEi
	9RCNfuUYo1k26Fj4j9dYF/8LOaMaxrWcNf6iEwJc9RRRixEiQpuvoIuimnuKWNFx
	JDR9MIVQe8Yud4Jl96ZxdzcMc2+HoAt+Pqas0AVNjEHrpzngtQKIvDey9aX0XLTo
	scQGD6n8AG9DCdWgESQTZkMORobFokXQtcvtAJHuztbwS867k7L37FT+f24C43ir
	t2e2DshHkpA4d3pITu8YiLcpqJC/7T3gZi+RnJfb5w1mYfIHiDbg4ap3o4PRg4Gn
	voisl7gLeyZ3PC5NJksBg==
X-ME-Sender: <xms:Qy6yZbnS6ySGwve7mBg1u4kZU4Jf1HX0jVzse70bpUzijwNexFFT-w>
    <xme:Qy6yZe0KPZAXFXbksJkPmorNe46Na-_6YEN6XXWOTQqlm1SAt5ZCjV7FuZyhYQypX
    C-qOwJYmnY9pNdbMfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Qy6yZRrtqtFfTqEeMBzSIs4U_bHH_cf17AWm8Q7os6uKvxDbQUlgeg>
    <xmx:Qy6yZTm8pzvHGv-11iGsAz1aHUSXBB45jLniUI9DlbUfq6dYbaMXdw>
    <xmx:Qy6yZZ0eVki9-tqufpTyzgdOCrQIp0hGWVRBr3iQ5v1PKvq5DYuVnA>
    <xmx:Qy6yZSwzzGaxAYELU7_t_Er0N5ZF_D4aDrjVC2BKy3f-T3p3h4-3fA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5600CB6008D; Thu, 25 Jan 2024 04:47:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com>
In-Reply-To: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
Date: Thu, 25 Jan 2024 10:47:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 "Christoph Hellwig" <hch@lst.de>, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024, at 09:50, Linus Walleij wrote:
> The MMC core sets BLK_BOUNCE_HIGH for devices where dma_mask
> is unassigned.
>
> For the majority of MMC hosts this path is never taken: the
> OF core will unconditionally assign a 32-bit mask to any
> OF device, and most MMC hosts are probed from device tree,
> see drivers/of/platform.c:
>
> of_platform_device_create_pdata()
>         dev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
>         if (!dev->dev.dma_mask)
>                 dev->dev.dma_mask =3D &dev->dev.coherent_dma_mask;
>
> of_amba_device_create()
>         dev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
>         dev->dev.dma_mask =3D &dev->dev.coherent_dma_mask;
>
> MMC devices that are probed from ACPI or PCI will likewise
> have a proper dma_mask assigned.
>
> The only remaining devices that could have a blank dma_mask
> are platform devices instantiated from board files.
>
> These are mostly used on systems without CONFIG_HIGHMEM
> enabled which means the block layer will not bounce, and in
> the few cases where it is enabled it is not used anyway:
> for example some OMAP2 systems such as Nokia n800/n810 will
> create a platform_device and not assign a dma_mask, however
> they do not have any highmem, so no bouncing will happen
> anyway: the block core checks if max_low_pfn >=3D max_pfn
> and this will always be false.
>
> Should it turn out there is a platform_device with blank
> DMA mask actually using CONFIG_HIGHMEM somewhere out there
> we should set dma_mask for it, not do this trickery.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think it's worth mentioning the cb710 example here, which
uses a platform device as a child of a PCI device and
does not assign a DMA mask nor use DMA.

This one will see a change in behavior, meaning that the
blockdev buffers are no longer bounced. As far as I can
tell, this is fine because the driver appears to correctly
use the sg_iter infrastructure for mapping data pages,
but it would be good to have this confirmed by
Micha=C5=82 Miros=C5=82aw because this code path has probably never
been tested without BLK_BOUNCE_HIGH.

Adding Micha=C5=82 to Cc.

     Arnd

