Return-Path: <linux-kernel+bounces-52273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A504C849620
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1CE281CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2F125B8;
	Mon,  5 Feb 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cE1LxpXk"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33463125A5;
	Mon,  5 Feb 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124459; cv=none; b=uFDfox5+878L3iCt6E8VHJ81P7TFMtmZdGPP/mR+vobJ7+Dbh8E3xybKJkH1oDFit1RUWbWLUISqL56InYKNarcaTguwO3NXID+LXY9jzGAHKTt7b6NhtBXHRoRHCwPiPv1aIW7p9BkM4vJjfrh7LzQs4OlvLlVLLmkgI/pMGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124459; c=relaxed/simple;
	bh=S3j0g6Q8yq6CWK5WrKwmt7WJP9NwO+lgTgzeSE7ywBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RdMuQozogjA+ToYClqe0HCXWSo+a3qVzl21rpO96mafxn2FOxzDaRzXgNMb/up5vtxn0dhIRbpHUFVXWHaU+qFg1N87FYsoRYCaa8AUP1omx1YmZdhA/w/2xQAuCeGEc/QwZi3fz7wsA924+KwxmEdB1ATvHxVacnfUFEIwUZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cE1LxpXk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158Mr6o002797;
	Mon, 5 Feb 2024 10:13:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=VAh/uHcHwPdL2VygqCfob3rT3K0TxGoaYXGdBzqrQk0=; b=cE
	1LxpXkd1OEZyGRDcnh9Zoj6ZGW6OQk6FHn3lNhgzpo4Omd0v2NxVJm/LCDvCViNr
	u6FRq39LDWaFZjY2fmkVGnsM0YK9Gni6T16UBvIeVP2pj5JyBc3izQEnLLwjTGFU
	Fq0idwwBy5Up9lvjJ+cv5rwp0DQYlVEj2ZekLs33jplPTHfTRNeU+1DOziPXHv3X
	lVBB/FbVIvMj6lJHgnSP9prfum9RY5wP1kwpqEdNC/lcujD6lb1+j+e6piyNhW6i
	u0xjvMoiWuSTEA9ehPAMFnPpX2c4e2ICUW3/hUg0hRcVpZEGDUfrx+qRUzT0h0oi
	nOIk+EEHlkvC4uSb93Cg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1f63dw2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:13:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC2BC100064;
	Mon,  5 Feb 2024 10:13:44 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF8112A06C4;
	Mon,  5 Feb 2024 10:13:44 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 10:13:44 +0100
Received: from [10.201.20.75] (10.201.20.75) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 10:13:43 +0100
Message-ID: <36c0368b-94f3-40bd-9273-33ab2c9bf913@foss.st.com>
Date: Mon, 5 Feb 2024 10:13:43 +0100
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
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-5-arnaud.pouliquen@foss.st.com>
 <ZbPnsJm67G10+HQ3@p14s> <7ec6c9e8-9267-4e7c-81a4-abcdb2ab4239@foss.st.com>
 <ZbqW5YfDmEWG4G1X@p14s> <8ede77bb-0fbc-4de2-b51b-67674744b551@foss.st.com>
 <ZbvAmxHscnbUQGOD@p14s> <a52e00c5-fb60-4a9e-85ff-0f9649850f48@foss.st.com>
 <Zb1IPlnbMp9Utu2y@p14s>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <Zb1IPlnbMp9Utu2y@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02



