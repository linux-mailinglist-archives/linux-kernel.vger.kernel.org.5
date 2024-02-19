Return-Path: <linux-kernel+bounces-71858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989785ABDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E258283B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66A50277;
	Mon, 19 Feb 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="QG9iEtjd"
Received: from sender3-of-o59.zoho.com (sender3-of-o59.zoho.com [136.143.184.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0C47F7E;
	Mon, 19 Feb 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370234; cv=pass; b=gkZIetanvdNAffiI8Gb1RNtisARM2VIml2xkyb8/CEnSqYDMJUgcMre2qi7owojFVnuiVDD3jxBnrVsdpg3ir4Wck3LfLWvYqmMIJ4eTtyElgmPLRhcEsbsSkcdr1Csw5btNWwYQMrtITbUu4uKMdziNzhDDHT3Bmtm2sxcnocI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370234; c=relaxed/simple;
	bh=/NKpxGD4L7EZ3oebf7IN7JxEddgVhdF8nAb587/mLtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5VmtxtOKyCn6/O9PFKI0OPW1AnbA9lIoCkKR6decXnGF5+iQGoFW7+VSQZZZuyiYxZrfBbgm6M5ZhnF4QCP775QEotIcTJzfYbLA9f4ifW2G2+dbxVCiw6ZtKoQBUEnI/gu+eZ3NS9HRPZ5AbAj2nIFMZI2ENXxRvNA/cGCjAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=QG9iEtjd; arc=pass smtp.client-ip=136.143.184.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1708370223; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ww1DrypyPmcYPD+U8LEKtS9w0mNW5PrTfCOJG7I877E4jZxn7jnXXWT2M7h/kcIaMm+4LrLqKwJgNS2U06gj2/WEBHnptVp1BI6V/RXiE7QDNkT+VNC0dfDyEHXv3oZ/Ya0jM0GZltpaFcjPp67ZEtAfnXkKLmjHYBoTEiVUL+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708370223; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+RfZps3cyaLzR9UeIkba7ZBflCqpBn2VxVNa1QfnSeE=; 
	b=EkY/vD6b6Pxq4Mw3++1cuf0Iog/XKnUwlXE+TaPPYseLVaNgCTFDJxjuSlsjsVjYcpuG2RaPajcbXstWrin5/IXn6oXHHqk6FWIPSg/b+4IyOy/0hRpjwKDgq2H3imp82CHBKdYykuYlSKVuJcrgTKrQPYEKzQVK5VMLSW2GQhY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708370223;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+RfZps3cyaLzR9UeIkba7ZBflCqpBn2VxVNa1QfnSeE=;
	b=QG9iEtjdxpLN7XM3isLANmCXuV/HvEnLyji5lW26/sbIdBC9dxbTqjhzBsiQJnto
	YAtvqn2ZnyaBcht3z3/R7s4g5YmSv6W11OQoQ4e5nc9nIzuRaAa2ahx9hNd5Byibm91
	r9Cm/L0/AdvP2YhTjpGwYRc2w6bTT7GAERhbm/44=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1708370222028706.4166130361724; Mon, 19 Feb 2024 11:17:02 -0800 (PST)
Message-ID: <2dd76ebf-b25d-447f-8abe-30e3423c4cdb@apertussolutions.com>
Date: Mon, 19 Feb 2024 14:17:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tpm: ensure tpm is in known state at startup
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-3-dpsmith@apertussolutions.com>
 <CYU3H17QGBR0.37HWK14BDMGCD@suppilovahvero>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CYU3H17QGBR0.37HWK14BDMGCD@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/1/24 17:33, Jarkko Sakkinen wrote:
> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>> When tis core initializes, it assumes all localities are closed. There
>         ~~~~~~~~
>         tpm_tis_core
> 
>> are cases when this may not be the case. This commit addresses this by
>> ensuring all localities are closed before initializing begins.
> 
> Remove the last sentence and replace with this paragraph:
> 
> "Address this by ensuring all the localities are closed in the beginning
> of tpm_tis_core_init(). There are environments, like Intel TXT, which
> may leave a locality open. Close all localities to start from a known
> state."

okay.

> BTW, why we should motivated to take this patch anyway?

Without this change, in this scenario the driver is unnecessarily 
thrashing the TPM with locality requests/relinquishes pairs for which 
will never take effect and that the TPM must do state change tracking. 
While I am confident that TPM chips are resilient to such abuse, I do 
not think it would be good form to knowingly allow such behavior to occur.

> Since the patch is not marked as a bug fix the commit message must pitch
> why it is important to care.

As far as I am aware, the TPM driver has always made this assumption, so 
I guess it could be written as a bug against the first commit of the 
driver. The reality is that it is more the case that the TPM driver has 
never completely supported higher localities. While there has been logic 
to support localities interface, the driver has always been hard wired 
to use locality 0.

Basically, this change makes the TPM driver function correctly when 
multiple localities are in use. I can write it up either way, just let 
me know.

>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>>   include/linux/tpm.h             |  6 ++++++
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 4176d3bd1f04..5709f87991d9 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -1109,7 +1109,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>   	u32 intmask;
>>   	u32 clkrun_val;
>>   	u8 rid;
>> -	int rc, probe;
>> +	int rc, probe, i;
>>   	struct tpm_chip *chip;
>>   
>>   	chip = tpmm_chip_alloc(dev, &tpm_tis);
>> @@ -1170,6 +1170,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>   		goto out_err;
>>   	}
>>   
>> +	/*
>> +	 * There are environments, like Intel TXT, that may leave a TPM
>> +	 * locality open. Close all localities to start from a known state.
>> +	 */
>> +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
>> +		if (check_locality(chip, i))
>> +			tpm_tis_relinquish_locality(chip, i);
>> +	}
>> +
>>   	/* Take control of the TPM's interrupt hardware and shut it off */
>>   	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>>   	if (rc < 0)
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 4ee9d13749ad..abe0d44d00ee 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -116,6 +116,12 @@ struct tpm_chip_seqops {
>>   	const struct seq_operations *seqops;
>>   };
>>   
>> +/*
>> + * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
>> + * Client Platform Profile Specification.
>> + */
>> +#define TPM_MAX_LOCALITY		4
>> +
>>   struct tpm_chip {
>>   	struct device dev;
>>   	struct device devs;
> 
> Is there a dependency to 1/3?

There is no direct dependency between these patches, but 1 and 2 are 
necessary to resolve the issue at hand while 3 corrects the return value 
behavior of the locality request function.

v/r,
dps

