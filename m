Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE17B86F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjJDRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJDRtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:49:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF5A6;
        Wed,  4 Oct 2023 10:49:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394HnNqA020720;
        Wed, 4 Oct 2023 17:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6sduqsr5oXTzBTQDKRgYapCkA4vfCqnwzQ5prHBGo2w=;
 b=Gd6TQhznc6BXPX2N0hrZhIid7bP0Vj2s6mdggoiYLuGiPpBQv3JYJ9ZU/ZwSK43j186N
 vQGmKWt4FEU2NMLQYRhAPem/ViNXRKJxpAPrIvqY1T4FFTIOJzvp/n/7XDXQM/kJ+D09
 RBnLmOMqjUaafDeJkzeL6Nx14SRGbqS9FdDAVcPr0dstidyVlzwIFRRkoy/UUgZwtDiu
 mVX4Kodbnjm62j48eFM9hBN4FXEJ2P5DJ9TxoqUVNX0tvHUIxfyKKXxI5E+wuBztQ+eI
 3rkX8t7xtUU1PR0yHkFE3YyF7zo4KLZa1PqExkyedk6rZdZC78Q8CiOVritOrK3HICCz Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgynha12b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 17:49:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394HmxX7019347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 17:48:59 GMT
Received: from [10.110.20.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 4 Oct
 2023 10:48:59 -0700
Message-ID: <d22b0da7-fc52-549f-20ad-3829379dccff@quicinc.com>
Date:   Wed, 4 Oct 2023 10:48:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
 <20231003111914.63z35sn3r3k7drtp@bogus>
 <6246714a-3b40-e1b6-640e-560ba55b6436@quicinc.com>
 <20231004160630.pxspafszlt6o7oj6@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231004160630.pxspafszlt6o7oj6@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BzcCYttomuGoeF3sGiC5z1TYPZ3xocJP
X-Proofpoint-ORIG-GUID: BzcCYttomuGoeF3sGiC5z1TYPZ3xocJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040129
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/2023 9:06 AM, Sudeep Holla wrote:
> On Tue, Oct 03, 2023 at 09:16:27AM -0700, Nikunj Kela wrote:
>> On 10/3/2023 4:19 AM, Sudeep Holla wrote:
>>> On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
>>>> This change adds the support for SCMI message exchange on Qualcomm
>>>> virtual platforms.
>>>>
>>>> The hypervisor associates an object-id also known as capability-id
>>>> with each hvc doorbell object. The capability-id is used to identify the
>>>> doorbell from the VM's capability namespace, similar to a file-descriptor.
>>>>
>>>> The hypervisor, in addition to the function-id, expects the capability-id
>>>> to be passed in x1 register when HVC call is invoked.
>>>>
>>>> The function-id & capability-id are allocated by the hypervisor on bootup
>>>> and are stored in the shmem region by the firmware before starting Linux.
>>>>
>>>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>>>> ---
>>>>    drivers/firmware/arm_scmi/driver.c |  1 +
>>>>    drivers/firmware/arm_scmi/smc.c    | 47 ++++++++++++++++++++++++++----
>>>>    2 files changed, 43 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>>>> index 87383c05424b..ea344bc6ae49 100644
>>>> --- a/drivers/firmware/arm_scmi/driver.c
>>>> +++ b/drivers/firmware/arm_scmi/driver.c
>>>> @@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
>>>>    #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>>>>    	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>>>>    	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
>>>> +	{ .compatible = "qcom,scmi-hvc-shmem", .data = &scmi_smc_desc},
>>>>    #endif
>>>>    #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>>>>    	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>>>> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
>>>> index 0a0b7e401159..94ec07fdc14a 100644
>>>> --- a/drivers/firmware/arm_scmi/smc.c
>>>> +++ b/drivers/firmware/arm_scmi/smc.c
>>>> @@ -50,6 +50,9 @@
>>>>     * @func_id: smc/hvc call function id
>>>>     * @param_page: 4K page number of the shmem channel
>>>>     * @param_offset: Offset within the 4K page of the shmem channel
>>>> + * @cap_id: hvc doorbell's capability id to be used on Qualcomm virtual
>>>> + *	    platforms
>>>> + * @qcom_xport: Flag to indicate the transport on Qualcomm virtual platforms
>>>>     */
>>>>    struct scmi_smc {
>>>> @@ -63,6 +66,8 @@ struct scmi_smc {
>>>>    	u32 func_id;
>>>>    	u32 param_page;
>>>>    	u32 param_offset;
>>>> +	u64 cap_id;
>>> Can it be unsigned long instead so that it just works for both 32 and 64 bit.
>> My first version of this patch was ulong but Bjorn suggested to make this
>> structure size fixed i.e. architecture independent. Hence changed it to u64.
>> If you are ok with ulong, I can change it back to ulong.
>>
> SMCCC pre-v1.2 used the common structure in that way. I don't see any issue
> with that. I haven't followed Bjorn suggestions/comments though.
Ok.
>>>> +	bool qcom_xport;
>>> Do we really need this ?
>> Not if we initialize it with a negative value since 0 is a valid value for
>> cap-id.
>>
> Fine with negative value(-EINVAL may be).
Ok.
>>>>    	int ret;
>>>>    	if (!tx)
>>>> @@ -158,9 +164,34 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>>>>    		return -EADDRNOTAVAIL;
>>>>    	}
>>>> -	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
>>>> -	if (ret < 0)
>>>> -		return ret;
>>>> +	if (of_device_is_compatible(dev->of_node, "qcom,scmi-hvc-shmem")) {
>>>> +		scmi_info->qcom_xport = true;
>>>> +
>>>> +		/* The func-id & capability-id are kept in last 16 bytes of shmem.
>>>> +		 *     +-------+
>>>> +		 *     |       |
>>>> +		 *     | shmem |
>>>> +		 *     |       |
>>>> +		 *     |       |
>>>> +		 *     +-------+ <-- (size - 16)
>>>> +		 *     | funcId|
>>>> +		 *     +-------+ <-- (size - 8)
>>>> +		 *     | capId |
>>>> +		 *     +-------+ <-- size
>>>> +		 */
>>>> +
>>>> +		func_id = readl((void __iomem *)(scmi_info->shmem) + size - 16);
>>> So unlike 'arm,scmi-smc', you don't want 'arm,smc-id' in the DT ? Any
>>> particular reason ? Just to get both FID and cap ID from shmem ?
> I am fine either way. If you use from DT(via arm,smc-id), then "qcom,scmi"
> can be just addition compatible that expects you to read cap-id from the
> shmem. May need adjustment in the binding as you allow both
> "qcom,scmi-smc", "arm,scmi-smc". I will leave the details to you.
Ok.
>> I could use smc-id binding for func-id, it's just two parameters will come
>> from two different places so thought of keeping everything at one place to
>> maintain consistency.  Since DT can't take cap-id, I decided to move
>> func-id. I am fine if you want me to use smc-id binding.
>>
> Up to you. If you want to make "qcom,scmi-smc" and "arm,scmi-smc"
> compatible in way in that way or you can keep it incompatible as you have
> proposed in this patch set.
Ok.
>>>> +#ifdef CONFIG_ARM64
>>> I would rather make this arch agnostic using CONFIG_64BIT
>> ok.
>>>> +		cap_id = readq((void __iomem *)(scmi_info->shmem) + size - 8);
>>> Do you need __iomem typecast here ? Is scmi_info->shmem not already __iomem ?
>>> Also scmi_info->shmem is ioremapped just few steps above and you are using
>>> read* here, is that safe ?
>> I saw some compilation warnings without __iomem. I will use ioread* API
>> instead of read*.
>>
> That was the clue that you were using __iomem with read* calls IMO.
Ok.
>>>> +#else
>>>> +		/* capability-id is 32 bit wide on 32bit machines */
>>>> +		cap_id = rieadl((void __iomem *)(scmi_info->shmem) + size - 8);
>>> Other thought once you move for u64 to unsigned long you need not have
>>> #ifdeffery, just do copy of sizeof(unsigned long)
>> Right, my first version was like that only.
> OK
>
>>>> +#endif
>>>> +	} else {
>>>> +		ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +	}
>>>>    	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
>>>>    		scmi_info->param_page = SHMEM_PAGE(res.start);
>>>> @@ -184,6 +215,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>>>>    	}
>>>>    	scmi_info->func_id = func_id;
>>>> +	scmi_info->cap_id = cap_id;
>>>>    	scmi_info->cinfo = cinfo;
>>>>    	smc_channel_lock_init(scmi_info);
>>>>    	cinfo->transport_info = scmi_info;
>>>> @@ -213,6 +245,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>>>>    	struct arm_smccc_res res;
>>>>    	unsigned long page = scmi_info->param_page;
>>>>    	unsigned long offset = scmi_info->param_offset;
>>>> +	unsigned long cap_id = (unsigned long)scmi_info->cap_id;
>>>>    	/*
>>>>    	 * Channel will be released only once response has been
>>>> @@ -222,8 +255,12 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>>>>    	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>>>> -	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
>>>> -			     &res);
>>>> +	if (scmi_info->qcom_xport)
>>> Just make sure cap_id is set only for qcom and just use that as your flag.
>>> No point in setting always true scmi_info->qcom_xport and using it here.
>> ok, I can remove that. Though 0 is a valid value for cap-id so will have to
>> init cap-id with a negative value.
> Yes as mentioned above.
Ok.
>
