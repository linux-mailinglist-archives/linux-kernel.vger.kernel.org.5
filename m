Return-Path: <linux-kernel+bounces-79367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B186213C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957841C24D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1223BF;
	Sat, 24 Feb 2024 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="viZL1Mlj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816517C8;
	Sat, 24 Feb 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734721; cv=none; b=WSEnFwFeRlwQbrlPE7nyJ2VbmXsFNuR9HyGfCUz25bOLzBu2FM9I+8a+gdJ7RO4IdW/aJR7XmKwKwHa9JSFT4ETyR+qVAh6pMpBq0qweEU3YpaVqwHeM53HmYUgKbg0OMoxfRC/cfaDJF1AutH26B6T1rr3naRpZ1KPkuAuNNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734721; c=relaxed/simple;
	bh=cLOlkiiIsBxs+c5aYZU7dTcatV2BS4MYwoiO1dPJuXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrkhhpelmBfH75xp03n0BWpr68UFSQ0beH0V4N8uKM3FT+pT2qJwoTsWRw0Hkynmb6dJLUB0vzRY8qx0oiifWkYgP5b4GRjaDv9SQyvYmVi26+8VUClZmvkHSq1wTH4LkzL6Ib6VMS4wSZsSBMStexKOsisrC3CUmADja+3NOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=viZL1Mlj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XKTcNlrx6kwLrC+QszV23LItEKAakzaqp1Ccgq00X8I=; b=viZL1Mljrj/9IMdJlawg3z4Y0P
	6nnCs0VbEuQujhg3Yz74g8bxTAaP0I392OjyEkqbNFKkH5vIqt/CNQA5559fN/sz2SisDxqkXb4sI
	ZGbIAgvFwqNx6KM7O/nG0Yd+B3KhyrBsAQC/seEmOMt+XLWIwjrK/hCX7v+F6sQ/WyHd9el4PZa+i
	wGnSSG6g9/5E9XKnepoTlWcLTS6Bo5g4pwFuEGHWUUk9cV0hE7VxHnaF7cw6OtPrCI48lzlNAyvnw
	qXAXX3orJ1qE+37atbQO+C2X1ZHndTzIB8pYQKRN+Nph6CMWiO2ckGqIkLVyL6GmNrenhs1r+6Ud3
	vokGQjWQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfxN-0000000BhCA-1Dr3;
	Sat, 24 Feb 2024 00:31:59 +0000
Message-ID: <19ecb47a-a168-49df-9673-bc1522f7d2c4@infradead.org>
Date: Fri, 23 Feb 2024 16:31:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] usb: host: uhci-grlib.c: Fix build, add
 platform_device
Content-Language: en-US
To: sam@ravnborg.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-4-5c60fd5c9250@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-4-5c60fd5c9250@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 11:36, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Fix the followig build error:
> uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
> 
> The fix was straightforward, and no attempt was made to understand why
> the build failed.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This looks good but the same patch is already in linux-next, courtesy of
Andreas.

> ---
>  drivers/usb/host/uhci-grlib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
> index ac3fc5970315..cfebb833668e 100644
> --- a/drivers/usb/host/uhci-grlib.c
> +++ b/drivers/usb/host/uhci-grlib.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  
>  static int uhci_grlib_init(struct usb_hcd *hcd)
>  {
> 

-- 
#Randy

