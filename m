Return-Path: <linux-kernel+bounces-37814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30F83B5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E96284B73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33733399;
	Thu, 25 Jan 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="b6FByK3X"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB77F;
	Thu, 25 Jan 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141571; cv=pass; b=ej018RsWHL9/Fr1kCxF0DQRxcbbkyn6m4nSsjhRR0bXn8hZiQ/Uxot+095+d9d1rRAF+rpWK7dE2VvY/z7C5Wb7vg0NAyQTSQEwQHvD/wGavvMLZJXOOXsmy28/VYa49VYqDX57APet5/gqcjmPikFfL3QItTc0XGRAul0f823o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141571; c=relaxed/simple;
	bh=ES4dIvkHbc7hWU66uoZKzdMjilDUhipl8F1H9v+LjKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGwWo961limnoIeLjRJ/ZUNNsOaEtCbBM5j/pBPIdf8cpDeOA7DMRbGQRvYxH5eNm/xWGCtQL+jqqnjlfThpXXguDgTMsD+RXbO8U5I85efdoROMXd2h/ApATRtl//foxqfNaRIi8vak466UQLJwHzKkg8X2Al6oeWE1dFSVMQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=b6FByK3X; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706141559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J1KoK/wX6e3dLE/8neLhf/zWOmlonqXoCj7l3CDyagB7ZruesIbVHWcOdvS2dgPyi+yBouePR433spJoWsi+nS/l+/CgO+N4gRRbKJWhC6jt+YI6mjSoNPdr+Rmr3+0kFvND6gVur2Zg87BVRVmYMk2mWzmHjDsIfTEJonYjMMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706141559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O8L/0lWppyp3HiUGsntSLDbITqkNTvtHxygx1Tjmam4=; 
	b=m+nf79RAhv7/4OjwRFPCMIrYFq41YHoKyPrH/TbLeN87jJgBVdfGqB/Ig80N8v7Dbu4L/MN/xRCbq3yO70YLt/wjWVPuY67zFch9kj9SR37Z1J3Y0NtKytdozdwnfSCW7arF6Wn4ygFwMMyk2dbXHE0005F5zAdj7HqvspxObj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706141559;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O8L/0lWppyp3HiUGsntSLDbITqkNTvtHxygx1Tjmam4=;
	b=b6FByK3XT+l8ERSc4c+2e8FKevOYWY7YRG3ukO/ESWgksJ9Rx9SgL1AxQwucSC2P
	Lm9/TffP/cRfaeCVUw3oLgFRGbkDfT4oMaTjAWyWpD69WTUryRBuxT/591hEr//SRsF
	Q4Nw2hRa7WgbUPLuvEuPtycK8itZrt/2Ty6XWIpI=
Received: from [10.10.1.126] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706141558757288.237353866082; Wed, 24 Jan 2024 16:12:38 -0800 (PST)
Message-ID: <9cfa437c-ba3d-471f-b6d6-6f37e7acea6c@apertussolutions.com>
Date: Wed, 24 Jan 2024 19:12:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: make locality handling resilient
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, Sasha Levin <sashal@kernel.org>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
 <CYJ02TX197BU.2MENZV8N4N87O@seitikki>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CYJ02TX197BU.2MENZV8N4N87O@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/19/24 16:28, Jarkko Sakkinen wrote:
