Return-Path: <linux-kernel+bounces-132399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF30899407
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A008C1C24D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497D1CA89;
	Fri,  5 Apr 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3g6iIFk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0F18E2A;
	Fri,  5 Apr 2024 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712290215; cv=none; b=JUD9ILNUkRmTJG+83G5u/AyO0mLe6R/qq7/oP956kGFuFzYcj2MX1Gi8cOvjsgpYyX/R2ErYGCB/BlipQJBtnPckVATMJxnltYD3hvsGSbWRegvGoN3DLKhdxJObATKUSui3HVv0SXBYSmg98GEDry07vIRfUjQWbqQodt7cODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712290215; c=relaxed/simple;
	bh=g7BQtInmRrLi+M5GE0wFlNQnSVd6g23d07lp51zGVzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkvcTORALrBrWvjkjg8qtvpCEssYfPNyFONm6+8pzhAiD5wlIeiGDdD60rGH35Eo3Q/uHnUbKpya12WDdrlOkrAft7I8kv42S3dXlh+9xIpbYqpVvPPO2ilxt6lDH5C8/+FKjFhJrCOhAA2TQWcz3ncWHZpV1mkTKkwp0MNirr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d3g6iIFk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=nSPrZsWCYvArB4boS+pxoaKtULxq2hWNfqCbSHuZGp0=; b=d3g6iIFkTBjoDGDsoT4rR4mRKB
	fnoRlIasjLao0N0/kvQ4SyspHeB22M+5OV+KfpBJkWEMfEQCj/piOe29f+EOfjYr6vXYLULT+CMpX
	EHCmvYaE47DTi/cFYiFmmCPVrI1dnDXenLCJqFTY8JUKVF9XnEwNiP49Ub+82ip+1945FVdGVA3aF
	HGYmdhaSsqA0IA/sLo8ciSfoRnUi2hONym1a13L3KJwopqoWvzGFzt/SncuS/zPl1JicXRe09AZ4A
	jyVrXN8d8z63xnzXtrYJXksxPOvfWbjQWl5yWEiPgLn6u9ZEL5SXVaRF9ANriu0xffFYuOny83MWL
	syZsNBeQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsau3-000000057M5-1q8y;
	Fri, 05 Apr 2024 04:10:11 +0000
Message-ID: <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>
Date: Thu, 4 Apr 2024 21:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] gpiolib: Update the kernel documentation - add
 Return sections
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/4/24 2:27 PM, Andy Shevchenko wrote:
> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> 67
> 
> Fix these by adding Return sections. While at it, make sure all of
> Return sections use the same style.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi.c   |  22 +++--
>  drivers/gpio/gpiolib-cdev.c   |   8 +-
>  drivers/gpio/gpiolib-devres.c |  44 +++++++++-
>  drivers/gpio/gpiolib-legacy.c |   3 +
>  drivers/gpio/gpiolib-of.c     |  48 ++++++++---
>  drivers/gpio/gpiolib-swnode.c |   4 +-
>  drivers/gpio/gpiolib-sysfs.c  |   6 +-
>  drivers/gpio/gpiolib.c        | 157 +++++++++++++++++++++++++++-------
>  8 files changed, 233 insertions(+), 59 deletions(-)


I would use %true, %false, %NULL, %0, and %1 in a few places.

s/error-code/error code/
or
s/error-code/errno/

I would s/active-low/active low/


or it can just be merged as is. It's a nice improvement.



Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
#Randy

