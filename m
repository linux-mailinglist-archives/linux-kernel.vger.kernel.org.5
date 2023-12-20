Return-Path: <linux-kernel+bounces-6526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81138199F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B2B1F24D48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388918637;
	Wed, 20 Dec 2023 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="asEHogS3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284271D6AB;
	Wed, 20 Dec 2023 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK7ePQw019738;
	Wed, 20 Dec 2023 08:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Im95OQeuK1bHXsXSynBGzQS4F6s+R4W/Sfgm+I1J06E=; b=as
	EHogS3TNhusxZyXrZWmhtXOqbTstSw49p7QAj4cmuZPKSRnpbGCNTfs5TtNmJGc0
	r7fFzMTGbrAVmX6nYPfXBHB2Tqv4i1wsi9k1idGGmKjPxZCy3accGq3yoMtDby5x
	Xl7Tz9koEvtpsT8bjlHS371dfodK1u2pgWsulUpRipglpCoOcQtt6SrkQhJuB7I+
	UNu3/rv2qICdkdFkHA58gAajI9BndG+pvezklPqAtokcJjdJw5OXg9nFvKZtqYGC
	KkhjWG6EmA/mhfiOHI1y/iRBBYs6BPFvtYDvWzTSnrxSpS2RFHvYezM5bFWTqPGp
	QmdNqQR8zlPLk3HtdKOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3v3381f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:02:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK820xp001528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:02:00 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:01:55 -0800
Message-ID: <08013b9f-f259-459d-a5ce-269fb78ecf7a@quicinc.com>
Date: Wed, 20 Dec 2023 13:31:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/34] media: introduce common helpers for video
 firmware handling
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-2-git-send-email-quic_dikshita@quicinc.com>
 <e08f54cb-5b28-497b-9484-b691dce0acff@linaro.org>
 <CAA8EJpojYFRcO32wXc9B5Q1D1oSMbx3GP1d9qdtppar39-2=Qw@mail.gmail.com>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <CAA8EJpojYFRcO32wXc9B5Q1D1oSMbx3GP1d9qdtppar39-2=Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DZv1BZGDm9-M2heHH_-G5BMtESA_DwTT
X-Proofpoint-GUID: DZv1BZGDm9-M2heHH_-G5BMtESA_DwTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200054



On 12/19/2023 6:56 PM, Dmitry Baryshkov wrote:
> On Tue, 19 Dec 2023 at 13:40, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 18/12/2023 11:31, Dikshita Agarwal wrote:
>>> Re-organize the video driver code by introducing a new folder
>>> 'vcodec' and placing 'venus' driver code inside that.
>>>
>>> Introduce common helpers for trustzone based firmware
>>> load/unload etc. which are placed in common folder
>>> i.e. 'vcodec'.
>>> Use these helpers in 'venus' driver. These helpers will be
>>> used by 'iris' driver as well which is introduced later
>>> in this patch series.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> ---
>>
>> This is a very large patch, I think it needs to be broken up into
>> smaller chunks.
>>
>> #1 Introduce common helper functions
>> #2 Use common helper functions
> 
> This will make it harder to review. It's usually preferred to have a
> single 'move' patch instead of two (add + remove). But I definitely
> agree that the size of the patch is big. Somewhat it is related to the
> fact that this doesn't only introduce helpers, but also reshuffles the
> rest of the code.
> 
Thanking along the same lines as Dmitry's, we wanted to show the usage of
these common helpers in iris driver as well, hence we added these patches
as part of this series.
I can send these patches 1-3 as separate series and mark the dependency of
iris series to that if you would prefer that way.

Also, as mentioned in comments in previous patches, to make the common
helper code generic, moving just the code from venus to vcodec was not
sufficient and more changes were needed in calling functions of venus as well.
>>
>> Its alot of code to try to eat in the one go.
>>
>> Could you consider making patches 1-3 a standalone series to reduce the
>> amount of code to review here ?
> 
> This sounds like a good idea.
> >>
>> * 77e7025529d7c - (HEAD -> linux-stable-master-23-12-18-iris-v2) media:
>> iris: add power management for encoder (21 hours ago)
>>
>> * ceb6a6f023fd3 - (tag: v6.7-rc6, linux-stable/master) Linux 6.7-rc6 (2
>> days ago)
>>
>> git diff ceb6a6f023fd3 | wc -l
>>
>> 21243
>>
>> Also I feel it wouild give more time for the changes to "digest" though
>> upstream users and to find any unintended bugs.
>>
>>> +int load_fw(struct device *dev, const char *fw_name, phys_addr_t *mem_phys,
>>> +         size_t *mem_size, u32 pas_id, bool use_tz)
>>> +{
>>> +     const struct firmware *firmware = NULL;
>>> +     struct reserved_mem *rmem;
>>> +     struct device_node *node;
>>> +     void *mem_virt = NULL;
>>> +     ssize_t fw_size = 0;
>>> +     int ret;
>>> +
>>> +     if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
>>> +         (use_tz && !qcom_scm_is_available()))
>>> +             return -EPROBE_DEFER;
>>> +
>>> +     if (!fw_name || !(*fw_name))
>>> +             return -EINVAL;
>>
>> The parameter check should come before the qcom_scm_is_available()
>>
>> No matter how many times you -EPROBE_DEFER -EINVAL is still -EINVAL.
>>
Sure, will check and do the needful.
>>> +
>>> +     *mem_phys = 0;
>>> +     *mem_size = 0;
>>
>> I don't think you need this, you don't appear to use these variables
>> before you assign them below.
>>
That's true, will fix.
>>
>>> +
>>> +     *mem_phys = rmem->base;
>>> +     *mem_size = rmem->size;
>>
>>> +
>>> +int auth_reset_fw(u32 pas_id)
>>> +{
>>> +     return qcom_scm_pas_auth_and_reset(pas_id);
>>> +}
>>> +
>>> +void unload_fw(u32 pas_id)
>>> +{
>>> +     qcom_scm_pas_shutdown(pas_id);
>>> +}
>>> +
>>
>> Do these wrapper functions add anything ? Some kind of validity check on
>> the pas_id otherwise I'm not sure these are justified.
>>
>>> +int set_hw_state(bool resume)
>>> +{
>>> +     return qcom_scm_set_remote_state(resume, 0);
>>> +}
Will check more on this and do required changes.
>>> diff --git a/drivers/media/platform/qcom/vcodec/firmware.h b/drivers/media/platform/qcom/vcodec/firmware.h
>>> new file mode 100644
>>> index 0000000..7d410a8
>>> --- /dev/null
>>
>> ---
>> bod
>>
>>
> 
> 

