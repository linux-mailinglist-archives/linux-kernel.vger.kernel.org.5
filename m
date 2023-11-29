Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8817FD271
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjK2J0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2J0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:26:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAEFB9;
        Wed, 29 Nov 2023 01:26:10 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6TU8W029933;
        Wed, 29 Nov 2023 09:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7R1kbCVA6UYn66gQXAAcWAa9/+nx41Cmcr+zfZ67Fkk=;
 b=kepG/xR/E5etU7XUaBqrwL8BTp/D9vf/qQo3dN4ulfPOszvVIKmu5IrEvA7usVaNNay4
 OFSNc3ENPHQjcQT1AhtJGNRgu29uQRQvZgT+hph8D43Ursjnn/894+HdlRMTUQRWm7ay
 t50jm2CIAZvBPPzNWm4Ek+sBzHyqL5soMHTJ34JsAMeqTMG1BPaPzchpTCqp1+5iRNn1
 muNYW27HIb0dY0XMr0AhmBbp8QQnw9Ct0JJNJQ3BTFSdAhE/MAouFArK8xre1lTVErGD
 tRIDEjEnWwJxwhdOifYIq66c9HTFALh2Cj4iRHYiIQ/Vmjoqbs8kExpjGbUdD06oUNPw nA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up02xrf1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 09:25:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT9Polr032404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 09:25:50 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 01:25:44 -0800
Message-ID: <3dd41426-c026-a832-0a6b-0aabfaec2a8c@quicinc.com>
Date:   Wed, 29 Nov 2023 14:55:40 +0530
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
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <918ff1f5-ce01-43ea-b034-e69fbb31f495@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FtYYxaln7cyVjFWbjwltIs7dEvDSRTbl
X-Proofpoint-GUID: FtYYxaln7cyVjFWbjwltIs7dEvDSRTbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=943 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290069
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/23 06:36, Konrad Dybcio wrote:
> On 17.11.2023 12:39, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> Add base dtsi and QCP board (Qualcomm Compute Platform) dts file for
>> X1E80100 SoC, describing the CPUs, GCC and RPMHCC clock controllers,
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
>> +	gpio-reserved-ranges = <33 3>, <44 4>, /* SPI (TPM) */
> Surely SPI doesn't use 7 wires! :D

yeah, they are just secure reserved unused gpios.

> 
> [...]
> 
>> +			L2_0: l2-cache-0 {
> the cache device is distinguishable by its parent, so "l2-cache" is enough

thanks will fix ^^

> 
> 
>> +				compatible = "cache";
>> +				cache-level = <2>;
>> +				cache-unified;
>> +			};
>> +		};
>> +
> [...]
> 
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			CLUSTER_C4: cpu-sleep-0 {
>> +				compatible = "arm,idle-state";
>> +				idle-state-name = "ret";
>> +				arm,psci-suspend-param = <0x00000004>;
> These suspend parameters look funky.. is this just a PSCI sleep
> implementation that strays far away from Arm's suggested guidelines?

not really! it's just that 30th bit is set according to spec i.e
it's marked as a retention state.

> 
> [...]
> 
> 
>> +		CPU_PD11: power-domain-cpu11 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +		};
>> +
>> +		CLUSTER_PD: power-domain-cpu-cluster {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_CL4>, <&CLUSTER_CL5>;
>> +		};
> So, can the 3 clusters not shut down their L2 and PLLs (if separate?)
> on their own?

on CL5 the clusters are expected to shutdown their l2 and PLL on their
own.

> 
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		gunyah_hyp_mem: gunyah-hyp@80000000 {
>> +			reg = <0x0 0x80000000 0x0 0x800000>;
>> +			no-map;
>> +		};
>> +
>> +		hyp_elf_package_mem: hyp-elf_package@80800000 {
> no underscores in node names, use hyphens

ack

-Sibi
> 
> The rest looks OK I think
> 
> Konrad
