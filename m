Return-Path: <linux-kernel+bounces-95771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF7875252
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4372836BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A538412EBE9;
	Thu,  7 Mar 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FwxVwPaT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F01EB2B;
	Thu,  7 Mar 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823076; cv=none; b=Xs5XxV+tZCZgZXLfD5iMdDgSwGDqbgh0Gl3Tbd6tsTVD776SfVTSDr+yiGbbuyx9WTnn1Jj4h+OE1+Rqov73bYpgMdo3EXQ+DwjjydCo6EAW3NhoX64ORed0U6ppY85zN/0fGIaGRT0Ywi/JxeOBxqWAic81zvMWWBA4WArt/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823076; c=relaxed/simple;
	bh=rvD2P1O/Yu1SCYV6g84ids32N2kqDADZ3NNB6jXOw7s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YqJrGsWgvY3g6V7oGU4z7FAaMcldKiWj3xMxyup2LRJR4zW46Kjzq9iVbw3CQkE4iglsvyFqDp+7VFD32qfzQY5vGEMdAvtmNo+wlx9m0bihLAHS/3Eqo9m7btBT7GlmKbtW38P3YpOz5AkIhh9Diw3WY5pVlcuNgRjNZOabn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FwxVwPaT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709823072;
	bh=rvD2P1O/Yu1SCYV6g84ids32N2kqDADZ3NNB6jXOw7s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FwxVwPaTOu8T4BU3Li5Rcrf3OSyxJy5bi9TVo+gMmOFQGdXQybtdDK256yvmz9YSy
	 qgimCt/65+QGHinL4XyGeqwX7bTIxVFuAIZUmGaoETDX5VrC565pPwehm1IAafwEck
	 yLxunoxGIMdhOyB2xdzC3e1q0vihhBRfqZKftjZobR0g2x7/F788AMH13p+9diKXdt
	 FxOGd8FvseKBGUTe7i/0kasKdxr89dc5/4u0MGW80lkUTnTKe/1H0kqaLtVwdns+ug
	 Z1JMTjVS5bi7O2s+WDBMIBrClWS53CZBsz8D0S908z1A0ENFmTIGHhbWw5Nh3P8B78
	 n1bptiYlK6g7g==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9F36037820C1;
	Thu,  7 Mar 2024 14:51:09 +0000 (UTC)
Message-ID: <8cf4333a-b500-4fb7-8176-734fdc892da4@collabora.com>
Date: Thu, 7 Mar 2024 19:51:37 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
To: Yang Xiwen <forbidden405@outlook.com>
References: <20240307122129.2359553-1-usama.anjum@collabora.com>
 <SEZPR06MB69597EEFAB2F77049E9B257296202@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <SEZPR06MB69597EEFAB2F77049E9B257296202@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/24 5:22 PM, Yang Xiwen wrote:
> On 3/7/2024 8:21 PM, Muhammad Usama Anjum wrote:
>> The err is being set to 0 and replaced every time after this
>> assignment. Remove this assignment as it is extraneous.
>>
>> Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   drivers/mmc/host/dw_mmc-hi3798mv200.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c
>> b/drivers/mmc/host/dw_mmc-hi3798mv200.c
>> index 989ae8dda7228..96af693e3e37c 100644
>> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
>> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
>> @@ -133,7 +133,6 @@ static int
>> dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
>>               goto tuning_out;
>>             prev_err = err;
>> -        err = 0;
> 
> 
> Same for dw_mmc-hi3798cv200.c, maybe fix it as well?
Sent separately as different Fixes tag is required for that:
https://lore.kernel.org/all/20240307145013.2721326-1-usama.anjum@collabora.com

> 
> 
>>       }
>>     tuning_out:
> 
> 

-- 
BR,
Muhammad Usama Anjum

