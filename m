Return-Path: <linux-kernel+bounces-92190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487F871C79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64701B258C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75A5D491;
	Tue,  5 Mar 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KOtvR2uk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AB5D470;
	Tue,  5 Mar 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636084; cv=none; b=SFs/thFEmTuMHF2MD26qFmcxoOOvMrNpGSIN2Bj10anmKtsBlalPU4wBrPmf0Fao1byYC6ya/2QAZHHzXIknYXvc//oCxdZ3rpTSkRr+xRyVXS/jf1BS+X8b1jF3e/8GEArQ+b1AkibGhCKCZDBg4cYeEAvakGR8mQRZnsWqr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636084; c=relaxed/simple;
	bh=oxRVpdLJF2FGYqRu9QIMQZ4jI/4N8Pa67tYhC3kRTdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nyNFBrJZaiwOvVTGrdyZjnMThX8WPYkvYubdx5JyUe/EWSWMZyLsup4JuXaZIwhZOnf2HTjl6zye4ylZoMRiAWNSBI0LiagB2YvlPByMOvt44kqdqCHrwXt1QJBgL7WVtVNo2/nny84UgVYpTctSA/1IZdKIB+EkO0/5z/m6SB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KOtvR2uk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4258n2KA031464;
	Tue, 5 Mar 2024 10:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q+2JuocJ0ml2lss8W2wnTp8l9G02UA/Lm3HYCXFFg/4=; b=KO
	tvR2ukBl4/73NTRxjwEJaadCUuNEP6diZpCajfBcIxGrnGZ3owvxZfP5FKE8htUq
	p2h0rV7mN1Tg8NGd6/fBjzYSUPremVDyxpAcJz1M+ilytYj+GLNs1o8/0pMvvppD
	f+fZ2m37NwbYhn941p8uqBAXb4vFOQSiXleAhFODKpXnNHdfx5YY9PlrunW+D8wL
	vEwZkBCyd8lmQ01A2CwyVwbDSyE6N/Rh57DD4PR+76HOBMUCuKSPeH5u+JBbLTai
	PurKKwBj1qEXACUq5IkenSQnSzNFKN/AAhY3DKL4qRWdF27MlDIWUCWAWVOZSBjh
	ZJ6Cxw/SB+LQiDBsvzcA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnqwhs69s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:54:38 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425AsbpL025647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 10:54:37 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 02:54:35 -0800
Message-ID: <6670e21a-46d7-db1f-3830-73e97786cde8@quicinc.com>
Date: Tue, 5 Mar 2024 16:24:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 4/9] firmware: qcom: scm: Rework dload mode
 availability check
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, Elliot Berman <quic_eberman@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-5-quic_mojha@quicinc.com>
 <bmwswdvzqldse4dgbcev7hcyktkzffur3pcs6ogwnekxrklgiu@hridh2l2hhgk>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <bmwswdvzqldse4dgbcev7hcyktkzffur3pcs6ogwnekxrklgiu@hridh2l2hhgk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NNLZd221BDqmqAjvKT-TjdBnd5JPvuFh
X-Proofpoint-ORIG-GUID: NNLZd221BDqmqAjvKT-TjdBnd5JPvuFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050087



On 3/3/2024 12:46 AM, Bjorn Andersson wrote:
> On Tue, Feb 27, 2024 at 09:23:03PM +0530, Mukesh Ojha wrote:
>> QCOM_SCM_BOOT_SET_DLOAD_MODE was only valid for very older
>> target and firmware and for recent targets there is dload
>> mode tcsr registers available to set the download mode.
>>
> 
> I presume this implies that it will always return false, so what's the
> actual problem with that? Presumably you want this because it takes
> unnecessary time to make that call, if so please say so.

Correct, will add in commit description.

Also, __qcom_scm_is_call_available() usage legacy mode of setting DLOAD 
mode setting via command which is deprecated long back from Trust zone 
firmware also it takes or wait statically global mutex lock at the lower 
level which unnecessary adds time which is of no use.
> 
> 
> Content of the patch looks good.

Thanks.

-Mukesh

> 
> Regards,
> Bjorn
> 
>> So, it is better to keep it as fallback check instead of
>> checking its availability and failing it always.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/firmware/qcom/qcom_scm.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index bd6bfdf2d828..3fd89cddba3b 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -540,18 +540,16 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>>   static void qcom_scm_set_download_mode(bool enable)
>>   {
>>   	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
>> -	bool avail;
>>   	int ret = 0;
>>   
>> -	avail = __qcom_scm_is_call_available(__scm->dev,
>> -					     QCOM_SCM_SVC_BOOT,
>> -					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
>> -	if (avail) {
>> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>> -	} else if (__scm->dload_mode_addr) {
>> +	if (__scm->dload_mode_addr) {
>>   		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
>>   				      QCOM_DLOAD_MASK,
>>   				      FIELD_PREP(QCOM_DLOAD_MASK, val));
>> +	} else if (__qcom_scm_is_call_available(__scm->dev,
>> +						QCOM_SCM_SVC_BOOT,
>> +						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
>> +		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>   	} else {
>>   		dev_err(__scm->dev,
>>   			"No available mechanism for setting download mode\n");
>> -- 
>> 2.43.0.254.ga26002b62827
>>

