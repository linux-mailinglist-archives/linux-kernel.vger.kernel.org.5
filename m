Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB257FDBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbjK2Pqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjK2Pqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:46:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559BD4A;
        Wed, 29 Nov 2023 07:46:50 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT95LFt023450;
        Wed, 29 Nov 2023 15:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QRdMrRohQbv/tt2MgO7i+Acwsqcl+EGgUW2nxnD1q3g=;
 b=cYP2h2Kf0IsXs4oz8YXDRGYH9k0GbWkUTm8OOjXhhiGZMi3CWjWp4+ddXelWLx1neRJj
 M0W5cFptKPW31tXa8R5EQSQhYrryUhtPpG94kwmF71qsnESbDE8ZMHZmMtS7FaiKRo6y
 3J/c4N86SIfy6+LcibvTZu/NMuHyBW3TT40b+hOqG7eBNDFaoAeO/OAVh0Xo2eyml99j
 Vnej7JkE0Y52clysn+1Ize4Dyoj4OE+xM/G3cgp4TSoFjLlly6VmzuNiHTpigXyW2SKL
 V2QwzasY5fzyr40HjEh4nb5/FKtP21jc6Q42GavRjRywUQINA0tgpUmuNtLJhiikLlUs aQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up2byrwxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 15:46:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATFkSZe029015
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 15:46:28 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 07:46:21 -0800
Message-ID: <8021a6f5-6316-031d-8181-e0e2047e2fa8@quicinc.com>
Date:   Wed, 29 Nov 2023 21:16:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/5] arm64: dts: qcom: Add base X1E80100 dtsi and the
 QCP dts
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
References: <20231117113931.26660-1-quic_sibis@quicinc.com>
 <20231117113931.26660-4-quic_sibis@quicinc.com>
 <918ff1f5-ce01-43ea-b034-e69fbb31f495@linaro.org>
 <3dd41426-c026-a832-0a6b-0aabfaec2a8c@quicinc.com>
 <c6e05a10-88cc-409c-afc0-37166b763eaa@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <c6e05a10-88cc-409c-afc0-37166b763eaa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kGbA_WCg7lEFRzzOyBeObLXQRZK1LAKD
X-Proofpoint-ORIG-GUID: kGbA_WCg7lEFRzzOyBeObLXQRZK1LAKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_13,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311290118
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 18:24, Konrad Dybcio wrote:
> On 29.11.2023 10:25, Sibi Sankar wrote:
>>
>>
>> On 11/18/23 06:36, Konrad Dybcio wrote:
>>> On 17.11.2023 12:39, Sibi Sankar wrote:
>>>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>>
>>>> Add base dtsi and QCP board (Qualcomm Compute Platform) dts file for
>>>> X1E80100 SoC, describing the CPUs, GCC and RPMHCC clock controllers,
>>>> geni UART, interrupt controller, TLMM, reserved memory, interconnects,
>>>> SMMU and LLCC nodes.
>>>>
>>>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> ---
> [...]
> 
> 
>>>> +        idle-states {
>>>> +            entry-method = "psci";
>>>> +
>>>> +            CLUSTER_C4: cpu-sleep-0 {
>>>> +                compatible = "arm,idle-state";
>>>> +                idle-state-name = "ret";
>>>> +                arm,psci-suspend-param = <0x00000004>;
>>> These suspend parameters look funky.. is this just a PSCI sleep
>>> implementation that strays far away from Arm's suggested guidelines?
>>
>> not really! it's just that 30th bit is set according to spec i.e
>> it's marked as a retention state.
> So, is there no state where the cores actually power down? Or is it
> not described yet?
> 
> FWIW by "power down" I mean it in the sense that Arm DEN0022D does,
> so "In this state the core is powered off. Software on the device
> needs to save all core state, so that it can be preserved over
> the powerdown."

I was told we mark it explicitly as retention because hw is expected
to handle powerdown and we don't want sw to also do the same.

> 
>>
>>>
>>> [...]
>>>
>>>
>>>> +        CPU_PD11: power-domain-cpu11 {
>>>> +            #power-domain-cells = <0>;
>>>> +            power-domains = <&CLUSTER_PD>;
>>>> +        };
>>>> +
>>>> +        CLUSTER_PD: power-domain-cpu-cluster {
>>>> +            #power-domain-cells = <0>;
>>>> +            domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
>>>> +        };
>>> So, can the 3 clusters not shut down their L2 and PLLs (if separate?)
>>> on their own?
>>
>> on CL5 the clusters are expected to shutdown their l2 and PLL on their
>> own.
> Then I think this won't happen with this description
> 
> every cpu has a genpd tree like this:
> 
> cpu_n
>   |_CPU_PDn
>      |_CLUSTER_PD
> 
> and CLUSTER_PD has two idle states: CLUSTER_CL4 and CLUSTER_CL5
> 
> which IIUC means that neither cluster idle state will be reached
> unless all children of CLUSTER_PD (so, all CPUs) go down that low
> 
> This is "fine" on e.g. sc8280 where both CPU clusters are part of
> the same Arm DynamIQ cluster (which is considered one cluster as
> far as MPIDR_EL1 goes) (though perhaps that's misleading and with
> the qcom plumbing they perhaps could actually be collapsed separately)

We did verify that the sleep stats increase independently for each
cluster, so it's behavior is unlike what you explained above. I'll
re-spin this series again in the meantime and you can take another
stab at it there.

-Sibi

> 
> Konrad
