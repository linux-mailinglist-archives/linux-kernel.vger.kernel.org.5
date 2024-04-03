Return-Path: <linux-kernel+bounces-129121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ADF89654B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415ED283E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3B548E0;
	Wed,  3 Apr 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BxEU8nsi"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C017BC2;
	Wed,  3 Apr 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127953; cv=none; b=C1LHnf0ShPv7CaG6Eie9AdPNYkYj9IjB8n66IxmP4tlZQEfRAuzCbn7i0qrFV4fFlUBrtgkdQg8BkYbw+oOqsOjedEwVSUJ3YM3DuyRZiyHAkfRkJnoKYNUV4//niMVEAT/d7dI9adkSZVWFd1VbFfPs6rJ4EDORf2qpnzhVcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127953; c=relaxed/simple;
	bh=JX3xv30Fh/dlb45h1AhPGtNRiRdxzdUrMYjjSgZdUH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W+8JfnpS0s777T/Mn3aYYNGtdOuQNfZ4oa0q/N7QMUlDGwgFvDbfAC64kzal5WaBBKNgcKFH/GJoWHHFPL5aq15Macc5oWxVcm3IKqooXLDCiE7Z3F4dInOIJIBoer9D3na80T1Nrqv6cQk3zaG/oqKYrwVyP3WbKoSpuQimm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BxEU8nsi; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4336x1Vn017098;
	Wed, 3 Apr 2024 09:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=DCUbKNbF474gC8lSGkhmcz5s3IeyLZ0AClzAIHxg1FI=; b=Bx
	EU8nsi6DU64tznn8b2K4Ofd6OEfjKTmmTuvyiPn6a9seHJ1JkmOwT9wM74I0sBwY
	edU2UjRsXbao30fSddAQnHboyDtG87H2GX7zuN7EM4IrY2MSFKQigjK6F5dLLt0v
	sR7JsZqRS+v71LRUGq52fmFG6YWZK5/4kpX7J7kLnGzlcXzJM3KrAUJuQLz2wXNJ
	+ljO5f8f+Y/Ih1XIU6YF19tBCnhw7+sootbgLNaAgvMie6TRHo30Wa2TO9+LhbWV
	1HmqYIle5pdGrEE1Ozrc4ZylRlsmxLAe9UOCy9jdxh6j6GkyCJJR0E3YRKwHyVKJ
	LsioAICav4OdSTne1FCw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x6aggygkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 09:05:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A2DF24002D;
	Wed,  3 Apr 2024 09:05:16 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20FF32105B0;
	Wed,  3 Apr 2024 09:04:27 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 3 Apr
 2024 09:04:26 +0200
Received: from [10.201.21.20] (10.201.21.20) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 3 Apr
 2024 09:04:26 +0200
Message-ID: <7080443a-e06b-45e1-a57a-3f90b2fad07f@foss.st.com>
Date: Wed, 3 Apr 2024 09:04:25 +0200
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
 <a08add21-b8ff-434a-9689-6af8b05b1965@foss.st.com> <ZgRT7PtzIogAWc50@p14s>
 <2cd23e93-1a3a-4128-b947-35fe2b04ccab@foss.st.com> <ZgrW2avODv29vWNP@p14s>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZgrW2avODv29vWNP@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02



