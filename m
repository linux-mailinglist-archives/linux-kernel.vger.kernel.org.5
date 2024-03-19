Return-Path: <linux-kernel+bounces-107361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5F87FB75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365171F21CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BA7D411;
	Tue, 19 Mar 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nuwJGmP+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E27D09C;
	Tue, 19 Mar 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842962; cv=none; b=Z+7u/tST0BtiEVv8ecp9e17zPrTVTEl0i5BZnWIiguybJ/4CrqWrv8rkcmGOOqa7YWzXHvCJSUzPy/5eie/7QYRzS8FK6kkDozGpFOhdxp1hKslNzA+aJpreqVTBrcyjaS0z60gFPffTOJ6AzSkr28hKPEvK14NlIaVmPqYD6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842962; c=relaxed/simple;
	bh=xGJDbsZKvq2Emit+5VbDjlvHBUP+akl2oFUb1saBNjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C/WjFlhfVwvfFMRKQgNvEoRgBk+LkGDJLyLY8OQchoEOyh+lYtDwBeZSXR0+1W6pGzTV+iB93ytbuQzEH6eq1f/8PpE6Fgm8PjLSaSMkBn+Fki3h750B+sy5wYhSXOtR5xTqPpfH4+jr5xC1CVZPMKtrZz9BeEKLQKqpnqMfW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nuwJGmP+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J4jDEr002997;
	Tue, 19 Mar 2024 10:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kDOjZxW1p0LT0bmGpnmE75Mvzuk6xn+HCXu4M0peMuM=; b=nu
	wJGmP+DRqFW9S5W00wBv5TForgJ1rVq4IdJD/Oy0gMjwzlqN7OZecTBJe7e6n75s
	NDp+wc1eeALc2LX+/tqnmjv4K3opJfgILTja56tGIfqCRi+o8EOJaqWXtuJXl5/M
	KLNparCjhCVFmyKM2gSjan/yRI72+eZ6+EiZMusqQ7Qg4AoO4QDcEq8RXsmnIJSs
	co2qZP7z/d6DvWwa6+5jkHTkfR4Upothi9mdGN9s4u8gaQx2u/0B9ZtSQTzDgSqU
	o/5lW6ybPEqatcMhZyR0gmQDZ794VToYn15XKqpscQ28Z57U9YYpcWfPS38hucCI
	MFCRuw6D1G+omjBqZ9bw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2cjru55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:09:12 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JA9Bdl010389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:09:11 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 03:09:08 -0700
Message-ID: <fce3beb8-7d70-672c-e25b-d46810c4d1dd@quicinc.com>
Date: Tue, 19 Mar 2024 15:38:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-8-quic_mojha@quicinc.com>
 <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
 <260371ff-da7a-8406-0511-4019f6b860bf@quicinc.com>
 <03367100-1ad4-4d83-8200-5879550398be@quicinc.com>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <03367100-1ad4-4d83-8200-5879550398be@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tH8PhIXpZW1zcbMQNH3QuCE_fIY8fdXL
X-Proofpoint-GUID: tH8PhIXpZW1zcbMQNH3QuCE_fIY8fdXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403190077



