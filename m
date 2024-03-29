Return-Path: <linux-kernel+bounces-124301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7089154F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CBA1C22529
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F7374F1;
	Fri, 29 Mar 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MQFZTRSn"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7E20DD0;
	Fri, 29 Mar 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702783; cv=none; b=IWvQtYE/A9Isl/3X+wNbHzEPBQ4YRTtmKOYrCUhKOt9mct1QbMdRTNZNtKGlZ8Ycq6VrTKhiOJWihbrtnUrGKumH7ARCSI0W6Np2me9409jdfInVoecYnasUo8OBYKbMrB6Q+U/EGNZ5q4h50xBWILzbh7bLUw8NWeZA3D9P6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702783; c=relaxed/simple;
	bh=5V0lgyE4BIIrI5Z+7ipF9eelhMxkMI4Sa7ZSC63CdhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YOewNmUcPFwhTfk+8VmMRx9dP/2fiM2jMw0PBeTa2eHF29Opdz+aaiwzs5roPMBtD2Cv1MYA2fqfIIsiKdIyMwMbFWcj1sEQfGnqagzLkjLilal4jgnIoMeseATglQuoJx2s/8bo1X9PVywaf6cCuPiE86tXw5heoFXpkTU+ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MQFZTRSn; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T83ais015356;
	Fri, 29 Mar 2024 09:59:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=DtNY0Zyn8FIIpjEge6RtNWqZhnJtcXC+kPoVJZMJf3w=; b=MQ
	FZTRSn+1F6e1+vsROaovSBf7BKjmdQPgQNntPQqTRW5qbJ395m165DnJ5Fk3iEwU
	mMBVvjBiGVKs77brlExv+GoK39JB+5Zzhl8BE+s4OxEx9QwdHXQHRKRpVaVNPq7V
	9Flegb/NB7hY43rr/61BiyfnQIjMMY9oGsJJ9UfsC2Z2RjTuNDrzd/SRuMqGglyN
	MaxxVd6CvR0iYCbGMMBkUagVy/Em/wYobhku/TGeHYcB4N7Uh/+C4j1oTgWCpQyY
	H6ULyVfjSmBq9SsaygFzDJsw4ZZcaZKeKj7g9tuZOamXRXOYVqsyodUMkHsStUvs
	ykEejT43C00sWfGpOKXA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x2awpva4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 09:59:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E5D6A40048;
	Fri, 29 Mar 2024 09:59:01 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 580B52128A5;
	Fri, 29 Mar 2024 09:58:14 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Mar
 2024 09:58:14 +0100
Received: from [10.201.21.20] (10.201.21.20) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Mar
 2024 09:58:13 +0100
Message-ID: <a4a1f938-d185-46d7-9f57-af7bf3a65e9c@foss.st.com>
Date: Fri, 29 Mar 2024 09:58:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] remoteproc: Add TEE support
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
 <20240308144708.62362-2-arnaud.pouliquen@foss.st.com> <ZgGqfItYtkUUvlxf@p14s>
 <5bb9f583-351d-45a4-90e1-ce0b8dde8ce2@foss.st.com> <ZgRSS76mtc4JBAJP@p14s>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZgRSS76mtc4JBAJP@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_08,2024-03-28_01,2023-05-22_02

Hello Mathieu,