On 4/1/24 17:46, Mathieu Poirier wrote:
> On Fri, Mar 29, 2024 at 11:57:43AM +0100, Arnaud POULIQUEN wrote:
>>
>>
>> On 3/27/24 18:14, Mathieu Poirier wrote:
>>> On Tue, Mar 26, 2024 at 08:31:33PM +0100, Arnaud POULIQUEN wrote:
>>>>
>>>>
>>>> On 3/25/24 17:51, Mathieu Poirier wrote:
>>>>> On Fri, Mar 08, 2024 at 03:47:08PM +0100, Arnaud Pouliquen wrote:
>>>>>> The new TEE remoteproc device is used to manage remote firmware in a
>>>>>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>>>>>> introduced to delegate the loading of the firmware to the trusted
>>>>>> execution context. In such cases, the firmware should be signed and
>>>>>> adhere to the image format defined by the TEE.
>>>>>>
>>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>>>> ---
>>>>>> Updates from V3:
>>>>>> - remove support of the attach use case. Will be addressed in a separate
>>>>>>   thread,
>>>>>> - add st_rproc_tee_ops::parse_fw ops,
>>>>>> - inverse call of devm_rproc_alloc()and tee_rproc_register() to manage cross
>>>>>>   reference between the rproc struct and the tee_rproc struct in tee_rproc.c.
>>>>>> ---
>>>>>>  drivers/remoteproc/stm32_rproc.c | 60 +++++++++++++++++++++++++++++---
>>>>>>  1 file changed, 56 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>>>>>> index 8cd838df4e92..13df33c78aa2 100644
>>>>>> --- a/drivers/remoteproc/stm32_rproc.c
>>>>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>>>>> @@ -20,6 +20,7 @@
>>>>>>  #include <linux/remoteproc.h>
>>>>>>  #include <linux/reset.h>
>>>>>>  #include <linux/slab.h>
>>>>>> +#include <linux/tee_remoteproc.h>
>>>>>>  #include <linux/workqueue.h>
>>>>>>  
>>>>>>  #include "remoteproc_internal.h"
>>>>>> @@ -49,6 +50,9 @@
>>>>>>  #define M4_STATE_STANDBY	4
>>>>>>  #define M4_STATE_CRASH		5
>>>>>>  
>>>>>> +/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */
>>>>>
>>>>> Why is this the case?  At least from the kernel side it is possible to call
>>>>> tee_rproc_register() with any kind of value, why is there a need to be any
>>>>> kind of alignment with the TEE?
>>>>
>>>>
>>>> The use of the proc_id is to identify a processor in case of multi co-processors.
>>>>
>>>
>>> That is well understood.
>>>
>>>> For instance we can have a system with A DSP and a modem. We would use the same
>>>> TEE service, but
>>>
>>> That too.
>>>
>>>> the TEE driver will probably be different, same for the signature key.
>>>
>>> What TEE driver are we talking about here?
>>
>> In OP-TEE remoteproc frameork is divided in 2 or  3 layers:
>>
>> - the remoteproc Trusted Application (TA) [1] which is platform agnostic
>> - The remoteproc Pseudo Trusted Application (PTA) [2] which is platform
>> dependent and can rely on the proc ID to retrieve the context.
>> - the remoteproc driver (optional for some platforms) [3], which is in charge
>>  of DT parsing and platform configuration.
>>
> 
> That part makes sense.
> 
>> Here TEE driver can be interpreted by remote PTA and/or platform driver.
>>
> 
> I have to guess PTA means "Platform Trusted Application" but I have no
> guarantee, adding to the level of (already high) confusion brought on by this
> patchset.

As mentioned above, PTA is Pseudo Trusted Application. It is an interface
exposed by OP-TEE core to the OP-TEE application.
In this case PTA is used to implement the platform part.
If you need more details about the remoteproc framework in OP-TEE, there is a
link in the to a presentation in the cover letter.

> 
>> [1]
>> https://elixir.bootlin.com/op-tee/latest/source/ta/remoteproc/src/remoteproc_core.c
>> [2]
>> https://elixir.bootlin.com/op-tee/latest/source/core/pta/stm32mp/remoteproc_pta.c
>> [3]
>> https://elixir.bootlin.com/op-tee/latest/source/core/drivers/remoteproc/stm32_remoteproc.c
>>
>>>
>>>> In such case the proc ID allows to identify the the processor you want to address.
>>>>
>>>
>>> That too is well understood, but there is no alignment needed with the TEE, i.e
>>> the TEE application is not expecting a value of '0'.  We could set
>>> STM32_MP1_M4_PROC_ID to 0xDEADBEEF and things would work.  This driver won't go
>>> anywhere for as long as it is not the case.
>>
>>
>> Here I suppose that you do not challenge the rproc_ID use in general, but for
>> the stm32mp1 platform as we have only one remote processor. I'm right?
> 
> That is correct - I understand the need for an rproc_ID.  The problem is with
> the comment that states that '0' is aligned with the TEE definitions, which in
> my head means hard coded value and a big red flag.  What it should say is
> "aligned with the TEE device tree definition". 
> 
>>
>> In OP-TEE the check is done here:
>> https://elixir.bootlin.com/op-tee/latest/source/core/drivers/remoteproc/stm32_remoteproc.c#L64
>>
>> If driver does not register the proc ID an error is returned indicating that the
>> feature is not supported.
>>
>> In case of stm32mp1 yes we could consider it as useless as we have only one
>> remote proc.
>>
>> Nevertheless I can not guaranty that a customer will not add an external
>> companion processor that uses OP-TEE to authenticate the associated firmware. As
>> the trusted Application is the unique entry point. he will need the proc_id to
>> identify the target at PTA level.
>>
>> So from my point of view having a proc ID on stm32MP1 (and on stm32mp2 that will
>> reuse same driver) aligned between Linux and OP-TEE is useful.
> 
> I agree, for as long as it is not hard coded.  The way remote processors are
> discovered in the DT is perfectly acceptable, i.e the first remote processor is
> for application X, the second for application Y...
> 
>>
>> That said using a TEE_REMOTEPROC_DEFAULT_ID is something that could be
>> more generic (for linux and OP-TEE). This ID could be reuse in the stm32mp
>> driver and platform drivers with an unique internal remote processor.
>>
> 
> I can't find the definition of TEE_REMOTEPROC_DEFAULT_ID anywhere, something
> that doesn't help the confusion I referred to above.

The TEE_REMOTEPROC_DEFAULT_ID does not yet exist; it is a proposal.

Nevertheless I also had in mind the addition of a "proc ID" property in the DT.
I will proceed in this way

I think I now have all the information needed to prepare a new revision.
Thanks for the time passed on this series and your advises
Regards,
Arnaud


