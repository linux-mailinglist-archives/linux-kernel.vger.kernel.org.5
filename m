Return-Path: <linux-kernel+bounces-55540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790284BDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C99628B899
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B7B14008;
	Tue,  6 Feb 2024 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AbBvkPpz"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C613FE2;
	Tue,  6 Feb 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246458; cv=none; b=bzYHqLvSfYnIjM8G6nnzKfjVuDK87lVynebMLkVfp4r31LehS0unirOH6+F5Bn5LDFdkvNf5eDH/rG8AyLKpQ+dOtSn2sU3bILqkXWUmFZer7MY/4DZjZYvKbOT0Ly7+c5BTJrS2Td/mYPRr7HMG704d55x3YkX9QJjjpLOR2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246458; c=relaxed/simple;
	bh=fcUpuXMDio+yishakHJrhuMm+7x1jRFTokuTht7ioxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l7IxR+8Yhlaqg6vHlxpXN340i2M0LJpVcRg/GRpyHjWva/nSrouB1zGD5Vk4nzkCIAy622Sr1+BYatZ5lssmmCUHXtPTfAhB+y/TcUVNeyePXGYsqfQVLtp0vAPpsTEQDyenu4AD7y8H/X8vRuTZAZ8XbciyyaFxh3SXC/MLUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AbBvkPpz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416J7T6K097971;
	Tue, 6 Feb 2024 13:07:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707246449;
	bh=McDF83SqW1QdyD+7tudNz9OwaUHXbfqRvg49t9XHoHA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AbBvkPpzp1KmZVlOd/gA9MzseMYs0IY8wHEybpvI5aWa6lyfHVQ/Hab2owaFYAx6+
	 FKxK/FymB9XIhgrRZP8Vjh5AnUJU+C1FaHCvsWDVuNudm8kLIqOKoa/zUMdlMXRqIm
	 VvD68Tk5/vcH+9ALaTw49DhF/igjQcTU7xlTm6SA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416J7TcP011106
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 13:07:29 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 13:07:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 13:07:29 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416J7SVl002592;
	Tue, 6 Feb 2024 13:07:28 -0600
Message-ID: <a225205a-0baf-493e-9138-91aac7e0371b@ti.com>
Date: Tue, 6 Feb 2024 13:07:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hwspinlock: omap: Use devm_pm_runtime_enable() helper
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240123160405.360437-1-afd@ti.com>
 <20240123160405.360437-2-afd@ti.com>
 <73jxbyqatxc7r56df2iweewb22qvmqo33rhpsu3darczn7ldof@p2qepqpdf5ds>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <73jxbyqatxc7r56df2iweewb22qvmqo33rhpsu3darczn7ldof@p2qepqpdf5ds>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/6/24 1:06 PM, Bjorn Andersson wrote:
> On Tue, Jan 23, 2024 at 10:04:03AM -0600, Andrew Davis wrote:
>> This disables runtime PM on module exit, allowing us to simplify
>> the probe exit path and remove callbacks. Do that here.
> 
> As with the later patch, unless I'm misreading the code, you already do
> disable runtime PM in omap_hwspinlock_remove().
> 

Right, what I meant to say in the commit message was

"This disables runtime PM on module exit *automatically for us*.."

As in we don't have to manually do it anymore, and that simplifies
the code, which is the "fix" that this patch does.

Will update the commit message to make that more clear in this
and the next patch.

>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/hwspinlock/omap_hwspinlock.c | 26 ++++++++------------------
>>   1 file changed, 8 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> [..]
>> @@ -129,16 +125,12 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>>   	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
>>   						base_id, num_locks);
>>   	if (ret)
>> -		goto runtime_err;
>> +		return ret;
>>   
>>   	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
>>   		num_locks);
> 
> I don't fancy these debug information messages, there are other ways to
> confirm that the device probed successfully etc.
> 
> Now that you don't need the goto runtime_err, I'd prefer the tail of
> this function:
> 
> 	return hwspin_lock_register(...);
> 

Sure, will update.

Thanks,
Andrew

> Regards,
> Bjorn
> 
>>   
>>   	return 0;
>> -
>> -runtime_err:
>> -	pm_runtime_disable(&pdev->dev);
>> -	return ret;
>>   }
>>   
>>   static void omap_hwspinlock_remove(struct platform_device *pdev)
>> @@ -151,8 +143,6 @@ static void omap_hwspinlock_remove(struct platform_device *pdev)
>>   		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
>>   		return;
>>   	}
>> -
>> -	pm_runtime_disable(&pdev->dev);
>>   }
>>   
>>   static const struct of_device_id omap_hwspinlock_of_match[] = {
>> -- 
>> 2.39.2
>>

