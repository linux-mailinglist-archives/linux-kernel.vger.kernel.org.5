Return-Path: <linux-kernel+bounces-87912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17186DAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0191F25E21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03E50278;
	Fri,  1 Mar 2024 05:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Wapk/aCW"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79B3FE3F;
	Fri,  1 Mar 2024 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709270468; cv=none; b=A2/8poOEqJ5kTsI2yDO0RdqrES9eFkIYCXVxIModKLmhJCWBB5gs/gxED4IX1yTl/zqwWp9S2CPig1Dv9DK4Vjh5H+5IwAN/JFaVlriNYM99T9ofrdA/uA3qk7u/PLfECCTnyau60aU4K6WeO2qC73WvdCqHrRNaTP4vSrvskFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709270468; c=relaxed/simple;
	bh=hYkXkTirDR6JozbmGZTEpu69g7CUbtqTAq7OcMqZhOc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Iocq4dxRhnaoFM7L4PQg7dxU+e/w+RjhzLqVggpcMmhGGtII5aIZqF6kAOvfE7/0G9eeiJlY+PWnjIoeWhZg7eFZts8QAFiou3sR4HFBdu6miCCZzUyvVt+lTAUfLwUdhyvXaNl9v7mYhm2sEppRQS9LZonLSgDIhLW+h33BrFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Wapk/aCW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=TGGFXxkdaHkpLZsjv4M/o7SAoLYzqZm3P9d/C+KSKlg=;
	t=1709270466; x=1709702466; b=Wapk/aCWBSGkwEKCmS3HWS/GqmYRwlzO0aQLvfxbgyWM6Ga
	vkWI7f0EsQSJKupe2IXnrnwB0RMsGnYRy/ugpzXxVPZWqOy39fiSopr0GspzDyuWXTWFCaKel918q
	Laq5Vcxuja0lvkt8mAjp7p8ppur6k3rBd1zRbKXzWSkjElJ7HhSsObbbdhQxqYNFqk4liDGN9yWh8
	elLt8eikCTDvX5859ptvjwnxuvB41IOx5fuDguuPf42YdGndMX3IHX4yha7fZp9ZE+H51kXs4pk2Y
	Mzu6Rlk4kTQXrBFGE24qz2PgXw5uj0JuqC++XliOT5cdM5lM97PS0W0ulR8VtcEQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rfvKI-0005dh-Vv; Fri, 01 Mar 2024 06:20:55 +0100
Message-ID: <d2465271-1e4b-4bae-9399-4d49d3938048@leemhuis.info>
Date: Fri, 1 Mar 2024 06:20:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators
 getting en-/dis-abled twice on suspend/resume
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Hans de Goede <hdegoede@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Piel <eric.piel@tremplin-utc.net>,
 linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 stable@vger.kernel.org, regressions@lists.linux.dev
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240220190035.53402-1-hdegoede@redhat.com>
 <1d8226cd-df43-4ef6-8425-2db01d513b32@leemhuis.info>
In-Reply-To: <1d8226cd-df43-4ef6-8425-2db01d513b32@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709270466;28c93d34;
X-HE-SMSGID: 1rfvKI-0005dh-Vv

On 27.02.24 17:25, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 20.02.24 20:00, Hans de Goede wrote:
>> When not configured for wakeup lis3lv02d_i2c_suspend() will call
>> lis3lv02d_poweroff() even if the device has already been turned off
>> by the runtime-suspend handler and if configured for wakeup and
>> the device is runtime-suspended at this point then it is not turned
>> back on to serve as a wakeup source.
>>
>> [...]
>>
>> Fixes: b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback")
>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Closes: https://lore.kernel.org/regressions/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
>> Cc: stable@vger.kernel.org
>> Cc: regressions@lists.linux.dev
> 
> Paul, did you maybe test this? I suppose Greg had no time to review this
> yet due to all the CVE stuff and stable tree maintenance; but with a bit
> of luck a "Tested-by" from your side might motivate him or somebody else
> to look into this.

Hmmm, Greg seems to be pretty busy with other stuff. Hans, is there
maybe someone we can motivate into reviewing this to make it easier for
Greg to pick this up and send it to Linus before -rc8/the final?

Sure, it's "just" a warning fix, still would have been nice to get this
into -rc7. But I guess time has already run out on that. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
>> index c6eb27d46cb0..15119584473c 100644
>> --- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
>> +++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
>> @@ -198,8 +198,14 @@ static int lis3lv02d_i2c_suspend(struct device *dev)
>>  	struct i2c_client *client = to_i2c_client(dev);
>>  	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
>>  
>> -	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
>> +	/* Turn on for wakeup if turned off by runtime suspend */
>> +	if (lis3->pdata && lis3->pdata->wakeup_flags) {
>> +		if (pm_runtime_suspended(dev))
>> +			lis3lv02d_poweron(lis3);
>> +	/* For non wakeup turn off if not already turned off by runtime suspend */
>> +	} else if (!pm_runtime_suspended(dev))
>>  		lis3lv02d_poweroff(lis3);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -208,13 +214,12 @@ static int lis3lv02d_i2c_resume(struct device *dev)
>>  	struct i2c_client *client = to_i2c_client(dev);
>>  	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
>>  
>> -	/*
>> -	 * pm_runtime documentation says that devices should always
>> -	 * be powered on at resume. Pm_runtime turns them off after system
>> -	 * wide resume is complete.
>> -	 */
>> -	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
>> -		pm_runtime_suspended(dev))
>> +	/* Turn back off if turned on for wakeup and runtime suspended*/
>> +	if (lis3->pdata && lis3->pdata->wakeup_flags) {
>> +		if (pm_runtime_suspended(dev))
>> +			lis3lv02d_poweroff(lis3);
>> +	/* For non wakeup turn back on if not runtime suspended */
>> +	} else if (!pm_runtime_suspended(dev))
>>  		lis3lv02d_poweron(lis3);
>>  
>>  	return 0;
> 
> 

