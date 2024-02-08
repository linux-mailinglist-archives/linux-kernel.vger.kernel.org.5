Return-Path: <linux-kernel+bounces-57874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175484DE76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17446285915
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7FF6A8A1;
	Thu,  8 Feb 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BTxHRlOS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540E41A88;
	Thu,  8 Feb 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388750; cv=none; b=qGjp9qm7NLvgaenzvHg4lcZcQxRfud6DSjlAFODnUsJ8tII9/OktVz6a/PgSSRIdKHm6oWy8TRH9Y9vVUfHB9RM0I/RTTm7+eJdm3BxtoRjoGAlReHSGI+3OBTHoCjtoF7SCKOpcmD1FyVHPgJUpxvCkR6wnYJELOOWuw/gz73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388750; c=relaxed/simple;
	bh=ChPuBbqgOqqYPEaW2BwH6XzfhgpJTmqg/qylBBkB8Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KCtwPTSdyF634//UcECpEaZUYBdabC7ewtxApNZATTNcp8Sh6xLVQfm4rV3DjdP5dc3s84ahRa4/Q1UFFoqgwe1rYS3QiLnJU30cueEoL3xC/Ubx9wJoGnzdkAtjXdRfiC4NXKTBoPOPZGXjzQN6wD3c3kxg5+0FFEDlBKkDeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BTxHRlOS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4188lplQ019681;
	Thu, 8 Feb 2024 10:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VCYj+6BYk05i84Jpje+CvtSGcyxK25vY9GPZ/O/U9wM=; b=BT
	xHRlOSjprkzJnuek2e8MN9o5bBoRlZ7yHV1IgbiIH3KZlzQ8lAw0cBLEKKOHE8kQ
	weEKkTH9M/l0NNIw7dClftn0a1DgFbnqN78yKWsTXy5pFTICL/+meI7ShhGDkWwD
	xG49S0ow7Z9MYJt8JDZtrwsImvoaT22b8qn4FEyvKonwehYpWV1zoehwd5Eyflz7
	QZnoo+rYDKzZ4Ms/k0kc/yxDLJGZtgjGtflc42q3HvLsMAfw7l4+LGWyjhuUr7Ik
	b2cbUPPy6YICzTeOw0pymtpA3/Uuujq70WLN87HotYFkXiL0SkR3h1ty851VfmPK
	HFoo/kK7Y/IBDsHziYng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4frwsvq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:39:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418Ad336003983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 10:39:03 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 02:38:59 -0800
Message-ID: <079ef9dc-fe21-2a28-9540-7395af0c4282@quicinc.com>
Date: Thu, 8 Feb 2024 16:08:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] remoteproc: qcom_q6v5_pas: Unload lite firmware on
 ADSP
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org>
 <20240129-x1e80100-remoteproc-v1-3-15d21ef58a4b@linaro.org>
 <CAA8EJporoBQQtrRWL5SS4qwpmu0rF6UMpaZXQ5t-qdvoW53XOA@mail.gmail.com>
 <ZboTMVx7SN1BBoaz@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZboTMVx7SN1BBoaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8IPKluktH-kK2P5TVffwT_SODUC4RHLr
X-Proofpoint-GUID: 8IPKluktH-kK2P5TVffwT_SODUC4RHLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080055



On 1/31/24 15:00, Abel Vesa wrote:
> On 24-01-29 17:17:28, Dmitry Baryshkov wrote:
>> On Mon, 29 Jan 2024 at 15:35, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>
>>> From: Sibi Sankar <quic_sibis@quicinc.com>
>>>
>>> The UEFI loads a lite variant of the ADSP firmware to support charging
>>> use cases. The kernel needs to unload and reload it with the firmware
>>> that has full feature support for audio. This patch arbitarily shutsdown
>>> the lite firmware before loading the full firmware.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>   drivers/remoteproc/qcom_q6v5_pas.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>>> index 083d71f80e5c..4f6940368eb4 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>>> @@ -39,6 +39,7 @@ struct adsp_data {
>>>          const char *dtb_firmware_name;
>>>          int pas_id;
>>>          int dtb_pas_id;
>>> +       int lite_pas_id;
>>>          unsigned int minidump_id;
>>>          bool auto_boot;
>>>          bool decrypt_shutdown;
>>> @@ -72,6 +73,7 @@ struct qcom_adsp {
>>>          const char *dtb_firmware_name;
>>>          int pas_id;
>>>          int dtb_pas_id;
>>> +       int lite_pas_id;
>>>          unsigned int minidump_id;
>>>          int crash_reason_smem;
>>>          bool decrypt_shutdown;
>>> @@ -210,6 +212,10 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>>>          /* Store firmware handle to be used in adsp_start() */
>>>          adsp->firmware = fw;
>>>
>>> +       /* WIP: Shutdown the ADSP if it's running a lite version of the firmware*/
>>
>> Why is it still marked as WIP?
> 
> AFAIU, there was more to be done here w.r.t. preloaded lite version
> firmware.
> 
> Later, was agreed that that is not case.
> 
> So maybe I just need to drop the comment.
> 
> Sibi, can you confirm?

ack, this is the best we can currently do. Please drop the comment when
you re-spin the series. Thanks for sending this out.

-Sibi

> 
>>
>>> +       if (adsp->lite_pas_id)
>>> +               ret = qcom_scm_pas_shutdown(adsp->lite_pas_id);
>>> +
>>>          if (adsp->dtb_pas_id) {
>>>                  ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
>>>                  if (ret) {
>>> @@ -693,6 +699,7 @@ static int adsp_probe(struct platform_device *pdev)
>>>          adsp->rproc = rproc;
>>>          adsp->minidump_id = desc->minidump_id;
>>>          adsp->pas_id = desc->pas_id;
>>> +       adsp->lite_pas_id = desc->lite_pas_id;
>>>          adsp->info_name = desc->sysmon_name;
>>>          adsp->decrypt_shutdown = desc->decrypt_shutdown;
>>>          adsp->region_assign_idx = desc->region_assign_idx;
>>> @@ -990,6 +997,7 @@ static const struct adsp_data x1e80100_adsp_resource = {
>>>          .dtb_firmware_name = "adsp_dtb.mdt",
>>>          .pas_id = 1,
>>>          .dtb_pas_id = 0x24,
>>> +       .lite_pas_id = 0x1f,
>>>          .minidump_id = 5,
>>>          .auto_boot = true,
>>>          .proxy_pd_names = (char*[]){
>>>
>>> --
>>> 2.34.1
>>>
>>>
>>
>>
>> -- 
>> With best wishes
>> Dmitry

