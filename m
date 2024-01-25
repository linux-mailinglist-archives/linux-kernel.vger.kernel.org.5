Return-Path: <linux-kernel+bounces-37811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5183B5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9EA1F23237
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA76FD0;
	Thu, 25 Jan 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="KUXguPHZ"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C96FD1;
	Thu, 25 Jan 2024 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140927; cv=pass; b=g+sfY/tmIvXloOH2eXkohzrZGVJaosi223pdVvm893hg0nTG8XvXDoxR1559x2LumeTjndOjRoRzNj/qn1BTUp1KgyZcWVsKeBX3zrK0MnP+qe1h8v2KGWaYmXZUzPVxpR72JLzAEV4eE1lOfIcK7J368HKWqtWolyUPbkfBAto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140927; c=relaxed/simple;
	bh=uMDDpxmjVsnsigiVrqzlpHUVeQjfY9aIaCC39DjTAV8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jVwVnxGW9jcMoyafVHhZpCGQgqWrOKAZyYJM1/ove5yOJZzUx1d5+Gdwkb2edY8+W4q2YcPqdRLmJeppNba0sSSEIJIVjhJkHFxIPFDI4Olg/bixIW23VOtqDCGjanPv12Oc5Dkuew5wzIhk2Kjkqqj4I/MAMLVezJ/rhgY6Diw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=KUXguPHZ; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706140910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iwL9YCZZUtsO0yNtbr4gZjJUPfFnyPFyzxAaDNq8AfcqBQx98WimbmnyHrWyMu6KKIVQp4cs2MHWhx1+Au621Sf3wmap1VM6s3EqVFeTe1Y8ye8s4LHsLfIFubj9o4t0lejHaek2qK/Z9l785SbT/3Lr5j7f1/1viD/t+IYv4hk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706140910; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TAlDSRdUtGC7nHIV+Kwr1ufueHveWKv+yA8OX/R6oHY=; 
	b=cWTS/bKcH+gGdd1HScGoaqylKjIDgwAvWxg6cs3W+VFocakN8goAlmhwV//JDf4eEi75Cgm4ErDNWhTBrXA8V98jsp71W2V0Lkn9tmxS5WuI4mrQAPJt1dkRBNP4Hsq3LVBXkgtzf9ueRiI1RIfEiD6uXlQ2JMK2Ll15ck+0W8M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706140910;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TAlDSRdUtGC7nHIV+Kwr1ufueHveWKv+yA8OX/R6oHY=;
	b=KUXguPHZwdUYkcyfsL9KO4lfaKLcxAsGVDv+1EFtmuqyQNQwnQf/ADRW87c0LQH8
	tPHaLk9Vc3S3zQc0QicJ98U98H3I3lcqb+q2zfoZ2517w4BDpuQTUxjwyCs7qftteKT
	RH2Y3c2DxXhB25Wm7zvyZwahyllGxGXt71c/W7p0=
Received: from [10.10.1.126] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706140908343292.0698777804661; Wed, 24 Jan 2024 16:01:48 -0800 (PST)
Message-ID: <d46abc40-5ad8-4d09-a6f8-f53c4b338142@apertussolutions.com>
Date: Wed, 24 Jan 2024 19:01:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH] tpm: make locality handling resilient
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, Sasha Levin <sashal@kernel.org>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
 <711d659f-3f57-48e4-b5b3-efbc2fe236c8@infineon.com>
Content-Language: en-US
In-Reply-To: <711d659f-3f57-48e4-b5b3-efbc2fe236c8@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 1/17/24 03:44, Alexander Steffen wrote:
> On 15.01.2024 02:15, Daniel P. Smith wrote:
>> Commit 933bfc5ad213 introduced the use of a locality counter to 
>> control when
>> locality request was actually sent to the TPM. This locality counter 
>> created a
>> hard enforcement that the TPM had no active locality at the time of 
>> the driver
>> initialization. The reality is that this may not always be the case 
>> coupled
>> with the fact that the commit indiscriminately decremented the counter 
>> created
>> the condition for integer underflow of the counter. The underflow was 
>> triggered
>> by the first pair of request/relinquish calls made in 
>> tpm_tis_init_core and all
>> subsequent calls to request/relinquished calls would have the counter 
>> flipping
>> between the underflow value and 0. The result is that it appeared all 
>> calls to
>> request/relinquish were successful, but they were not. The end result 
>> is that
>> the locality that was active when the driver loaded would always 
>> remain active,
>> to include after the driver shutdown. This creates a significant issue 
>> when
>> using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXIT]
>> instruction is called, the PCH will close access to Locality 2 MMIO 
>> address
>> space, leaving the TPM locked in Locality 2 with no means to 
>> relinquish the
>> locality until system reset.
>>
>> The commit seeks to address this situation through three changes.
> 
> Could you split this up into multiple patches then, so that they can be 
> discussed separately?

