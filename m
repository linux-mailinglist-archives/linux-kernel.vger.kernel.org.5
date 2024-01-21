Return-Path: <linux-kernel+bounces-32146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30D835738
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628B61F218D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71038380;
	Sun, 21 Jan 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="dbZCBvB/"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8BFBFA;
	Sun, 21 Jan 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705860869; cv=none; b=mkUqxYBi8XmwQgaZmt70mHZlK24CwLahC3CHJFhTAHMP7hww7IMl8l2/Mi7BVaStY3zURyFhag43xoeLjiGECMF4QwiCgLOze1HPlwvlcNQgh8Lx5XUgSwcplECeZX5AAkDgPkbeQewNGnr0EhccLOruGhXXSNEeTg/dTiABT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705860869; c=relaxed/simple;
	bh=N7OUZjKg0Z42XndQfe4qS1WdjqzPD6BmjTD9CLpxQpk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JpFpe+d4ywJ4z6/vff8yIoJ/STT+NwHHR6Zl5ze7IoMQrRSaw5Ta8JUB/Cy7SCG9oqUe8CFqbYoHbFZy0wCjhazCqOm//3YirMR8pkkDm23N7pfVb8Vi7QGto5D3GBSSfO52LtmrwTU5TkpWrFwaz/uuLYfhesjVZUF1Doy6aaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=dbZCBvB/; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id AB16D71;
	Sun, 21 Jan 2024 19:06:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1705860391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LUlRcO6qAUslB/aQvN4+sncIp9HuXImWqN6ii290a0=;
	b=dbZCBvB/tmsgJl20VVAvUddw5aNNE6egHwf0Na19PhkIglL6ehnwTzxLpop0zmv0cXC0Nu
	iO3dPOywTLOn7ibsBQXExorSg8oN3hv5wjRi7GmBCXPro+RqCco4nQjju49zx5nGo4cD6w
	eFqoqxSyvJUXQeBccdkxnnQ0dO1cTRqtP2y/kPUG75RkBRUTUlUYyxY/+esELRuA+jBmkF
	uqgBW8ppJHC23L2OaH6lz1e2uPczEyMt5varDkqct2DYwS6c0U6yLN3n5AjgLX+3pfgJok
	puFUea6zpmr+OtBh44bT/X02Hm2P0zrdX3HieqGZRQQAoJwAnv//pn8cf/lX6A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Jan 2024 19:06:31 +0100
From: Michael Walle <michael@walle.cc>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>, tudor.ambarus@linaro.org,
 pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, sbinding@opensource.cirrus.com, lee@kernel.org,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
In-Reply-To: <ec7e7972-d48d-4a47-bd03-eec0c4334471@roeck-us.net>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
 <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
 <ec7e7972-d48d-4a47-bd03-eec0c4334471@roeck-us.net>
Message-ID: <9806d99fab46c928f337b30b21057b3e@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

>>> FWIW, the problem is due to
>> 
>>> +#define SPI_CS_CNT_MAX 4
>> 
>>> in the offending patch, but apeed2400 FMC supports up to 5 SPI chip 
>>> selects.
>>> 
>>>   static const struct aspeed_spi_data ast2400_fmc_data = {
>>>          .max_cs        = 5,
>>> 	^^^^^^^^^^^^^^^^^^^
>>>          .hastype       = true,
>> 
>>> Limiting .max_cs to 4 or increasing SPI_CS_CNT_MAX to 5 fixes the 
>>> problem,
>>> though of course I don't know if increasing SPI_CS_CNT_MAX has other 
>>> side
>>> effects.
>> 
>> Yeah, I was coming to a similar conclusion myself - the limit is just
>> too low.  I can't see any problem with increasing it.
> 
> It would cost a bit of memory and somewhat affect performance sine many
> of the newly introduced loops are bound by SPI_CS_CNT_MAX and not by
> num_chipselect.
> 
> It also might make sense to document the new limit somewhere. Prior
> to this commit it was not limited at all.
> Documentation/devicetree/bindings/spi/spi-davinci.txt lists 5 chip
> selects in its example for the use of cs-gpios.
> Documentation/devicetree/bindings/spi/spi-controller.yaml also does not
> list a limit.

Given that, that the rest of this series is under discussion (and esp. 
whether
it is the correct way to do it) it might make sense to just revert the 
picked
patches.

-michael

