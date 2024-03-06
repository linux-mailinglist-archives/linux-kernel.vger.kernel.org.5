Return-Path: <linux-kernel+bounces-94596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A38741E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13A3B22145
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D41B286;
	Wed,  6 Mar 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="FOUQWrEU"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAF175A5;
	Wed,  6 Mar 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760118; cv=none; b=NYzPnK0gDfUL1mj9lKeqMyqrgYXrjS+Ll278XhKLxjPrKLV9OD63ktzxlyTNBihS3+RkYzjiK6aOCf6C+3isXY1zkaDtSrlIw0O16TJamaYRvl0yB+UfL/RasM+BakSkKnzTQFKUz/oFSLAbq91z5yHSRw1JImf9xYiNISL9S3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760118; c=relaxed/simple;
	bh=A45dKxd8Vr/o7Ri8lNpfa+iXwIOMMQ4L+1bvVK4BQ3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lhxs3VqSgm7/h3LIZd5nePOSYdedI8CZDtLo+su+3Z/CtktKTJlaYOULYEuDe/08yyKW5ZfiV2EBxiFenDj/1Y+fZBg9lMwy/jM/tHOaGVMa9f8ciw83KfVZCmmb/DxREBz3uph0LUVitqbF7KzKrRNf+ao2Gc+xDiV2f2dVjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=FOUQWrEU; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090] (unknown [IPv6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9A760C08B2;
	Wed,  6 Mar 2024 22:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1709760115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rUyQUV1pCO/tmmVIZpuhQjIooyInuiRI+/0DW02pz8=;
	b=FOUQWrEUWyNo29i2MYh8JQZZRmHk2rzO+Na1eACTvx0h8t3Vn0LDGNp8qO5rtDVxNPEF+g
	csPNQG/f17UIh/5mRmFCBBzAtbFIfXOyCmwsdNDm9zV8kTd5v4aFZ1A6kehV3i72bCLoap
	3L77YK1f63M3jCF7zkIo1xv+zWxNkPE87yBGbk+tdLI6+ave7lrE3f17FjHdQn11cB9BTg
	tzPMAYyrAtvdnd5h9yOZNvTRCZjF2u4kzCkq4PKICFlMpdJdLezZOm2M/xEonyQwmTLaFC
	VQo7ZxTQn0K3ifSz9VSUMqDU37ZkfVQZTkYXDJeRW6E5wYWP6xHZzBt/73HXeA==
Message-ID: <843b0011-d03d-4da9-8130-3eb1e08e87e3@datenfreihafen.org>
Date: Wed, 6 Mar 2024 22:21:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] ieee802154: mcr20a: Remove unused
 of_gpio.h
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240304175320.1199496-1-andriy.shevchenko@linux.intel.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240304175320.1199496-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 04.03.24 18:53, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/net/ieee802154/mcr20a.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index efb1be3c644e..433fb5839203 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -12,7 +12,6 @@
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
>   #include <linux/skbuff.h>
> -#include <linux/of_gpio.h>
>   #include <linux/regmap.h>
>   #include <linux/ieee802154.h>
>   #include <linux/debugfs.h>

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

