Return-Path: <linux-kernel+bounces-119812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531688CD44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870BA1C62957
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECC13D257;
	Tue, 26 Mar 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t0c8byvX"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266513CC41;
	Tue, 26 Mar 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481570; cv=none; b=oL7B7wR7ldHVEQ9pkEKiGlCpmLBsVe2ScFYEmFCQy7tXiK+/YpYJu0cf9AFbybXCR6gAHHuZT7VOoC8CuJ+T4vmPkFw4extfrKu3PK7b43tPmFXlMOZ26YWgdsOBIximYMmKG91g5ZH2+MrGorExGsS0VMOTfPcNHBN/VYdl+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481570; c=relaxed/simple;
	bh=ASYjIA4rikkNb+Dh03vIWzKDq33NHhyCndtc/W5T1ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jMKLM3EqXCB0i6t+v3AgAAOYwrvCVJkJILx4HmZPz9PDl7zyfGL0dlhsmk15L3oGdRW1OYuODLMwKqZBwB5KgDA2HF/Vmrul7IdNKNiK8paPtke3rSUCVGLXpAnq5ruxPxpRbPkZADwWDQQzxmfLPWg1TSaJ3HJ9Xm9c48pUDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t0c8byvX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QCr0FS007214;
	Tue, 26 Mar 2024 20:32:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Ul+HEbI6cYBHB5QYUmeHA+sVOAzeUux6CAaaAFte2o8=; b=t0
	c8byvXd3G/ZfwhVg/grm1HrXYOYgFdELjr997+3MctOBT+3K1ywh0qj6Y8+XYjvK
	po+1zMBWfg7LRh/uRheNJ0FIoahXu4B8GihUKV3mVeT8u6iErYMjnLhEruTKuvXb
	D+kCgKeZnYIBFubrGOGegRcLMpLuFBufBWnbHf4TBxWTy68nyO1rXY8+sP86A++h
	62Blvqf0fvnsxaM8bta6OQN3JWst5jpsOpjmQVLdLDxzRAI8T6RcV4lCZH/sWWsl
	1vuQn26YyEMd7LoZYPsEvJNpq1tAUo4ZdDAd1yKoBTSIwt54bBViPJVSrDu2tiFM
	6z4fxQX723ZWMRwo2BQQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1n39f33c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 20:32:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 730E54002D;
	Tue, 26 Mar 2024 20:32:25 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB7A1228A50;
	Tue, 26 Mar 2024 20:31:35 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 20:31:35 +0100
Received: from [10.201.21.20] (10.201.21.20) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 20:31:34 +0100
Message-ID: <a08add21-b8ff-434a-9689-6af8b05b1965@foss.st.com>
Date: Tue, 26 Mar 2024 20:31:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Jens Wiklander
	<jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240308144708.62362-1-arnaud.pouliquen@foss.st.com>
 <20240308144708.62362-5-arnaud.pouliquen@foss.st.com> <ZgGrnkcebcIQQic6@p14s>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZgGrnkcebcIQQic6@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02



On 3/25/24 17:51, Mathieu Poirier wrote:
> On Fri, Mar 08, 2024 at 03:47:08PM +0100, Arnaud Pouliquen wrote:
>> The new TEE remoteproc device is used to manage remote firmware in a
>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>> introduced to delegate the loading of the firmware to the trusted
>> execution context. In such cases, the firmware should be signed and
>> adhere to the image format defined by the TEE.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Updates from V3:
>> - remove support of the attach use case. Will be addressed in a separate
>>   thread,
>> - add st_rproc_tee_ops::parse_fw ops,
>> - inverse call of devm_rproc_alloc()and tee_rproc_register() to manage cross
>>   reference between the rproc struct and the tee_rproc struct in tee_rproc.c.
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 60 +++++++++++++++++++++++++++++---
>>  1 file changed, 56 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>> index 8cd838df4e92..13df33c78aa2 100644
>> --- a/drivers/remoteproc/stm32_rproc.c
>> +++ b/drivers/remoteproc/stm32_rproc.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/remoteproc.h>
>>  #include <linux/reset.h>
>>  #include <linux/slab.h>
>> +#include <linux/tee_remoteproc.h>
>>  #include <linux/workqueue.h>
>>  
>>  #include "remoteproc_internal.h"
>> @@ -49,6 +50,9 @@
>>  #define M4_STATE_STANDBY	4
>>  #define M4_STATE_CRASH		5
>>  
>> +/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */
> 
> Why is this the case?  At least from the kernel side it is possible to call
> tee_rproc_register() with any kind of value, why is there a need to be any
> kind of alignment with the TEE?