> On Mon Jan 15, 2024 at 1:15 AM UTC, Daniel P. Smith wrote:
>> Commit 933bfc5ad213 introduced the use of a locality counter to control when
>> locality request was actually sent to the TPM. This locality counter created a
>> hard enforcement that the TPM had no active locality at the time of the driver
>> initialization. The reality is that this may not always be the case coupled
>> with the fact that the commit indiscriminately decremented the counter created
>> the condition for integer underflow of the counter. The underflow was triggered
>> by the first pair of request/relinquish calls made in tpm_tis_init_core and all
>> subsequent calls to request/relinquished calls would have the counter flipping
>> between the underflow value and 0. The result is that it appeared all calls to
>> request/relinquish were successful, but they were not. The end result is that
>> the locality that was active when the driver loaded would always remain active,
>> to include after the driver shutdown. This creates a significant issue when
>> using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXIT]
>> instruction is called, the PCH will close access to Locality 2 MMIO address
>> space, leaving the TPM locked in Locality 2 with no means to relinquish the
>> locality until system reset.
>>
>> The commit seeks to address this situation through three changes. The first is
>> to walk the localities during initialization and close any open localities to
>> ensure the TPM is in the assumed state. Next is to put guards around the
>> counter and the requested locality to ensure they remain within valid values.
>> The last change is to make the request locality functions be consistent in
>> their return values. The functions will either return the locality requested if
>> successful or a negative error code.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
>> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
>> ---
>>   drivers/char/tpm/tpm-chip.c     |  2 +-
>>   drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++++++-----
>>   include/linux/tpm.h             |  2 ++
>>   3 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 42b1062e33cd..e7293f85335a 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -49,7 +49,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>>   		return rc;
>>   
>>   	chip->locality = rc;
>> -	return 0;
>> +	return chip->locality;
>>   }
>>   
>>   static void tpm_relinquish_locality(struct tpm_chip *chip)
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 1b350412d8a6..c8b9b0b199dc 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>   
>>   	mutex_lock(&priv->locality_count_mutex);
>> -	priv->locality_count--;
>> +	if (priv->locality_count > 0)
>> +		priv->locality_count--;
>>   	if (priv->locality_count == 0)
>>   		__tpm_tis_relinquish_locality(priv, l);
>>   	mutex_unlock(&priv->locality_count_mutex);
>> @@ -226,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
>>   			tpm_msleep(TPM_TIMEOUT);
>>   		} while (time_before(jiffies, stop));
>>   	}
>> -	return -1;
>> +	return -EBUSY;
>>   }
>>   
>>   static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>>   {
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -	int ret = 0;
>> +	int ret = -EIO;
>> +
>> +	if (l > TPM_MAX_LOCALITY)
>> +		return -EINVAL;
>>   
>>   	mutex_lock(&priv->locality_count_mutex);
>>   	if (priv->locality_count == 0)
>>   		ret = __tpm_tis_request_locality(chip, l);
>> -	if (!ret)
>> +	if (ret >= 0)
>>   		priv->locality_count++;
>>   	mutex_unlock(&priv->locality_count_mutex);
>>   	return ret;
>> @@ -1108,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>   	u32 intmask;
>>   	u32 clkrun_val;
>>   	u8 rid;
>> -	int rc, probe;
>> +	int rc, probe, locality;
> 
> s/locality/i/
> 
> We don't use long names for loop indices generally.

No problem, will change.

>>   	struct tpm_chip *chip;
>>   
>>   	chip = tpmm_chip_alloc(dev, &tpm_tis);
>> @@ -1169,6 +1173,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>   		goto out_err;
>>   	}
>>   
>> +	/* It is not safe to assume localities are closed on startup */
> 
> This is somewhat useless comment.
> 
> E.g. this would be way more useful:
> 
> 	/*
> 	 * Intel TXT starts with locality 2 active. Therefore,
> 	 * localities cannot be assumed to be closed on startup.
> 	 */

Okay, will expand.

>> +	for (locality = 0; locality <= TPM_MAX_LOCALITY; locality++) {
>> +		if (check_locality(chip, locality))
>> +			tpm_tis_relinquish_locality(chip, locality);
>> +	}
>> +
>>   	/* Take control of the TPM's interrupt hardware and shut it off */
>>   	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>>   	if (rc < 0)
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 4ee9d13749ad..f2651281f02e 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -116,6 +116,8 @@ struct tpm_chip_seqops {
>>   	const struct seq_operations *seqops;
>>   };
>>   
>> +#define TPM_MAX_LOCALITY		4
> 
> Not documented.

Okay, will add spec ref.

>> +
>>   struct tpm_chip {
>>   	struct device dev;
>>   	struct device devs;
> 
> Thanks for the fix.

Your welcome.

> BR, Jarkko

V/r,
DPS

