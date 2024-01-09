Return-Path: <linux-kernel+bounces-20765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B48284EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2C7283732
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D0381DC;
	Tue,  9 Jan 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="od+aAxu1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7237142;
	Tue,  9 Jan 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4099xltc003856;
	Tue, 9 Jan 2024 11:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BUOV8m+4DEEUF6xZdv136lnIKPlCxnHVKDVFqa6I66A=; b=od
	+aAxu1TB3wRFXEFGLOAQDtNHrrmoPg7KXrSbQMSytbLqNIC40mp7FnCn8Rqpgqhd
	Jzo4l9NiFuXCNWUISXD411YwfkpaZe1uwre7Ij23pise/k/J6Qr87Lwmohw3fq/X
	gtNiaL5a+lDOmKUA+qHyUn6Fv8nrGKjO26HMEajFgaunxbcPAmmBsj8nMoeVL9hS
	T4z+ZJ2u9jJW24DiuCtzzFtaM6o13tjGCUVt3KrQciT06slFBnjx+1VrNOtG6+U0
	itZsc0v9XcWpglMOBg9eUaw7JMkQ9D8y2mp1ZSJmrL9ePHZv6JVxBI6dSb5015cc
	AKkxGXAtzVLgiK45NH0A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgr1shfkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:23:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409BN5of031079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 11:23:05 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 03:23:02 -0800
Message-ID: <b4066862-3d41-3932-379a-9c6358c65962@quicinc.com>
Date: Tue, 9 Jan 2024 16:52:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write
 function
Content-Language: en-US
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
 <6e99c4ff-a377-4385-b79c-60438e3e8735@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <6e99c4ff-a377-4385-b79c-60438e3e8735@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZnSPnutS7mcQcXXDJdevXhpS83Y09Tkw
X-Proofpoint-GUID: ZnSPnutS7mcQcXXDJdevXhpS83Y09Tkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090092



On 1/9/2024 10:34 AM, Pavan Kondeti wrote:
> On Mon, Jan 08, 2024 at 08:57:31PM +0530, Mukesh Ojha wrote:
>> It was realized by Srinivas K. that there is a need of
>> read-modify-write scm exported function so that it can
>> be used by multiple clients.
>>
>> Let's introduce qcom_scm_io_rmw() which masks out the bits
>> and write the passed value to that bit-offset.
>>
>> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
>> ---
>>   drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
>>   include/linux/firmware/qcom/qcom_scm.h |  1 +
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 520de9b5633a..25549178a30f 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/of_irq.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/types.h>
>>   
>> @@ -41,6 +42,8 @@ struct qcom_scm {
>>   	int scm_vote_count;
>>   
>>   	u64 dload_mode_addr;
>> +	/* Atomic context only */
>> +	spinlock_t lock;
> 
> IMHO, this comment can be confusing later. one might think that
> qcom_scm_call_atomic() needs to be called with this lock, but that does
> not seems to be the intention here.
> 
>>   };
>>   
>>   struct qcom_scm_current_perm_info {
>> @@ -481,6 +484,28 @@ static int qcom_scm_disable_sdi(void)
>>   	return ret ? : res.result[0];
>>   }
>>   
>> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
>> +{
>> +	unsigned int old, new;
>> +	int ret;
>> +
>> +	if (!__scm)
>> +		return -EINVAL;
>> +
>> +	spin_lock(&__scm->lock);
> 
> So, this function can't be called from hardirq context. If that ever
> happens, with this new spinlock (without disabling interrupts), can
> result in deadlock.

Ok, let's make it fully atomic with spin_lock_irqsave();

-Mukesh
> 
>> +	ret = qcom_scm_io_readl(addr, &old);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	new = (old & ~mask) | (val & mask);
>> +
>> +	ret = qcom_scm_io_writel(addr, new);
>> +unlock:
>> +	spin_unlock(&__scm->lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
> 
> Thanks,
> Pavan

