Return-Path: <linux-kernel+bounces-78432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43486136B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6799B24BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F080047;
	Fri, 23 Feb 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TlNHI5wY"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0637EEEF;
	Fri, 23 Feb 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696543; cv=none; b=Ez2J54wQumxrydvxUSLIPlZjJ6x4wNnT28the6XXPoysY+K+YgCYJcKgfuOtqV2HKhAVreLzuVhEOX4JHqzm2Y7E6J9I/XtHD+Be30DGlseewVQsqXWQy34U6oCtxlFiF40QB083s/NBP3u6p6IdBY4UeOkkUNtcEVkEaCrhKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696543; c=relaxed/simple;
	bh=WNzaMmfhNuKJTH3fauBAcg3xbUwTmJr3tsSzrljKW7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QyOCLLgyamYZ23wqKDOUnmKPPnF6vCttRsM1UpgeqCjjupPluz4v6BoQ2EsrKOg1cl2kby5fop1ngt9va0OzgSqCrp3g1ksxAPF7Dbc9y7Pu7MODvaAsK1z4x9+E07rxkK0XiNYc54jdZ5lbdx2fs1+KL0LP4AZKwCImB34EkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TlNHI5wY; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NCsUoU027885;
	Fri, 23 Feb 2024 14:55:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Etr8q078NuutlMXhOaszpwHP5/sGDLIT8y4V0nRB7O0=; b=Tl
	NHI5wYnYr2lahYu1V09COvAyYGQScHeYdi3BKHQHTMXmKWziJ8sIszqubLbH23po
	DCWJam7HBRVOw2KlPo0t+yBF+3UzVaGi50LUVXvJbhKIGDoqT2BhdzhHSec7JxND
	ouCQlHYlnoYtxzc/I13Jnhsio5r+2XUc0sMO1mti+v2lciOu64sK9hptzwYjlveL
	t3QDyAbJz/R5PjKaRxpTCBP5pNxGDytYMB9whsyxqK2+SjgaUZmHsBFnGJCtdG92
	sL48qabmTI3i0Q/0v2FtkEdlKQpCE+4X9YzSiVLP11Svy/3+6QRinbCHvekkggU7
	SbYHHczVJdgch+hfmJOQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd201w6x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:55:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 394A740044;
	Fri, 23 Feb 2024 14:55:04 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 69F612A0A29;
	Fri, 23 Feb 2024 14:54:14 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 14:54:14 +0100
Received: from [10.252.31.57] (10.252.31.57) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 14:54:13 +0100
Message-ID: <609373ba-c81d-4aee-81cb-8628e2c6897b@foss.st.com>
Date: Fri, 23 Feb 2024 14:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
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
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <20240214172127.1022199-8-arnaud.pouliquen@foss.st.com>
 <ZdeaUGpWlqGOG31u@p14s>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZdeaUGpWlqGOG31u@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02

Hello Mathieu,

On 2/22/24 20:02, Mathieu Poirier wrote:
> Hi,
> 
> On Wed, Feb 14, 2024 at 06:21:27PM +0100, Arnaud Pouliquen wrote:
>> The new TEE remoteproc device is used to manage remote firmware in a
>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>> introduced to delegate the loading of the firmware to the trusted
>> execution context. In such cases, the firmware should be signed and
>> adhere to the image format defined by the TEE.
>>
>> A new "to_attach" field is introduced to differentiate the use cases
>> "firmware loaded by the boot stage" and "firmware loaded by the TEE".
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> V2 to V3 update:
>> - remove stm32_rproc_tee_elf_sanity_check(), stm32_rproc_tee_elf_load()
>>   stm32_rproc_tee_elf_find_loaded_rsc_table() and  stm32_rproc_tee_start() that are bnow unused
>> - use new rproc::alt_boot field to sepcify that the alternate fboot method is used
>> - use stm32_rproc::to_attach field to differenciate attch mode from remoteproc tee boot mode.
>> - remove the used of stm32_rproc::fw_loaded
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 85 +++++++++++++++++++++++++++++---
>>  1 file changed, 79 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>> index fcc0001e2657..9cfcf66462e0 100644
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
>> +	bool to_attach;
>> +	struct tee_rproc *trproc;
>>  	void __iomem *rsc_va;
>>  };
>>  
>> @@ -253,10 +259,30 @@ static int stm32_rproc_release(struct rproc *rproc)
>>  			return err;
>>  		}
>>  	}
>> +	ddata->to_attach = false;
>>  
>>  	return err;
>>  }
>>  
>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
>> +{
>> +	/* Nothing to do, remote proc already started by the secured context. */
>> +	return 0;
>> +}
>> +
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
>> @@ -637,10 +663,14 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>>  {
>>  	struct stm32_rproc *ddata = rproc->priv;
>>  	struct device *dev = rproc->dev.parent;
>> +	struct tee_rproc *trproc = ddata->trproc;
>>  	phys_addr_t rsc_pa;
>>  	u32 rsc_da;
>>  	int err;
>>  
>> +	if (trproc && !ddata->to_attach)
>> +		return tee_rproc_get_loaded_rsc_table(rproc, table_sz);
>> +
> 
> Why do we need a flag at all?  Why can't st_rproc_tee_ops::get_loaded_rsc_table
> be set to tee_rproc_get_loaded_rsc_table()?


This function is used to retrieve the address of the resource table in 3 cases
- attach to a firmware started by the boot loader (U-boot).
- load of the firmware by OP-TEE.
- crash recovery on a signed firmware started by the boot loader.

The flag is used to differentiate the attch from the other uses cases
For instance we support this use case.
1) attach to the firmware on boot
2) crash during runtime
  2a) stop the firmware by OP-TEE( ddata->to_attach set to 0)
  2b) load the firmware by OP-TEE
  2c) get the loaded resource table from OP-TEE (we can not guaranty
      that the firmware loaded on recovery is the same)
  2d) restart the firmware by OP-TEE

