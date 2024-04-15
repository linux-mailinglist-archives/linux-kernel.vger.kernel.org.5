Return-Path: <linux-kernel+bounces-145557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A638A57D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F70E283FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFC82494;
	Mon, 15 Apr 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="aa8DdZTB"
Received: from mail-108-mta33.mxroute.com (mail-108-mta33.mxroute.com [136.175.108.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260661CD23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198767; cv=none; b=AnDflAW+pPyVu7pwaOHKA2Pk3sNZ8SHAMAUrGT+RWH4JNLeOWglBgAhllXRJhXY9Ni4Oj7jpPhLfgIEKCSeyxzYLjhkiXFs93czy31SGJ4SXrLcNVwFEn4h+4MtlFj4XWXTBYst6bkvP2KljMswUfJibnno2Gs9PpA+yDKCpoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198767; c=relaxed/simple;
	bh=+exoGmCOK4B2TtxLi9b/ila3bGXOXu85jVJIdxsj6mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aROcCyyzZoJhdPIvyfVHJoXhgHKDvEo500IJSW44MCR/7a0ZMe5XbQ9qaSA/OQYeOpTOlbTMWjYjRYPTEJIZUBFmQ0B2gxbjwZZT8lrIzDqdx30rknQBhZD4SbzKpsKO1vegtPVZRJ6XT6JBMLwiXIky0UCLtK0hrrdod99Uyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=aa8DdZTB; arc=none smtp.client-ip=136.175.108.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta33.mxroute.com (ZoneMTA) with ESMTPSA id 18ee295d2890003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 15 Apr 2024 16:27:33 +0000
X-Zone-Loop: c34f974572cfb78ac6c768e94899715187bea3e007ad
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V2Nn7Jrr3tkjyvXhAtGFNC4qmjJ+nKbbMNdFT82JTT0=; b=aa8DdZTBpjNxd1bP/EKMfyI4Mx
	tIOkjezMnyxWR4TLiN5ypsnhdPM8o8RLVeO6ccjvkoeBGt47xkRYnNm/6kUsUZfiQlnCf2OE8jiM1
	qSh3nLgateh6NXvemhs0tKo0inFmmT2jghc3e7qVCId6N3SJauot80rEyAhkQJZDYvCbjp9AR1Uod
	NKDy7tlTDeGT3k8NKdCxNiOapt2TCuLKPnhlSq+0s1gS8e+ZOEvyQxthDDRedP3NUjdA4E6qJ7h6A
	k8zPSBuVoMfbKHG5i0uRNxY/v9UG6f5rSHgpJttbrZ8jEGyNjBxyNr6wkTPstyIjrVGKyKSELG353
	FFRtmd4Q==;
Message-ID: <656bf349-38bf-44b7-936c-58f424613a49@luigi311.com>
Date: Mon, 15 Apr 2024 10:27:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/25] media:i2c: imx258: Use v4l2_link_freq_to_bitmap
 helper
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-25-git@luigi311.com>
 <Zh1FUQOt9n/tO3er@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <Zh1FUQOt9n/tO3er@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/15/24 09:18, Tommaso Merciai wrote:
> Hi Luis,
> 
> On Sun, Apr 14, 2024 at 02:35:02PM -0600, git@luigi311.com wrote:
>> From: Luis Garcia <git@luigi311.com>
>>
>> Use the v4l2_link_freq_to_bitmap() helper to figure out which
>> driver-supported link freq can be used on a given system.
>>
>> Signed-off-by: Luis Garcia <git@luigi311.com>
>> Reviewed-by: Pavel Machek <pavel@ucw.cz>
>> ---
>>  drivers/media/i2c/imx258.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index 5de71cb7c1ae..65846dff775e 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> @@ -693,6 +693,7 @@ struct imx258 {
>>  	/* Current mode */
>>  	const struct imx258_mode *cur_mode;
>>  
>> +	unsigned long link_freq_bitmap;
>>  	const struct imx258_link_freq_config *link_freq_configs;
>>  	const s64 *link_freq_menu_items;
>>  	unsigned int lane_mode_idx;
>> @@ -1552,6 +1553,17 @@ static int imx258_probe(struct i2c_client *client)
>>  		return ret;
>>  	}
>>  
>> +	ret = v4l2_link_freq_to_bitmap(&client->dev,
>> +				       ep.link_frequencies,
>> +				       ep.nr_of_link_frequencies,
>> +				       imx258->link_freq_menu_items,
>> +				       ARRAY_SIZE(link_freq_menu_items_19_2),
>> +				       &imx258->link_freq_bitmap);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Link frequency not supported\n");
>> +		goto error_endpoint_free;
>> +	}
>> +
>>  	/* Get number of data lanes */
>>  	switch (ep.bus.mipi_csi2.num_data_lanes) {
>>  	case 2:
> 
> Looks good to me.
> 
> ps:
> Maybe a good plan for the future would be to use: dev_err_probe
> (instead of dev_err into probe function)
> 
> But this I think is somenthing for next improvements. :)
> 
> Thanks & Regards,
> Tommaso
> 

Perfect, can i go ahead and add in your reviewed by looks like
you didnt add it here.

>> -- 
>> 2.44.0
>>
>>