On 3/19/2024 6:47 AM, Pavan Kondeti wrote:
> On Mon, Mar 18, 2024 at 06:38:20PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 3/3/2024 12:55 AM, Bjorn Andersson wrote:
>>> On Tue, Feb 27, 2024 at 09:23:06PM +0530, Mukesh Ojha wrote:
>>>> qcom_scm_is_available() gives wrong indication if __scm
>>>> is initialized but __scm->dev is not.
>>>>
>>>> Fix this appropriately by making sure if __scm is
>>>> initialized and then it is associated with its
>>>> device.
>>>>
>>>
>>> This seems like a bug fix, and should as such have a Fixes: tag and
>>> probably Cc: stable@vger.kernel.org
>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>>    drivers/firmware/qcom/qcom_scm.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>>> index 6c252cddd44e..6f14254c0c10 100644
>>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>>> @@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>    	if (!scm)
>>>>    		return -ENOMEM;
>>>> +	scm->dev = &pdev->dev;
>>>>    	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
>>>>    	if (ret < 0)
>>>>    		return ret;
>>>> @@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>    		return ret;
>>>>    	__scm = scm;
>>>> -	__scm->dev = &pdev->dev;
>>>
>>> Is it sufficient to just move the line up, or do we need a barrier of
>>> some sort here?
>>
>> Would be good to use, smp_mb() before the assignment
>>       __scm = scm
>> along with moving below line
>> __scm->dev = &pdev->dev
>>
> 
> Full memory barrier is not needed here. store variant is sufficient.
> WRITE_ONCE() + smp_store_release() will fit here no?

Thanks for the comment, i again have a look at it and agree we don't
need a full barrier here.

And we can do either of the below two ways.

-Mukesh


// 1st way

diff --git a/drivers/firmware/qcom/qcom_scm.c 
b/drivers/firmware/qcom/qcom_scm.c
index 49ddbcab0680..b638fb407fc6 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1741,7 +1741,12 @@ static int qcom_scm_qseecom_init(struct qcom_scm 
*scm)
   */
  bool qcom_scm_is_available(void)
  {
-       return !!__scm;
+       bool avail;
   */
  bool qcom_scm_is_available(void)
  {
-       return !!__scm;
+       bool avail;
+
+       avail = !!READ_ONCE(__scm);
+       smp_rmb();
+
+       return avail;
  }
  EXPORT_SYMBOL_GPL(qcom_scm_is_available);

@@ -1822,10 +1827,12 @@ static int qcom_scm_probe(struct platform_device 
*pdev)
         if (!scm)
                 return -ENOMEM;

+       scm->dev = &pdev->dev;
         ret = qcom_scm_find_dload_address(&pdev->dev, 
&scm->dload_mode_addr);
         if (ret < 0)
                 return ret;

+       init_completion(&scm->waitq_comp);
         mutex_init(&scm->scm_bw_lock);

         scm->path = devm_of_icc_get(&pdev->dev, NULL);
@@ -1857,10 +1864,8 @@ static int qcom_scm_probe(struct platform_device 
*pdev)
         if (ret)
                 return ret;

-       __scm = scm;
-       __scm->dev = &pdev->dev;
-
-       init_completion(&__scm->waitq_comp);
+       smp_wmb();
+       WRITE_ONCE(__scm, scm);


// 2nd way

diff --git a/drivers/firmware/qcom/qcom_scm.c 
b/drivers/firmware/qcom/qcom_scm.c
index 49ddbcab0680..911699123f9f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1741,7 +1741,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
   */
  bool qcom_scm_is_available(void)
  {
-	return !!__scm;
+	return !!smp_load_acquire(&__scm);
  }
  EXPORT_SYMBOL_GPL(qcom_scm_is_available);

@@ -1822,10 +1822,12 @@ static int qcom_scm_probe(struct platform_device 
*pdev)
  	if (!scm)
  		return -ENOMEM;

+	scm->dev = &pdev->dev;
  	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
  	if (ret < 0)
  		return ret;

+	init_completion(&scm->waitq_comp);
  	mutex_init(&scm->scm_bw_lock);

  	scm->path = devm_of_icc_get(&pdev->dev, NULL);
@@ -1857,10 +1859,8 @@ static int qcom_scm_probe(struct platform_device 
*pdev)
  	if (ret)
  		return ret;

-	__scm = scm;
-	__scm->dev = &pdev->dev;
-
-	init_completion(&__scm->waitq_comp);
+	/* Let all above stores available after this. */
+	smp_store_release(&__scm, scm);

  	irq = platform_get_irq_optional(pdev, 0);
  	if (irq < 0) {
-- 
2.7.4



> 
> Thanks,
> Pavan