> 
>>  	/* The resource table has already been mapped, nothing to do */
>>  	if (ddata->rsc_va)
>>  		goto done;
>> @@ -693,8 +723,20 @@ static const struct rproc_ops st_rproc_ops = {
>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>  };
>>  
>> +static const struct rproc_ops st_rproc_tee_ops = {
>> +	.prepare	= stm32_rproc_prepare,
>> +	.start		= tee_rproc_start,
>> +	.stop		= stm32_rproc_tee_stop,
>> +	.attach		= stm32_rproc_tee_attach,
>> +	.kick		= stm32_rproc_kick,
>> +	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
>> +	.find_loaded_rsc_table = tee_rproc_find_loaded_rsc_table,
>> +	.load		= tee_rproc_load_fw,
>> +};
>> +
>>  static const struct of_device_id stm32_rproc_match[] = {
>> -	{ .compatible = "st,stm32mp1-m4" },
>> +	{.compatible = "st,stm32mp1-m4",},
>> +	{.compatible = "st,stm32mp1-m4-tee",},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>> @@ -853,6 +895,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct stm32_rproc *ddata;
>>  	struct device_node *np = dev->of_node;
>> +	struct tee_rproc *trproc = NULL;
>>  	struct rproc *rproc;
>>  	unsigned int state;
>>  	int ret;
>> @@ -861,12 +904,33 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>> -	if (!rproc)
>> -		return -ENOMEM;
> 
> This patch doesn't apply to rproc-next - please rebase.

Yes, sure. I forgot to mention in my cover letter that my series has been
applied and tested on 841c35169323 (Linux 6.8-rc4).

> 
> 
>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>> +		/*
>> +		 * Delegate the firmware management to the secure context.
>> +		 * The firmware loaded has to be signed.
>> +		 */
>> +		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
>> +		if (IS_ERR(trproc)) {
>> +			dev_err_probe(dev, PTR_ERR(trproc),
>> +				      "signed firmware not supported by TEE\n");
>> +			return PTR_ERR(trproc);
>> +		}
>> +	}
>>  
>> -	ddata = rproc->priv;
>> +	rproc = rproc_alloc(dev, np->name,
>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
>> +			    NULL, sizeof(*ddata));
>> +	if (!rproc) {
>> +		ret = -ENOMEM;
>> +		goto free_tee;
>> +	}
>>  
>> +	ddata = rproc->priv;
>> +	ddata->trproc = trproc;
> 
> My opinion hasn't changed from the previous patchet, i.e tee_rproc should be
> folded in struct rproc as rproc::tee_interface.

Sure, I will do it in next version

> 
> More comments to come shortly...
> 

Thanks!
Arnaud

>> +	if (trproc) {
>> +		rproc->alt_boot = true;
>> +		trproc->rproc = rproc;
>> +	}
>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>>  
>>  	ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
>> @@ -881,8 +945,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto free_rproc;
>>  
>> -	if (state == M4_STATE_CRUN)
>> +	if (state == M4_STATE_CRUN) {
>>  		rproc->state = RPROC_DETACHED;
>> +		ddata->to_attach = true;
>> +	}
>>  
>>  	rproc->has_iommu = false;
>>  	ddata->workqueue = create_workqueue(dev_name(dev));
>> @@ -916,6 +982,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
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
>> @@ -923,6 +993,7 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>>  {
>>  	struct rproc *rproc = platform_get_drvdata(pdev);
>>  	struct stm32_rproc *ddata = rproc->priv;
>> +	struct tee_rproc *trproc = ddata->trproc;
>>  	struct device *dev = &pdev->dev;
>>  
>>  	if (atomic_read(&rproc->power) > 0)
>> @@ -937,6 +1008,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>>  		device_init_wakeup(dev, false);
>>  	}
>>  	rproc_free(rproc);
>> +	if (trproc)
>> +		tee_rproc_unregister(trproc);
>>  }
>>  
>>  static int stm32_rproc_suspend(struct device *dev)
>> -- 
>> 2.25.1
>>
> 

