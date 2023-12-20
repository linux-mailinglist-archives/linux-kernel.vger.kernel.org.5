Return-Path: <linux-kernel+bounces-6533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AEA819A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1E1F21B93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2B18AF1;
	Wed, 20 Dec 2023 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j4awItQf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434701DDCF;
	Wed, 20 Dec 2023 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6l8HG001980;
	Wed, 20 Dec 2023 08:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IuU6xFjjZL5UaQ3lTd9QxPwDsO6Scr8/kFeEUWr+wVA=; b=j4
	awItQfFxDz9rv2FuETLDjAbZiJUDkhwQ9hKxG24wVtY+zpXgQqz/JETP1tohQQjc
	GRfMN/nmFXBjFKMaJIyIIas4ICrxSE8v0DbtuQdIgf1frjbVdBftYvsLf9VpMfui
	EtLOktLVG/wYEL7CKf09v5vkBXzjh75hqHGhI/Dr5Ii4tygKH2cRTnsuYe1XUqei
	KnLl4LZIgDAdnqJHwVuJdtVWAZ4WPBeiSKGVgGJaLnANjH/Nk2J5lW5YwwmKZY4C
	rreuH6BrTyTc+hmreJSA8rdTLmhhw3Km3fgGat8z/JhtW6Zf4sJPXC1eYNm2zQbp
	nHFf5pNJiR2X9tIGX1mw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35tmb8b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:05:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK85rna016214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:05:53 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:05:49 -0800
Message-ID: <41f356cc-87d6-0dcb-82fa-e158f72e8383@quicinc.com>
Date: Wed, 20 Dec 2023 13:35:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/34] media: iris: initialize shared queues for host
 and firmware communication
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-10-git-send-email-quic_dikshita@quicinc.com>
 <057c9f67-3ef6-438a-91bf-996c3c45c6d5@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <057c9f67-3ef6-438a-91bf-996c3c45c6d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _70epjBZCQTD5Uasr-RjHegttjtbrlNf
X-Proofpoint-ORIG-GUID: _70epjBZCQTD5Uasr-RjHegttjtbrlNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200055



On 12/19/2023 12:16 AM, Dmitry Baryshkov wrote:
> On 18/12/2023 13:32, Dikshita Agarwal wrote:
>> Shared queues are used for communication between driver and firmware.
>> There are 3 types of queues:
>> Command queue - driver to write any command to firmware.
>> Message queue - firmware to send any response to driver.
>> Debug queue - firmware to write debug message.
>>
>> Above queues are initialized and configured to firmware during probe.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/vcodec/iris/Makefile   |  2 ++
>>   .../media/platform/qcom/vcodec/iris/iris_core.h    | 11 ++++++++
>>   .../media/platform/qcom/vcodec/iris/iris_probe.c   | 31
>> ++++++++++++++++++++++
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile
>> b/drivers/media/platform/qcom/vcodec/iris/Makefile
>> index 12a74de..59798e5d 100644
>> --- a/drivers/media/platform/qcom/vcodec/iris/Makefile
>> +++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
>> @@ -1,3 +1,5 @@
>> +iris-objs += ../hfi_queue.o
>> +
>>   iris-objs += iris_probe.o \
>>                resources.o \
>>                iris_state.o
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> index 56a5b7d..77124f9 100644
>> --- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> @@ -9,6 +9,7 @@
>>   #include <linux/types.h>
>>   #include <media/v4l2-device.h>
>>   +#include "../hfi_queue.h"
>>   #include "iris_state.h"
>>     /**
>> @@ -30,6 +31,11 @@
>>    * @reset_tbl: table of iris reset clocks
>>    * @reset_count: count of iris reset clocks
>>    * @state: current state of core
>> + * @iface_q_table: Interface queue table memory
>> + * @command_queue: shared interface queue to send commands to firmware
>> + * @message_queue: shared interface queue to receive responses from
>> firmware
>> + * @debug_queue: shared interface queue to receive debug info from firmware
>> + * @sfr: SFR register memory
>>    */
>>     struct iris_core {
>> @@ -49,6 +55,11 @@ struct iris_core {
>>       struct reset_info            *reset_tbl;
>>       u32                    reset_count;
>>       enum iris_core_state            state;
>> +    struct mem_desc                iface_q_table;
>> +    struct iface_q_info            command_queue;
>> +    struct iface_q_info            message_queue;
>> +    struct iface_q_info            debug_queue;
>> +    struct mem_desc                sfr;
>>   };
>>     #endif
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
>> b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
>> index 7bb9c92..fd349a3 100644
>> --- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
>> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   +#include "../hfi_queue.h"
>>   #include "iris_core.h"
>>   #include "resources.h"
>>   @@ -50,6 +51,10 @@ static void iris_remove(struct platform_device *pdev)
>>       if (!core)
>>           return;
>>   +    hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
>> +             &core->command_queue, &core->message_queue,
>> +             &core->debug_queue);
>> +
>>       video_unregister_device(core->vdev_dec);
>>         v4l2_device_unregister(&core->v4l2_dev);
>> @@ -59,6 +64,7 @@ static int iris_probe(struct platform_device *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>>       struct iris_core *core;
>> +    u64 dma_mask;
>>       int ret;
>>         core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
>> @@ -91,8 +97,33 @@ static int iris_probe(struct platform_device *pdev)
>>         platform_set_drvdata(pdev, core);
>>   +    /*
>> +     * Specify the max value of address space, which can be used
>> +     * for buffer transactions.
>> +     */
>> +    dma_mask = DMA_BIT_MASK(32);
>> +    dma_mask &= ~BIT(29);
>> +
>> +    ret = dma_set_mask_and_coherent(dev, dma_mask);
>> +    if (ret)
>> +        goto err_vdev_unreg;
>> +
>> +    dma_set_max_seg_size(&pdev->dev, (unsigned int)DMA_BIT_MASK(32));
>> +    dma_set_seg_boundary(&pdev->dev, (unsigned long)DMA_BIT_MASK(64));
> 
> This isn't related to queues.
> 
Using this DMA mask, we define the upper limit of memory to be used to
allocate the queues, hence this is added with this patch.
>> +
>> +    ret = hfi_queue_init(core->dev, &core->iface_q_table, &core->sfr,
>> +                 &core->command_queue, &core->message_queue,
>> +                 &core->debug_queue, core);
>> +    if (ret) {
>> +        dev_err_probe(core->dev, ret,
>> +                  "%s: interface queues init failed\n", __func__);
>> +        goto err_vdev_unreg;
>> +    }
>> +
>>       return ret;
>>   +err_vdev_unreg:
>> +    iris_unregister_video_device(core);
>>   err_v4l2_unreg:
>>       v4l2_device_unregister(&core->v4l2_dev);
>>   
> 

