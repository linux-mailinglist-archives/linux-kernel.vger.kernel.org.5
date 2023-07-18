Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3592975855E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGRTKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:10:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEACDF4;
        Tue, 18 Jul 2023 12:10:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IBQa1j024657;
        Tue, 18 Jul 2023 19:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZQa9k2+6j6lALLr/TaoBsR6l8x/z7nc4yjW53EyLC0o=;
 b=WvTwiJCMWNQgVyndOal5wLD1bTYTflR3SQe51IxHtskCPq9EbZ9wev8xPZFw7kvZ3V1l
 vqP1ujMmjAGoGF5ZH5+WYeuCqG235nzXdFIx37aLPHPlxA0dvRm5O/UO2nzCDlOXatQs
 YfUZvyIe/qWHwYA6ldwM38Kcii3upVJWvVmiiiKaj4pMubPQluyAsgKuvAZywen/+c00
 OY+BYVFQlmCAbSsUpeC+u+LnDVRT7VY2GY7pdPRf/MdHi8olD8rrdtOm1ZEoN+r8lZXm
 gs6MAxPFY48GxoNbtmKLXXyrOMq5Koy/5Wkpja/DeFnC41jNpageIjbbC7lHK4kAQypG rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwn909rp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 19:10:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IJAHqg001448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 19:10:17 GMT
Received: from [10.110.49.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 12:10:16 -0700
Message-ID: <d2d01794-ef13-07f9-7695-b56b58cc01ac@quicinc.com>
Date:   Tue, 18 Jul 2023 12:10:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
 <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
 <6uelwa7fpzbw757rbb2j3u4ogagypdzyqj5mykyhlkkkvrnfin@ttonjpfn7nxc>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <6uelwa7fpzbw757rbb2j3u4ogagypdzyqj5mykyhlkkkvrnfin@ttonjpfn7nxc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2rCKIEvQwGE0gIHOH4CQWeHyot3clfz7
X-Proofpoint-ORIG-GUID: 2rCKIEvQwGE0gIHOH4CQWeHyot3clfz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_14,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180174
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/2023 12:07 PM, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 11:53:24AM -0700, Nikunj Kela wrote:
>> On 7/18/2023 11:29 AM, Bjorn Andersson wrote:
>>> On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
>>>> diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
> [..]
>>>> +static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
>>>> +			       struct device *dev, bool tx)
>>>> +{
> [..]
>>>> +	/* let's map 2 additional ulong since
>>>> +	 * func-id & capability-id are kept after shmem.
>>>> +	 *     +-------+
>>>> +	 *     |       |
>>>> +	 *     | shmem |
>>>> +	 *     |       |
>>>> +	 *     |       |
>>>> +	 *     +-------+ <-- size
>>>> +	 *     | funcId|
>>>> +	 *     +-------+ <-- size + sizeof(ulong)
>>>> +	 *     | capId |
>>>> +	 *     +-------+ <-- size + 2*sizeof(ulong)
>>> Relying on an undocumented convention that following the region
>>> specified in DeviceTree are two architecture specifically sized integers
>>> isn't good practice.
>>>
>>> This should be covered by the DeviceTree binding, in one way or another.
>> ok. Usually, DTBs don't allow non-hw properties in the dtb. I can try adding
>> a property as cap-id-width if its allowed.
>>
> If you remove the additional part, per the next comment, DeviceTree
> would be oblivious to these properties. I'll don't know if the
> DeviceTree people have any concerns/suggestions about this.
ok.
>
>>>> +	 */
>>>> +
>>>> +	scmi_info->shmem = devm_ioremap(dev, res.start,
>>>> +					size + 2 * sizeof(unsigned long));
>>> I don't find any code that uses the size of the defined shm, so I don't
>>> think you need to do this dance.
>> Right! I can remove the addition part.
>>>> +	if (!scmi_info->shmem) {
>>>> +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
>>>> +		return -EADDRNOTAVAIL;
>>>> +	}
>>>> +
>>>> +	func_id = readl((void *)(scmi_info->shmem) + size);
>>>> +
>>>> +#ifdef CONFIG_ARM64
>>>> +	cap_id = readq((void *)(scmi_info->shmem) + size +
>>>> +		       sizeof(unsigned long));
>>>> +#else
>>>> +	cap_id = readl((void *)(scmi_info->shmem) + size +
>>>> +		       sizeof(unsigned long));
>>>> +#endif
>>> Please don't make the in-memory representation depend on architecture
>>> specific data types. Quite likely you didn't compile test one of these
>>> variants?
>>>
>>> Just define the in-memory representation as u32 + u64.
>> I tested this for ARM64, I didn't test it for 32bit since Hypervisor doesn't
>> support it currently. In future, it may add 32 bit support too.
> I'd not be surprised if the capability id is 64 bit on a 32-bit machine
> as well, it's not really a property of the architecture.

on 32bit machine, you will have to use SMC32 convention. lt will mean 
that the parameters can only be 32 bit long. If you keep cap-id 64 bit 
in 32bit machines, then it has to be passed in two parameters. Are you 
suggesting, I make this driver dependent on ARM64 and only care about 64 
bit for now?

>
> But regardless, always using 64 bits in your memory representation will
> at worst waste a few bytes. But the result is a better defined
> interface, and you can avoid the conditional code.
>
> Regards,
> Bjorn
