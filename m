Return-Path: <linux-kernel+bounces-63952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6676B8536B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2297A28D29D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16B5FDAA;
	Tue, 13 Feb 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QZhSC2bT"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268160240;
	Tue, 13 Feb 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843495; cv=none; b=R8CyScCvMcEHxsgYuejdnp8xbateOgGAEqLTzdDZxI3iUhNPLnzC3pPEadOHTfAYJVLO9unJVtOg5Uz9EIXSkdW164QuKYsOo/UiddF1+JdI30/sJu/G9sPS6w3UpXMnmo7QyAMfrAmpFDuzoNpbWpjuZMu6W0w2fGX50rOG9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843495; c=relaxed/simple;
	bh=o8V1pQbYXdmwl5TJW5YYMmyTDaJLo0SMtQmsIPxMD7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjzuJEiUkJR0ncwuky55WzzvCFZS0Sldbq3AUViAR1w0STqXviXs5sJrQqQMnYPumkxx7TDgkjuyCUlUJS0t34MyU2xHJHTEY65TXnaPePeR6ZTmBTwl7hzG2z8Yx9eqkVsUEgJ7QvkXUVtbsukOu9jmrl6lncugJud3uQRc7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QZhSC2bT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5C8640006;
	Tue, 13 Feb 2024 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707843485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6WtodzyA37Tsf0yyJLrsStjz46Dt/H5d1zhtEGLKUQ=;
	b=QZhSC2bTcL1lh+gfF13O7yowrUvo+48vIfv79pY98ORlCVqhwVl8BhitjKvsX+sBGT7ziH
	QJ90TPpd3eEHnKXkMlcLOKK/KvSJ+p1XeWm1831D0rnRpucAPZrrBIKp9lZTTgNgrK8ouZ
	HhqL055QehVZOnlolNADPZNcyFtQ1vkITYuF7lZIR4kSFaIEnP+m1p5V7lXEasVVTNOiwI
	v7m6SXS1vOFbaz/Y8RQ+85V/7JUqHO6bA5L8b5Z/lwbpiCmkJBvnm6QV5HdNSb+IOAr0ug
	8M5pWA0AuZQne8g/CRKqnL4F/pJVE6oCTsz5cbsp+hQCQdEaILUoIAp2WEgaNw==
Message-ID: <081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
Date: Tue, 13 Feb 2024 17:58:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Content-Language: en-US
To: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
 <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/13/24 17:42, David Mosberger-Tang wrote:
> On Tue, 2024-02-13 at 16:22 +0100, Alexis Lothoré wrote:
>> When using a wilc1000 chip over a spi bus, users can optionally define a
>> reset gpio and a chip enable gpio. The reset line of wilc1000 is active
>> low, so to hold the chip in reset, a low (physical) value must be applied.
>>
>> The corresponding device tree binding documentation was introduced by
>> commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
>> properties") and correctly indicates that the reset line is an active-low
>> signal. However, the corresponding driver part, brought by commit
>> ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver"), is
>> misusing the gpiod APIs and apply an inverted logic when powering up/down
>> the chip (for example, setting the reset line to a logic "1" during power
>> up, which in fact asserts the reset line when device tree describes the
>> reset line as GPIO_ACTIVE_LOW).
> 
> Note that commit ec031ac4792c is doing the right thing in regards to an
> ACTIVE_LOW RESET pin and the binding documentation is consistent with that code.
> 
> It was later on that commit fcf690b0 flipped the RESET line polarity to treat it
> as GPIO_ACTIVE_HIGH.  I never understood why that was done and, as you noted, it
> introduced in inconsistency with the binding documentation.

Ah, you are right, and I was wrong citing your GPIOs patch as faulty
(git-blaming too fast !), thanks for the clarification. I missed this patch from
Ajay (fcf690b0) flipping the reset logic. Maybe he had issues while missing
proper device tree configuration and then submitted this flip ?

> On our platform, we never merged commit fcf690b0 and hence our DTS already
> defines the RESET pin as GPIO_ACTIVE_LOW.  So, I don't have any issues at all
> with your patch! :-)

So in the end, the patch should be about a mere revert. I will update
accordingly when relevant, but before that I'll wait for some feedback about the
potential issue of this patch (forcing users to udpate faulty devicetree)

Thanks,
Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


