Return-Path: <linux-kernel+bounces-90244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B386FC62
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D14F1F21AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88825755;
	Mon,  4 Mar 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bbmqj9Cu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9B19474;
	Mon,  4 Mar 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541972; cv=none; b=G5GaSYgNm6+FdPih0ohdJThgUmbygHGUoyPQMRrS3pxDX49CSl4XLkdxl/yG9dPonREHcfmdxIjZDDjUTt0p2EEtJYd7BN/R0lMgpA/m6M3cTI9wYiPup0S0hnCKDt8AU8ukwKuJqPE5Y0/sGiQL4NWkXCXdlxyTEXBTDcIScQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541972; c=relaxed/simple;
	bh=gkCW8KsdIC7ZfO49SVRDYAdSUC2Z8gW9XivfLoDvYPs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F1p1wQssnJajZIF4vKOwWwIf5n9fXAyLQE295nCh0jbmd6yx1vIgX6Tmya1QYY0DayzLrEr7a1pQcq0tTO9JynbGF+8N1opnCFJQmST0LMEyhVOhMKlQx66etxej0SK2W2WXZHl+XN0UBzwH6pFWVbnD+Td+maKN0+S+YMsWS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bbmqj9Cu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709541968;
	bh=gkCW8KsdIC7ZfO49SVRDYAdSUC2Z8gW9XivfLoDvYPs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bbmqj9CuuzAWYhrZ5GlKYRmjhAFMpkAQSXihWxkuAw6Xt6xEjpWNGjS8alQ8AVNlb
	 Sl89lqht6JSrxxUKbQ+FPcdZbySuTM/umAkmsLzkVd2CPrBWDTBGU3ldQdw671eIPX
	 UbwhgLdluWM/7K9fHlmzY3wSmK5sH38TZFdfAJi8pl72U6hpDJDwdTNiB9UgHcCt/H
	 RhnzD9omeD6JR7mBD+TrSxKZ5TNpnjUj8tV2uMZujmLRrL+F9UexbaBj4scHusIWbw
	 qaCkIp8zMplisVsa0tA8fGrUqwUpJpB9dRtjJQUEImoG/1jdKa1gv/7RTslQzbhbOu
	 v4GhYuV6mHkjA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E127B3781FE9;
	Mon,  4 Mar 2024 08:45:50 +0000 (UTC)
Message-ID: <d6596dd7-4d80-4024-af2b-c4f6c9da1084@collabora.com>
Date: Mon, 4 Mar 2024 13:46:21 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: core: correct type of i to be signed
Content-Language: en-US
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20240301144517.2811370-1-usama.anjum@collabora.com>
 <CZII7JH72OWF.1IAQO5VJCBZX3@kernel.org>
 <713393d5-13ef-4891-bf7c-d835edacef8a@linaro.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <713393d5-13ef-4891-bf7c-d835edacef8a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 12:51 PM, Tudor Ambarus wrote:
> 
> 
> On 3/1/24 15:04, Michael Walle wrote:
>> Hi,
>>
>> On Fri Mar 1, 2024 at 3:45 PM CET, Muhammad Usama Anjum wrote:
>>> The i should be signed to find out the end of the loop. Otherwise,
>>> i >= 0 is always true and loop becomes infinite.
>>>
>>> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>  drivers/mtd/spi-nor/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 65b32ea59afc6..46bc45b80883f 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -3373,7 +3373,7 @@ static u32
>>>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>>>  			     const struct spi_nor_erase_type *erase_type)
>>>  {
>>> -	u8 i;
>>> +	s8 i;
>>
>> Can we just have an "int" here. So we don't shoot ourselves in the
> 
> Muhammad, do you care to resubmit using int? Would be better indeed.
I'm sending a v2 with int.

> 
>> foot again. I'm really no friend of these kind of micro
>> optimizations, it should have been int in the first place IMHO.
>>
>> -michael
>>
>>>  
>>>  	if (region->overlaid)
>>>  		return region->size;
>>
> 

-- 
BR,
Muhammad Usama Anjum

