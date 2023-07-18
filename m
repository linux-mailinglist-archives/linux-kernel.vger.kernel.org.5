Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93487586B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGRVQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGRVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:16:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF02198C;
        Tue, 18 Jul 2023 14:16:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IL7KXu015522;
        Tue, 18 Jul 2023 21:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PqfrqoeAg+0b1g+Sc4EJfTTv6RRn4fSeA06NxQ7vN/E=;
 b=Onwnnv+g0Jv0RxApQWdDjRJ/jQLGzFw3a4UOipleGW5fQZeSwsC7q9i3GEGQfE8KxMYS
 5WEseE3xiYfciHw+h9ID7DCpV3awHxgEpkaXdOIsASeoHoSb3RgrzZCCPvKJ7jW+WyI4
 zm0L4zQRgCoZsYbKziQ2ld2ljtK4mMkYZFtwpgSyJhLqVUp6+mQDS6Wpc9bc2xiVBeuk
 UzsSFikb4QvXQmOdUoxwfbvUaaNWkMKqjuGpADZY+LECcn+K311MHIVnf6a/V+4uupmI
 ERes7+WlzQLI+cduOgXnd31gVYyTBB88al07NduMIn0wnBk48kuMMyuKVgn+O0rsZqC0 iA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwpphhrr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 21:16:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ILG56L015128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 21:16:05 GMT
Received: from [10.110.49.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 14:16:05 -0700
Message-ID: <e8399fcf-e0d8-cc31-d9a7-b0f4f7cc3e71@quicinc.com>
Date:   Tue, 18 Jul 2023 14:16:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <d9d5ffd5-6f85-f091-5d69-12cdd8d04c99@linaro.org>
 <3ae2d618-490a-06da-b4b6-b5a24b0a9747@quicinc.com>
 <ec3d7769-8a5f-d938-7f77-351ddfe6fb45@linaro.org>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ec3d7769-8a5f-d938-7f77-351ddfe6fb45@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KuPAXTxwQROxCiF9BTqLsOxJIvWxkS5B
X-Proofpoint-ORIG-GUID: KuPAXTxwQROxCiF9BTqLsOxJIvWxkS5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_15,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180194
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/2023 11:42 AM, Krzysztof Kozlowski wrote:
> On 18/07/2023 20:25, Nikunj Kela wrote:
>>>> +
>>>> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
>>>> +	if (!scmi_info)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
>>>> +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
>>> You leak here reference.
>> Wouldn't the devm_* API take care of that implicitly? It is same in
>> smc.c as well.
> Thanks for bringing my attention to this. I sent a fix for smc.c. Fix
> your patch as well, please.
Thanks, I thought you were referring to kzalloc cleanup. Will include 
this fix. BTW, you may need to fix mailbox.c as well.
>
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
>>>> +	 */
>>>> +
>>>> +	scmi_info->shmem = devm_ioremap(dev, res.start,
>>>> +					size + 2 * sizeof(unsigned long));
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
>>> return dev_err_probe, unless this is not called in probe... but then
>>> using devm-interface raises questions.
>> This is copied as is from existing smc.c
> I understand and I hope you understand the code you copied. If there is
> a bug in existing code, please do not copy it to new code (like leaking
> OF node reference).
>
> Best regards,
> Krzysztof
>
