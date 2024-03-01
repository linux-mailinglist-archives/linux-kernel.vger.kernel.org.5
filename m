Return-Path: <linux-kernel+bounces-88954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814486E8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA97928AFE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40E3D0B9;
	Fri,  1 Mar 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFLQ0zl/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F41E88A;
	Fri,  1 Mar 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319020; cv=none; b=MS3/xHvgcReGHgz7j9/LOztMh8rQPr111+H832U+rO9mieUxjqRM2BJzbGbX66UUuhDMXLkUzNx6l0PZui7FoxkVOxVpvKFB+KzDnQQpUwRPsQBWwCn7Qn8NWOxww4+P+uSA9qAR1e7zjDOHWxpeLw75DIYovZS0gIfdYOUXZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319020; c=relaxed/simple;
	bh=xQB4TikMejf8HYKCd2nqTboBbc2W/l5k/UsuZ1nnvBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IxNjRNKNUkfaTxg9kd2cOnM5nFsW9/ZExjlxkmQWosS/RAhSZ2kk5e6+A8EnBBcnHqXKvX5EMQLivbsGeDQ45TAIjFAqfkuqtTwAlA4X4RewEHTiejdf0I8lkW0Q1IDSrS0xBSwDgvoZEammTuBR0wkycTGSGc69ooi6mMqa8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dFLQ0zl/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421GuNc1008586;
	Fri, 1 Mar 2024 18:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lk1W+lVN+n6/SoaQkVD5BF3cUTG8UJWo7u5+NF+HJwQ=; b=dF
	LQ0zl/DzGyDy70kkvdA+gNF9yKY4689P8EYCKzK081w53ZnNJk0eTUhs8f3M3jSL
	xB77Ic5n9ABMgDEuUaE5JwVbaF9iChp5MTlUndYXhQ52snuqi6mbUqaD+CZm2grt
	ph19Nhl8V9XZ+JfsXjS0K1gM6CThK/E/POQsur6c7p25BtFxH0eoZlV9BCZBvUFz
	wtAkrXg18xHZ4DNYbEM31utKtsaLTdobYM/a6vSOs6qvCQ35x1RnSCrtv5DcWcdo
	pCCPDgNRhQO3be8vsUGzCUWqkT3XKCNnnkGCMFtnCLMm3lgr7y7SxUNfUyzPWq6b
	9/oz130Bmy9q/s3FiPdQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk7cg9xkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 18:50:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421Io00L014051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 18:50:00 GMT
Received: from [10.110.82.174] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 10:49:57 -0800
Message-ID: <6a3e3071-f8cd-66b4-99a0-427f7e11177a@quicinc.com>
Date: Fri, 1 Mar 2024 10:49:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 11/12] firmware: qcom: scm: clarify the comment in
 qcom_scm_pas_init_image()
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>
CC: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh
	<quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian
 Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini
 Kandagatla" <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@quicinc.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Deepti Jaggi
	<quic_djaggi@quicinc.com>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-12-brgl@bgdev.pl>
 <ihz4jczbhn3gdcs6nkgnzpyv3577ebd73qbkynw6jz7ciy4fu3@kxqu7olrrely>
Content-Language: en-US
From: Prasad Sodagudi <quic_psodagud@quicinc.com>
In-Reply-To: <ihz4jczbhn3gdcs6nkgnzpyv3577ebd73qbkynw6jz7ciy4fu3@kxqu7olrrely>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zJU114Lht-Ax-EGW8-ctMDqs437U1DQF
X-Proofpoint-GUID: zJU114Lht-Ax-EGW8-ctMDqs437U1DQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_20,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010153


On 2/17/2024 7:50 PM, Bjorn Andersson wrote:
> On Mon, Feb 05, 2024 at 07:28:09PM +0100, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> The "memory protection" mechanism mentioned in the comment is the SHM
>> Bridge. This is also the reason why we do not convert this call to using
>> the TZ memory allocator.
>>
> No, this mechanism predates shmbridge.
Yes. PIL calls are there for very long time and shm bridge concept is 
introduced later.
>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
>> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
>> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 839773270a21..7ba5cff6e4e7 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>>   	struct qcom_scm_res res;
>>   
>>   	/*
>> -	 * During the scm call memory protection will be enabled for the meta
>> -	 * data blob, so make sure it's physically contiguous, 4K aligned and
>> -	 * non-cachable to avoid XPU violations.
> What this is saying is that the memory will be made unaccessible to
> Linux, so it needs to be contiguous and aligned.

Based on my understanding,  this buffer has to be  physically 
contiguous, 4K aligned and non-cachable to avoid XPU violations.

We should keep this comment

>
>> +	 * During the SCM call the hypervisor will make the buffer containing
>> +	 * the program data into an SHM Bridge.
> Are you saying that the hypervisor will convert this memory to a
> shmbridge, and then pass it to TrustZone?
Yes.  Specifically for PIL calls hyp is creating shm bridge for 
buffers/regions on behalf of Linux/NS-EL1.
>
>> This is why we exceptionally
>> +	 * must not use the TrustZone memory allocator here as - depending on
>> +	 * Kconfig - it may already use the SHM Bridge mechanism internally.
>> +	 *
> "it may already"? You describe above that we shouldn't pass shmbridge
> memory, and the other case never deals with shmbridges. So, I think you
> can omit this part.
>
>> +	 * If we pass a buffer that is already part of an SHM Bridge to this
>> +	 * call, it will fail.
> Could this be because the consumer of this buffer operates in EL2, and
> not TZ?
These buffers are consumed by TZ only and not by EL2.  hyp creating the 
required bridges for pil buffers.
>
> Regards,
> Bjorn
>
>>   	 */
>>   	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
>>   				       GFP_KERNEL);
>> -- 
>> 2.40.1
>>

