Return-Path: <linux-kernel+bounces-94594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE48741E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5571F21F41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCD1B286;
	Wed,  6 Mar 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="NRcF1Tak"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762718EB8;
	Wed,  6 Mar 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760066; cv=none; b=jsz/Dj3Ww4TuewmzEo8nKlv5/iFJ8++M7Pr5wVUn4rEhQ19EosFJaHkLmO4c/gjZLXIpVQPopz19er3bkuaRdxlerAWkUuxhwTPPuRpQm9Yo/STw2oC88zx2RO61eqYvo4Q0x+uhwLaDbKcBCG6eXvt/T0TABcsRwgdsZWQjBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760066; c=relaxed/simple;
	bh=dZSQghJjuTSN7jqIjRSewNyDAheVkmkBBIxDRw6bzPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkhzUNpnu7kJ23QhgnkqTe7TCkCQhHqY8blak6PqGsfBcwJt+REoYdHQazFvJChCTwS6mSWq+LiZP+5UHi8GFt2Re2Kwv0z6+RsV0oYp2VfBnr4h+0VYSVs5y+E6MJPqP+VsdDvVSKSGwhW0cM6XBh5RvMCZO9P0uiv6KWxT67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=NRcF1Tak; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090] (unknown [IPv6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 1C204C0C5B;
	Wed,  6 Mar 2024 22:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1709760062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oDqv1E2RV+mJiH4Y6w0U+QxzsmgttpOdUSOUzMPYaY=;
	b=NRcF1Taka1of2CHI51yNnQdQnFVgnGh1rkqacvI4MT+VAR6M5pLMMKSroZ0VfwXBH8lDax
	nIMsZOBYRNVoxJqxHYTMCgK3MQq31XO10XIE4bk2pBEwF5X+MRas6Dj68amPDSLjnRXKxI
	VKxYks6czaFcecIIrZfU4evRKj7hWzf05jRsuVr01fwOQ9vZk0Z71wKLv+/Eo/4dbHqQxe
	WJJYdnjx+UCw5clNfL9Sm8BOgXFCohacTGLUriLAT4NHuMxiEEdCzJQIHGVIZG1u2+UK3i
	NS6ArnY+5aa8ATsQlO8UNVSKdDCx9J08kfJwYcIkKZwLqiTKdlJU10RUYz7pgA==
Message-ID: <655e986d-9a9c-4fc1-93d4-d94a197ba686@datenfreihafen.org>
Date: Wed, 6 Mar 2024 22:21:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] ieee802154: at86rf230: Replace of_gpio.h
 by proper one
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240304174218.1198411-1-andriy.shevchenko@linux.intel.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240304174218.1198411-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 04.03.24 18:42, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 6212164ffb36..f632b0cfd5ae 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -11,17 +11,16 @@
>    */
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/hrtimer.h>
>   #include <linux/jiffies.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
> -#include <linux/gpio.h>
>   #include <linux/delay.h>
>   #include <linux/property.h>
>   #include <linux/spi/spi.h>
>   #include <linux/regmap.h>
>   #include <linux/skbuff.h>
> -#include <linux/of_gpio.h>
>   #include <linux/ieee802154.h>
>   
>   #include <net/mac802154.h>

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

