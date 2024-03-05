Return-Path: <linux-kernel+bounces-92153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA382871BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC041F2451D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C435A4FE;
	Tue,  5 Mar 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pbhji+zj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E4433CA;
	Tue,  5 Mar 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635159; cv=none; b=QE4g5WIyc0E7yHJFYq3clF2TjM/1hfGN/2ndyCHwoIuJ8fdECI6TCEc2uPxEK2HQ2I/ekp1FpwqaM2fFm+BxWQsB7nheCTSxPnvmr+EPqF0WZyT+zAbVIipMRcNZV2ScTmjZwQ5DLafkHlkp7fApvOMEnaX3la8RHgSnpsLyotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635159; c=relaxed/simple;
	bh=Kp+ocfoPn0hfrTsODIqN9IVLxzuV0Bp6X4SCxQQbbQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oZj6fVEZQ6CPqvymW9TW+nF6MwH1ZDeItd8qvBz0byQhrA7u1GxSZOIH8CK83Ulm3i5MyPvgfas5vzI4yNJ9jAIlCs8gVoH15XvhayTXcMb5hd94C+Tdj2AgZk9FVPcan5dop29HnlFjBz2ngXG4IIvBY+YpudNbmLH/xmLcyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pbhji+zj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425AU5pE014814;
	Tue, 5 Mar 2024 10:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7QZfxu29DD6dXzgFZY11+5DekmpMs+XOUHCKYnMalzs=; b=pb
	hji+zj+oSyMxX46lY7qvYs2UnEJIB+jfLsWDekwChQI6W4H4zw9+Qj7gBwDfwPYx
	BX6UHNRuuqaLgrNGT3cb5/2XLiDfxouokF6j2Y+bawynb+zHFBij5lKnIKI1ZCx6
	J9U1BMx3YsV4wum2a2qz75uZzjaSyEAyDfPbKjJM/Q0wXLUWDP4D4qAK1s89EgMM
	SeEI9TanqotLovZn7HSjWQVey7AxEWLeUv+qtEZPSQ3lxZhTY71tXbZX/kVMp2Ja
	cDRmrqzf2Z2iuy7p65XPnb54t8j6UVDms0vMF3wsPQSDKVqaWdg02rC/jNGFK4IQ
	+LiFyybz/izsAItqSYIQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnx0y0gm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:39:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425Ad9mY000885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 10:39:09 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 02:39:07 -0800
Message-ID: <9db7deef-9d62-edca-4ec0-c55ca65bed29@quicinc.com>
Date: Tue, 5 Mar 2024 16:09:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 2/9] firmware: qcom: scm: provide a read-modify-write
 function
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Kathiravan Thirumoorthy
	<quic_kathirav@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-3-quic_mojha@quicinc.com>
 <xht25xxxzxmb24yobz4drmo5u4btlqo4akhscow7g5to7zyh3g@75bl5ddhib43>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <xht25xxxzxmb24yobz4drmo5u4btlqo4akhscow7g5to7zyh3g@75bl5ddhib43>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1AjLYhxFx8H4X_2vCAdgOxzb4Q8eOpXw
X-Proofpoint-ORIG-GUID: 1AjLYhxFx8H4X_2vCAdgOxzb4Q8eOpXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050085



On 3/3/2024 12:39 AM, Bjorn Andersson wrote:
> On Tue, Feb 27, 2024 at 09:23:01PM +0530, Mukesh Ojha wrote:
>> It is possible that different bits of a secure register is used
>> for different purpose and currently, there is no such available
>> function from SCM driver to do that; one similar usage was pointed
>> by Srinivas K. inside pinctrl-msm where interrupt configuration
>> register lying in secure region and written via read-modify-write
>> operation.
>>
>> Export qcom_scm_io_rmw() to do read-modify-write operation on secure
>> register and reuse it wherever applicable, also document scm_lock
>> to convey its usage.
>>
>> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
>> ---
>>   drivers/firmware/qcom/qcom_scm.c       | 33 ++++++++++++++++++++++++++
>>   include/linux/firmware/qcom/qcom_scm.h |  1 +
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 2d0ba529cf56..8f766fce5f7c 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -193,6 +193,11 @@ static void qcom_scm_bw_disable(void)
>>   }
>>   
>>   enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
>> +/*
>> + * scm_lock to serialize call to query SMC convention and
>> + * to atomically operate(read-modify-write) on different
>> + * bits of secure register.
>> + */
>>   static DEFINE_SPINLOCK(scm_lock);
>>   
>>   static enum qcom_scm_convention __get_convention(void)
>> @@ -481,6 +486,34 @@ static int qcom_scm_disable_sdi(void)
>>   	return ret ? : res.result[0];
>>   }
>>   
>> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
>> +{
>> +	unsigned long flags;
>> +	unsigned int old;
>> +	unsigned int new;
>> +	int ret;
>> +
>> +	if (!__scm)
>> +		return -EPROBE_DEFER;
>> +
>> +	/*
>> +	 * Lock to atomically do rmw operation on different bits
>> +	 * of secure register
>> +	 */
> 
> A spinlock does not make something globally atomic, all you have made
> sure is that:
> 1) qcom_scm_io_rmw() can not happen concurrently with __get_convention()
> 
> The reuse of the lock makes me wonder what the use case you're having a
> need to protect #1... When is rmw happening concurrently with convention
> detection?
> 
> 2) Two qcom_scm_io_rmw() can not happen concurrently
> 
> What happens if a separate process invokes qcom_scm_io_write() of the
> same address concurrently with qcom_scm_io_rmw()?

Yes, that is not protected..

> 
> 
> Quite likely neither of these will happen in practice, and I'm guessing
> that there will not be any caching issues etc among different calls to
> qcom_scm_io_*(), and hence this spinlock serves just to complicate the
> implementation.
> 
> Please add a kernel-doc comment to this function (and perhaps
> qcom_scm_io_write()) and describe that we don't guarantee this operation
> to happen atomically - or if you have a valid reason, document that and
> it's exact limitations.

Sure, that make sense !! it is possible for a call to be preempted right
before it reaches to Trust zone(TZ) and it is not being handled 
inherently from SCM driver.

To further add, qcom_scm_io_{read|write}() atomic calls to TZ which
makes sure the does not get interrupted while it is in trust zone by
disabling interrupts and it is other way with non-atomic calls.

> 
> 
> PS. I would have been perfectly happy with us not adding a rmw function.
> You're adding 34 lines of code to save 2*3 lines of duplicated, easy to
> understand, code.

I agree with you..

Global scm spin lock would have only made sense if there could be some
resources to share from secure to non-secure and here, addresses are 
specific to the client driver and lock does need to be taken by the 
client and their address can not get overwritten by other drivers.
So, we already discussed on regmap which does not fit here at scale.

Currently, we have only one place where we have secure rmw() operation
in Qualcomm msm pinctrl driver and that seems to protected 
spin_lock_irqsave(), similarly others can do the same way if there
is a chance of race on the same address.

-Mukesh

> 
> Regards,
> Bjorn
> 
>> +	spin_lock_irqsave(&scm_lock, flags);
>> +	ret = qcom_scm_io_readl(addr, &old);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	new = (old & ~mask) | (val & mask);
>> +
>> +	ret = qcom_scm_io_writel(addr, new);
>> +unlock:
>> +	spin_unlock_irqrestore(&scm_lock, flags);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
>> +
>>   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>>   {
>>   	struct qcom_scm_desc desc = {
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
>> 2.43.0.254.ga26002b62827
>>

