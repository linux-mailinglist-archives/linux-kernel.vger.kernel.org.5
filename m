Return-Path: <linux-kernel+bounces-100238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D019A8793E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C12845BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8D7A129;
	Tue, 12 Mar 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMtMcM1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2C79DBB;
	Tue, 12 Mar 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245647; cv=none; b=JQeXRpcZuSpii68h7Mt8wsobh3ucvYkEDRKGjYGRlU33BmK0FGqweJcMEDYRLeNX/p5Yd9DmWlmqnee2/b+ugXy02b+WnpwCPh+nUik9j4leGTERLHU9lYYI5lnycALrSedIZKOGocJcKYsT6fnfkIn49tJKRfQi5D6IXGwHgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245647; c=relaxed/simple;
	bh=RIledjCrWSCL/IPypQh0lHmpGxAEht7ZxoU3/0wNE40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUcx51A72eTC4o4OK5Ic1BT/zXLvFdBRer3NxfxqxHKARNNxGc9wZkksG1jKI8r15cy/BZ6KSgo+e0RPIOhe1+aLvzQWuDZuS8ilZzcwzbqRar3TMhRp6ixu7GTu2wp3CV9SW6HbwE3rPosTcR1EAjgLkKyoiM+XKskAfndyhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMtMcM1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B1C43399;
	Tue, 12 Mar 2024 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710245647;
	bh=RIledjCrWSCL/IPypQh0lHmpGxAEht7ZxoU3/0wNE40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YMtMcM1HD9JepAKEyuQuswytFBV5pq115pEWz+RZw+dGwUTHO+H4E8uCtlCmZLu3K
	 yeOtnQJas5uaLZ5D4TxqkVTt8JDac3yA4qXENMSAKlo1jxQnELvmHvHhkI7osYGwze
	 YtiXGANJtJ+sCP1L4YujohQOGY44MzijVk8bgsW/4iKM8MrU41wWsXsGr3yQcI5Hlv
	 ddPv1rRmJn5LS76fTTGBSTVsIoyDae2Ohagyot/OLHO4LaUc2iLaAYU7ypAGttwB2e
	 r/F1J1p7aMpA21mP3h8ofprS7UQ3ZLuF7U3n1xXqT7sW50x6UCInYUuiyGxhWwRwTS
	 AQFPaCOFGml7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  kernel@collabora.com,
  kernel-janitors@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
In-Reply-To: <865fc24b-ae27-4084-893b-c5c389480a09@collabora.com> (Muhammad
	Usama Anjum's message of "Mon, 11 Mar 2024 22:11:33 +0500")
References: <20240304090103.818092-1-usama.anjum@collabora.com>
	<865fc24b-ae27-4084-893b-c5c389480a09@collabora.com>
Date: Tue, 12 Mar 2024 13:14:03 +0100
Message-ID: <mafs0r0gf8x6c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Mon, Mar 11 2024, Muhammad Usama Anjum wrote:

> Soft reminder

Miquel should pick up the patch when sending out his pull request [0].

[0] https://lore.kernel.org/linux-mtd/20240307180919.4cb7a4cb@xps-13/

>
> On 3/4/24 2:01 PM, Muhammad Usama Anjum wrote:
>> The i should be signed to find out the end of the loop. Otherwise,
>> i >= 0 is always true and loop becomes infinite. Make its type to be
>> int.
>> 
>> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Make i int instead of u8
>> ---
>>  drivers/mtd/spi-nor/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 65b32ea59afc6..3e1f1913536bf 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3373,7 +3373,7 @@ static u32
>>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>>  			     const struct spi_nor_erase_type *erase_type)
>>  {
>> -	u8 i;
>> +	int i;
>>  
>>  	if (region->overlaid)
>>  		return region->size;

-- 
Regards,
Pratyush Yadav

