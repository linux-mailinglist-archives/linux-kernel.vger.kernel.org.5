Return-Path: <linux-kernel+bounces-4679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107B81808B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892D81F23E51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64006AA2;
	Tue, 19 Dec 2023 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S/fa/fRp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576455393;
	Tue, 19 Dec 2023 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ4B90q019855;
	Tue, 19 Dec 2023 04:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1LvdRBEmgzoZYtKVp4qSaWGEgf9dojAOAXCcX+993A0=; b=S/
	fa/fRpKahcgWO2CrRKlCOq0e/b1eBvbJCqG1oMQWePnIZlStOSxwLgnRmXtHR600
	4pBQ+PdLTBtSQ4EEckJnW6qW5BS4zBhnTIYMWFV8ijdiLaqbFMgZegZFkKTpyMjh
	g0iiNfKf/7/oD+Ay9+befj5dv7dODGQqq4+2oKyIU/5bg57+BLbGp76A24K/Y8r9
	FMxpz7aoSeIONIiVqK9+9bRw1DFUahA7UGRHLKdWbjBfpDk1DAjQbIHKrI6CjowF
	ervDkMqoHtqimSOr1nnElYK4yQqw+lC0zjDekEcbCW4e+SrXHvN5Ax6PmBRkMk47
	KL2HxiITlBvCfqLP9pFg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2ghdjrn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 04:28:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ4SdIu010960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 04:28:39 GMT
Received: from [10.201.3.200] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 20:28:35 -0800
Message-ID: <f24f5cd5-2425-4bde-ab01-f351bb621de5@quicinc.com>
Date: Tue, 19 Dec 2023 09:58:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] remoteproc: qcom: q6v5: Get crash reason from specific
 SMEM partition
To: Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_anusha@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20231218061042.3015013-1-quic_viswanat@quicinc.com>
 <3a3bdbaf-2022-88d7-a0ff-6b98c7e5ab7e@quicinc.com>
Content-Language: en-US
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <3a3bdbaf-2022-88d7-a0ff-6b98c7e5ab7e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b50lhe5VC5NUuM9-EcvM6i1EFJjYGPtu
X-Proofpoint-ORIG-GUID: b50lhe5VC5NUuM9-EcvM6i1EFJjYGPtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=950 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190030



On 12/18/2023 9:26 PM, Mukesh Ojha wrote:
> 
> 
> On 12/18/2023 11:40 AM, Vignesh Viswanathan wrote:
>> q6v5 fatal and watchdog IRQ handlers always retrieves the crash reason
>> information from SMEM global partition (QCOM_SMEM_HOST_ANY).
>>
>> For some targets like IPQ9574 and IPQ5332, crash reason information is
>> present in target specific partition due to which the crash reason is
>> not printed in the current implementation.
>>
>> Add support to pass crash_reason_partition along with crash_reason_item
>> number in qcom_q6v5_init call and use the same to get the crash
>> information from SMEM in fatal and watchdog IRQ handlers.
>>
>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>> ---
>> Changes in V3: Updated commit message.
>> Changes in V2: Addressed comments in V1.
>>
>> This patch depends on [1] which adds support for IPQ9574 and IPQ5332
>> remoteproc q5v5_mpd driver.
>>
>> [1]: https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/
>>
>>   drivers/remoteproc/qcom_q6v5.c      | 10 ++++++----
>>   drivers/remoteproc/qcom_q6v5.h      |  6 ++++--
>>   drivers/remoteproc/qcom_q6v5_adsp.c |  5 +++--
>>   drivers/remoteproc/qcom_q6v5_mpd.c  | 14 ++++++++------
>>   drivers/remoteproc/qcom_q6v5_mss.c  |  5 +++--
>>   drivers/remoteproc/qcom_q6v5_pas.c  |  3 ++-
>>   drivers/remoteproc/qcom_q6v5_wcss.c |  4 +++-
>>   7 files changed, 29 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>> index 0e32f13c196d..e4a28bf25130 100644
>> --- a/drivers/remoteproc/qcom_q6v5.c
>> +++ b/drivers/remoteproc/qcom_q6v5.c
>> @@ -100,7 +100,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>>           return IRQ_HANDLED;
>>       }
>>   -    msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
>> +    msg = qcom_smem_get(q6v5->crash_reason_partition, q6v5->crash_reason_item, &len);
>>       if (!IS_ERR(msg) && len > 0 && msg[0])
>>           dev_err(q6v5->dev, "watchdog received: %s\n", msg);
>>       else
>> @@ -121,7 +121,7 @@ irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>       if (!q6v5->running)
>>           return IRQ_HANDLED;
>>   -    msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
>> +    msg = qcom_smem_get(q6v5->crash_reason_partition, q6v5->crash_reason_item, &len);
>>       if (!IS_ERR(msg) && len > 0 && msg[0])
>>           dev_err(q6v5->dev, "fatal error received: %s\n", msg);
>>       else
>> @@ -279,14 +279,16 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>>    * Return: 0 on success, negative errno on failure
>>    */
>>   int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>> -           struct rproc *rproc, int crash_reason, const char *load_state,
>> +           struct rproc *rproc, int crash_reason_partition,
>> +           int crash_reason_item, const char *load_state,
>>              void (*handover)(struct qcom_q6v5 *q6v5))
>>   {
>>       int ret;
>>         q6v5->rproc = rproc;
>>       q6v5->dev = &pdev->dev;
>> -    q6v5->crash_reason = crash_reason;
>> +    q6v5->crash_reason_partition = crash_reason_partition;
>> +    q6v5->crash_reason_item = crash_reason_item;
>>       q6v5->handover = handover;
>>         init_completion(&q6v5->start_done);
>> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
>> index 4e1bb1a68284..cd02372e9856 100644
>> --- a/drivers/remoteproc/qcom_q6v5.h
>> +++ b/drivers/remoteproc/qcom_q6v5.h
>> @@ -40,7 +40,8 @@ struct qcom_q6v5 {
>>       struct completion stop_done;
>>       struct completion spawn_done;
>>   -    int crash_reason;
>> +    int crash_reason_partition;
>> +    int crash_reason_item;
>>         bool running;
>>   @@ -49,7 +50,8 @@ struct qcom_q6v5 {
>>   };
>>     int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>> -           struct rproc *rproc, int crash_reason, const char *load_state,
>> +           struct rproc *rproc, int crash_reason_partition,
>> +           int crash_reason_item, const char *load_state,
>>              void (*handover)(struct qcom_q6v5 *q6v5));
>>   void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>>   diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 6c67514cc493..8feb2eb45737 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -731,8 +731,9 @@ static int adsp_probe(struct platform_device *pdev)
>>       if (ret)
>>           goto disable_pm;
>>   -    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
>> -                 desc->load_state, qcom_adsp_pil_handover);
>> +    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>> +                 desc->crash_reason_smem, desc->load_state,
> 
> Can we also rename this ->crash_reason_smem to ->crash_reason_item to
> proper reflect its meaning ?
> 
> -Mukesh

