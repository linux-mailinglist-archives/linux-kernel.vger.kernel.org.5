Return-Path: <linux-kernel+bounces-97267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622D8767E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758001C21BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12032C183;
	Fri,  8 Mar 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fk3JILj1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386B15C0;
	Fri,  8 Mar 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913749; cv=none; b=bYalhoxU/lLAeHG3g6SPhAovL/lJRYJLm3xVHQv2s/WMr5Gx1TXRZa7AlL4zu2mpDbYLMeYBefejkBn+UjHT+/XZbud+I//eSY9haiu9OtYGXptbQ7uPO35ezgSzu2Y3BhbMz5qUbJs/T4Njy6TFlWwHV+lBLZcPVNLQLDQj4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913749; c=relaxed/simple;
	bh=gIQH50gg9SOgNgl51sZgJTzCVYTSlLLKyNVLKonywTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZZPsLZ47ROLseWDvdKnBpWKAwgnJg+MwXP3MGJum77z8+McgacNlZcSR0pxz3XKhbQWWkD8uTVr0ulxneMqifTdAu0qebM/chEcvGjUy4pLHzmxjOftJp6UlHOid0C/na6Rim1hglmSFoix/w57QXG4K61WDKoPFevHV4dHsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fk3JILj1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yT9fwzb8OAA4S1K0lEF8ICeF8jyr8A1UB33tnDN82s4=; b=Fk3JILj1s1sO+KbUcupiXt6C1V
	R2pjyCNdneAd6wXdPNDFGC7yLVYj4tWbG+Jo8jUPSHHPnuaeGHE6t/2PjL43gKKQnY/b1aWwh0hiM
	hxbrKI2tZN/BAHgyERfC/kQ27/HUfFi1ImGVAOrF2Z30uvXBiIv6NnkNLHdbf3m0VybomiPPz4etE
	jfxFB0CSRJl6pgapnLkj6EbIzEfd1IGhmJzoez9au7yTBVofIsTimmVY8wvFjaZw/xumWFr+ednE0
	KpOQdsB7vy4mH6ffSwvyyVJe9Byn1gjMxYLCKF/WUKWVmZE8K21EO5vZunOpWLQMEbhFr/5q5mv4t
	RfVCq77A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricfz-0000000A2Y6-1Cp3;
	Fri, 08 Mar 2024 16:02:27 +0000
Message-ID: <0efda75a-dde6-42e0-86dc-993f0d1c4730@infradead.org>
Date: Fri, 8 Mar 2024 08:02:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ACPI: Add kernel-doc comments to
 handle_eject_request function
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308073214.11262-1-yang.lee@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240308073214.11262-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/24 23:32, Yang Li wrote:
> This patch adds proper kernel-doc comments to the
> handle_eject_request function in the ACPI dock subsystem.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/acpi/dock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index a89bdbe00184..a7c00ef78086 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -380,6 +380,8 @@ static int dock_in_progress(struct dock_station *ds)
>  
>  /**
>   * handle_eject_request - handle an undock request checking for error conditions
> + * @ds: The dock station to undock.
> + * @event: The ACPI event number associated with the undock request.
>   *
>   * Check to make sure the dock device is still present, then undock and
>   * hotremove all the devices that may need removing.

-- 
#Randy

