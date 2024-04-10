Return-Path: <linux-kernel+bounces-137903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07089E93B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CA01F2351A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997510A25;
	Wed, 10 Apr 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDUMyuaU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898F8F44;
	Wed, 10 Apr 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724877; cv=none; b=mjueXHuWRhdcPzJoAZPpJ7c0ZdPIpsUXLaanGmm0+CCXoQhMtp0gU3mdznDDuKF/XvmCR0FiU7c8zp23iNFt2jnOw4sHu6Syhi7KjKenwMtJUL6bYMr4I3O9kenogIGqLKCY/+EQ4CYn5o+4g7nxAg7PciNXd9O4V3eD2Z3zwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724877; c=relaxed/simple;
	bh=+PP+7xyp7mZeBlJnB62bonN9tv8yVzjzZGET211dMwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtshnCDaHoijMGaozOG2fJ8MAvuh5GNv47SQjk7LvxAVzMkVWlELkd6kWFDh8H5obf7qPZcG3b++k4idK0vX55UzPlwDftsY8FHLI4cgBN3eDRxh6sE5d3Pehlau+1KKFjsAS8NAmgqiVZy7FR/6q05cN7moRNaGUjd4MnDzZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eDUMyuaU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8C+0CGPOaTrvPlLGeH5cZbzRihud44TyrcpJRxDnZNY=; b=eDUMyuaUPQlEYoqqBbVcd0mNq3
	WD7AN98JJQlkqSSqKRNgVSlPVTgSbUU88ZuqzVKVnWuSluqAbwNbRWd7/rT1OXXTta1mpPYZh208c
	syqZZZTpXdNyz3Ff1l1ZtA9Y9tXHfsq08Dbo49JxDS9DGhb0bc0USjmd0WzUOiCkMLhKxqz2kSvLr
	j0LDikEvbOOUNe0Du4ciGkLjM6iOro5uIsfqi7E6DowK9fFehrMgq/gX2Dq1GlM5O09LJ5MWGTFpS
	w+OwdeaQTb67WQjbjoa7tsK/rX0b29Cx556UdfDbBAubFQhER57NFYkiUIZ4M7hvnY2rlqpfYF+Th
	dGMem+Lg==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruPyh-000000055W4-1nEZ;
	Wed, 10 Apr 2024 04:54:31 +0000
Message-ID: <c5436115-0b26-4369-8d71-154cc3c95659@infradead.org>
Date: Tue, 9 Apr 2024 21:54:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/sh7760fb: allow modular build
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240210053938.30558-1-rdunlap@infradead.org>
 <4d01127a9130ce46b7c1d447811c89c1d1503199.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4d01127a9130ce46b7c1d447811c89c1d1503199.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Will someone be merging this patch?

thanks.

On 2/10/24 1:31 AM, John Paul Adrian Glaubitz wrote:
> On Fri, 2024-02-09 at 21:39 -0800, Randy Dunlap wrote:
>> There is no reason to prohibit sh7760fb from being built as a
>> loadable module as suggested by Geert, so change the config symbol
>> from bool to tristate to allow that and change the FB dependency as
>> needed.
>>
>> Fixes: f75f71b2c418 ("fbdev/sh7760fb: Depend on FB=y")
>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>  drivers/video/fbdev/Kconfig |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -1645,8 +1645,8 @@ config FB_COBALT
>>  	select FB_IOMEM_HELPERS
>>  
>>  config FB_SH7760
>> -	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
>> -	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>> +	tristate "SH7760/SH7763/SH7720/SH7721 LCDC support"
>> +	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>>  		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
>>  	select FB_IOMEM_HELPERS
>>  	help
> 
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Adrian
> 

-- 
#Randy

