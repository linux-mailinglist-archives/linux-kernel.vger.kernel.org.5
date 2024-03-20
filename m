Return-Path: <linux-kernel+bounces-108499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576D880B41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE6B1C22067
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEC12E4A;
	Wed, 20 Mar 2024 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="msCSRmCf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6DA29;
	Wed, 20 Mar 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916503; cv=none; b=RRKskHIDwf0ygJZnNSJEXqmC0QychfNNnUWQHCXxhGDAGnj+QPF7Ng22MetZgGu2yCJkpnkYIkeTEFdLOUgOBGXqZQG7/TcPCQzSfqAGOwTvHTSHbOrOK1ywON4PXW4Nc0nGE/5O5wQaBdyfQFAZ48C4PSiNI5T+rawyeiX3MiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916503; c=relaxed/simple;
	bh=ianIbzzQTFfYXMot1C3h/FL9tFGEeRVdkfcK1e0VSiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=foNWXQFnjVlwOL4tObu/Ig1Z3hyqzO+wfcC8p+QWieeg08byfYkQqN7lEOdSuhd2YTvYSgwOzLacOqEoFrDgNnJlVQ0qxeJZ3E0MqNCIie/XdS9d8RLj12+rGvt618KAz4c8aiUg0rF3VaFEGDI5p7yKx7rraXKDZoasi2k7l5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=msCSRmCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K4I9FJ016465;
	Wed, 20 Mar 2024 06:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gibPDNh+ncfO0OJ7NGZdgTNIfnqZd+drxwtVVYsvV6U=; b=ms
	CSRmCfIwhfqYtxU0xAP81OGWZMJZnq8e5z6Bhs7NtRKxffj1+dTNJXB9AEdmHrj6
	y+OUzT9rt5OMHGYBbmdtOnauqmBlHB8hhFEqBZT76cLB+wh044MAy7pcsg1hnPhp
	sXb08c3N8CQaBXvXXzwjTarWaL+Odaq6miQxBrVHhX6LVylPxL9mY6Hh5uZ3Ksmx
	8BET4BBYa0yWBGh05OqT/gxOiBDpOBhtf9DdxN6Geh2/FrAAB/kQ+F6HIiwhWIoX
	4qrPdUyWPodqLpuzOdrZa1xDApABhOZNlqOH90fNoIQfAyfU0wpeFoymcFUYZJfR
	YGx7+cRSpTWcziI5iawQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wygbbh4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:34:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K6YPso019848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:34:25 GMT
Received: from [10.216.16.222] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 23:34:19 -0700
Message-ID: <58dfa2f5-8b49-a8a9-0857-f75f755f703c@quicinc.com>
Date: Wed, 20 Mar 2024 12:04:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/5] drivers: mtd: nand: Add qpic_common API file
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <neil.armstrong@linaro.org>,
        <daniel@makrotopia.org>, <arnd@arndb.de>,
        <chris.packham@alliedtelesis.co.nz>, <christophe.kerello@foss.st.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-3-quic_mdalam@quicinc.com>
 <20240315124517.4a546ce9@xps-13>
 <93b08226-3297-2161-cc7d-d33d839c32f0@quicinc.com>
 <20240319114316.4b977d93@xps-13>
 <756ccc79-0077-5c23-73e3-bbb82fbfa8b0@quicinc.com>
 <20240319140924.167f3063@xps-13>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240319140924.167f3063@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BfPakkWhuLrOxL76Q0W3qYhEzZTAFfXw
X-Proofpoint-GUID: BfPakkWhuLrOxL76Q0W3qYhEzZTAFfXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=660 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200050



