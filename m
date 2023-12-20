Return-Path: <linux-kernel+bounces-6292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8E8196DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F905288A92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5277488;
	Wed, 20 Dec 2023 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKN9UDKu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59B8813;
	Wed, 20 Dec 2023 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dVQYlaBe9hfhIT6+lRT1DBZm59Iynh+qvZQN8+WtvMI=; b=BKN9UDKuog7Pkk1h0wxRw9qhfQ
	relMuM1g0hxKEL6NMG0KEHdPSQ2sqMT/3VpfubAVHBTjZwG2HxBmnM6RYzH47ZIzEYWy8XGY0Tsq7
	XXHFoqe40fygoE+KXfaHwsw5EkIBsiDgQpcl2dmn3Bc588foQCkL+sUttcbzvtLmId8sqQXqAvnfa
	Vd0gwGnjeLp4kWsUoZJYoygO3IfTFfaMhuDcKWPIJHNcWBkHoHZQs/obfFo7GhnOpVNLxvLKph1lC
	MECW2TyV1OC1/IT0ub5/huxZ35xqv7nUZSRQQC5w+SjJER5N10jPXyvgOWnZC54KRZSrqFVULgFek
	6rl9kzSw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFmSa-00FzAD-0A;
	Wed, 20 Dec 2023 02:37:24 +0000
Message-ID: <7e1e12d5-041c-4263-a522-c8079f4ed5a1@infradead.org>
Date: Tue, 19 Dec 2023 18:37:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: of: Fixed kernel doc warning
Content-Language: en-US
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>, robh+dt@kernel.org,
 frowand.list@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219062317.17650-1-muzammil@dreambigsemi.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231219062317.17650-1-muzammil@dreambigsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/23 22:23, Muhammad Muzammil wrote:
> From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
> 
> property.c:1220 : Fixed excess struct member definition warning
> property.c:444 	: Fixed missing a blank line after declarations
> 

Nit: only one of those is a kernel-doc warning.

> Signed-off-by: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
> ---
>  drivers/of/property.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index afdaefbd03f6..641a40cf5cf3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -441,6 +441,7 @@ int of_property_read_string(const struct device_node *np, const char *propname,
>  				const char **out_string)
>  {
>  	const struct property *prop = of_find_property(np, propname, NULL);
> +
>  	if (!prop)
>  		return -EINVAL;
>  	if (!prop->length)
> @@ -1217,9 +1218,9 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
>   *
>   * @parse_prop: function name
>   *	parse_prop() finds the node corresponding to a supplier phandle
> - * @parse_prop.np: Pointer to device node holding supplier phandle property
> - * @parse_prop.prop_name: Name of property holding a phandle value
> - * @parse_prop.index: For properties holding a list of phandles, this is the
> + *  parse_prop.np: Pointer to device node holding supplier phandle property
> + *  parse_prop.prop_name: Name of property holding a phandle value
> + *  parse_prop.index: For properties holding a list of phandles, this is the
>   *		      index into the list

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

>   * @optional: Describes whether a supplier is mandatory or not
>   * @node_not_dev: The consumer node containing the property is never converted

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