The use of the proc_id is to identify a processor in case of multi co-processors.

For instance we can have a system with A DSP and a modem. We would use the same
TEE service, but
the TEE driver will probably be different, same for the signature key.
In such case the proc ID allows to identify the the processor you want to address.


> 
>> +#define STM32_MP1_M4_PROC_ID    0
>> +
>>  struct stm32_syscon {
>>  	struct regmap *map;
>>  	u32 reg;
>> @@ -257,6 +261,19 @@ static int stm32_rproc_release(struct rproc *rproc)
>>  	return 0;
>>  }
>>  
>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	int err;
>> +
>> +	stm32_rproc_request_shutdown(rproc);
>> +
>> +	err = tee_rproc_stop(rproc);
>> +	if (err)
>> +		return err;
>> +
>> +	return stm32_rproc_release(rproc);
>> +}
>> +
>>  static int stm32_rproc_prepare(struct rproc *rproc)
>>  {
>>  	struct device *dev = rproc->dev.parent;
>> @@ -693,8 +710,19 @@ static const struct rproc_ops st_rproc_ops = {
>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>  };
>>  
>> +static const struct rproc_ops st_rproc_tee_ops = {
>> +	.prepare	= stm32_rproc_prepare,
>> +	.start		= tee_rproc_start,
>> +	.stop		= stm32_rproc_tee_stop,
>> +	.kick		= stm32_rproc_kick,
>> +	.load		= tee_rproc_load_fw,
>> +	.parse_fw	= tee_rproc_parse_fw,
>> +	.find_loaded_rsc_table = tee_rproc_find_loaded_rsc_table,
>> +};
>> +
>>  static const struct of_device_id stm32_rproc_match[] = {
>> -	{ .compatible = "st,stm32mp1-m4" },
>> +	{.compatible = "st,stm32mp1-m4",},
>> +	{.compatible = "st,stm32mp1-m4-tee",},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>> @@ -853,6 +881,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct stm32_rproc *ddata;
>>  	struct device_node *np = dev->of_node;
>> +	struct tee_rproc *trproc = NULL;
>>  	struct rproc *rproc;
>>  	unsigned int state;
>>  	int ret;
>> @@ -861,9 +890,26 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>> -	if (!rproc)
>> -		return -ENOMEM;
>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>> +		/*
>> +		 * Delegate the firmware management to the secure context.
>> +		 * The firmware loaded has to be signed.
>> +		 */
>> +		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, sizeof(*ddata));
>> +		if (!rproc)
>> +			return -ENOMEM;
>> +
>> +		trproc = tee_rproc_register(dev, rproc, STM32_MP1_M4_PROC_ID);
>> +		if (IS_ERR(trproc)) {
>> +			dev_err_probe(dev, PTR_ERR(trproc),
>> +				      "signed firmware not supported by TEE\n");
>> +			return PTR_ERR(trproc);
>> +		}
>> +	} else {
>> +		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>> +		if (!rproc)
>> +			return -ENOMEM;
>> +	}
>>  
>>  	ddata = rproc->priv;
>>  
>> @@ -915,6 +961,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  		dev_pm_clear_wake_irq(dev);
>>  		device_init_wakeup(dev, false);
>>  	}
>> +	if (trproc)
> 
>         if (rproc->tee_interface)
> 
> 
> I am done reviewing this set.

Thank for your review!
Arnaud

> 
> Thanks,
> Mathieu
> 
>> +		tee_rproc_unregister(trproc);
>> +
>>  	return ret;
>>  }
>>  
>> @@ -935,6 +984,9 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>>  		dev_pm_clear_wake_irq(dev);
>>  		device_init_wakeup(dev, false);
>>  	}
>> +	if (rproc->tee_interface)
>> +		tee_rproc_unregister(rproc->tee_interface);
>> +
>>  }
>>  
>>  static int stm32_rproc_suspend(struct device *dev)
>> -- 
>> 2.25.1
>>

