Return-Path: <linux-kernel+bounces-117156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEF88A7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D6C1FA129E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674B55E59;
	Mon, 25 Mar 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ERX8MNSh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE950248;
	Mon, 25 Mar 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373906; cv=none; b=ZiRGH1/KnCCGA1Hu4NgIxWqCXpwGAYxeBLDuJeFGfCHmAlr/MLqRhlN/dGCkI/3KKP7o4ibAm9X0kCUO75rOPIlvBTKxxZKpfDLSkdPkyJ8GSTb0PsbhTUcEQJX0HzKjFN+ErB8u/7yFGj4QTIiKmp6XiualSTemnhjgf8R8G4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373906; c=relaxed/simple;
	bh=ZVWjwKcwPAGTbX3rUYsuDi055yHk0teXSvVowtFCK/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z920DjBxJjoIIbh0FhVEFFP/ZF0ZJXqM+EArDjW8OHPCoOfFv/tYDPGlxw5pX0js1kluVKFFNj4pnrWfG18y5dM4jR/aap6OHg89zXG2H/pl/or1+g6A6jqy3XoDwHHjR37c6dKR3AykHoJBWSjDndrChmJ0dARpWeEzIOl2oCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ERX8MNSh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PAqS57023557;
	Mon, 25 Mar 2024 13:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5Wh1H7LS3r3Supdrc6pXTAfv62LxvOInVhK7Q7cZT5U=; b=ER
	X8MNSh/vE1fsICj8J2/H1ybE3el/darRbiI6VQOJRokw9erEcBxRV1jqoYIYefQ1
	5p1npBIIsYwo/s2ZUmgjpKhbJGhb8jIg/JWpX09BzApxhutbo1+WZSi/JBv9chFU
	WJ8eRnIGZsJxTxbGcRvy9AW75gURaSw73Qvlk7izbQVAGIn33I92kGnv+1WaJZzB
	L6byx+Gmzak6cwQALXZLtp7Z/H5jAOKGLOw8FWjP86LxBn1lbkCfXgcH+8rkcB0+
	Km9QTyxYztg7M9F3e42YNVL8mj+upkSDt7gZgf4k7u2lO1kInKidhyUeO0P80kD3
	+9VBinjcjJgLO1h8Eu+Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x35eagu50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:38:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PDcIgl032390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:38:18 GMT
Received: from [10.239.96.73] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 06:38:15 -0700
Message-ID: <8d363b4b-d666-47bb-973e-f4a6d52e1024@quicinc.com>
Date: Mon, 25 Mar 2024 21:38:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] media: qcom: camss: Add CSID gen3 driver
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <quic_yon@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-6-quic_depengs@quicinc.com>
 <b542f9a1-2053-4431-832e-5510e8d8220e@linaro.org>
Content-Language: en-US
From: Depeng Shao <quic_depengs@quicinc.com>
In-Reply-To: <b542f9a1-2053-4431-832e-5510e8d8220e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m4OukUkNQ8stChkbATTvhxJTk6XNDe2E
X-Proofpoint-ORIG-GUID: m4OukUkNQ8stChkbATTvhxJTk6XNDe2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250074

Hi Bryan,

