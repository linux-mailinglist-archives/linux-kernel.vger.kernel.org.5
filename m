Return-Path: <linux-kernel+bounces-3002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD98165F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EFFB213C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016363C0;
	Mon, 18 Dec 2023 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ka1tIBVd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2D63A3;
	Mon, 18 Dec 2023 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI3hLAP003345;
	Mon, 18 Dec 2023 04:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fT5vSV1woK64grEbBLf1B4VyryFJfK9/zEZyxGB8gKY=; b=ka
	1tIBVdKjSrQ4Aja58rjI3YXncSI9tYBC+c/8JO+uScgMMxXw4sFk+Skv6N6ywhS1
	ldY9Yfz6pQgSeDZlaTTj+6EgBBOhhByHK34H9qXkDkRiTD583TuksaIozftK0SFt
	U6pr7YKdzfnxMZ+KrNScJqXyYVM3T69ZWUeVVS/AZR3CDGr4FEF2C0ZtDZO9frHT
	NxnSy3U2nHodXmFHmQeGO90lqYmDU9vA1/6kXsK41Wm3REdebkWaKBEX3DLTcBAc
	nidSbTpNiiuFKNUsaKl15xNJukSudiUoDG+6idy91VEk3yvNVXuRD/25oIfGLBtd
	7T9lya8CD90kYivsIDMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xvud0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:59:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI4xwlY017135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:59:58 GMT
Received: from [10.201.3.200] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 20:59:54 -0800
Message-ID: <aa5df30c-2c94-4fd2-b907-383fc01364d4@quicinc.com>
Date: Mon, 18 Dec 2023 10:29:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Get crash reason from specific
 SMEM partition
To: Bjorn Andersson <andersson@kernel.org>
CC: <agross@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_anusha@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20231124185059.3395563-1-quic_viswanat@quicinc.com>
 <oxy6ht52r6dlhho43vlrefaljxtvnal557iloobulwcdjxxedq@67iexdnjv2yw>
Content-Language: en-US
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <oxy6ht52r6dlhho43vlrefaljxtvnal557iloobulwcdjxxedq@67iexdnjv2yw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RlwWTfeOe1985I8G5fa72rbFlOpCtgt8
X-Proofpoint-ORIG-GUID: RlwWTfeOe1985I8G5fa72rbFlOpCtgt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180033



On 12/18/2023 2:13 AM, Bjorn Andersson wrote:
> On Sat, Nov 25, 2023 at 12:20:59AM +0530, Vignesh Viswanathan wrote:
>> q6v5 fatal and watchdog IRQ handlers always retrieves the crash reason
>> information from SMEM global partition (QCOM_SMEM_HOST_ANY).
>>
>> For some targets like IPQ9574 and IPQ5332, crash reason information is
>> present in target specific partition due to which the crash reason is
>> not printed in the current implementation.
>>
>> Add support to pass crash_reason_smem_id along with crash_reason item
>> number in qcom_q6v5_init call and use the same to get the crash
>> information from SMEM in fatal and watchdog IRQ handlers.
>>
>> This patch depends on [1] which adds support for IPQ9574 and IPQ5332
>> remoteproc q5v5_mpd driver.
> 
> This is solely here to ensure things are applied in appropriate order,
> there's no benefit in documenting it in the eternal git history. So
> please move this comment below the "---" line.
> 
Ack. Will move this below in V2.
>>
>> [1]: https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/
>>
>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>> ---
>>  drivers/remoteproc/qcom_q6v5.c      | 10 +++++++---
>>  drivers/remoteproc/qcom_q6v5.h      |  4 +++-
>>  drivers/remoteproc/qcom_q6v5_adsp.c |  3 ++-
>>  drivers/remoteproc/qcom_q6v5_mpd.c  |  2 +-
>>  drivers/remoteproc/qcom_q6v5_mss.c  |  5 +++--
>>  drivers/remoteproc/qcom_q6v5_pas.c  |  3 ++-
>>  drivers/remoteproc/qcom_q6v5_wcss.c |  4 +++-
>>  7 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>> index 0e32f13c196d..072e41730110 100644
>> --- a/drivers/remoteproc/qcom_q6v5.c
>> +++ b/drivers/remoteproc/qcom_q6v5.c
>> @@ -100,7 +100,8 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>>  		return IRQ_HANDLED;
>>  	}
>>  
>> -	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
>> +	msg = qcom_smem_get(q6v5->crash_reason_smem_id, q6v5->crash_reason,
>> +			    &len);
> 
> No need to break lines that are just slightly over 80 characters...

