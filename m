Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC4A7BE3BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376318AbjJIO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjJIO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:59:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E89A6;
        Mon,  9 Oct 2023 07:59:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399Dxkcj027223;
        Mon, 9 Oct 2023 14:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T6F8pc84NjvWuaNiXzQp1WQhhqK8wFXKn+d4LMiGlCI=;
 b=Jr1q8swIAe9KWqNICtSt3cuud/yci8XeWYy7fbhD+lrsWLv+jy3ei14SLN+UjE58RqqZ
 xAYToYnakDV2iSVYJU2QtvayZsj4fBSq1GUWc00xd8UqEuPxPtQZvZHI6vYglv7aXorg
 VYzfoKwyLp0Jdx3XY6BBcm11WNHFgt3bHyctTm4MuzP3DW+SqouexhgoHU7TZ+WENeyI
 nQJz+ncxBSdSfDZvglGWidRQxLpjwfraaDANmobOypTYkYw6scpMEqnF02tDDFNrXwbz
 MFFnF6eUzHV6rHSlUZHyWd+IcF5jqoO9IlBxJzJj8BXwxbciRP3Acv7GDSAfAPD7oCRt Pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkhj12nak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:59:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399Ex9LX028488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 14:59:09 GMT
Received: from [10.110.87.129] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 07:59:08 -0700
Message-ID: <e6d9fbbb-eb61-0736-aa7b-a5e5d1a91db1@quicinc.com>
Date:   Mon, 9 Oct 2023 07:59:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Add qcom smc/hvc transport
 support
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-3-quic_nkela@quicinc.com>
 <20231009144744.yi44ljq4llaxjsb7@bogus>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231009144744.yi44ljq4llaxjsb7@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LDZHqVFqKlD6kKLAdFiaifzEyyfQuJct
X-Proofpoint-GUID: LDZHqVFqKlD6kKLAdFiaifzEyyfQuJct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310090124
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/2023 7:47 AM, Sudeep Holla wrote:
> On Fri, Oct 06, 2023 at 09:42:06AM -0700, Nikunj Kela wrote:
>> This change adds the support for SCMI message exchange on Qualcomm
>> virtual platforms.
>>
>> The hypervisor associates an object-id also known as capability-id
>> with each smc/hvc doorbell object. The capability-id is used to
>> identify the doorbell from the VM's capability namespace, similar
>> to a file-descriptor.
>>
>> The hypervisor, in addition to the function-id, expects the capability-id
>> to be passed in x1 register when SMC/HVC call is invoked.
>>
>> The capability-id is allocated by the hypervisor on bootup and is stored in
>> the shmem region by the firmware before starting Linux.
>>
> Since you are happy to move to signed value, I assume you are happy to loose
> upper half of the range values ?
>
> Anyways after Bjorn pointed out inconsistency, I am thinking of moving
> all the values to unsigned long to work with both 32bit and 64bit.
>
> Does the below delta on top of this patch works for you and makes sense?

This looks good to me. Will do some testing and float v6 with the 
changes you suggested below. Thanks


>
> --
> Regards,
> Sudeep
>
> -->8
> diff --git c/drivers/firmware/arm_scmi/smc.c i/drivers/firmware/arm_scmi/smc.c
> index bf0b7769c7b2..e00c5e81c8d9 100644
> --- c/drivers/firmware/arm_scmi/smc.c
> +++ i/drivers/firmware/arm_scmi/smc.c
> @@ -15,6 +15,7 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
> +#include <linux/limits.h>
>   #include <linux/processor.h>
>   #include <linux/slab.h>
>   
> @@ -65,7 +66,7 @@ struct scmi_smc {
>   	unsigned long func_id;
>   	unsigned long param_page;
>   	unsigned long param_offset;
> -	s64 cap_id;
> +	unsigned long cap_id;
>   };
>   
>   static irqreturn_t smc_msg_done_isr(int irq, void *data)
> @@ -127,11 +128,11 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   			  bool tx)
>   {
>   	struct device *cdev = cinfo->dev;
> +	unsigned long cap_id = ULONG_MAX;
>   	struct scmi_smc *scmi_info;
>   	resource_size_t size;
>   	struct resource res;
>   	struct device_node *np;
> -	s64 cap_id = -EINVAL;
>   	u32 func_id;
>   	int ret;
>   
> @@ -167,6 +168,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   		return ret;
>   
>   	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
> +		void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
>   		/* The capability-id is kept in last 8 bytes of shmem.
>   		 *     +-------+
>   		 *     |       |
> @@ -177,12 +179,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   		 *     | capId |
>   		 *     +-------+ <-- size
>   		 */
> -
> -#ifdef CONFIG_64BIT
> -		cap_id = ioread64((void *)scmi_info->shmem + size - 8);
> -#else
> -		cap_id = ioread32((void *)scmi_info->shmem + size - 8);
> -#endif
> +		memcpy_fromio(&cap_id, ptr, sizeof(cap_id));
>   	}
>   
>   	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
> @@ -247,7 +244,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>   
>   	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>   
> -	if (cap_id >= 0)
> +	if (cap_id != ULONG_MAX)
>   		arm_smccc_1_1_invoke(scmi_info->func_id, cap_id, 0, 0, 0, 0, 0,
>   				     0, &res);
>   	else
>
