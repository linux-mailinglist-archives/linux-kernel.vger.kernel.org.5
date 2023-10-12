Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153CC7C7392
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378915AbjJLQ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjJLQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:57:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC46B7;
        Thu, 12 Oct 2023 09:57:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CDLifc010756;
        Thu, 12 Oct 2023 16:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tFLxmj09QJweq//cJjff42gF1cQIyOlmZvPRzNFpAgE=;
 b=QyutPYSTY40Uo8WywxpJmE4wMv1CwNmnxeX+uqA+JXlBkJjKgf53UWMo4rxSbatkq67/
 PF6B9i8Fq2msYf21sBZV4BFW8ePytgOvsMKkMi68DEm7GShhcQvXBfYRLNCqdZxEwO+/
 NemiTVXUq/BO2xTFC/D0zDGoFpuZXJq+4vlBGMG96zWEuS0Ce52LuofJcIeMjvVhuXOl
 DSPvn088YbYhaZHv67LOvN7MK4DCC6FWmydYJ/WKxY+dWtrw/s9WBiGUT/kq74Nj8lTG
 iPH+3Kx7PhzROYEvfogWxSkY2SIsZBYbVrqi6A0ZAg280SuhPVBaezjKX49+ti8Veipf pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tp87v9qcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 16:57:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CGvlQ6026494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 16:57:47 GMT
Received: from [10.216.13.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 09:57:42 -0700
Message-ID: <6da8dc86-0b9a-488f-9046-9d9d269beeaf@quicinc.com>
Date:   Thu, 12 Oct 2023 22:27:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1696406908-9688-1-git-send-email-quic_rohiagar@quicinc.com>
 <1696406908-9688-2-git-send-email-quic_rohiagar@quicinc.com>
 <3a042a26-81b4-4ab3-ba03-a38ae876634b@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <3a042a26-81b4-4ab3-ba03-a38ae876634b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KRTXYAmRRvK2hXu9K0uZxZTC_73vYGrm
X-Proofpoint-GUID: KRTXYAmRRvK2hXu9K0uZxZTC_73vYGrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/2023 10:18 PM, Konrad Dybcio wrote:
>
>
> On 10/4/23 10:08, Rohit Agarwal wrote:
>> Add interconnect nodes to support interconnects on SDX75.
>> Also parallely add the interconnect property for UART required
>> so that the bootup to shell does not break with interconnects
>> in place.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 52 
>> +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index e180aa4..b4723fa 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -8,6 +8,8 @@
>>     #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/clock/qcom,sdx75-gcc.h>
>> +#include <dt-bindings/interconnect/qcom,icc.h>
>> +#include <dt-bindings/interconnect/qcom,sdx75.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> @@ -203,6 +205,19 @@
>>           };
>>       };
>>   +    clk_virt: interconnect-0 {
>> +        compatible = "qcom,sdx75-clk-virt";
>> +        #interconnect-cells = <2>;
>> +        qcom,bcm-voters = <&apps_bcm_voter>;
>> +        clocks = <&rpmhcc RPMH_QPIC_CLK>;
>> +    };
>> +
>> +    mc_virt: interconnect-1 {
>> +        compatible = "qcom,sdx75-mc-virt";
>> +        #interconnect-cells = <2>;
>> +        qcom,bcm-voters = <&apps_bcm_voter>;
>> +    };
>> +
>>       memory@80000000 {
>>           device_type = "memory";
>>           reg = <0x0 0x80000000 0x0 0x0>;
>> @@ -434,6 +449,9 @@
>>               clock-names = "m-ahb",
>>                         "s-ahb";
>>               iommus = <&apps_smmu 0xe3 0x0>;
>> +            interconnects = <&clk_virt MASTER_QUP_CORE_0 
>> QCOM_ICC_TAG_ALWAYS
>> +                     &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
>> +            interconnect-names = "qup-core";
> No qup-config?
>
> My brain compiler says this would cause a dt checker warning, at least 
> on next-20231012.
If I check the tip, then there is only one interconnect entry.
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/soc/qcom/qcom%2Cgeni-se.yaml#L50
For the debug uart, the qup-config is added.
I did check the dtbs_check before sending these patches.
Please let me know if I am missing anything.

Thanks,
Rohit.
>
> Konrad