> 
>> It that solution would be ok for you?
>>
>> Regards,
>> Arnaud
>>
>>
>>>
>>>>
>>>>>
>>>>>> +#define STM32_MP1_M4_PROC_ID    0
>>>>>> +
>>>>>>  struct stm32_syscon {
>>>>>>  	struct regmap *map;
>>>>>>  	u32 reg;
>>>>>> @@ -257,6 +261,19 @@ static int stm32_rproc_release(struct rproc *rproc)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
>>>>>> +{
>>>>>> +	int err;
>>>>>> +
>>>>>> +	stm32_rproc_request_shutdown(rproc);
>>>>>> +
>>>>>> +	err = tee_rproc_stop(rproc);
>>>>>> +	if (err)
>>>>>> +		return err;
>>>>>> +
>>>>>> +	return stm32_rproc_release(rproc);
>>>>>> +}
>>>>>> +
>>>>>>  static int stm32_rproc_prepare(struct rproc *rproc)
>>>>>>  {
>>>>>>  	struct device *dev = rproc->dev.parent;
>>>>>> @@ -693,8 +710,19 @@ static const struct rproc_ops st_rproc_ops = {
>>>>>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>>>>  };
>>>>>>  
>>>>>> +static const struct rproc_ops st_rproc_tee_ops = {
>>>>>> +	.prepare	= stm32_rproc_prepare,
>>>>>> +	.start		= tee_rproc_start,
>>>>>> +	.stop		= stm32_rproc_tee_stop,
>>>>>> +	.kick		= stm32_rproc_kick,
>>>>>> +	.load		= tee_rproc_load_fw,
>>>>>> +	.parse_fw	= tee_rproc_parse_fw,
>>>>>> +	.find_loaded_rsc_table = tee_rproc_find_loaded_rsc_table,
>>>>>> +};
>>>>>> +
>>>>>>  static const struct of_device_id stm32_rproc_match[] = {
>>>>>> -	{ .compatible = "st,stm32mp1-m4" },
>>>>>> +	{.compatible = "st,stm32mp1-m4",},
>>>>>> +	{.compatible = "st,stm32mp1-m4-tee",},
>>>>>>  	{},
>>>>>>  };
>>>>>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>>>>>> @@ -853,6 +881,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>>>>>  	struct device *dev = &pdev->dev;
>>>>>>  	struct stm32_rproc *ddata;
>>>>>>  	struct device_node *np = dev->of_node;
>>>>>> +	struct tee_rproc *trproc = NULL;
>>>>>>  	struct rproc *rproc;
>>>>>>  	unsigned int state;
>>>>>>  	int ret;
>>>>>> @@ -861,9 +890,26 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>>>>>  	if (ret)
>>>>>>  		return ret;
>>>>>>  
>>>>>> -	rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>>>>>> -	if (!rproc)
>>>>>> -		return -ENOMEM;
>>>>>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>>>>>> +		/*
>>>>>> +		 * Delegate the firmware management to the secure context.
>>>>>> +		 * The firmware loaded has to be signed.
>>>>>> +		 */
>>>>>> +		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, sizeof(*ddata));
>>>>>> +		if (!rproc)
>>>>>> +			return -ENOMEM;
>>>>>> +
>>>>>> +		trproc = tee_rproc_register(dev, rproc, STM32_MP1_M4_PROC_ID);
>>>>>> +		if (IS_ERR(trproc)) {
>>>>>> +			dev_err_probe(dev, PTR_ERR(trproc),
>>>>>> +				      "signed firmware not supported by TEE\n");
>>>>>> +			return PTR_ERR(trproc);
>>>>>> +		}
>>>>>> +	} else {
>>>>>> +		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>>>>>> +		if (!rproc)
>>>>>> +			return -ENOMEM;
>>>>>> +	}
>>>>>>  
>>>>>>  	ddata = rproc->priv;
>>>>>>  
>>>>>> @@ -915,6 +961,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>>>>>  		dev_pm_clear_wake_irq(dev);
>>>>>>  		device_init_wakeup(dev, false);
>>>>>>  	}
>>>>>> +	if (trproc)
>>>>>
>>>>>         if (rproc->tee_interface)
>>>>>
>>>>>
>>>>> I am done reviewing this set.
>>>>
>>>> Thank for your review!
>>>> Arnaud
>>>>
>>>>>
>>>>> Thanks,
>>>>> Mathieu
>>>>>
>>>>>> +		tee_rproc_unregister(trproc);
>>>>>> +
>>>>>>  	return ret;
>>>>>>  }
>>>>>>  
>>>>>> @@ -935,6 +984,9 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>>>>>>  		dev_pm_clear_wake_irq(dev);
>>>>>>  		device_init_wakeup(dev, false);
>>>>>>  	}
>>>>>> +	if (rproc->tee_interface)
>>>>>> +		tee_rproc_unregister(rproc->tee_interface);
>>>>>> +
>>>>>>  }
>>>>>>  
>>>>>>  static int stm32_rproc_suspend(struct device *dev)
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>