Ack. Quick search shows this is used in qcom_q6v5_adsp.c, qcom_q6v5_pas.c
and qcom_q6v5_wcss.c. Will change across all the files.

Thanks,
Vignesh
> 
>> +                 qcom_adsp_pil_handover);
>>       if (ret)
>>           goto disable_pm;
>>   diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
>> index b133285888c7..c893deac30e1 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mpd.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mpd.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/of_reserved_mem.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/reset.h>
>> @@ -555,9 +556,9 @@ static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
>>       return 0;
>>   }
>>   -static int init_irq(struct qcom_q6v5 *q6,
>> -            struct platform_device *pdev, struct rproc *rproc,
>> -            int crash_reason, const char *load_state,
>> +static int init_irq(struct qcom_q6v5 *q6, struct platform_device *pdev,
>> +            struct rproc *rproc, int crash_reason_partition,
>> +            int crash_reason_item, const char *load_state,
>>               void (*handover)(struct qcom_q6v5 *q6))
>>   {
>>       int ret;
>> @@ -565,7 +566,8 @@ static int init_irq(struct qcom_q6v5 *q6,
>>         q6->rproc = rproc;
>>       q6->dev = &pdev->dev;
>> -    q6->crash_reason = crash_reason;
>> +    q6->crash_reason_partition = crash_reason_partition;
>> +    q6->crash_reason_item = crash_reason_item;
>>       q6->handover = handover;
>>         init_completion(&q6->start_done);
>> @@ -666,7 +668,7 @@ static int q6_register_userpd(struct platform_device *pdev,
>>       if (ret)
>>           goto free_rproc;
>>   -    ret = init_irq(&wcss->q6, userpd_pdev, rproc,
>> +    ret = init_irq(&wcss->q6, userpd_pdev, rproc, WCSS_SMEM_HOST,
>>                  WCSS_CRASH_REASON, NULL, NULL);
>>       if (ret)
>>           goto free_rproc;
>> @@ -725,7 +727,7 @@ static int q6_wcss_probe(struct platform_device *pdev)
>>       if (ret)
>>           goto free_rproc;
>>   -    ret = qcom_q6v5_init(&wcss->q6, pdev, rproc,
>> +    ret = qcom_q6v5_init(&wcss->q6, pdev, rproc, WCSS_SMEM_HOST,
>>                    WCSS_CRASH_REASON, NULL, NULL);
>>       if (ret)
>>           goto free_rproc;
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 394b2c1cb5e2..48f115f9337b 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/remoteproc.h>
>>   #include <linux/reset.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>> +#include <linux/soc/qcom/smem.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/slab.h>
>>   @@ -2093,8 +2094,8 @@ static int q6v5_probe(struct platform_device *pdev)
>>       qproc->need_mem_protection = desc->need_mem_protection;
>>       qproc->has_mba_logs = desc->has_mba_logs;
>>   -    ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
>> -                 qcom_msa_handover);
>> +    ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>> +                 MPSS_CRASH_REASON_SMEM, "modem", qcom_msa_handover);
>>       if (ret)
>>           goto detach_proxy_pds;
>>   diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 913a5d2068e8..bfadc7bd4b51 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -728,7 +728,8 @@ static int adsp_probe(struct platform_device *pdev)
>>           goto free_rproc;
>>       adsp->proxy_pd_count = ret;
>>   -    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem, desc->load_state,
>> +    ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>> +                 desc->crash_reason_smem, desc->load_state,
>>                    qcom_pas_handover);
>>       if (ret)
>>           goto detach_proxy_pds;
>> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
>> index cff1fa07d1de..29510bbefa2e 100644
>> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/reset.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>> +#include <linux/soc/qcom/smem.h>
>>   #include "qcom_common.h"
>>   #include "qcom_pil_info.h"
>>   #include "qcom_q6v5.h"
>> @@ -1047,7 +1048,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>       if (ret)
>>           goto free_rproc;
>>   -    ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
>> +    ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
>> +                 desc->crash_reason_smem, NULL, NULL);
>>       if (ret)
>>           goto free_rproc;
>>   

