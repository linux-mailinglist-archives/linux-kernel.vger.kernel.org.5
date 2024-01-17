Return-Path: <linux-kernel+bounces-28585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D983005A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00CA1C23B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D954C8F65;
	Wed, 17 Jan 2024 07:08:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE86AA2;
	Wed, 17 Jan 2024 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705475289; cv=none; b=dgZG/q8WVZ/596tEWUCVGt/oE0ixuyiKCkEwxL4mk6O7ZGTc5HvMMgscwyvWL5MKexSy3XD3hRUJdwMwemMKUbk4G2+WU+ihlMqLRIdXpqCZkKqYONtKnyEcNoyUulDc26O1u1l0/w2EL8n4dFJlD2NWC9kY1tNcaSUN+7RwMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705475289; c=relaxed/simple;
	bh=WXNYjqgzNatwx+1zxT1NT6S8kRttXGSS7rRMRoawxlA=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=k4faD+T4A/4n6WiwCTIZWHb+5xktyIB2ejZ10ZMncBsnJedNPjObTtgjFExOY3hY6WbRrp6g7hgeUsU/zwMAzXKnkusqXaXhRtk1Xr/b2CgJ7yEZ1WwCvE0xJb47yTE4MA8+m2RZd+sPSqlhFlbI26D7rOKHcpNeW+BO+pIor/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5125fa9da51240b98565e2c343a33f68-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e522f8bc-1ccc-40fb-bf5e-816037eda404,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:e522f8bc-1ccc-40fb-bf5e-816037eda404,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:b792578e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401170312075O11I267,BulkQuantity:5,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 5125fa9da51240b98565e2c343a33f68-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 284761598; Wed, 17 Jan 2024 15:08:00 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5249EE000EB9;
	Wed, 17 Jan 2024 15:08:00 +0800 (CST)
X-ns-mid: postfix-65A77CD0-263206224
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id B0AC1E000EB9;
	Wed, 17 Jan 2024 15:07:59 +0800 (CST)
Message-ID: <3e7945e2-1891-4d86-aef9-e19eaa805721@kylinos.cn>
Date: Wed, 17 Jan 2024 15:07:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: synaptics-rmi4: Fix NULL pointer dereference in
 rmi_driver_probe
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com, cheiny@synaptics.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240116083847.89934-1-chentao@kylinos.cn>
 <ZabU_lsGCuki1dSY@google.com>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <ZabU_lsGCuki1dSY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/17 03:11, Dmitry Torokhov wrote:
> On Tue, Jan 16, 2024 at 04:38:47PM +0800, Kunwu Chan wrote:
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
> 
> It is perfectly valid to not set "input->phys" and leave it at NULL. So
> while I agree that having error handling is good I do not believe
> there's chance for NULL pointer dereference, so please adjust your patch
> title.

Thanks for your suggestions.
I'll change patch title to "Input: synaptics-rmi4: Add a null pointer 
check to the rmi_driver_probe".

>>
>> Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/input/rmi4/rmi_driver.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>> index 258d5fe3d395..d3a601ff51e6 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -1197,6 +1197,12 @@ static int rmi_driver_probe(struct device *dev)
>>   		rmi_driver_set_input_params(rmi_dev, data->input);
>>   		data->input->phys = devm_kasprintf(dev, GFP_KERNEL,
>>   						"%s/input0", dev_name(dev));
>> +		if (!data->input->phys) {
>> +			dev_err(dev, "%s: Failed to allocate memory.\n",
> 
> No need to log the error here, memory allocation will already log the
> failure.
Thanks, I'll remove the dev_err.
> 
> Thanks.
> 
-- 
Thanks,
   Kunwu