On 3/19/2024 6:39 PM, Miquel Raynal wrote:
> Hi,
> 
> quic_mdalam@quicinc.com wrote on Tue, 19 Mar 2024 17:46:05 +0530:
> 
>> On 3/19/2024 4:13 PM, Miquel Raynal wrote:
>>> Hi,
>>>    
>>>>>> +/**
>>>>>> + * qcom_offset_to_nandc_reg() - Get the actual offset
>>>>>> + * @regs: pointer to nandc_reg structure
>>>>>> + * @offset: register offset
>>>>>> + *
>>>>>> + * This function will reurn the actual offset for qpic controller register
>>>>>> + */
>>>>>> +__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset)
>>>>>> +{
>>>>>> +	switch (offset) {
>>>>>> +	case NAND_FLASH_CMD:
>>>>>> +		return &regs->cmd;
>>>>>> +	case NAND_ADDR0:
>>>>>> +		return &regs->addr0;
>>>>>> +	case NAND_ADDR1:
>>>>>> +		return &regs->addr1;
>>>>>> +	case NAND_FLASH_CHIP_SELECT:
>>>>>> +		return &regs->chip_sel;
>>>>>> +	case NAND_EXEC_CMD:
>>>>>> +		return &regs->exec;
>>>>>> +	case NAND_FLASH_STATUS:
>>>>>> +		return &regs->clrflashstatus;
>>>>>> +	case NAND_DEV0_CFG0:
>>>>>> +		return &regs->cfg0;
>>>>>> +	case NAND_DEV0_CFG1:
>>>>>> +		return &regs->cfg1;
>>>>>> +	case NAND_DEV0_ECC_CFG:
>>>>>> +		return &regs->ecc_bch_cfg;
>>>>>> +	case NAND_READ_STATUS:
>>>>>> +		return &regs->clrreadstatus;
>>>>>> +	case NAND_DEV_CMD1:
>>>>>> +		return &regs->cmd1;
>>>>>> +	case NAND_DEV_CMD1_RESTORE:
>>>>>> +		return &regs->orig_cmd1;
>>>>>> +	case NAND_DEV_CMD_VLD:
>>>>>> +		return &regs->vld;
>>>>>> +	case NAND_DEV_CMD_VLD_RESTORE:
>>>>>> +		return &regs->orig_vld;
>>>>>> +	case NAND_EBI2_ECC_BUF_CFG:
>>>>>> +		return &regs->ecc_buf_cfg;
>>>>>> +	case NAND_READ_LOCATION_0:
>>>>>> +		return &regs->read_location0;
>>>>>> +	case NAND_READ_LOCATION_1:
>>>>>> +		return &regs->read_location1;
>>>>>> +	case NAND_READ_LOCATION_2:
>>>>>> +		return &regs->read_location2;
>>>>>> +	case NAND_READ_LOCATION_3:
>>>>>> +		return &regs->read_location3;
>>>>>> +	case NAND_READ_LOCATION_LAST_CW_0:
>>>>>> +		return &regs->read_location_last0;
>>>>>> +	case NAND_READ_LOCATION_LAST_CW_1:
>>>>>> +		return &regs->read_location_last1;
>>>>>> +	case NAND_READ_LOCATION_LAST_CW_2:
>>>>>> +		return &regs->read_location_last2;
>>>>>> +	case NAND_READ_LOCATION_LAST_CW_3:
>>>>>> +		return &regs->read_location_last3;
>>>>>
>>>>> Why do you need this indirection?
>>>>
>>>> This indirection I believe is needed by the write_reg_dma function,
>>>> wherein a bunch of registers are modified based on a starting register.
>>>> Can I change this in a separate cleanup series as a follow up to this?
>>>
>>> I think it would be cleaner to make the changes I requested first and
>>> then make a copy. I understand it is more work on your side, so if you
>>> really prefer you can (1) make the copy and then (2) clean it all. But
>>> please do it all in this series.
>> Ok
>>>    
>>>>>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..aced15866627
>>>>>> --- /dev/null
>>>>>> +++ b/include/linux/mtd/nand-qpic-common.h
>>>>>> @@ -0,0 +1,486 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +/*
>>>>>> + * QCOM QPIC common APIs header file
>>>>>> + *
>>>>>> + * Copyright (c) 2023 Qualcomm Inc.
>>>>>> + * Authors:     Md sadre Alam           <quic_mdalam@quicinc.com>
>>>>>> + *		Sricharan R             <quic_srichara@quicinc.com>
>>>>>> + *		Varadarajan Narayanan   <quic_varada@quicinc.com>
>>>>>> + *
>>>>>> + */
>>>>>> +#ifndef __MTD_NAND_QPIC_COMMON_H__
>>>>>> +#define __MTD_NAND_QPIC_COMMON_H__
>>>>>> +
>>>>>> +#include <linux/bitops.h>
>>>>>> +#include <linux/clk.h>
>>>>>> +#include <linux/delay.h>
>>>>>> +#include <linux/dmaengine.h>
>>>>>> +#include <linux/dma-mapping.h>
>>>>>> +#include <linux/dma/qcom_adm.h>
>>>>>> +#include <linux/dma/qcom_bam_dma.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/mtd/partitions.h>
>>>>>> +#include <linux/mtd/rawnand.h>
>>>>>
>>>>> You really need this?
>>>> Yes , since some generic structure used here.
>>>
>>> Which ones? If this is a common file, you probably should not.
>>    Since we are using this struct qcom_nand_controller { }
>>    for both SPI nand as well as raw nand. In this we are having this
>>    struct nand_controller controller member.
> 
> Maybe we should not expose qcom_nand_controller at all and just share
> the minimum bits which are really common.

  Will move all the header files to .c file from nand-qpic-common.h

> 
> Thanks,
> Miquèl

Thanks,
Alam.


