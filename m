Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6D7B339D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjI2Na6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjI2Na4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:30:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3189C;
        Fri, 29 Sep 2023 06:30:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TChDP0014922;
        Fri, 29 Sep 2023 13:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rq6yxyFdTOuB7xAYdzQxJoBRTl12pxZCBJrKD+DcNdY=;
 b=nm9QbwKIKRdTg86NcY3bxclxR6E7Pqh1hEoGn7rCbS8LoMij3bckOC6jXmV3i7gRPNyw
 x0FOUMNmA5iBVRXzH9Oa539cRlz9PUucNZRaGvILDmBCDx7SUM0+S3Yo4/MowvpxodkZ
 p9Aptxk4pH6IWyhVgF2bsWWxov7lLoLfJ4XWZF4Yv8RL0TlRUf8BuEpX2s7mC+gJDnLy
 FiBiNwXebCBi8AD9Bcpm1jQqrDkBwSVzzdbtPNbIidapzBTE8sEJ3OegQBfeCsh0YjzX
 +9upPp1NCQnaRGjKq3p2FRGFnhP1W06Cm6EAchRLTIY0UXJDLxveYjMnLPCv2lIAoDP+ zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdhru1g2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:30:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38TDUSXH032382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:30:28 GMT
Received: from [10.216.51.141] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 29 Sep
 2023 06:30:18 -0700
Message-ID: <cc7a80f7-399e-40ca-ab29-9df3da70412d@quicinc.com>
Date:   Fri, 29 Sep 2023 19:00:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: ipq5332: Add USB Super-Speed PHY
 node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <quic_wcheng@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-4-quic_ipkumar@quicinc.com>
 <9e5ad332-2c04-4024-8321-3a9c66586b64@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <9e5ad332-2c04-4024-8321-3a9c66586b64@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kiprBqOw9GhCKVnOHvCO_KCwiO93qGmz
X-Proofpoint-GUID: kiprBqOw9GhCKVnOHvCO_KCwiO93qGmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=520 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2023 6:26 PM, Konrad Dybcio wrote:
> On 29.09.2023 10:42, Praveenkumar I wrote:
>> Add USB Super-Speed UNIPHY node and populate the phandle on
>> gcc node for the parent clock map.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index d3fef2f80a81..b08ffd8c094e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -158,6 +158,29 @@ usbphy0: phy@7b000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		usbphy1: phy@4b0000 {
>> +			compatible = "qcom,ipq5332-usb-uniphy";
>> +			reg = <0x4b0000 0x800>;
> Please pad the address part to 8 hex digits with leading zeroes.
Sure, will add.
>
>> +
>> +			clocks = <&gcc GCC_PCIE3X1_PHY_AHB_CLK>,
>> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>> +				 <&gcc GCC_USB0_PIPE_CLK>;
>> +			clock-names = "ahb",
>> +				      "cfg_ahb",
>> +				      "pipe";
>> +
>> +			resets =  <&gcc GCC_USB0_PHY_BCR>;
> Looks like there's a double space after '='
Sure, will remove the extra space.

--
Thanks,
Praveenkumar
>
> Konrad