On 3/27/24 18:07, Mathieu Poirier wrote:
> On Tue, Mar 26, 2024 at 08:18:23PM +0100, Arnaud POULIQUEN wrote:
>> Hello Mathieu,
>>
>> On 3/25/24 17:46, Mathieu Poirier wrote:
>>> On Fri, Mar 08, 2024 at 03:47:05PM +0100, Arnaud Pouliquen wrote:
>>>> Add a remoteproc TEE (Trusted Execution Environment) driver
>>>> that will be probed by the TEE bus. If the associated Trusted
>>>> application is supported on secure part this device offers a client
>>>
>>> Device or driver?  I thought I touched on that before.
>>
>> Right, I changed the first instance and missed this one
>>
>>>
>>>> interface to load a firmware in the secure part.
>>>> This firmware could be authenticated by the secure trusted application.
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>> Updates from V3:
>>>> - rework TEE_REMOTEPROC description in Kconfig
>>>> - fix some namings
>>>> - add tee_rproc_parse_fw  to support rproc_ops::parse_fw
>>>> - add proc::tee_interface;
>>>> - add rproc struct as parameter of the tee_rproc_register() function
>>>> ---
>>>>  drivers/remoteproc/Kconfig          |  10 +
>>>>  drivers/remoteproc/Makefile         |   1 +
>>>>  drivers/remoteproc/tee_remoteproc.c | 434 ++++++++++++++++++++++++++++
>>>>  include/linux/remoteproc.h          |   4 +
>>>>  include/linux/tee_remoteproc.h      | 112 +++++++
>>>>  5 files changed, 561 insertions(+)
>>>>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
>>>>  create mode 100644 include/linux/tee_remoteproc.h
>>>>
>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>> index 48845dc8fa85..2cf1431b2b59 100644
>>>> --- a/drivers/remoteproc/Kconfig
>>>> +++ b/drivers/remoteproc/Kconfig
>>>> @@ -365,6 +365,16 @@ config XLNX_R5_REMOTEPROC
>>>>  
>>>>  	  It's safe to say N if not interested in using RPU r5f cores.
>>>>  
>>>> +
>>>> +config TEE_REMOTEPROC
>>>> +	tristate "remoteproc support by a TEE application"
>>>
>>> s/remoteproc/Remoteproc
>>>
>>>> +	depends on OPTEE
>>>> +	help
>>>> +	  Support a remote processor with a TEE application. The Trusted
>>>> +	  Execution Context is responsible for loading the trusted firmware
>>>> +	  image and managing the remote processor's lifecycle.
>>>> +	  This can be either built-in or a loadable module.
>>>> +
>>>>  endif # REMOTEPROC
>>>>  
>>>>  endmenu
>>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>>>> index 91314a9b43ce..fa8daebce277 100644
>>>> --- a/drivers/remoteproc/Makefile
>>>> +++ b/drivers/remoteproc/Makefile
>>>> @@ -36,6 +36,7 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
>>>>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>>>>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>>>>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>>>> +obj-$(CONFIG_TEE_REMOTEPROC)		+= tee_remoteproc.o
>>>>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>>>>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>>>>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
>>>> diff --git a/drivers/remoteproc/tee_remoteproc.c b/drivers/remoteproc/tee_remoteproc.c
>>>> new file mode 100644
>>>> index 000000000000..c855210e52e3
>>>> --- /dev/null
>>>> +++ b/drivers/remoteproc/tee_remoteproc.c
>>>> @@ -0,0 +1,434 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
>>>> + * Author: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> + */
>>>> +
>>>> +#include <linux/firmware.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/remoteproc.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/tee_drv.h>
>>>> +#include <linux/tee_remoteproc.h>
>>>> +
>>>> +#include "remoteproc_internal.h"
>>>> +
>>>> +#define MAX_TEE_PARAM_ARRY_MEMBER	4
>>>> +
>>>> +/*
>>>> + * Authentication of the firmware and load in the remote processor memory
>>>> + *
>>>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
>>>> + * [in]	 params[1].memref:	buffer containing the image of the buffer
>>>> + */
>>>> +#define TA_RPROC_FW_CMD_LOAD_FW		1
>>>> +
>>>> +/*
>>>> + * Start the remote processor
>>>> + *
>>>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
>>>> + */
>>>> +#define TA_RPROC_FW_CMD_START_FW	2
>>>> +
>>>> +/*
>>>> + * Stop the remote processor
>>>> + *
>>>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
>>>> + */
>>>> +#define TA_RPROC_FW_CMD_STOP_FW		3
>>>> +
>>>> +/*
>>>> + * Return the address of the resource table, or 0 if not found
>>>> + * No check is done to verify that the address returned is accessible by
>>>> + * the non secure context. If the resource table is loaded in a protected
>>>> + * memory the access by the non secure context will lead to a data abort.
>>>> + *
>>>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
>>>> + * [out]  params[1].value.a:	32bit LSB resource table memory address
>>>> + * [out]  params[1].value.b:	32bit MSB resource table memory address
>>>> + * [out]  params[2].value.a:	32bit LSB resource table memory size
>>>> + * [out]  params[2].value.b:	32bit MSB resource table memory size
>>>> + */
>>>> +#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
>>>> +
>>>> +/*
>>>> + * Return the address of the core dump
>>>> + *
>>>> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
>>>> + * [out] params[1].memref:	address of the core dump image if exist,
>>>> + *				else return Null
>>>> + */
>>>> +#define TA_RPROC_FW_CMD_GET_COREDUMP	5
>>>> +
>>>> +struct tee_rproc_context {
>>>> +	struct list_head sessions;
>>>> +	struct tee_context *tee_ctx;
>>>> +	struct device *dev;
>>>> +};
>>>> +
>>>> +static struct tee_rproc_context *tee_rproc_ctx;
>>>> +
>>>> +static void tee_rproc_prepare_args(struct tee_rproc *trproc, int cmd,
>>>> +				   struct tee_ioctl_invoke_arg *arg,
>>>> +				   struct tee_param *param,
>>>> +				   unsigned int num_params)
>>>> +{
>>>> +	memset(arg, 0, sizeof(*arg));
>>>> +	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
>>>> +
>>>> +	arg->func = cmd;
>>>> +	arg->session = trproc->session_id;
>>>> +	arg->num_params = num_params + 1;
>>>> +
>>>> +	param[0] = (struct tee_param) {
>>>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>>>> +		.u.value.a = trproc->rproc_id,
>>>> +	};
>>>> +}
>>>> +
>>>> +int tee_rproc_load_fw(struct rproc *rproc, const struct firmware *fw)
>>>> +{
>>>> +	struct tee_ioctl_invoke_arg arg;
>>>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>>>> +	struct tee_rproc *trproc = rproc->tee_interface;
>>>> +	struct tee_shm *fw_shm;
>>>> +	int ret;
>>>
>>> Declarations in reverse ascending order here and everywhere in the driver.
>>> Sometimes it is done properly, sometimes it isn't. 
>>>
>>>> +
>>>> +	if (!trproc)
>>>> +		return -EINVAL;
>>>> +
>>>> +	fw_shm = tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw->data, fw->size);
>>>> +	if (IS_ERR(fw_shm))
>>>> +		return PTR_ERR(fw_shm);
>>>> +
>>>> +	tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
>>>> +
>>>> +	/* Provide the address of the firmware image */
>>>> +	param[1] = (struct tee_param) {
>>>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>>>> +		.u.memref = {
>>>> +			.shm = fw_shm,
>>>> +			.size = fw->size,
>>>> +			.shm_offs = 0,
>>>> +		},
>>>> +	};
>>>> +
>>>> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>>>> +	if (ret < 0 || arg.ret != 0) {
>>>> +		dev_err(tee_rproc_ctx->dev,
>>>> +			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %x, ret:%x\n",
>>>> +			arg.ret, ret);
>>>> +		if (!ret)
>>>> +			ret = -EIO;
>>>> +	}
>>>> +
>>>> +	tee_shm_free(fw_shm);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_load_fw);
>>>> +
>>>> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>>>> +{
>>>> +	struct tee_ioctl_invoke_arg arg;
>>>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>>>> +	struct tee_rproc *trproc = rproc->tee_interface;
>>>> +	struct resource_table *rsc_table;
>>>> +	int ret;
>>>> +
>>>> +	if (!trproc)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
>>>> +
>>>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>>>> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>>>> +
>>>> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>>>> +	if (ret < 0 || arg.ret != 0) {
>>>> +		dev_err(tee_rproc_ctx->dev,
>>>> +			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
>>>> +			arg.ret, ret);
>>>> +		return ERR_PTR(-EIO);
>>>> +	}
>>>> +
>>>> +	*table_sz = param[2].u.value.a;
>>>> +
>>>> +	/* If the size is null no resource table defined in the image */
>>>> +	if (!*table_sz)
>>>> +		return NULL;
>>>> +
>>>> +	/* Store the resource table address that would be updated by the remote core. */
>>>> +	rsc_table = ioremap_wc(param[1].u.value.a, *table_sz);
>>>> +	if (IS_ERR_OR_NULL(rsc_table)) {
>>>> +		dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
>>>> +			param[1].u.value.a, *table_sz);
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +	}
>>>> +
>>>> +	return rsc_table;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
>>>> +
>>>> +int tee_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>>>> +{
>>>> +	struct tee_rproc *trproc = rproc->tee_interface;
>>>> +	struct resource_table *rsc_table;
>>>> +	size_t table_sz;
>>>> +	int ret;
>>>> +
>>>> +	ret = tee_rproc_load_fw(rproc, fw);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	rsc_table = tee_rproc_get_loaded_rsc_table(rproc, &table_sz);
>>>> +	if (IS_ERR(rsc_table))
>>>> +		return PTR_ERR(rsc_table);
>>>> +
>>>> +	/* Create a copy of the resource table to have same behaviour than the elf loader. */
>>>> +	rproc->cached_table = kmemdup(rsc_table, table_sz, GFP_KERNEL);
>>>> +	if (!rproc->cached_table)
>>>> +		return -ENOMEM;
>>>
>>> Why not ->table_ptr and setting ->cached_table to NULL?
>>
>> It was my plan preparing this version. But during implementarion it looks
>> to me that having exactly same behavior than the ELF loader would be
>> simpler to maintain the remoteproc avoiding to update in the remoteproc core
>> to manage for the cached resource table (see also my comment below abourt recovery)
>> That why I propose this implementation
>>
>> That said what you proposal should also work (with some updates in
>> remoteproc_core for the management of the cached table).
>>
> 
> Yes
> 
>> So please just comfirm your preference.
>>
> 
> Definitely keep ->cached_table to NULL.  
> 
>>>
>>>> +
>>>> +	rproc->table_ptr = rproc->cached_table;
>>>> +	rproc->table_sz = table_sz;
>>>> +	trproc->rsc_table = rsc_table;
>>>
>>> I really don't see why this is needed, please remove and use rproc->table_ptr
>>> instead.
>>
>> I need to store it for the iounmap in tee_rproc_remove.
> 
> iounmap(entry->rproc->rsc_table);
> 
> What am I missing?

rproc->rsc_table is a field that can be updated by remoteproc_core.
How can we garanty in tee_remoteproc that it still points to the mapped resource
table?
As the remoteproc_tee maps the pointer, it seems reliable that it stores it for
unmap.

Seems also that I also missed to  handle the case where rproc_fw_boot() fails[3]
(not done yet).

[3]https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remoteproc_core.c#L1442


> 
>>
>>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_parse_fw);
>>>> +
>>>> +struct resource_table *tee_rproc_find_loaded_rsc_table(struct rproc *rproc,
>>>> +						       const struct firmware *fw)
>>>> +{
>>>> +	struct tee_rproc *trproc = rproc->tee_interface;
>>>> +	struct resource_table *rsc_table;
>>>> +	size_t table_sz;
>>>> +
>>>> +	if (!trproc)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	/* Check if the resourse table has already been obtained in tee_rproc_parse_fw() */
>>>> +	if (trproc->rsc_table)
>>>> +		return trproc->rsc_table;
>>>
>>> Again, why not simply use rproc->rsc_table?  This function should only return
>>> the resource table that was set in tee_rproc_parse_fw(). 
>>
>> In case of recovery rproc->_rsc_table point to the cached table [1]
>  
> In [1], on line 1554, add a check for rproc->tee_interface and if it is valid
> call rproc_find_loaded_rsc_table(). 
> 
>> and we need to reapply the configuration in rproc_start() called during the
>> recovery[2]
> 
> 1) Rename rproc_set_rsc_table() to rproc_set_rsc_table_on_attach()
> 2) Introduce a new function called rproc_set_rsc_table_on_start()
> 3) Move code from [2], line 1278 to 1292, to that new function.  In the new
> function, add a check on rproc->tee_interface.  If it is valid then call
> rproc_find_loaded_rsc_table().
> 4) in rproc_start(), replace lines 1278 to 1292 with a call to
> rproc_set_rsc_table_on_start().


