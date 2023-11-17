Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476DB7EEB9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbjKQERH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQERF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:17:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D691A5;
        Thu, 16 Nov 2023 20:17:02 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH3uYWl029393;
        Fri, 17 Nov 2023 04:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p9Jn6pkjc+vmJ8LCAOXWibM9ThVrcjeOLQX7yoL51Ic=;
 b=WN7dj6w/EyVOSfFnOIKNIUViYrfZnNeAR2LcPRXqQ6mKXCU71QSxAqVYD1LAjWb6HwUh
 xjSFkL3wb2+qnzUuNRDtYG3Go4VeMsey6Tk0SghsZW8DpAJbdSE3ypzXBWDU2sktR/TI
 AEqBe6v4YkwIMv6B6Z815ODNmu15Rq+ISrd65G8u3NVPbl2HpTP4vAf3n73j0PN3eLTW
 PzM/rAnM1lx86wXrTR2pIuwUhEeHB96HXToRefE+6BGm6Y2i9puxEJ0oc22NzRXZK4MN
 igJrNVOGV8qTg0WUQEQ9CMKrj84u0Wa3PJ4zZWbsxMbaNjvflxtoD1SFQfmelAzJyB1b 4w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udw46rckg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 04:16:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH4GeZj006381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 04:16:40 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 20:16:33 -0800
Message-ID: <ece6fb69-b313-a47d-24b3-af4077f09cc3@quicinc.com>
Date:   Fri, 17 Nov 2023 09:46:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: Add base SC8380XP dtsi and the QCP
 dts
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <ulf.hansson@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <ayan.kumar.halder@amd.com>, <j@jannau.net>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <lpieralisi@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>
References: <20231025142427.2661-1-quic_sibis@quicinc.com>
 <20231025142427.2661-4-quic_sibis@quicinc.com>
 <f3661605-ea2f-4681-8486-b83bd042568c@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <f3661605-ea2f-4681-8486-b83bd042568c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q-xyel4BCDUd47_vmMPMhnAlb7cgrmkX
X-Proofpoint-ORIG-GUID: q-xyel4BCDUd47_vmMPMhnAlb7cgrmkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_01,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170030
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Konrad,

On 10/26/23 16:06, Konrad Dybcio wrote:
> 
> 
> On 10/25/23 16:24, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> Add base dtsi and QCP board (Qualcomm Compute Platform) dts file for
>> SC8380XP SoC, describing the CPUs, GCC and RPMHCC clock controllers,
>> geni UART, interrupt controller, TLMM, reserved memory, interconnects,
>> SMMU and LLCC nodes.
>>
>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> [...]
> 
>> +&tlmm {
>> +    gpio-reserved-ranges = <33 3>, <44 4>, <238 1>;
> It would be really cool if you added an explanation on why these
> GPIOs need to be reserved, especially since you can see what's
> connected on there on schematics. So, like:
> 
> gpio-reserved-ranges = <33 3>, /* something */
>                 <44 4>, /* something else (fp scanner?)
>                 <238 1>; /* UFS reset? */

will do.

> 
> 
> [...]
> 
>> +            compatible = "qcom,oryon";
> Again, this compatible won't fly unless all of these cores
> are totally identical and Oryon is only a name for this
> generation on this SoC (which I believe not to be the case).
> 
>> +            reg = <0x0 0x0>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L1_0>;
>> +
>> +            L1_0: l1-cache {
>> +                compatible = "cache";
> I'm not sure if L1 is supposed to be described in the DT,
> Krzysztof should know.
> 
>> +                next-level-cache = <&L2_0>;
>> +
>> +                L2_0: l2-cache-0 {
>> +                    compatible = "cache";
> cache-level?
> cache-unified?

ack will remove the l1 and use ^^ appropriately.

> 
> [...]
> 
>> +    memory@80000000 {
>> +        device_type = "memory";
>> +        /* We expect the bootloader to fill in the size */
>> +        reg = <0 0x80000000 0 0x80000000>;
> That contradicts the comment you made above. Plus, 2 GiB seems a
> bit low for this SoC :D

will fix this.

> 
> [...]
> 
>> +        gunyah_hyp_mem: gunyah-hyp-region@80000000 {
> you can probably strip the "-region" part, as this is implied by
> being a child of /reserved-memory

ok, will do but all the previous SoCs do it differently.

> 
>> +        pld_pep_mem: pld-pep-region@81f30000 {
> What's PLD?
> 
> What's this region used for? PEP is a Windows invention.
> 

We list all the possible reserved memory regions from the reference doc.
I can remove the unused regions in the platforms dts later once this
series lands.

> [...]
> 
>> +        av1_encoder_mem: av1-encoder-region@8e900000 {
> Is AV1enc hardware separate from iris?

no, it isn't separate from iris AFAIK.

> 
> [...]
> 
>> +        gcc: clock-controller@100000 {
>> +            compatible = "qcom,sc8380xp-gcc";
>> +            reg = <0 0x100000 0 0x200000>;
> The address part of reg should be padded to 8 hex digits.

thanks for catching this.

> 
>> +
>> +                interconnects = <&clk_virt MASTER_QUP_CORE_2 0 
>> &clk_virt SLAVE_QUP_CORE_2 0>,
> QCOM_ICC_TAG_ALWAYS would be nicer than 0 (see sa8775p)

will do.

> 
> [...]
> 
>> +
>> +            interrupts =    <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> One space after and before '='

ack

> 
> Konrad
