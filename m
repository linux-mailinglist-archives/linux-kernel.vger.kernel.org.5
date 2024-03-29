Return-Path: <linux-kernel+bounces-125153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC99989212D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478C6287ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235485656;
	Fri, 29 Mar 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="JjdG2ubE"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EF1E893
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728248; cv=none; b=cGOn8sGZts6CH78Mj7S+etLLaM+oHMIGRDhQq7dp1EtuuaBxLoVSyRTYO8w3uM0tss4y4MERSq8egm5RV2lu/hwpJaURApaYvzPFs9UK+3qzRGirWy7lf5mxXS80nuuOXHhBGA8WW2Km7GMsL4EYpap+3JDEZ7QuUB2UFdDe8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728248; c=relaxed/simple;
	bh=732K/XnBNH6TMeCPYvn8g4FYNQ0rWfv8ASum/ByW3l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaYrvXM633Xb0yf3NZj++ajiGtRuhEGZlDxGRB9PP6VZ8bds+cXGwUWO0Br9NfvtRumiHhE98e548msjIfbH/BWlwCjNBJvFJnXFwYo22IlLGzPdKgF4X9LJAY8NGXC8wb4x7p1Ek2/Kcnt/xvrL+6F8t0ZCJF+LlosLpc5AKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=JjdG2ubE; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id q4YfrqUAwHXmAqEhxrGbrW; Fri, 29 Mar 2024 16:03:58 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id qEhurTqi4sT9BqEhwrJEVP; Fri, 29 Mar 2024 16:03:56 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=6606e66c
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8
 a=BvONN35OqgEy8-QZpXoA:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aHU8LaL+HMkC/1OFnSc7IMvxGqZxLbVRl1K9ttHFCuk=; b=JjdG2ubE8kQ0vnURdpRSxuFi9j
	hew5YEwCvcFJQCeC1F0aVmXfPPtSWmpqayZ8wRSXMK4LrroQxU+LKk+YDDEDVJFxbE9AdPAig0mmP
	JCl88WOOagVOfQC6lTcsILDnY0F5ObS/FxRa8Mn4rsTWI8d0LIRISmBNOnC03Favnjd+h6G9pbQmV
	x4w0WPtv4JGyDaJ66k7xmoDjlptWQOKSnvG82dRwXJVk/pAGxNoCVEgxq9bq5nIbw3OgvMuemrJec
	+BHyUIgie74lobCIO4mbIPhtfK1P4HPGRJqcbbbT//VfDwGVF7/sA4s/c6DD6ZgKKKIfURcUuPOq8
	yFRhWkEA==;
Received: from [122.165.245.213] (port=60658 helo=[192.168.1.32])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1rqEhu-001jxe-04;
	Fri, 29 Mar 2024 21:33:54 +0530
Message-ID: <1823735f-d677-4f5a-ae39-713f0c9b7777@linumiz.com>
Date: Fri, 29 Mar 2024 21:33:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: rtc: rv3028: check and update PORF flag during
 probe
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com
References: <20240329101940.1424643-1-karthikeyan@linumiz.com>
 <20240329102847fcdca1cf@mail.local>
From: karthikeyan <karthikeyan@linumiz.com>
In-Reply-To: <20240329102847fcdca1cf@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rqEhu-001jxe-04
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.32]) [122.165.245.213]:60658
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAmufozCeFnDagOmgvnqhiqzpJY6GWx3iJjM6mRcFZw075ocAhiq3D8pRhCzmakuZhueh4fIAnQcPLq0OgBPnJ0Mne+YLVr0RSXRFNx9z9mgsfREZyHq
 Sq8DZh6v9KUvVt0rlZbMFHe9w+oUhRjR/X8TVriv9/xZjU6NYB3oF2xb8Lyz3OAsJSRYzdd44m5v0wq+huQei9o0keZATC3o9buWKMlO9CW7RAZ0F1u0xiDs

Agreed. Thanks for clarification.

Regards,
Karthikeyan Krishnasamy


On 3/29/24 15:58, Alexandre Belloni wrote:
> On 29/03/2024 15:49:40+0530, Karthikeyan Krishnasamy wrote:
>> PORF flag is set during power reset and voltage drop below Vpor
>> data in rtc device is no longer valid if PORF flag is set
>> and software must reset to 0, in order to perform sanity
>> check on rtc data
>>
>> Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
>> ---
>>   drivers/rtc/rtc-rv3028.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
>> index 2f001c59c61d..e9699ff0c4e8 100644
>> --- a/drivers/rtc/rtc-rv3028.c
>> +++ b/drivers/rtc/rtc-rv3028.c
>> @@ -951,6 +951,13 @@ static int rv3028_probe(struct i2c_client *client)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> +	if (status & RV3028_STATUS_PORF) {
>> +		ret = regmap_update_bits(rv3028->regmap, RV3028_STATUS,
>> +					 RV3028_STATUS_PORF, 0);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
> 
> This breaks the workflow, you must set the time to reset PORF.
> 
>>   	if (status & RV3028_STATUS_AF)
>>   		dev_warn(&client->dev, "An alarm may have been missed.\n");
>>   
>> -- 
>> 2.34.1
>>
> 

