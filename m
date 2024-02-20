Return-Path: <linux-kernel+bounces-72666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FB85B6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214B2B21C37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6435627EE;
	Tue, 20 Feb 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CztYE3oQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864361679;
	Tue, 20 Feb 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420192; cv=none; b=RmvY09JERpFfKrkrYK/of7U4kY4Bhb2rIPVJWPsxzCnemchi3DHnN+DhhndiACIoiwnD+ovOACFFlGRVpYewfmCebJpn5++Pgu9j6IVMXQCA1xorSBLCMgY+ER/1nSJkudkX1Bb4wGkugDs/DWEm8KPcdQ58vm6juvnLAcpMUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420192; c=relaxed/simple;
	bh=kZSC0u0xCH+EKw5Y92fp6j3/7Gmt8o5bJD51LkXnVA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p2wwLiCoQlM+ugdV3jmeNnBARWtMgFsifaDPqi/+pNHliDTJ9jKAtbuMcK/IMwbS/quyoN413FmQ6wxBzDUPQ0gdKqjav8BWEoqd6hQgpjMLexH6xy+x6DxnkCAVn7O4Inh4iWvl10V/gXD/zqfmU/1KH2gnWj86HfnIsRwbVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CztYE3oQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K5lXJp027921;
	Tue, 20 Feb 2024 09:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ceg/10uJLVK7KePIXERAX4S+Ja/3uZvZWDLNQNnL+/E=; b=Cz
	tYE3oQf6Cg6R8YFVlDN1TBrHZCwGbewXZKo2WRnHPcDCeEKB1h7J0oSMaKuRhwfx
	bXLS1SDfhKPK6mILebEeYXE8PE7v1pdg/a37JrvSjPAPU6Yj7o6oIa9QwNIksGy7
	HYsqiQeh5I9QH2I4a/VDITSNhGmjBsTfGH2pJ2vy8xq3GakSNYydww3sL19ahxWx
	XWGLOJbu6kjEyl3Sh+s5wZUU7KS7Rv7OTpDf4IooAW4Sgn8dciCtcGP/JwkChH2n
	nO5rRxTJJBo0FJTuGGPO6AK9XSJZPVXJWk6N/1idoLQfVD3VAqVyjtP/7gqWJqOv
	+EjNPcJplxRbyiKRiIng==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcnbd8f4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:09:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K99kMb004818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:09:46 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 01:09:37 -0800
Message-ID: <4184207f-14d6-352a-b6db-6423757d46e6@quicinc.com>
Date: Tue, 20 Feb 2024 14:39:23 +0530
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
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
 <jyfpwd3jiwwqgbap3vk7uzhumqaj2rt2udiakink7rgxk4k5le@hqclapr7wizu>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <jyfpwd3jiwwqgbap3vk7uzhumqaj2rt2udiakink7rgxk4k5le@hqclapr7wizu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mVOt-obVES4UF5ylrp4ipc6c1T2dSrcA
X-Proofpoint-ORIG-GUID: mVOt-obVES4UF5ylrp4ipc6c1T2dSrcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200065



On 2/17/2024 12:09 AM, Bjorn Andersson wrote:
> On Mon, Jan 08, 2024 at 08:57:31PM +0530, Mukesh Ojha wrote:
>> It was realized by Srinivas K. that there is a need of
> 
> "need" is a strong word for this functionality, unless there's some use
> case that I'm missing.

I would rather say as below,

""
It is possible that different bits of a secure register is used
for different purpose and currently, there is no such available
function from SCM driver to do that; one similar usage was pointed
by Srinivas K. inside pinctrl-msm where interrupt configuration
register lying in secure region and written via read-modify-write operation.

Export qcom_scm_io_rmw() to do read-modify-write operation on secure 
register and reuse it wherever applicable.


""
> 
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
> Please express that this lock is just for create mutual exclusion
> between rmw operations, nothing else.
> 
> Also please make a statement why this is desirable and/or needed.

Sure.

However, i was thinking of reusing existing scm_query_lock with rename
which is used only during boot up in __get_convention() .

-Mukesh
> 
> Regards,
> Bjorn
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
>> +
>>   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>>   {
>>   	struct qcom_scm_desc desc = {
>> @@ -1824,6 +1849,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   		return ret;
>>   
>>   	mutex_init(&scm->scm_bw_lock);
>> +	spin_lock_init(&scm->lock);
>>   
>>   	scm->path = devm_of_icc_get(&pdev->dev, NULL);
>>   	if (IS_ERR(scm->path))
>> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
>> index ccaf28846054..3a8bb2e603b3 100644
>> --- a/include/linux/firmware/qcom/qcom_scm.h
>> +++ b/include/linux/firmware/qcom/qcom_scm.h
>> @@ -82,6 +82,7 @@ bool qcom_scm_pas_supported(u32 peripheral);
>>   
>>   int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>>   int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val);
>>   
>>   bool qcom_scm_restore_sec_cfg_available(void);
>>   int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
>> -- 
>> 2.7.4
>>

