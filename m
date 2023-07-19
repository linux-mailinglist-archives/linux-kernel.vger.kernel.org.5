Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E67597AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGSOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGSOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:02:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9091;
        Wed, 19 Jul 2023 07:02:36 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JDhD6A025912;
        Wed, 19 Jul 2023 14:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lP+UQdvdiZga76/wKcWV7GgY6jAh8Ek4VBnz9rgidDQ=;
 b=emvVz798hTiwtrWz6LpfYWKlbSFWV/DUZguxxCimfPuT/yRd86G8gyTH6yRSi92XH367
 BvzSROZy6M59gz0PwC20G6Z7lrvscWIFxOa6mIm1PLyX5JjLt0bB8vJ0NcuirO5Bgh6Z
 ch+zD3U9QBxO0hwRMIm4TfyQYqIKMwzQ8Qd337PTw6Hfmfb4xuGMMa2oC1XDnVIGvYtx
 aSA/pPHsvQmYuBhh7APS7qkrjziA1ArjV+KMCt81aAt3AnWxIL8SIPUninSTyOXVcgoc
 oxP2JN+N2q2HO35Zfy/KgSAt6auuDaHH2cAnMcwJDPwyyj8A5r9XYsJRvn9QhTCpVnLo iQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwxknt7em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 14:02:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JE2QN4016970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 14:02:26 GMT
Received: from [10.110.49.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 07:02:25 -0700
Message-ID: <5ac65f22-0ea8-b6b0-f1d4-57ba3b5ba259@quicinc.com>
Date:   Wed, 19 Jul 2023 07:02:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     Bjorn Andersson <andersson@kernel.org>, <sudeep.holla@arm.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
 <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
 <ZLfBEsVQ8Zf7NO3d@e120937-lin>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZLfBEsVQ8Zf7NO3d@e120937-lin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8w9SV7-3f_k7GEPHxw73F75BaAvdaVLk
X-Proofpoint-GUID: 8w9SV7-3f_k7GEPHxw73F75BaAvdaVLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2023 3:55 AM, Cristian Marussi wrote:
> On Tue, Jul 18, 2023 at 11:53:24AM -0700, Nikunj Kela wrote:
>> On 7/18/2023 11:29 AM, Bjorn Andersson wrote:
>>> On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
>>>> diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
>>>> new file mode 100644
>>>> index 000000000000..3b6096d8fe67
>>>> --- /dev/null
>>>> +++ b/drivers/firmware/arm_scmi/qcom_hvc.c
>>>> @@ -0,0 +1,241 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * System Control and Management Interface (SCMI) Message
>>>> + * Qualcomm HVC/shmem Transport driver
>>>> + *
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright 2020 NXP
>>>> + *
>>>> + * This is copied from drivers/firmware/arm_scmi/smc.c
>>> s/copied from/based on/
>> ok.
> Hi Nikunj,
>
>>>> + */
>>>> +
>>>> +#include <linux/arm-smccc.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_address.h>
> [snip]
>
>>>> +
>>>> +static inline void
>>>> +qcom_hvc_channel_lock_acquire(struct scmi_qcom_hvc *scmi_info,
>>>> +			      struct scmi_xfer *xfer __maybe_unused)
>>>> +{
>>> You claim above that you copied smc.c, but you don't mention that you
>>> dropped the support for transfers from atomic mode. Please capture this
>>> in the commit message, so that someone looking at this in the future
>>> knows why you made this choice.
>> At the moment, we dont have any requirement to support atomicity. Will add a
>> comment in the commit message.
>>
> As said no atomic support no wrappers needed.
ACK!
>
>>>> +	mutex_lock(&scmi_info->shmem_lock);
>>>> +}
>>>> +
>>>> +static inline void qcom_hvc_channel_lock_release(struct scmi_qcom_hvc
>>>> +						 *scmi_info)
>>>> +{
>>>> +	mutex_unlock(&scmi_info->shmem_lock);
>>>> +}
>>>> +
>>>> +static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
>>>> +			       struct device *dev, bool tx)
>>>> +{
>>>> +	struct device *cdev = cinfo->dev;
>>>> +	struct scmi_qcom_hvc *scmi_info;
>>>> +	resource_size_t size;
>>>> +	struct resource res;
>>>> +	struct device_node *np;
>>>> +	unsigned long cap_id;
>>>> +	u32 func_id;
>>>> +	int ret, irq;
>>> Please declare one variable per line, and please sort them by length, in
>>> descending order (i.e. reverse Christmas tree).
>> ok
>>>> +
>>>> +	if (!tx)
>>>> +		return -ENODEV;
>>>> +
>>>> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
>>>> +	if (!scmi_info)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
>>>> +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
>>>> +		return -ENXIO;
>>>> +
>>>> +	ret = of_address_to_resource(np, 0, &res);
>>>> +	of_node_put(np);
>>>> +	if (ret) {
>>>> +		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	size = resource_size(&res);
>>>> +
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
> This is sort of transport configuration so maybe it could be placed on a
> shmem on its own, but it seems difficult that the binding can be accepted
> since, as you said, is not an HW description BUT indeed configuration.
Ok.
>
>>>> +	 */
>>>> +
>>>> +	scmi_info->shmem = devm_ioremap(dev, res.start,
>>>> +					size + 2 * sizeof(unsigned long));
>>> I don't find any code that uses the size of the defined shm, so I don't
>>> think you need to do this dance.
>> Right! I can remove the addition part.
> Mmm...but can you access this trailing config bytes if you dont ioremap it ?
No, I meant, the last 16 bytes of each channel can be used so we don't 
need to remap 2 extra ulong.
>
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
>>>> +
>>>> +	/*
>>>> +	 * If there is an interrupt named "a2p", then the service and
>>>> +	 * completion of a message is signaled by an interrupt rather than by
>>>> +	 * the return of the hvc call.
>>>> +	 */
>>>> +	irq = of_irq_get_byname(cdev->of_node, "a2p");
>>>> +	if (irq > 0) {
>>>> +		ret = devm_request_irq(dev, irq, qcom_hvc_msg_done_isr,
>>>> +				       IRQF_NO_SUSPEND,
>>>> +				       dev_name(dev), scmi_info);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "failed to setup SCMI completion irq\n");
>>>> +			return ret;
>>>> +		}
>>>> +	} else {
>>>> +		cinfo->no_completion_irq = true;
>>>> +	}
>>>> +
>>>> +	scmi_info->func_id = func_id;
>>>> +	scmi_info->cap_id = cap_id;
>>>> +	scmi_info->cinfo = cinfo;
>>>> +	qcom_hvc_channel_lock_init(scmi_info);
>>>> +	cinfo->transport_info = scmi_info;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int qcom_hvc_chan_free(int id, void *p, void *data)
>>>> +{
>>>> +	struct scmi_chan_info *cinfo = p;
>>>> +	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
>>>> +
>>>> +	cinfo->transport_info = NULL;
>>>> +	scmi_info->cinfo = NULL;
>>> Your a2p interrupt is cleaned up using devres, which will happen at a
>>> later point. So just setting cinfo to NULL here would cause an interrupt
>>> to trigger qcom_hvc_msg_done_isr() which will call scmi_rx_callback()
>>> which happily will dereference that NULL.
>> Ok, will add a check in ISR.
> Other transports here takes care to block/inhibit any further possible
> message reception with a transport/subsystem dependent method (like masking
> the IRQ calling into mbox subsys or breaking the virtio device); I suppose
> here you could also unregister the ISR before clearing to NULL.
> (and I'll need to post a similar fix for SMC...)
Thanks, will do!
>
> Thanks,
> Cristian