On 2/2/24 20:53, Mathieu Poirier wrote:
> On Thu, Feb 01, 2024 at 07:33:35PM +0100, Arnaud POULIQUEN wrote:
>>
>>
>> On 2/1/24 17:02, Mathieu Poirier wrote:
>>> On Thu, Feb 01, 2024 at 04:06:37PM +0100, Arnaud POULIQUEN wrote:
>>>> hello Mathieu,
>>>>
>>>> On 1/31/24 19:52, Mathieu Poirier wrote:
>>>>> On Tue, Jan 30, 2024 at 10:13:48AM +0100, Arnaud POULIQUEN wrote:
>>>>>>
>>>>>>
>>>>>> On 1/26/24 18:11, Mathieu Poirier wrote:
>>>>>>> On Thu, Jan 18, 2024 at 11:04:33AM +0100, Arnaud Pouliquen wrote:
>>>>>>>> The new TEE remoteproc device is used to manage remote firmware in a
>>>>>>>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
>>>>>>>> introduced to delegate the loading of the firmware to the trusted
>>>>>>>> execution context. In such cases, the firmware should be signed and
>>>>>>>> adhere to the image format defined by the TEE.
>>>>>>>>
>>>>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>>>>>> ---
>>>>>>>> V1 to V2 update:
>>>>>>>> - remove the select "TEE_REMOTEPROC" in STM32_RPROC config as detected by
>>>>>>>>   the kernel test robot:
>>>>>>>>      WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
>>>>>>>>      Depends on [n]: REMOTEPROC [=y] && OPTEE [=n]
>>>>>>>>      Selected by [y]:
>>>>>>>>      - STM32_RPROC [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && REMOTEPROC [=y]
>>>>>>>> - Fix initialized trproc variable in  stm32_rproc_probe
>>>>>>>> ---
>>>>>>>>  drivers/remoteproc/stm32_rproc.c | 149 +++++++++++++++++++++++++++++--
>>>>>>>>  1 file changed, 144 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>>>>>>>> index fcc0001e2657..cf6a21bac945 100644
>>>>>>>> --- a/drivers/remoteproc/stm32_rproc.c
>>>>>>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>>>>>>> @@ -20,6 +20,7 @@
>>>>>>>>  #include <linux/remoteproc.h>
>>>>>>>>  #include <linux/reset.h>
>>>>>>>>  #include <linux/slab.h>
>>>>>>>> +#include <linux/tee_remoteproc.h>
>>>>>>>>  #include <linux/workqueue.h>
>>>>>>>>  
>>>>>>>>  #include "remoteproc_internal.h"
>>>>>>>> @@ -49,6 +50,9 @@
>>>>>>>>  #define M4_STATE_STANDBY	4
>>>>>>>>  #define M4_STATE_CRASH		5
>>>>>>>>  
>>>>>>>> +/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */
>>>>>>>> +#define STM32_MP1_M4_PROC_ID    0
>>>>>>>> +
>>>>>>>>  struct stm32_syscon {
>>>>>>>>  	struct regmap *map;
>>>>>>>>  	u32 reg;
>>>>>>>> @@ -90,6 +94,8 @@ struct stm32_rproc {
>>>>>>>>  	struct stm32_mbox mb[MBOX_NB_MBX];
>>>>>>>>  	struct workqueue_struct *workqueue;
>>>>>>>>  	bool hold_boot_smc;
>>>>>>>> +	bool fw_loaded;
>>>>>>>> +	struct tee_rproc *trproc;
>>>>>>>>  	void __iomem *rsc_va;
>>>>>>>>  };
>>>>>>>>  
>>>>>>>> @@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc *rproc)
>>>>>>>>  	return err;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
>>>>>>>> +					    const struct firmware *fw)
>>>>>>>> +{
>>>>>>>> +	struct stm32_rproc *ddata = rproc->priv;
>>>>>>>> +	unsigned int ret = 0;
>>>>>>>> +
>>>>>>>> +	if (rproc->state == RPROC_DETACHED)
>>>>>>>> +		return 0;
>>>>>>>> +
>>>>>>>> +	ret = tee_rproc_load_fw(ddata->trproc, fw);
>>>>>>>> +	if (!ret)
>>>>>>>> +		ddata->fw_loaded = true;
>>>>>>>> +
>>>>>>>> +	return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int stm32_rproc_tee_elf_load(struct rproc *rproc,
>>>>>>>> +				    const struct firmware *fw)
>>>>>>>> +{
>>>>>>>> +	struct stm32_rproc *ddata = rproc->priv;
>>>>>>>> +	unsigned int ret;
>>>>>>>> +
>>>>>>>> +	/*
>>>>>>>> +	 * This function can be called by remote proc for recovery
>>>>>>>> +	 * without the sanity check. In this case we need to load the firmware
>>>>>>>> +	 * else nothing done here as the firmware has been preloaded for the
>>>>>>>> +	 * sanity check to be able to parse it for the resource table.
>>>>>>>> +	 */
>>>>>>>
>>>>>>> This comment is very confusing - please consider refactoring.  
>>>>>>>
>>>>>>>> +	if (ddata->fw_loaded)
>>>>>>>> +		return 0;
>>>>>>>> +
>>>>>>>
>>>>>>> I'm not sure about keeping a flag to indicate the status of the loaded firmware.
>>>>>>> It is not done for the non-secure method, I don't see why it would be needed for
>>>>>>> the secure one.
>>>>>>>
>>>>>>
>>>>>> The difference is on the sanity check.
>>>>>> - in rproc_elf_sanity_check we  parse the elf file to verify that it is
>>>>>> valid.
>>>>>> - in stm32_rproc_tee_elf_sanity_check we have to do the same, that means to
>>>>>> authenticate it. the authentication is done during the load.
>>>>>>
>>>>>> So this flag is used to avoid to reload it twice time.
>>>>>> refactoring the comment should help to understand this flag
>>>>>>
>>>>>>
>>>>>> An alternative would be to bypass the sanity check. But this lead to same
>>>>>> limitation.
>>>>>> Before loading the firmware in remoteproc_core, we call rproc_parse_fw() that is
>>>>>> used to get the resource table address. To get it from tee we need to
>>>>>> authenticate the firmware so load it...
>>>>>>
>>>>>
>>>>> I spent a long time thinking about this patchset.  Looking at the code as it
>>>>> is now, request_firmware() in rproc_boot() is called even when the TEE is
>>>>> responsible for loading the firmware.  There should be some conditional code
>>>>> that calls either request_firmware() or tee_rproc_load_fw().  The latter should
>>>>> also be renamed to tee_rproc_request_firmware() to avoid confusion.
>>>>
>>>>
>>>> The request_firmware() call is needed in both cases to get the image from the
>>>> filesystem. The tee_rproc_load_fw() gets, as input, the struct firmware provided
>>>> by request_firmware().
>>>
>>> The cover letter clearly state the secure side is responsible for loading the
>>> firmware image but here you're telling me it has to be loaded twice.  This is
>>> very confusing.
>>
>> Concerning the call of request_firmware()
>>
>> By "both cases" I would say that the call of request_firmware() is needed in
>> both modes:
>> - the ELF firmware is parsed and loaded by linux (legacy)
>> - the binary firmware is parsed and loaded by OP-TEE.
>>
>> The Op-TEE is not able to get the firmware image from the file system.
>>
>>
>> Concerning the call of tee_rproc_load_fw twice time
>>
>> There are 2 use cases:
>>
>> - First boot of the remote processor:
>>
>>   1) The Linux rproc gets the binary firmware image from the file system by
>>      calling  request_firmware(). A copy is stored in memory.
> 
> Right.  And I think tee_rproc_load_fw() should be called right after
> request_firmware() if rproc::tee_rproc_interface is valid.  At that point the TEE
> app may or may not do the firmware authentication, that is application specific.
> 
>>   2) the linux performs a sanity check on the firmware calling
>>      rproc_fw_sanity_check()
>> 	=> from OP-TEE point of view this means to autenticate the firmware
>> 	=> let consider in this exemple that we bypass this step
>>            (ops->sanity_check = NULL)
> 
> Ok
> 
>> 		
>>   3) the linux rproc call rproc_parse_fw() to get the resource table
>> 	=> From OP-TEE point of view the resource table is available only when
>>            the firmware is loaded
> 
> Right, and it should have been loaded already.  If it is not then the TEE should
> return an error.
> 
>> 	=> We need to call tee_rproc_load_fw() to be able then to get the
>>            address of the resource table.
> 
> See my comment above - at this point the TEE should already have the firmware.
> As such the only thing left is to get the address of the resource table, which
> you already do in rproc_tee_get_rsc_table().  The upper part of that function
> should be spun off in a new static function to deal with the TEE API, something
> like _rproc_tee_get_rsc_table().  The new function should also be called in
> tee_rproc_get_loaded_rsc_table() rather than keeping a cache value in
> trproc->rsc_va.
> 
>>   4) The Linux rproc calls rproc_handle_resources() to parse the resource table.
>>   5) The linux rproc calls rproc_start()
>> 	- load the firrmware calling rproc_load_segments()
>> 		=> we don't want to call tee_rproc_load_fw() it a second time
> 
> And that is fine if the TEE app has already placed the program segments in
> memory.
> 
>> 	- start the firmware calling ops->start()
>>
>> - Reboot on crash recovery using rproc_boot_recovery()
>>
>>   1)  The Linux rproc gets the binary firmware image from the file system by
>>      calling request_firmware(). A copy is stored in memory.
>>   5) The linux rproc calls rproc_start()
>> 	- load the firrmware calling rproc_load_segments()
>> 		=> we have to call tee_rproc_load_fw() to reload the firmware
> 
> Loading the firmware in the TEE should be done right after request_firmware()
> has been called, the same way it is done in the boot path.  If there isn't a
> need to reload the TEE firmware than the TEE application should ignore the
> request.