Ack.
> 
>>  	if (!IS_ERR(msg) && len > 0 && msg[0])
>>  		dev_err(q6v5->dev, "watchdog received: %s\n", msg);
>>  	else
>> @@ -121,7 +122,8 @@ irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>  	if (!q6v5->running)
>>  		return IRQ_HANDLED;
>>  
>> -	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
>> +	msg = qcom_smem_get(q6v5->crash_reason_smem_id, q6v5->crash_reason,
>> +			    &len);
>>  	if (!IS_ERR(msg) && len > 0 && msg[0])
>>  		dev_err(q6v5->dev, "fatal error received: %s\n", msg);
>>  	else
>> @@ -279,7 +281,8 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>>   * Return: 0 on success, negative errno on failure
>>   */
>>  int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>> -		   struct rproc *rproc, int crash_reason, const char *load_state,
>> +		   struct rproc *rproc, int crash_reason,
>> +		   int crash_reason_smem_id, const char *load_state,
>>  		   void (*handover)(struct qcom_q6v5 *q6v5))
>>  {
>>  	int ret;
>> @@ -287,6 +290,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>  	q6v5->rproc = rproc;
>>  	q6v5->dev = &pdev->dev;
>>  	q6v5->crash_reason = crash_reason;
>> +	q6v5->crash_reason_smem_id = crash_reason_smem_id;
>>  	q6v5->handover = handover;
>>  
>>  	init_completion(&q6v5->start_done);
>> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
>> index 4e1bb1a68284..21cd879e6e1e 100644
>> --- a/drivers/remoteproc/qcom_q6v5.h
>> +++ b/drivers/remoteproc/qcom_q6v5.h
>> @@ -41,6 +41,7 @@ struct qcom_q6v5 {
>>  	struct completion spawn_done;
>>  
>>  	int crash_reason;
>> +	int crash_reason_smem_id;
> 
> While this is called "smem_id" in some places, you refer to it as SMEM
> partition in the commit message - and that's much less confusing.
> 
> So please rename this.
> 

Sure, partition makes more sense in this context. Will rename.
>>  
>>  	bool running;
>>  
>> @@ -49,7 +50,8 @@ struct qcom_q6v5 {
>>  };
>>  
>>  int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>> -		   struct rproc *rproc, int crash_reason, const char *load_state,
>> +		   struct rproc *rproc, int crash_reason,
>> +		   int crash_reason_smem_id, const char *load_state,
> 
> To me it would be more natural if the most significant specifier was
> given before the least significant specifier. Please swap the partition
> and item parameters...
> 
> Regards,
> Bjorn

Ack.

Thanks,
Vignesh
> 
>>  		   void (*handover)(struct qcom_q6v5 *q6v5));
>>  void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>>  
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 6c67514cc493..30d91205f199 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -732,7 +732,8 @@ static int adsp_probe(struct platform_device *pdev)
>>  		goto disable_pm;
>>  
>>  	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
>> -			     desc->load_state, qcom_adsp_pil_handover);
>> +			     QCOM_SMEM_HOST_ANY, desc->load_state,
>> +			     qcom_adsp_pil_handover);
>>  	if (ret)
>>  		goto disable_pm;
>>  
>> diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
>> index b133285888c7..839f6a15b88d 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mpd.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mpd.c
>> @@ -726,7 +726,7 @@ static int q6_wcss_probe(struct platform_device *pdev)
>>  		goto free_rproc;
>>  
>>  	ret = qcom_q6v5_init(&wcss->q6, pdev, rproc,
>> -			     WCSS_CRASH_REASON, NULL, NULL);
>> +			     WCSS_CRASH_REASON, WCSS_SMEM_HOST, NULL, NULL);
>>  	if (ret)
>>  		goto free_rproc;
>>  
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 394b2c1cb5e2..45ecb87d73ef 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/remoteproc.h>
>>  #include <linux/reset.h>
>>  #include <linux/soc/qcom/mdt_loader.h>
>> +#include <linux/soc/qcom/smem.h>
>>  #include <linux/iopoll.h>
>>  #include <linux/slab.h>
>>  
>> @@ -2093,8 +2094,8 @@ static int q6v5_probe(struct platform_device *pdev)
>>  	qproc->need_mem_protection = desc->need_mem_protection;
>>  	qproc->has_mba_logs = desc->has_mba_logs;
>>  
>> -	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
>> -			     qcom_msa_handover);
>> +	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
>> +			     QCOM_SMEM_HOST_ANY, "modem", qcom_msa_handover);
>>  	if (ret)
>>  		goto detach_proxy_pds;
>>  
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 913a5d2068e8..6a29b6ab181f 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -728,7 +728,8 @@ static int adsp_probe(struct platform_device *pdev)
>>  		goto free_rproc;
>>  	adsp->proxy_pd_count = ret;
>>  
>> -	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem, desc->load_state,
>> +	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
>> +			     QCOM_SMEM_HOST_ANY, desc->load_state,
>>  			     qcom_pas_handover);
>>  	if (ret)
>>  		goto detach_proxy_pds;
>> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
>> index cff1fa07d1de..077ecfa2cf86 100644
>> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/reset.h>
>>  #include <linux/soc/qcom/mdt_loader.h>
>> +#include <linux/soc/qcom/smem.h>
>>  #include "qcom_common.h"
>>  #include "qcom_pil_info.h"
>>  #include "qcom_q6v5.h"
>> @@ -1047,7 +1048,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto free_rproc;
>>  
>> -	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
>> +	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem,
>> +			     QCOM_SMEM_HOST_ANY, NULL, NULL);
>>  	if (ret)
>>  		goto free_rproc;
>>  
>> -- 
>> 2.41.0
>>

