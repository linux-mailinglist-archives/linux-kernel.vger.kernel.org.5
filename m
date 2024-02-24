Return-Path: <linux-kernel+bounces-79365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DDE862138
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D41C2481F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41F17F5;
	Sat, 24 Feb 2024 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ua0b7SgM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0551391;
	Sat, 24 Feb 2024 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734604; cv=none; b=Eol/A53GTo0fpsw/lSdoqYQRLCTa/xEwCOLgG/UtFIV1piRiNqrzX1QQ9xHtIIvTR2zXLwS6oqVNSyMu4qz4u3J/EsQDNsosmoDbuwUYgNFtwsJGPq2DD8R74N5IsERBN+sUnYh9+hmHjbfi02K10EUIcXHB/LgJ9mBLkZSAI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734604; c=relaxed/simple;
	bh=kxojQVNnM759VfcUUvz9/QIZ54cjntTrT98mGnYBwf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQTL+0bPydhziYos4KmKjkH3bMMXk6PM+X9J+NC8L04W/r6rlAkBkkZmQcMtgYH6YA9kghHI48Je3MLysw/JDekQgrY8AA2mocc0pWHMRkeB3TTSjnoZJnlSzApgYXrnfv/81pa19uqvoVvm2PGZgX7cVrge7abrPysXfJ/cbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ua0b7SgM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gOpJqIKHrYdAdrp4+8xh2s9+ZzmBOi5gRguaabwYj6Q=; b=Ua0b7SgM3o2+rmgI0f5S1lgiUz
	kwWwPpdCeOpP8Ja27XL71SEJF6Rchsn0uiuZqzhGdmjN8576y9wJDVYnLbM0J4fn3NuIcOFvyTs45
	kpyeex8URTRDpzL3gCUu9wduj6rmNGgBwQRkR3KimSs4R2SDYk0QRa8C1QwgsXCIPvd5rBGztiii4
	UKc4QZYDO+qMr3jihcebANk+byfII/jLIJjoa7syMGlvBoqvjGwuL1Zjqo1/lcwu1wm8WgOxF0v4Q
	EuNLpVRXrxRr1qrZLQn7nMK3mhjZ6Hz7lxTbBd9eBC+Zy8+yQ42Ex6SLLrG+HH8H/guTgCmmiWSGg
	PWI94tQQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfvW-0000000BgUh-0Mfq;
	Sat, 24 Feb 2024 00:30:02 +0000
Message-ID: <d6ed0068-6f04-4a3c-b981-5c27f57985f6@infradead.org>
Date: Fri, 23 Feb 2024 16:30:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mtd: maps: sun_uflash: Declare uflash_devinit static
Content-Language: en-US
To: sam@ravnborg.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-3-5c60fd5c9250@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-3-5c60fd5c9250@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 11:36, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> This fixes the following warning:
> sun_uflash.c:50:5: error: no previous prototype for 'uflash_devinit'
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/mtd/maps/sun_uflash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
> index f58cfb15d6e8..b69dade3f7ad 100644
> --- a/drivers/mtd/maps/sun_uflash.c
> +++ b/drivers/mtd/maps/sun_uflash.c
> @@ -47,7 +47,7 @@ struct map_info uflash_map_templ = {
>  	.bankwidth =	UFLASH_BUSWIDTH,
>  };
>  
> -int uflash_devinit(struct platform_device *op, struct device_node *dp)
> +static int uflash_devinit(struct platform_device *op, struct device_node *dp)
>  {
>  	struct uflash_dev *up;
>  
> 

-- 
#Randy