On 3/20/2024 11:40 PM, Bryan O'Donoghue wrote:
> On 20/03/2024 14:11, Depeng Shao wrote:
>> The CSID in SM8550 is gen3, it has new register
>> offset and new functionality, the buf done irq,
>> register update and reset is moved to CSID gen3.
>>
>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
>> Co-developed-by: Yongsheng Li <quic_yon@quicinc.com>
>> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/camss/Makefile    |   1 +
>>   .../platform/qcom/camss/camss-csid-gen3.c     | 639 ++++++++++++++++++
>>   .../platform/qcom/camss/camss-csid-gen3.h     |  26 +
>>   .../media/platform/qcom/camss/camss-csid.h    |   1 +
>>   4 files changed, 667 insertions(+)
>>   create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.c
>>   create mode 100644 drivers/media/platform/qcom/camss/camss-csid-gen3.h
>>
>> diff --git a/drivers/media/platform/qcom/camss/Makefile 
>> b/drivers/media/platform/qcom/camss/Makefile
>> index 28eba4bf3e38..c5fcd6eec0f2 100644
>> --- a/drivers/media/platform/qcom/camss/Makefile
>> +++ b/drivers/media/platform/qcom/camss/Makefile
>> @@ -7,6 +7,7 @@ qcom-camss-objs += \
>>           camss-csid-4-1.o \
>>           camss-csid-4-7.o \
>>           camss-csid-gen2.o \
>> +        camss-csid-gen3.o \
>>           camss-csiphy-2ph-1-0.o \
>>           camss-csiphy-3ph-1-0.o \
>>           camss-csiphy-2-1-2.o \
>> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c 
>> b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
>> new file mode 100644
>> index 000000000000..b97005f7065d
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
>> @@ -0,0 +1,639 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * camss-csid-gen3.c
>> + *
>> + * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
>> + *
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/delay.h>
> 
> Please alphanumerically sort your include list.
> 
>> +
>> +
>> +#include "camss-csid.h"
>> +#include "camss-csid-gen3.h"
>> +#include "camss.h"
> 
> and here.
> 
>> +
>> +#define CSID_TOP_IO_PATH_CFG0(csid)    (0x4 * (csid))
>> +#define        OUTPUT_IFE_EN 0x100
>> +#define        INTERNAL_CSID 1
>> +
>> +#define CSID_HW_VERSION        0x0
>> +#define        HW_VERSION_STEPPING    0
>> +#define        HW_VERSION_REVISION    16
>> +#define        HW_VERSION_GENERATION    28
>> +
>> +#define CSID_RST_CFG    0xC
>> +#define        RST_MODE        0
>> +#define        RST_LOCATION    4
>> +
>> +#define CSID_RST_CMD    0x10
>> +#define        SELECT_HW_RST    0
>> +#define        SELECT_SW_RST    1
>> +#define        SELECT_IRQ_RST    2
>> +
>> +#define CSID_CSI2_RX_IRQ_STATUS    0x9C
>> +#define CSID_CSI2_RX_IRQ_MASK    0xA0
>> +#define CSID_CSI2_RX_IRQ_CLEAR    0xA4
>> +#define CSID_CSI2_RX_IRQ_SET    0xA8
>> +
>> +#define CSID_CSI2_RDIN_IRQ_STATUS(rdi)        (0xEC + 0x10 * (rdi))
>> +#define CSID_CSI2_RDIN_IRQ_MASK(rdi)        (0xF0 + 0x10 * (rdi))
>> +#define        CSID_CSI2_RDIN_INFO_FIFO_FULL 2
>> +#define        CSID_CSI2_RDIN_INFO_CAMIF_EOF 3
>> +#define        CSID_CSI2_RDIN_INFO_CAMIF_SOF 4
>> +#define        CSID_CSI2_RDIN_INFO_INPUT_EOF 9
>> +#define        CSID_CSI2_RDIN_INFO_INPUT_SOF 12
>> +#define        CSID_CSI2_RDIN_ERROR_REC_FRAME_DROP 18
>> +#define        CSID_CSI2_RDIN_ERROR_REC_OVERFLOW_IRQ 19
>> +#define        CSID_CSI2_RDIN_ERROR_REC_CCIF_VIOLATION 20
>> +#define        CSID_CSI2_RDIN_EPOCH0 21
>> +#define        CSID_CSI2_RDIN_EPOCH1 22
>> +#define        CSID_CSI2_RDIN_RUP_DONE 23
>> +#define        CSID_CSI2_RDIN_CCIF_VIOLATION 29
>> +
>> +#define CSID_CSI2_RDIN_IRQ_CLEAR(rdi)        (0xF4 + 0x10 * (rdi))
>> +#define CSID_CSI2_RDIN_IRQ_SET(rdi)            (0xF8 + 0x10 * (rdi))
>> +
>> +#define CSID_TOP_IRQ_STATUS    0x7C
>> +#define        TOP_IRQ_STATUS_RESET_DONE 0
>> +#define CSID_TOP_IRQ_MASK    0x80
>> +#define CSID_TOP_IRQ_CLEAR    0x84
>> +#define CSID_TOP_IRQ_SET    0x88
>> +#define CSID_IRQ_CMD        0x14
>> +#define        IRQ_CMD_CLEAR    0
>> +#define        IRQ_CMD_SET    4
>> +
>> +#define CSID_BUF_DONE_IRQ_STATUS    0x8C
>> +#define        BUF_DONE_IRQ_STATUS_RDI_OFFSET (csid_is_lite(csid) ? 1 
>> : 14)
> 
> Stick with hex please 0x01 : 0x0e
> 
>> +#define CSID_BUF_DONE_IRQ_MASK    0x90
>> +#define CSID_BUF_DONE_IRQ_CLEAR    0x94
>> +#define CSID_BUF_DONE_IRQ_SET    0x98
>> +
>> +#define CSID_CSI2_RX_CFG0    0x200
>> +#define        CSI2_RX_CFG0_NUM_ACTIVE_LANES    0
>> +#define        CSI2_RX_CFG0_DL0_INPUT_SEL    4
>> +#define        CSI2_RX_CFG0_DL1_INPUT_SEL    8
>> +#define        CSI2_RX_CFG0_DL2_INPUT_SEL    12
>> +#define        CSI2_RX_CFG0_DL3_INPUT_SEL    16
>> +#define        CSI2_RX_CFG0_PHY_NUM_SEL    20
>> +#define            CSI2_RX_CFG0_PHY_SEL_BASE_IDX 1
>> +#define        CSI2_RX_CFG0_PHY_TYPE_SEL    24
>> +#define        CSI2_RX_CFG0_TPG_MUX_EN        27
>> +#define        CSI2_RX_CFG0_TPG_NUM_SEL    28
>> +
>> +#define CSID_CSI2_RX_CFG1    0x204
>> +#define        CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN        0
>> +#define        CSI2_RX_CFG1_DE_SCRAMBLE_EN            1
>> +#define        CSI2_RX_CFG1_VC_MODE                2
>> +#define        CSI2_RX_CFG1_COMPLETE_STREAM_EN            4
>> +#define        CSI2_RX_CFG1_COMPLETE_STREAM_FRAME_TIMING    5
>> +#define        CSI2_RX_CFG1_MISR_EN                6
>> +#define        CSI2_RX_CFG1_PHY_BIST_EN            7
>> +#define        CSI2_RX_CFG1_EPD_MODE                8
>> +#define        CSI2_RX_CFG1_EOTP_EN                9
>> +#define        CSI2_RX_CFG1_DYN_SWITCH_EN            10
>> +#define        CSI2_RX_CFG1_RUP_AUP_LATCH_DIS        11
>> +
>> +#define CSID_CSI2_RX_CAPTURE_CTRL    0x208
>> +#define        CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_EN    0
>> +#define        CSI2_RX_CAPTURE_CTRL_SHORT_PKT_CAPTURE_EN    1
>> +#define        CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_EN    3
>> +#define        CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_DT        4
>> +#define        CSI2_RX_CAPTURE_CTRL_LONG_PKT_CAPTURE_VC        10
>> +#define        CSI2_RX_CAPTURE_CTRL_SHORT_PKT_CAPTURE_VC    15
>> +#define        CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_DT        20
>> +#define        CSI2_RX_CAPTURE_CTRL_CPHY_PKT_CAPTURE_VC        26
>> +
>> +#define CSID_RDI_CFG0(rdi)            (0x500 + 0x100 * (rdi))
>> +#define        RDI_CFG0_VFR_EN                0
>> +#define        RDI_CFG0_FRAME_ID_DEC_EN    1
>> +#define        RDI_CFG0_RETIME_DIS            5
>> +#define        RDI_CFG0_TIMESTAMP_EN        6
>> +#define        RDI_CFG0_TIMESTAMP_STB_SEL    8
>> +#define        RDI_CFG0_DECODE_FORMAT        12
>> +#define        RDI_CFG0_DT                    16
>> +#define        RDI_CFG0_VC                    22
>> +#define        RDI_CFG0_DT_ID                27
>> +#define        RDI_CFG0_EN                    31
>> +
>> +#define CSID_RDI_CFG1(rdi)            (0x510 + 0x100 * (rdi))
>> +#define        RDI_CFG1_BYTE_CNTR_EN    2
>> +#define        RDI_CFG1_DROP_H_EN    5
>> +#define        RDI_CFG1_DROP_V_EN    6
>> +#define        RDI_CFG1_CROP_H_EN    7
>> +#define        RDI_CFG1_CROP_V_EN    8
>> +#define        RDI_CFG1_MISR_EN    9
>> +#define        RDI_CFG1_PIX_STORE  10
>> +#define        RDI_CFG1_PLAIN_ALIGNMENT    11
>> +#define        RDI_CFG1_PLAIN_FORMAT    12
>> +#define        RDI_CFG1_EARLY_EOF_EN    14
>> +#define        RDI_CFG1_PACKING_FORMAT    15
>> +
>> +#define CSID_RDI_CTRL(rdi)            (0x504 + 0x100 * (rdi))
>> +#define        RDI_CTRL_START_CMD        0
>> +#define        RDI_CTRL_START_MODE        2
>> +
>> +#define CSID_RDI_EPOCH_IRQ_CFG(rdi) (0x52C + 0x100 * (rdi))
>> +
>> +#define CSID_RDI_FRM_DROP_PATTERN(rdi)            (0x540 + 0x100 * 
>> (rdi))
>> +#define CSID_RDI_FRM_DROP_PERIOD(rdi)            (0x544 + 0x100 * (rdi))
>> +#define CSID_RDI_IRQ_SUBSAMPLE_PATTERN(rdi)        (0x548 + 0x100 * 
>> (rdi))
>> +#define CSID_RDI_IRQ_SUBSAMPLE_PERIOD(rdi)        (0x54C + 0x100 * 
>> (rdi))
>> +#define CSID_RDI_RPP_PIX_DROP_PATTERN(rdi)        (0x558 + 0x100 * 
>> (rdi))
>> +#define CSID_RDI_RPP_PIX_DROP_PERIOD(rdi)        (0x55C + 0x100 * (rdi))
>> +#define CSID_RDI_RPP_LINE_DROP_PATTERN(rdi)        (0x560 + 0x100 * 
>> (rdi))
>> +#define CSID_RDI_RPP_LINE_DROP_PERIOD(rdi)        (0x564 + 0x100 * 
>> (rdi))
>> +
>> +#define CSID_RDI_RPP_HCROP(rdi)                 (0x550 + 0x100 * (rdi))
>> +#define CSID_RDI_RPP_VCROP(rdi)                 (0x554 + 0x100 * (rdi))
>> +
>> +#define CSID_RDI_ERROR_RECOVERY_CFG0(rdi)       (0x514 + 0x100 * (rdi))
>> +
>> +#define CSID_DISCARD_FRAMES 4
>> +
>> +#define CSID_REG_UPDATE_CMD        0x18
>> +static inline int reg_update_rdi(struct csid_device *csid, int n)
>> +{
>> +    return BIT(n + 4) + BIT(20 + n);
>> +}
>> +
>> +#define        REG_UPDATE_RDI        reg_update_rdi
>> +
>> +static const struct csid_format csid_formats[] = {
>> +    {
>> +        MEDIA_BUS_FMT_UYVY8_1X16,
>> +        DATA_TYPE_YUV422_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        2,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_VYUY8_1X16,
>> +        DATA_TYPE_YUV422_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        2,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_YUYV8_1X16,
>> +        DATA_TYPE_YUV422_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        2,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_YVYU8_1X16,
>> +        DATA_TYPE_YUV422_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        2,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SBGGR8_1X8,
>> +        DATA_TYPE_RAW_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGBRG8_1X8,
>> +        DATA_TYPE_RAW_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGRBG8_1X8,
>> +        DATA_TYPE_RAW_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SRGGB8_1X8,
>> +        DATA_TYPE_RAW_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SBGGR10_1X10,
>> +        DATA_TYPE_RAW_10BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_10_BIT,
>> +        10,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGBRG10_1X10,
>> +        DATA_TYPE_RAW_10BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_10_BIT,
>> +        10,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGRBG10_1X10,
>> +        DATA_TYPE_RAW_10BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_10_BIT,
>> +        10,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SRGGB10_1X10,
>> +        DATA_TYPE_RAW_10BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_10_BIT,
>> +        10,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_Y8_1X8,
>> +        DATA_TYPE_RAW_8BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_8_BIT,
>> +        8,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_Y10_1X10,
>> +        DATA_TYPE_RAW_10BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_10_BIT,
>> +        10,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SBGGR12_1X12,
>> +        DATA_TYPE_RAW_12BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_12_BIT,
>> +        12,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGBRG12_1X12,
>> +        DATA_TYPE_RAW_12BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_12_BIT,
>> +        12,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGRBG12_1X12,
>> +        DATA_TYPE_RAW_12BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_12_BIT,
>> +        12,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SRGGB12_1X12,
>> +        DATA_TYPE_RAW_12BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_12_BIT,
>> +        12,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SBGGR14_1X14,
>> +        DATA_TYPE_RAW_14BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_14_BIT,
>> +        14,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGBRG14_1X14,
>> +        DATA_TYPE_RAW_14BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_14_BIT,
>> +        14,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SGRBG14_1X14,
>> +        DATA_TYPE_RAW_14BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_14_BIT,
>> +        14,
>> +        1,
>> +    },
>> +    {
>> +        MEDIA_BUS_FMT_SRGGB14_1X14,
>> +        DATA_TYPE_RAW_14BIT,
>> +        DECODE_FORMAT_UNCOMPRESSED_14_BIT,
>> +        14,
>> +        1,
>> +    },
>> +};
>> +
>> +static void __csid_configure_rx(struct csid_device *csid,
>> +                struct csid_phy_config *phy, int vc)
>> +{
>> +    int val;
>> +
>> +    val = (phy->lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
>> +    val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
>> +    val |= (phy->csiphy_id + CSI2_RX_CFG0_PHY_SEL_BASE_IDX) << 
>> CSI2_RX_CFG0_PHY_NUM_SEL;
>> +
>> +    writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
>> +
>> +    val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
>> +    if (vc > 3)
>> +        val |= 1 << CSI2_RX_CFG1_VC_MODE;
>> +    writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
>> +}
>> +
>> +static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 
>> rdi)
>> +{
>> +    int val;
>> +
>> +    if (enable)
>> +        val = 1 << RDI_CTRL_START_CMD;
>> +    else
>> +        val = 0 << RDI_CTRL_START_CMD;
>> +    writel_relaxed(val, csid->base + CSID_RDI_CTRL(rdi));
>> +}
>> +
>> +static void __csid_configure_top(struct csid_device *csid)
>> +{
>> +    u32 val;
>> +
>> +    if (csid->top_base) {
>> +        val = OUTPUT_IFE_EN | INTERNAL_CSID;
>> +        writel_relaxed(val, csid->top_base + 
>> CSID_TOP_IO_PATH_CFG0(csid->id));
>> +    }
>> +}
>> +
>> +static void __csid_configure_rdi_stream(struct csid_device *csid, u8 
>> enable, u8 vc)
>> +{
>> +    u32 val;
>> +    u8 lane_cnt = csid->phy.lane_cnt;
>> +    /* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, 
>> Pad 2 -> RDI1, etc. */
>> +    struct v4l2_mbus_framefmt *input_format = 
>> &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
>> +    const struct csid_format *format = 
>> csid_get_fmt_entry(csid->formats, csid->nformats,
>> +                                  input_format->code);
>> +
>> +    if (!lane_cnt)
>> +        lane_cnt = 4;
>> +
>> +    val = 0;
>> +    writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
>> +
>> +    /*
>> +     * DT_ID is a two bit bitfield that is concatenated with
>> +     * the four least significant bits of the five bit VC
>> +     * bitfield to generate an internal CID value.
>> +     *
>> +     * CSID_RDI_CFG0(vc)
>> +     * DT_ID : 28:27
>> +     * VC    : 26:22
>> +     * DT    : 21:16
>> +     *
>> +     * CID   : VC 3:0 << 2 | DT_ID 1:0
>> +     */
>> +    u8 dt_id = vc & 0x03;
>> +
>> +    val = 1 << RDI_CFG0_TIMESTAMP_EN;
>> +    val |= 2 << RDI_CFG0_TIMESTAMP_STB_SEL;
>> +    /* note: for non-RDI path, this should be format->decode_format */
>> +    val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
>> +    val |= vc << RDI_CFG0_VC;
>> +    val |= format->data_type << RDI_CFG0_DT;
>> +    val |= dt_id << RDI_CFG0_DT_ID;
>> +
>> +    writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
>> +
>> +    val = 1 << RDI_CFG1_PACKING_FORMAT;
>> +    val |= 1 << RDI_CFG1_PIX_STORE;
>> +    val |= 1 << RDI_CFG1_DROP_H_EN;
>> +    val |= 1 << RDI_CFG1_DROP_V_EN;
>> +    val |= 1 << RDI_CFG1_CROP_H_EN;
>> +    val |= 1 << RDI_CFG1_CROP_V_EN;
>> +    val |= RDI_CFG1_EARLY_EOF_EN;
>> +
>> +    writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
>> +
>> +    val = 0;
>> +    writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
>> +
>> +    val = 1;
>> +    writel_relaxed(val, csid->base + 
>> CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
>> +
>> +    val = 0;
>> +    writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
>> +
>> +    val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
>> +    val |=  enable << RDI_CFG0_EN;
>> +    writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
>> +}
> 
> Hmm.
> 
> So I think 90% of the code here can be moved into a shared file - 
> ideally instantiated in gen2.c and then reused here rather than 
> copy/paste from one file to the other.
> 
> Lets sync up and try to get a unified tree for x1e80100 and sm8550 for 
> that purpose.
> 
> I think the code you have here is slightly further along that the 
> CSID/VFE stuff I've been working with.
> 
> But still - reductio ad absurdum - we need to functionally decompose and 
> not replicate code.
> 

Yes, agree, most of the code are same, but the difficult part is most of 
the code is configuring the register which are defined as macro 
definition, and they are different between different platform.

>> +
>> +static void csid_configure_stream(struct csid_device *csid, u8 enable)
>> +{
>> +    u8 i;
>> +
>> +    /* Loop through all enabled VCs and configure stream for each */
>> +    for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
>> +        if (csid->phy.en_vc & BIT(i)) {
>> +            __csid_configure_top(csid);
>> +            __csid_configure_rdi_stream(csid, enable, i);
>> +            __csid_configure_rx(csid, &csid->phy, i);
>> +            __csid_ctrl_rdi(csid, enable, i);
>> +        }
>> +}
> 
> Another example, straight copy/paste - we need to zap all of that.
> 
> ---
> bod

Thanks,
Depeng

