Return-Path: <linux-kernel+bounces-107663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E187FFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5ABDB223EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C233998;
	Tue, 19 Mar 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="giUt/UYE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F01CFB6;
	Tue, 19 Mar 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859212; cv=none; b=Rk5JaZ9e3lGCTTROnylaB+J2+Yq+zpVNdjNbDbtU/rxOyItQ/UkO/Gv0UciJJOD8RIr/eEMTVKVgQr3cK3gf53wYyfqUv46e1Xh52FW+U3ifisLcNwX5C2rn3UyZZ2twOjCXt5PlzQu9S669fCDoL9oka3bSC/l3cLMH112dYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859212; c=relaxed/simple;
	bh=pyJIFooyiBsskHRUs3QZ9a4TPD6RJdsZtGVeIr+yqh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ieW77Ur1kLm3HXXv5v/MUREX7gq996M9XgbTI26aAqDDXyCInitugqQSfZv4gOnXVmEtbIxshWkIgp00jKO1OqXG6pvPsDrlY21H3+w4CdY/R3gWJ+C26hqcHl+UFGgCj18+oWYppepJAuHxb0Jl3DlD2tw+RcZ0twmHsO2laRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=giUt/UYE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JCePUN016300;
	Tue, 19 Mar 2024 14:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xqB+lNzHIodLkLTeclAOVQStR8PiYLj4tVxJgCfsqwU=; b=gi
	Ut/UYE27keQAplo6o08pfzcrPOqrnMonkWDRYCY1iVFJtthDtjtdZcqGkQQr93rB
	XlBqQyUvDSsmLXlIg4JwcUIe88QsPPrTgj547lMTWo3onzVA2C+R5t0UHyfB4yXd
	RdF3QDVsr2R/y0H1zG4wDEhgZbdoyReuQlTnE+N32hfAsuYDwpOA09vazfZRD8cM
	30BEqBnD4mykm4yDunDywCIpYd2V0n/r/WRNbdkIk/EQLzqQQyxsd7q8b/fo04Ve
	/C9T/MQ8DzLAT+wPSJT/4UhWSreakAthVxCuwbGmg/H2KhBtJ67jLAIANcjxGjXu
	eVkPAGAlC9StZfFCNVrw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2cjsfux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 14:40:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JEe2uK020825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 14:40:02 GMT
Received: from [10.216.21.188] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 07:39:59 -0700
Message-ID: <8222e4cf-bc40-98b5-cf75-b0a547a3c4df@quicinc.com>
Date: Tue, 19 Mar 2024 20:09:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
Content-Language: en-US
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-8-quic_mojha@quicinc.com>
 <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
 <260371ff-da7a-8406-0511-4019f6b860bf@quicinc.com>
 <03367100-1ad4-4d83-8200-5879550398be@quicinc.com>
 <fce3beb8-7d70-672c-e25b-d46810c4d1dd@quicinc.com>
 <60535d91-3610-4610-ae1a-46b8e3ccd4fa@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <60535d91-3610-4610-ae1a-46b8e3ccd4fa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4h0pPrrwiO2_94Iu8xRYkNaOgGtWOIER
X-Proofpoint-GUID: 4h0pPrrwiO2_94Iu8xRYkNaOgGtWOIER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403190109



On 3/19/2024 3:52 PM, Pavan Kondeti wrote:
> On Tue, Mar 19, 2024 at 03:38:57PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 3/19/2024 6:47 AM, Pavan Kondeti wrote:
>>> On Mon, Mar 18, 2024 at 06:38:20PM +0530, Mukesh Ojha wrote:
>>>>
>>>>
>>>> On 3/3/2024 12:55 AM, Bjorn Andersson wrote:
>>>>> On Tue, Feb 27, 2024 at 09:23:06PM +0530, Mukesh Ojha wrote:
>>>>>> qcom_scm_is_available() gives wrong indication if __scm
>>>>>> is initialized but __scm->dev is not.
>>>>>>
>>>>>> Fix this appropriately by making sure if __scm is
>>>>>> initialized and then it is associated with its
>>>>>> device.
>>>>>>
>>>>>
>>>>> This seems like a bug fix, and should as such have a Fixes: tag and
>>>>> probably Cc: stable@vger.kernel.org
>>>>>
>>>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>>>> ---
>>>>>>     drivers/firmware/qcom/qcom_scm.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>>>>> index 6c252cddd44e..6f14254c0c10 100644
>>>>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>>>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>>>>> @@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>>>     	if (!scm)
>>>>>>     		return -ENOMEM;
>>>>>> +	scm->dev = &pdev->dev;
>>>>>>     	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
>>>>>>     	if (ret < 0)
>>>>>>     		return ret;
>>>>>> @@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>>>     		return ret;
>>>>>>     	__scm = scm;
>>>>>> -	__scm->dev = &pdev->dev;
>>>>>
>>>>> Is it sufficient to just move the line up, or do we need a barrier of
>>>>> some sort here?
>>>>
>>>> Would be good to use, smp_mb() before the assignment
>>>>        __scm = scm
>>>> along with moving below line
>>>> __scm->dev = &pdev->dev
>>>>
>>>
>>> Full memory barrier is not needed here. store variant is sufficient.
>>> WRITE_ONCE() + smp_store_release() will fit here no?
>>
>> Thanks for the comment, i again have a look at it and agree we don't
>> need a full barrier here.
>>
>> And we can do either of the below two ways.
>>
>> -Mukesh
>>
>>
>> // 1st way
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c
>> b/drivers/firmware/qcom/qcom_scm.c
>> index 49ddbcab0680..b638fb407fc6 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -1741,7 +1741,12 @@ static int qcom_scm_qseecom_init(struct qcom_scm
>> *scm)
>>    */
>>   bool qcom_scm_is_available(void)
>>   {
>> -       return !!__scm;
>> +       bool avail;
>>    */
>>   bool qcom_scm_is_available(void)
>>   {
>> -       return !!__scm;
>> +       bool avail;
>> +
>> +       avail = !!READ_ONCE(__scm);
>> +       smp_rmb();
>> +
>> +       return avail;
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>>
> 
> Your original problem statement: qcom_scm_is_available() gives wrong indication
> if __scm is initialized but __scm->dev is not.
> 
> This does not require read side barrier as there is an address
> dependency. If the writer does it *correctly*, the reader would always
> observe __scm->dev != NULL when __scm != NULL without any barrier.

It looks like write barrier pairs with an address-dependency barrier, a
control dependency, an acquire barrier, a release barrier, a read 
barrier, or a general barrier.

So, smp_rmb() is redundant here.

Also, for correction, we may not need smp_load_acquire() in the 1st way
and just using READ_ONCE() is enough.

-Mukesh
> 
> Thanks,
> Pavan