I need to prototype to verify this proposal.
I will come back with a V3.

Thank you for the advice and review!

Regard,
Arnaud

> 
>> 	- start the firmware calling ops->start()
>>
>> In first use case we have to load the firmware on rproc_parse_fw(), in second
>> usecase on rproc_load_segments().
>>
>> This is the point I have tried to solve with the ddata->fw_loaded variable.
>>
>>>
>>> I'm also confused as to why stm32_rproc_tee_elf_sanity_check() is calling
>>> tee_rproc_load_fw().  There should be one call to load the firmware and another
>>> to perform a sanity check on it.  If the sanity check is done at load time by
>>> the secure world then ops::sanity_check() is NULL.
>>
>> Sure, make sense to remove the sanity_check ops
>>
>> Thanks,
>> Arnaud
>>
>>>
>>> Most of what this patchset does makes sense, but some of it needs to be moved
>>> around.  
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>>
>>>> If we want to integrate in remoteproc_core the solution could probably have to
>>>> create the equivalent of the rproc_fw_boot() to load the firmware with an
>>>> external method. Here is an example based on a new rproc_ops ( not tested)
>>>>
>>>> + static int rproc_fw_ext_boot(struct rproc *rproc, const struct firmware *fw)
>>>> + {
>>>> + 	struct device *dev = &rproc->dev;
>>>> + 	const char *name = rproc->firmware;
>>>> + 	int ret;
>>>> +
>>>> +
>>>> + 	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>>>> + 	
>>>> + 	/* ops to load and start the remoteprocessor */
>>>> + 	ret = rproc->ops->boot(rproc, fw);
>>>> + 	if (ret)
>>>> + 		return ret;
>>>> +
>>>> + 	/*
>>>> + 	 * if enabling an IOMMU isn't relevant for this rproc, this is
>>>> + 	 * just a nop
>>>> + 	 */
>>>> + 	ret = rproc_enable_iommu(rproc);
>>>> + 	if (ret) {
>>>> + 		dev_err(dev, "can't enable iommu: %d\n", ret);
>>>> + 		return ret;
>>>> + 	}
>>>> +
>>>> + 	/* Prepare rproc for firmware loading if needed */
>>>> + 	ret = rproc_prepare_device(rproc);
>>>> + 	if (ret) {
>>>> + 		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
>>>> + 		goto disable_iommu;
>>>> + 	}
>>>> +
>>>> + 	ret = rproc_set_rsc_table(rproc);
>>>> + 	if (ret) {
>>>> + 		dev_err(dev, "can't load resource table: %d\n", ret);
>>>> + 		goto unprepare_device;
>>>> + 	}
>>>> +
>>>> +
>>>> + 	/* reset max_notifyid */
>>>> + 	rproc->max_notifyid = -1;
>>>> +
>>>> + 	/* reset handled vdev */
>>>> + 	rproc->nb_vdev = 0;
>>>> +
>>>> + 	/* handle fw resources which are required to boot rproc */
>>>> + 	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
>>>> + 	if (ret) {
>>>> + 		dev_err(dev, "Failed to process resources: %d\n", ret);
>>>> + 		goto clean_up_resources;
>>>> + 	}
>>>> +
>>>> + 	/* Allocate carveout resources associated to rproc */
>>>> + 	ret = rproc_alloc_registered_carveouts(rproc);
>>>> + 	if (ret) {
>>>> + 		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
>>>> + 			ret);
>>>> + 		goto clean_up_resources;
>>>> + 	}
>>>> +
>>>> + 	return 0;
>>>> +
>>>> + clean_up_resources:
>>>> + 	rproc_resource_cleanup(rproc);
>>>> + unprepare_rproc:
>>>> + 	/* release HW resources if needed */
>>>> + 	rproc_unprepare_device(rproc);
>>>> + disable_iommu:
>>>> + 	rproc_disable_iommu(rproc);
>>>> + 	return ret;
>>>> + }
>>>>
>>>>
>>>> int rproc_boot(struct rproc *rproc)
>>>> {
>>>> [...]
>>>>
>>>> - 		ret = rproc_fw_boot(rproc, firmware_p);
>>>> + 		if(rproc->ops->boot)
>>>> + 			ret = rproc_fw_ext_boot(rproc, firmware_p);
>>>> + 		else
>>>> + 			ret = rproc_fw_boot(rproc, firmware_p);
>>>>
>>>> Another advantage of this solution is that it opens the framework to other
>>>> formats. For instance it could be a way to support dtb format requested in [RFC]
>>>> Passing device-tree to remoteproc [1].
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-remoteproc/f67cd822-4e29-71f2-7c42-e11dbaa6cd8c@kalrayinc.com/T/#t
>>>>
>>>> Thanks,
>>>> Arnaud
>>>>
>>>>
>>>>
>>>>>
>>>>> I touched on that before but please rename rproc_tee_get_rsc_table() to
>>>>> rproc_tee_elf_load_rsc_table().  I also suggest to introduce a new function,
>>>>> rproc_tee_get_loaded_rsc_table() that would be called from
>>>>> rproc_tee_elf_load_rsc_table().  That way we don't need trproc->rsc_va.  
>>>>>
>>>>> I also think tee_rproc should be renamed to "rproc_tee_interface" and folded
>>>>> under struct rproc.  
>>>>>
>>>>> With the above most of the problems with the current implementation should
>>>>> naturally go away.
>>>>>
>>>>> Thanks,
>>>>> Mathieu
>>>>>
>>>>>>
>>>>>>>> +	ret = tee_rproc_load_fw(ddata->trproc, fw);
>>>>>>>> +	if (ret)
>>>>>>>> +		return ret;
>>>>>>>> +	ddata->fw_loaded = true;
>>>>>>>> +
>>>>>>>> +	/* Update the resource table parameters. */
>>>>>>>> +	if (rproc_tee_get_rsc_table(ddata->trproc)) {
>>>>>>>> +		/* No resource table: reset the related fields. */
>>>>>>>> +		rproc->cached_table = NULL;
>>>>>>>> +		rproc->table_ptr = NULL;
>>>>>>>> +		rproc->table_sz = 0;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static struct resource_table *
>>>>>>>> +stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
>>>>>>>> +					  const struct firmware *fw)
>>>>>>>> +{
>>>>>>>> +	struct stm32_rproc *ddata = rproc->priv;
>>>>>>>> +
>>>>>>>> +	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int stm32_rproc_tee_start(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +	struct stm32_rproc *ddata = rproc->priv;
>>>>>>>> +
>>>>>>>> +	return tee_rproc_start(ddata->trproc);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +	/* Nothing to do, remote proc already started by the secured context. */
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +	struct stm32_rproc *ddata = rproc->priv;
>>>>>>>> +	int err;
>>>>>>>> +
>>>>>>>> +	stm32_rproc_request_shutdown(rproc);
>>>>>>>> +
>>>>>>>> +	err = tee_rproc_stop(ddata->trproc);
>>>>>>>> +	if (err)
>>>>>>>> +		return err;
>>>>>>>> +
>>>>>>>> +	ddata->fw_loaded = false;
>>>>>>>> +
>>>>>>>> +	return stm32_rproc_release(rproc);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static int stm32_rproc_prepare(struct rproc *rproc)
>>>>>>>>  {
>>>>>>>>  	struct device *dev = rproc->dev.parent;
>>>>>>>> @@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>>>>>>>>  
>>>>>>>>  static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>>>>>>>>  {
>>>>>>>> -	if (rproc_elf_load_rsc_table(rproc, fw))
>>>>>>>> +	struct stm32_rproc *ddata = rproc->priv;
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	if (ddata->trproc)
>>>>>>>> +		ret = rproc_tee_get_rsc_table(ddata->trproc);
>>>>>>>> +	else
>>>>>>>> +		ret = rproc_elf_load_rsc_table(rproc, fw);
>>>>>>>> +	if (ret)
>>>>>>>>  		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
>>>>>>>>  
>>>>>>>>  	return 0;
>>>>>>>> @@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops = {
>>>>>>>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>>>>>>  };
>>>>>>>>  
>>>>>>>> +static const struct rproc_ops st_rproc_tee_ops = {
>>>>>>>> +	.prepare	= stm32_rproc_prepare,
>>>>>>>> +	.start		= stm32_rproc_tee_start,
>>>>>>>> +	.stop		= stm32_rproc_tee_stop,
>>>>>>>> +	.attach		= stm32_rproc_tee_attach,
>>>>>>>> +	.kick		= stm32_rproc_kick,
>>>>>>>> +	.parse_fw	= stm32_rproc_parse_fw,
>>>>>>>> +	.find_loaded_rsc_table = stm32_rproc_tee_elf_find_loaded_rsc_table,
>>>>>>>> +	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
>>>>>>>> +	.sanity_check	= stm32_rproc_tee_elf_sanity_check,
>>>>>>>> +	.load		= stm32_rproc_tee_elf_load,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>  static const struct of_device_id stm32_rproc_match[] = {
>>>>>>>> -	{ .compatible = "st,stm32mp1-m4" },
>>>>>>>> +	{.compatible = "st,stm32mp1-m4",},
>>>>>>>> +	{.compatible = "st,stm32mp1-m4-tee",},
>>>>>>>>  	{},
>>>>>>>>  };
>>>>>>>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
>>>>>>>> @@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>>>>>>>  	struct device *dev = &pdev->dev;
>>>>>>>>  	struct stm32_rproc *ddata;
>>>>>>>>  	struct device_node *np = dev->of_node;
>>>>>>>> +	struct tee_rproc *trproc = NULL;
>>>>>>>>  	struct rproc *rproc;
>>>>>>>>  	unsigned int state;
>>>>>>>>  	int ret;
>>>>>>>> @@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>>>>>>>  	if (ret)
>>>>>>>>  		return ret;
>>>>>>>>  
>>>>>>>> -	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>>>>>>>> -	if (!rproc)
>>>>>>>> -		return -ENOMEM;
>>>>>>>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
>>>>>>>> +		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
>>>>>>>> +		if (IS_ERR(trproc)) {
>>>>>>>> +			dev_err_probe(dev, PTR_ERR(trproc),
>>>>>>>> +				      "signed firmware not supported by TEE\n");
>>>>>>>> +			return PTR_ERR(trproc);
>>>>>>>> +		}
>>>>>>>> +		/*
>>>>>>>> +		 * Delegate the firmware management to the secure context.
>>>>>>>> +		 * The firmware loaded has to be signed.
>>>>>>>> +		 */
>>>>>>>> +		dev_info(dev, "Support of signed firmware only\n");
>>>>>>>
>>>>>>> Not sure what this adds.  Please remove.
>>>>>>
>>>>>> This is used to inform the user that only a signed firmware can be loaded, not
>>>>>> an ELF file.
>>>>>> I have a patch in my pipe to provide the supported format in the debugfs. In a
>>>>>> first step, I can suppress this message and we can revisit the issue when I push
>>>>>> the debugfs proposal.
>>>>>>
>>>>>> Thanks,
>>>>>> Arnaud
>>>>>>
>>>>>>>
>>>>>>>> +	}
>>>>>>>> +	rproc = rproc_alloc(dev, np->name,
>>>>>>>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
>>>>>>>> +			    NULL, sizeof(*ddata));
>>>>>>>> +	if (!rproc) {
>>>>>>>> +		ret = -ENOMEM;
>>>>>>>> +		goto free_tee;
>>>>>>>> +	}
>>>>>>>>  
>>>>>>>>  	ddata = rproc->priv;
>>>>>>>> +	ddata->trproc = trproc;
>>>>>>>> +	if (trproc)
>>>>>>>> +		trproc->rproc = rproc;
>>>>>>>>  
>>>>>>>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>>>>>>>>  
>>>>>>>> @@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>>>>>>>>  		device_init_wakeup(dev, false);
>>>>>>>>  	}
>>>>>>>>  	rproc_free(rproc);
>>>>>>>> +free_tee:
>>>>>>>> +	if (trproc)
>>>>>>>> +		tee_rproc_unregister(trproc);
>>>>>>>> +
>>>>>>>>  	return ret;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> @@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>>>>>>>>  		device_init_wakeup(dev, false);
>>>>>>>>  	}
>>>>>>>>  	rproc_free(rproc);
>>>>>>>> +	if (ddata->trproc)
>>>>>>>> +		tee_rproc_unregister(ddata->trproc);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>>  static int stm32_rproc_suspend(struct device *dev)
>>>>>>>> -- 
>>>>>>>> 2.25.1
>>>>>>>>

