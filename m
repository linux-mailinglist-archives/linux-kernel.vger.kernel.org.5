Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6717B5A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbjJBSmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJBSmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:42:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800999B;
        Mon,  2 Oct 2023 11:42:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392GrjwF023515;
        Mon, 2 Oct 2023 18:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dw6cRiyD4ij6FFvALmSO0YkJH8axhbYkwEimPioPBPM=;
 b=ZBGshLzSSiNC6Xgh727AyySBQx9K71UUom7uDB94DmT8qJFrGxlNQ1+j+e0w4MCB+K73
 +aAb7wzyL+hgIJymnY5d38cHLIIaoru7n+1EB4qbPnLT/vLD6lJBbtIKiDxANdpJyUlB
 QRcRPtpgKMGDd7Pz9R7hkuzTIZoQ/KbCHv5RafQXldMM7hIWojJL8vuDiKo6V6YemR3Y
 KNG14lWuwi8gGcn9zYEz6JfrH/5dKQX0kURSFNCoSmsHmgOX4r41SX9l8qpmLLQ2iD/c
 C0QIcPZyA8fmQqDXWQToDVx2cJG0lLnd/LwMpUOKZhPjRo/+ohXkVIfRUGdFH5TFl+Gs Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3teamxmjkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 18:42:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 392IgNaB032091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Oct 2023 18:42:23 GMT
Received: from [10.110.71.113] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 2 Oct
 2023 11:42:22 -0700
Message-ID: <9684a5fc-f981-bc4b-5d3a-3cd539bdb421@quicinc.com>
Date:   Mon, 2 Oct 2023 11:42:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>
CC:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com> <ZRsNHnuUdGl+vuqz@brian-x1>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZRsNHnuUdGl+vuqz@brian-x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sYkcnUooeMierLCqgb0nxDz_t0mZlT6I
X-Proofpoint-ORIG-GUID: sYkcnUooeMierLCqgb0nxDz_t0mZlT6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020145
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/2023 11:34 AM, Brian Masney wrote:
> On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
>> This change adds the support for SCMI message exchange on Qualcomm
>> virtual platforms.
>>
>> The hypervisor associates an object-id also known as capability-id
>> with each hvc doorbell object. The capability-id is used to identify the
>> doorbell from the VM's capability namespace, similar to a file-descriptor.
>>
>> The hypervisor, in addition to the function-id, expects the capability-id
>> to be passed in x1 register when HVC call is invoked.
>>
>> The function-id & capability-id are allocated by the hypervisor on bootup
>> and are stored in the shmem region by the firmware before starting Linux.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/driver.c |  1 +
>>   drivers/firmware/arm_scmi/smc.c    | 47 ++++++++++++++++++++++++++----
>>   2 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> index 87383c05424b..ea344bc6ae49 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
>>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>>   	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>>   	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
>> +	{ .compatible = "qcom,scmi-hvc-shmem", .data = &scmi_smc_desc},
>>   #endif
>>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>>   	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
>> index 0a0b7e401159..94ec07fdc14a 100644
>> --- a/drivers/firmware/arm_scmi/smc.c
>> +++ b/drivers/firmware/arm_scmi/smc.c
>> @@ -50,6 +50,9 @@
>>    * @func_id: smc/hvc call function id
>>    * @param_page: 4K page number of the shmem channel
>>    * @param_offset: Offset within the 4K page of the shmem channel
>> + * @cap_id: hvc doorbell's capability id to be used on Qualcomm virtual
>> + *	    platforms
>> + * @qcom_xport: Flag to indicate the transport on Qualcomm virtual platforms
>>    */
>>   
>>   struct scmi_smc {
>> @@ -63,6 +66,8 @@ struct scmi_smc {
>>   	u32 func_id;
>>   	u32 param_page;
>>   	u32 param_offset;
>> +	u64 cap_id;
>> +	bool qcom_xport;
>>   };
> [snip]
>
>>   static irqreturn_t smc_msg_done_isr(int irq, void *data)
>> @@ -129,6 +134,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>>   	struct resource res;
>>   	struct device_node *np;
>>   	u32 func_id;
>> +	u64 cap_id;
>>   	int ret;
> [snip]
>
>> +		func_id = readl((void __iomem *)(scmi_info->shmem) + size - 16);
>> +#ifdef CONFIG_ARM64
>> +		cap_id = readq((void __iomem *)(scmi_info->shmem) + size - 8);
>> +#else
>> +		/* capability-id is 32 bit wide on 32bit machines */
>> +		cap_id = readl((void __iomem *)(scmi_info->shmem) + size - 8);
>> +#endif
> The 32 bit case is defined as a u64 in two places above.

That is done to make sure the size of the structure in memory is not 
architecture dependent. This was recommended in one of the previous 
version of this patch.


>
>> +
>> +		/* The func-id & capability-id are kept in last 16 bytes of shmem.
>> +		 *     +-------+
>> +		 *     |       |
>> +		 *     | shmem |
>> +		 *     |       |
>> +		 *     |       |
>> +		 *     +-------+ <-- (size - 16)
>> +		 *     | funcId|
>> +		 *     +-------+ <-- (size - 8)
>> +		 *     | capId |
>> +		 *     +-------+ <-- size
>> +		 */
> Personally I'd add one more space to the right side of the table after
> funcId.

I could do that but then in 32bit case, you would want one more space 
right after cap-id since it is 32 bit on 32 bit platform. If it helps, I 
can have two lay out one for 32bit and one for 64 bit.


>> -	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
>> -			     &res);
>> +	if (scmi_info->qcom_xport)
>> +		arm_smccc_1_1_hvc(scmi_info->func_id, cap_id, 0, 0, 0, 0, 0, 0,
>> +				  &res);
>> +	else
>> +		arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0,
>> +				     0, 0, &res);
> Does it make sense to call this variable qcom_xport? Would hvc_xport be
> a more appropriate name?
>
> Brian

Cap-id is QCOM specific ABI parameter not HVC.

>