Gladly, but individually none of these fully address the situation.

>> The first is
>> to walk the localities during initialization and close any open 
>> localities to
>> ensure the TPM is in the assumed state. Next is to put guards around the
>> counter and the requested locality to ensure they remain within valid 
>> values.
>> The last change is to make the request locality functions be 
>> consistent in
>> their return values. The functions will either return the locality 
>> requested if
>> successful or a negative error code.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
>> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
>> ---
>>   drivers/char/tpm/tpm-chip.c     |  2 +-
>>   drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++++++-----
>>   include/linux/tpm.h             |  2 ++
>>   3 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 42b1062e33cd..e7293f85335a 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -49,7 +49,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>>                  return rc;
>>
>>          chip->locality = rc;
>> -       return 0;
>> +       return chip->locality;
>>   }
>>
>>   static void tpm_relinquish_locality(struct tpm_chip *chip)
>> diff --git a/drivers/char/tpm/tpm_tis_core.c 
>> b/drivers/char/tpm/tpm_tis_core.c
>> index 1b350412d8a6..c8b9b0b199dc 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct 
>> tpm_chip *chip, int l)
>>          struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>
>>          mutex_lock(&priv->locality_count_mutex);
>> -       priv->locality_count--;
>> +       if (priv->locality_count > 0)
>> +               priv->locality_count--;
>>          if (priv->locality_count == 0)
>>                  __tpm_tis_relinquish_locality(priv, l);
>>          mutex_unlock(&priv->locality_count_mutex);
>> @@ -226,18 +227,21 @@ static int __tpm_tis_request_locality(struct 
>> tpm_chip *chip, int l)
>>                          tpm_msleep(TPM_TIMEOUT);
>>                  } while (time_before(jiffies, stop));
>>          }
>> -       return -1;
>> +       return -EBUSY;
>>   }
>>
>>   static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>>   {
>>          struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -       int ret = 0;
>> +       int ret = -EIO;
>> +
>> +       if (l > TPM_MAX_LOCALITY)
>> +               return -EINVAL;
>>
>>          mutex_lock(&priv->locality_count_mutex);
>>          if (priv->locality_count == 0)
>>                  ret = __tpm_tis_request_locality(chip, l);
>> -       if (!ret)
>> +       if (ret >= 0)
>>                  priv->locality_count++;
>>          mutex_unlock(&priv->locality_count_mutex);
>>          return ret;
> 
> This line seems to be the most important change, that fixes the 
> locality_count handling for localities != 0. It could already be 
> sufficient to fix your original problem. I'm not sure all the other 
> changes are really necessary.

It do not believe this fully address the issue. It does stop the 
underflow but locality still is not being properly tracked.

>> @@ -1108,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct 
>> tpm_tis_data *priv, int irq,
>>          u32 intmask;
>>          u32 clkrun_val;
>>          u8 rid;
>> -       int rc, probe;
>> +       int rc, probe, locality;
>>          struct tpm_chip *chip;
>>
>>          chip = tpmm_chip_alloc(dev, &tpm_tis);
>> @@ -1169,6 +1173,12 @@ int tpm_tis_core_init(struct device *dev, 
>> struct tpm_tis_data *priv, int irq,
>>                  goto out_err;
>>          }
>>
>> +       /* It is not safe to assume localities are closed on startup */
>> +       for (locality = 0; locality <= TPM_MAX_LOCALITY; locality++) {
>> +               if (check_locality(chip, locality))
>> +                       tpm_tis_relinquish_locality(chip, locality);
>> +       }
>> +
>>          /* Take control of the TPM's interrupt hardware and shut it 
>> off */
>>          rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), 
>> &intmask);
>>          if (rc < 0)
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 4ee9d13749ad..f2651281f02e 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -116,6 +116,8 @@ struct tpm_chip_seqops {
>>          const struct seq_operations *seqops;
>>   };
>>
>> +#define TPM_MAX_LOCALITY               4
>> +
>>   struct tpm_chip {
>>          struct device dev;
>>          struct device devs;
>> -- 
>> 2.30.2
>>