I will try this

Thanks!
Arnaud

> 
>> [1]https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remoteproc_core.c#L1586
>> [2]https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remoteproc_core.c#L1287
>>
>>>
>>>> +
>>>> +	rsc_table = tee_rproc_get_loaded_rsc_table(rproc, &table_sz);
>>>> +	if (IS_ERR(rsc_table))
>>>> +		return rsc_table;
>>>> +
>>>> +	rproc->table_sz = table_sz;
>>>> +	trproc->rsc_table = rsc_table;
>>>> +
>>>> +	return rsc_table;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_find_loaded_rsc_table);
>>>> +
>>>> +int tee_rproc_start(struct rproc *rproc)
>>>> +{
>>>> +	struct tee_ioctl_invoke_arg arg;
>>>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>>>> +	struct tee_rproc *trproc = rproc->tee_interface;
>>>> +	int ret;
>>>> +
>>>> +	if (!trproc)
>>>> +		return -EINVAL;
>>>> +
>>>> +	tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
>>>> +
>>>> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>>>> +	if (ret < 0 || arg.ret != 0) {
>>>> +		dev_err(tee_rproc_ctx->dev,
>>>> +			"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
>>>> +			arg.ret, ret);
>>>> +		if (!ret)
>>>> +			ret = -EIO;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_start);
>>>> +
>>>> +int tee_rproc_stop(struct rproc *rproc)
>>>> +{
>>>> +	struct tee_ioctl_invoke_arg arg;
>>>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>>>> +	struct tee_rproc *trproc = rproc->tee_interface;
>>>> +	int ret;
>>>> +
>>>> +	if (!trproc)
>>>> +		return -EINVAL;
>>>> +
>>>> +	tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
>>>> +
>>>> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
>>>> +	if (ret < 0 || arg.ret != 0) {
>>>> +		dev_err(tee_rproc_ctx->dev,
>>>> +			"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
>>>> +			arg.ret, ret);
>>>> +		if (!ret)
>>>> +			ret = -EIO;
>>>> +	}
>>>> +
>>>> +	if (!rproc->table_ptr)
>>>> +		return ret;
>>>> +
>>>> +	iounmap(trproc->rsc_table);
>>>> +	trproc->rsc_table = NULL;
>>>> +	rproc->table_ptr = NULL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_stop);
>>>> +
>>>> +static const struct tee_client_device_id stm32_tee_rproc_id_table[] = {
>>>> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905,
>>>> +		   0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
>>>> +	{}
>>>> +};
>>>> +
>>>> +struct tee_rproc *tee_rproc_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id)
>>>> +{
>>>> +	struct tee_client_device *tee_device;
>>>> +	struct tee_ioctl_open_session_arg sess_arg;
>>>> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
>>>> +	struct tee_rproc *trproc;
>>>> +	int ret;
>>>> +
>>>> +	/*
>>>> +	 * Test if the device has been probed by the TEE bus. In case of failure, we ignore the
>>>> +	 * reason. The bus could be not yet probed or the service not available in the secure
>>>> +	 * firmware.The assumption in such a case is that the TEE remoteproc is not probed.
>>>> +	 */
>>>> +	if (!tee_rproc_ctx)
>>>> +		return ERR_PTR(-EPROBE_DEFER);
>>>> +
>>>> +	trproc =  devm_kzalloc(dev, sizeof(*trproc), GFP_KERNEL);
>>>> +	if (!trproc)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	tee_device = to_tee_client_device(tee_rproc_ctx->dev);
>>>> +	memset(&sess_arg, 0, sizeof(sess_arg));
>>>> +
>>>> +	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
>>>> +
>>>> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
>>>> +	sess_arg.num_params = 1;
>>>> +
>>>> +	param[0] = (struct tee_param) {
>>>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>>>> +		.u.value.a = rproc_id,
>>>> +	};
>>>> +
>>>> +	ret = tee_client_open_session(tee_rproc_ctx->tee_ctx, &sess_arg, param);
>>>> +	if (ret < 0 || sess_arg.ret != 0) {
>>>> +		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.ret);
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	trproc->parent =  dev;
>>>> +	trproc->rproc_id = rproc_id;
>>>> +	trproc->session_id = sess_arg.session;
>>>> +
>>>> +	trproc->rproc = rproc;
>>>> +	rproc->tee_interface = trproc;
>>>> +
>>>> +	list_add_tail(&trproc->node, &tee_rproc_ctx->sessions);
>>>> +
>>>> +	return trproc;
>>>
>>> Once this function was called by a client, what prevents a user from unloading
>>> the tee_remoteproc module and breaking everything?
>>
>> Good point! seems better toremove the module build capability
>>
> 
> I was thinking more along the lines of try_module_get() and module_put() to
> avoid bloating the core.
> 
>> Thanks,
>> Arnaud
>>
>>>
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_register);
>>>> +
>>>> +int tee_rproc_unregister(struct tee_rproc *trproc)
>>>> +{
>>>
>>> If you pass a struct_rproc instead of a struct tee_rproc there is no need for
>>> tee_rproc::rproc, which is only ever used in this function.
>>>
>>>
>>>> +	struct rproc *rproc = trproc->rproc;
>>>> +	int ret;
>>>> +
>>>> +	ret = tee_client_close_session(tee_rproc_ctx->tee_ctx, trproc->session_id);
>>>> +	if (ret < 0)
>>>> +		dev_err(trproc->parent,	"tee_client_close_session failed, err: %x\n", ret);
>>>> +
>>>> +	list_del(&trproc->node);
>>>> +	rproc->tee_interface = NULL;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tee_rproc_unregister);
>>>> +
>>>> +static int tee_rproc_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>>>> +{
>>>> +	/* Today we support only the OP-TEE, could be extend to other tees */
>>>> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
>>>> +}
>>>> +
>>>> +static int tee_rproc_probe(struct device *dev)
>>>> +{
>>>> +	struct tee_context *tee_ctx;
>>>> +	int ret;
>>>> +
>>>> +	/* Open context with TEE driver */
>>>> +	tee_ctx = tee_client_open_context(NULL, tee_rproc_ctx_match, NULL, NULL);
>>>> +	if (IS_ERR(tee_ctx))
>>>> +		return PTR_ERR(tee_ctx);
>>>> +
>>>> +	tee_rproc_ctx = devm_kzalloc(dev, sizeof(*tee_ctx), GFP_KERNEL);
>>>> +	if (!tee_rproc_ctx) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err;
>>>> +	}
>>>> +
>>>> +	tee_rproc_ctx->dev = dev;
>>>> +	tee_rproc_ctx->tee_ctx = tee_ctx;
>>>> +	INIT_LIST_HEAD(&tee_rproc_ctx->sessions);
>>>> +
>>>> +	return 0;
>>>> +err:
>>>> +	tee_client_close_context(tee_ctx);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int tee_rproc_remove(struct device *dev)
>>>> +{
>>>> +	struct tee_rproc *entry, *tmp;
>>>> +
>>>> +	list_for_each_entry_safe(entry, tmp, &tee_rproc_ctx->sessions, node) {
>>>> +		tee_client_close_session(tee_rproc_ctx->tee_ctx, entry->session_id);
>>>> +		list_del(&entry->node);
>>>> +		if (entry->rsc_table)
>>>> +			iounmap(entry->rsc_table);
>>>> +		kfree(entry);
>>>> +	}
>>>> +
>>>> +	tee_client_close_context(tee_rproc_ctx->tee_ctx);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +MODULE_DEVICE_TABLE(tee, stm32_tee_rproc_id_table);
>>>> +
>>>> +static struct tee_client_driver tee_rproc_fw_driver = {
>>>> +	.id_table	= stm32_tee_rproc_id_table,
>>>> +	.driver		= {
>>>> +		.name		= KBUILD_MODNAME,
>>>> +		.bus		= &tee_bus_type,
>>>> +		.probe		= tee_rproc_probe,
>>>> +		.remove		= tee_rproc_remove,
>>>> +	},
>>>> +};
>>>> +
>>>> +static int __init tee_rproc_fw_mod_init(void)
>>>> +{
>>>> +	return driver_register(&tee_rproc_fw_driver.driver);
>>>> +}
>>>> +
>>>> +static void __exit tee_rproc_fw_mod_exit(void)
>>>> +{
>>>> +	driver_unregister(&tee_rproc_fw_driver.driver);
>>>> +}
>>>> +
>>>> +module_init(tee_rproc_fw_mod_init);
>>>> +module_exit(tee_rproc_fw_mod_exit);
>>>> +
>>>> +MODULE_DESCRIPTION(" TEE remote processor control driver");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>> index b4795698d8c2..8b678009e481 100644
>>>> --- a/include/linux/remoteproc.h
>>>> +++ b/include/linux/remoteproc.h
>>>> @@ -503,6 +503,8 @@ enum rproc_features {
>>>>  	RPROC_MAX_FEATURES,
>>>>  };
>>>>  
>>>> +struct tee_rproc;
>>>> +
>>>>  /**
>>>>   * struct rproc - represents a physical remote processor device
>>>>   * @node: list node of this rproc object
>>>> @@ -545,6 +547,7 @@ enum rproc_features {
>>>>   * @cdev: character device of the rproc
>>>>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
>>>>   * @features: indicate remoteproc features
>>>> + * @tee_interface: pointer to the remoteproc tee context
>>>>   */
>>>>  struct rproc {
>>>>  	struct list_head node;
>>>> @@ -586,6 +589,7 @@ struct rproc {
>>>>  	struct cdev cdev;
>>>>  	bool cdev_put_on_release;
>>>>  	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
>>>> +	struct tee_rproc *tee_interface;
>>>>  };
>>>>  
>>>>  /**
>>>> diff --git a/include/linux/tee_remoteproc.h b/include/linux/tee_remoteproc.h
>>>> new file mode 100644
>>>> index 000000000000..571e47190d02
>>>> --- /dev/null
>>>> +++ b/include/linux/tee_remoteproc.h
>>>> @@ -0,0 +1,112 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Copyright(c) 2024 STMicroelectronics - All Rights Reserved
>>>> + */
>>>> +
>>>> +#ifndef TEE_REMOTEPROC_H
>>>> +#define TEE_REMOTEPROC_H
>>>> +
>>>> +#include <linux/tee_drv.h>
>>>> +#include <linux/firmware.h>
>>>> +#include <linux/remoteproc.h>
>>>> +
>>>> +struct rproc;
>>>> +
>>>> +/**
>>>> + * struct tee_rproc - TEE remoteproc structure
>>>> + * @node:		Reference in list
>>>> + * @rproc:		Remoteproc reference
>>>> + * @parent:		Parent device
>>>> + * @rproc_id:		Identifier of the target firmware
>>>> + * @session_id:		TEE session identifier
>>>> + * @rsc_table:		Resource table virtual address.
>>>> + */
>>>> +struct tee_rproc {
>>>> +	struct list_head node;
>>>> +	struct rproc *rproc;
>>>> +	struct device *parent;
>>>> +	u32 rproc_id;
>>>> +	u32 session_id;
>>>> +	struct resource_table *rsc_table;
>>>> +};
>>>> +
>>>> +#if IS_REACHABLE(CONFIG_TEE_REMOTEPROC)
>>>> +
>>>> +struct tee_rproc *tee_rproc_register(struct device *dev, struct rproc *rproc,
>>>> +				     unsigned int rproc_id);
>>>> +int tee_rproc_unregister(struct tee_rproc *trproc);
>>>> +int tee_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw);
>>>> +int tee_rproc_load_fw(struct rproc *rproc, const struct firmware *fw);
>>>> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz);
>>>> +struct resource_table *tee_rproc_find_loaded_rsc_table(struct rproc *rproc,
>>>> +						       const struct firmware *fw);
>>>> +int tee_rproc_start(struct rproc *rproc);
>>>> +int tee_rproc_stop(struct rproc *rproc);
>>>> +
>>>> +#else
>>>> +
>>>> +static inline struct tee_rproc *tee_rproc_register(struct device *dev, struct rproc *rproc,
>>>> +						   unsigned int rproc_id)
>>>> +{
>>>> +	return ERR_PTR(-ENODEV);
>>>> +}
>>>> +
>>>> +static int tee_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static inline int tee_rproc_unregister(struct tee_rproc *trproc)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static inline int tee_rproc_load_fw(struct rproc *rproc,  const struct firmware *fw)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static inline int tee_rproc_start(struct rproc *rproc)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static inline int tee_rproc_stop(struct rproc *rproc)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static inline struct resource_table *
>>>> +tee_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static inline struct resource_table *
>>>> +tee_rproc_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
>>>> +{
>>>> +	/* This shouldn't be possible */
>>>> +	WARN_ON(1);
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +#endif /* CONFIG_TEE_REMOTEPROC */
>>>> +#endif /* TEE_REMOTEPROC_H */
>>>> -- 
>>>> 2.25.1
>>>>

