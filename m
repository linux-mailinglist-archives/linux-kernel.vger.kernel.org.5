Return-Path: <linux-kernel+bounces-44230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBB841F28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C7E1C24581
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3770605B7;
	Tue, 30 Jan 2024 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KyI2NNjO"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112659151;
	Tue, 30 Jan 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606050; cv=none; b=Z9SIQCjjgKhs9a/PPck1m7eAAh+Kav4I7CNPLysOdknn5MDT1MoL6nD5iv5kIqEQgbu9PtW3dCM5VbLukiSGuhI5nVGu7+Pbi+4c06rTNnLeQiC0M5YnBcTP7to6rbEr0ouJ72/K/c8XbInyYAm1KneOkkr5B3wCqcPhJE2ARLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606050; c=relaxed/simple;
	bh=OQAVT7USdV8k3d4ULX+DKpgKb5XJUSnQwA1JCi3lL1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qogxOuv63IJEiiD0RsF/hXqcgPEDyGkGlZZFS2p+r5xC4CbZaRdpbtRnsRtNcnuv9BYjy8aSocg7CkMzuwnREyMQIQyla2XEURMxeDmIwkm7KNXLsKpcsa8IHctNnTx6sVJY5iCUJTzhvOyHQYv3B+O7nO7TBbM5Bajj5Vell5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KyI2NNjO; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U74qLU017764;
	Tue, 30 Jan 2024 10:13:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=dt87CNLkMt3980cHLAqyKgavtbKzWkDPS1dcS5e8/3Y=; b=Ky
	I2NNjOnDo3+K8j+jKsOw3RWwgItQniWKLKLigFeSxpW81U+AKzcVMjJkxJXrN40J
	jeJnJYIy73AoKxeCVFXdc/hs67+YxNrFVUldgEK053eDkiBQT0Rv6l3wJ9YNjrIT
	zVx2O97WKIa8R1eUv4t5AVY4+7/qR+bOOmZc3CdbU4SYKGiJOmELNYADg4sviJe+
	c0zbrSE6S3sKNbZ479JWAFzJVpJP0ktCQD7hFX60gaJL3UhrK/LM4HbOvy5l6xF9
	344cTbxIZqJDv9NMa/5b9n1/INVIcuMNZRnyaJfE9qBpEZve2Vo9jmNx3iQS9JNp
	DUSHTlHsAdQrX1LoWJ7w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vvqu8tjf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:13:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CCA60100067;
	Tue, 30 Jan 2024 10:13:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C007020B9E5;
	Tue, 30 Jan 2024 10:13:50 +0100 (CET)
Received: from [10.201.20.75] (10.201.20.75) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 30 Jan
 2024 10:13:49 +0100
Message-ID: <7ec6c9e8-9267-4e7c-81a4-abcdb2ab4239@foss.st.com>
Date: Tue, 30 Jan 2024 10:13:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Jens Wiklander
	<jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-5-arnaud.pouliquen@foss.st.com>
 <ZbPnsJm67G10+HQ3@p14s>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZbPnsJm67G10+HQ3@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_03,2024-01-29_01,2023-05-22_02



On 1/26/24 18:11, Mathieu Poirier wrote:
> On Thu, Jan 18, 2024 at 11:04:33AM +0100, Arnaud Pouliquen wrote:
>> The new TEE remoteproc device is used to manage remote firmware in a
>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>> introduced to delegate the loading of the firmware to the trusted
>> execution context. In such cases, the firmware should be signed and
>> adhere to the image format defined by the TEE.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> V1 to V2 update:
>> - remove the select "TEE_REMOTEPROC" in STM32_RPROC config as detected by
>>   the kernel test robot:
>>      WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
>>      Depends on [n]: REMOTEPROC [=y] && OPTEE [=n]
>>      Selected by [y]:
>>      - STM32_RPROC [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && REMOTEPROC [=y]
>> - Fix initialized trproc variable in  stm32_rproc_probe
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 149 +++++++++++++++++++++++++++++--
>>  1 file changed, 144 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>> index fcc0001e2657..cf6a21bac945 100644
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
>> +#define STM32_MP1_M4_PROC_ID    0
>> +
>>  struct stm32_syscon {
>>  	struct regmap *map;
>>  	u32 reg;
>> @@ -90,6 +94,8 @@ struct stm32_rproc {
>>  	struct stm32_mbox mb[MBOX_NB_MBX];
>>  	struct workqueue_struct *workqueue;
>>  	bool hold_boot_smc;
>> +	bool fw_loaded;
>> +	struct tee_rproc *trproc;
>>  	void __iomem *rsc_va;
>>  };
>>  
>> @@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc *rproc)
>>  	return err;
>>  }
>>  
>> +static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
>> +					    const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +	unsigned int ret = 0;
>> +
>> +	if (rproc->state == RPROC_DETACHED)
>> +		return 0;
>> +
>> +	ret = tee_rproc_load_fw(ddata->trproc, fw);
>> +	if (!ret)
>> +		ddata->fw_loaded = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int stm32_rproc_tee_elf_load(struct rproc *rproc,
>> +				    const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +	unsigned int ret;
>> +
>> +	/*
>> +	 * This function can be called by remote proc for recovery
>> +	 * without the sanity check. In this case we need to load the firmware
>> +	 * else nothing done here as the firmware has been preloaded for the
>> +	 * sanity check to be able to parse it for the resource table.
>> +	 */
> 
> This comment is very confusing - please consider refactoring.  
> 
>> +	if (ddata->fw_loaded)
>> +		return 0;
>> +
> 
> I'm not sure about keeping a flag to indicate the status of the loaded firmware.
> It is not done for the non-secure method, I don't see why it would be needed for
> the secure one.
> 

The difference is on the sanity check.
- in rproc_elf_sanity_check we  parse the elf file to verify that it is
valid.
- in stm32_rproc_tee_elf_sanity_check we have to do the same, that means to
authenticate it. the authentication is done during the load.

So this flag is used to avoid to reload it twice time.
refactoring the comment should help to understand this flag


An alternative would be to bypass the sanity check. But this lead to same
limitation.
Before loading the firmware in remoteproc_core, we call rproc_parse_fw() that is
used to get the resource table address. To get it from tee we need to
authenticate the firmware so load it...


>> +	ret = tee_rproc_load_fw(ddata->trproc, fw);
>> +	if (ret)
>> +		return ret;
>> +	ddata->fw_loaded = true;
>> +
>> +	/* Update the resource table parameters. */
>> +	if (rproc_tee_get_rsc_table(ddata->trproc)) {
>> +		/* No resource table: reset the related fields. */
>> +		rproc->cached_table = NULL;
>> +		rproc->table_ptr = NULL;
>> +		rproc->table_sz = 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct resource_table *
>> +stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
>> +					  const struct firmware *fw)
>> +{
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +
>> +	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
>> +}
>> +
>> +static int stm32_rproc_tee_start(struct rproc *rproc)
>> +{
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +
>> +	return tee_rproc_start(ddata->trproc);
>> +}
>> +
>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
>> +{
>> +	/* Nothing to do, remote proc already started by the secured context. */
>> +	return 0;
>> +}
>> +
>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +	int err;
>> +
>> +	stm32_rproc_request_shutdown(rproc);
>> +
>> +	err = tee_rproc_stop(ddata->trproc);
>> +	if (err)
>> +		return err;
>> +
>> +	ddata->fw_loaded = false;
>> +
>> +	return stm32_rproc_release(rproc);
>> +}
>> +
>>  static int stm32_rproc_prepare(struct rproc *rproc)
>>  {
>>  	struct device *dev = rproc->dev.parent;
>> @@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>>  
>>  static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>>  {
>> -	if (rproc_elf_load_rsc_table(rproc, fw))
>> +	struct stm32_rproc *ddata = rproc->priv;
>> +	int ret;
>> +
>> +	if (ddata->trproc)
>> +		ret = rproc_tee_get_rsc_table(ddata->trproc);
>> +	else
>> +		ret = rproc_elf_load_rsc_table(rproc, fw);
>> +	if (ret)
>>  		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
>>  
>>  	return 0;
>> @@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops = {
>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>  };
>>  
>> +static const struct rproc_ops st_rproc_tee_ops = {
>> +	.prepare	= stm32_rproc_prepare,
>> +	.start		= stm32_rproc_tee_start,
>> +	.stop		= stm32_rproc_tee_stop,
>> +	.attach		= stm32_rproc_tee_attach,
>> +	.kick		= stm32_rproc_kick,
>> +	.parse_fw	= stm32_rproc_parse_fw,
>> +	.find_loaded_rsc_table = stm32_rproc_tee_elf_find_loaded_rsc_table,
>> +	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
>> +	.sanity_check	= stm32_rproc_tee_elf_sanity_check,
>> +	.load		= stm32_rproc_tee_elf_load,
>> +};
>> +
>>  static const struct of_device_id stm32_rproc_match[] = {
>> -	{ .compatible = "st,stm32mp1-m4" },
>> +	{.compatible = "st,stm32mp1-m4",},
>> +	{.compatible = "st,stm32mp1-m4-tee",},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>> @@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct stm32_rproc *ddata;
>>  	struct device_node *np = dev->of_node;
>> +	struct tee_rproc *trproc = NULL;
>>  	struct rproc *rproc;
>>  	unsigned int state;
>>  	int ret;
>> @@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>> -	if (!rproc)
>> -		return -ENOMEM;
>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>> +		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
>> +		if (IS_ERR(trproc)) {
>> +			dev_err_probe(dev, PTR_ERR(trproc),
>> +				      "signed firmware not supported by TEE\n");
>> +			return PTR_ERR(trproc);
>> +		}
>> +		/*
>> +		 * Delegate the firmware management to the secure context.
>> +		 * The firmware loaded has to be signed.
>> +		 */
>> +		dev_info(dev, "Support of signed firmware only\n");
> 
> Not sure what this adds.  Please remove.

This is used to inform the user that only a signed firmware can be loaded, not
an ELF file.
I have a patch in my pipe to provide the supported format in the debugfs. In a
first step, I can suppress this message and we can revisit the issue when I push
the debugfs proposal.

Thanks,
Arnaud

> 
>> +	}
>> +	rproc = rproc_alloc(dev, np->name,
>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
>> +			    NULL, sizeof(*ddata));
>> +	if (!rproc) {
>> +		ret = -ENOMEM;
>> +		goto free_tee;
>> +	}
>>  
>>  	ddata = rproc->priv;
>> +	ddata->trproc = trproc;
>> +	if (trproc)
>> +		trproc->rproc = rproc;
>>  
>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>>  
>> @@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  		device_init_wakeup(dev, false);
>>  	}
>>  	rproc_free(rproc);
>> +free_tee:
>> +	if (trproc)
>> +		tee_rproc_unregister(trproc);
>> +
>>  	return ret;
>>  }
>>  
>> @@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>>  		device_init_wakeup(dev, false);
>>  	}
>>  	rproc_free(rproc);
>> +	if (ddata->trproc)
>> +		tee_rproc_unregister(ddata->trproc);
>>  }
>>  
>>  static int stm32_rproc_suspend(struct device *dev)
>> -- 
>> 2.25.1
>>

