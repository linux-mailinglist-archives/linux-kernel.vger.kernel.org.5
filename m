Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39BD7ACDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjIYCJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIYCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:09:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F9BBD;
        Sun, 24 Sep 2023 19:09:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P1eQYS019089;
        Mon, 25 Sep 2023 02:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gOu68Amm+qW3XZNBLbx+1piq7YY1IRG2q+AVux5o1JM=;
 b=VUV187JvSVlwZMzBFGYfdwEaiisiVm9Y/NcAI9V/UUb2+H6Zs42AJZkJrxryLNCVTMtP
 v3UOLqZg+6/0cj4NuJGRCo5bUbR3vEQ2ksDm5ulfmxFrEUg/6MaOIuzZAq/+2m7InSF1
 xeX60yCu9fFT0P1YZvahNRNYR9V0wp4Etuv8iFjTdQlsW6nnAD9PC+xejq17QuPu4OkA
 rKttzCihSizicXAa8AV4sdpv/G1Q4CITnRWDPgc/VoM/KikUQx0/1fh4gHkaKipNYFV+
 Lz5TbOV+KQs8lx9QJHiegt8biqPyKkOzFvT+nB/VuFfFbIRjBHMdmSLIF5MUOIE3aUHD TA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9r88jqm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:09:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P29SrN027965
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:09:28 GMT
Received: from [10.216.19.6] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 24 Sep
 2023 19:09:23 -0700
Message-ID: <6508a3ed-ac2e-c575-b152-0491b624e408@quicinc.com>
Date:   Mon, 25 Sep 2023 07:39:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sricharan R <quic_srichara@quicinc.com>
CC:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
 <CAA8EJprMP5KW80Qfc6DQDhjsoHQzeXm9H4UiRPexQNqsPtUzbA@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAA8EJprMP5KW80Qfc6DQDhjsoHQzeXm9H4UiRPexQNqsPtUzbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2a0pRWVikoCu9XzVa-SIzmVQd0UKIjSk
X-Proofpoint-GUID: 2a0pRWVikoCu9XzVa-SIzmVQd0UKIjSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250010
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2023 12:18 AM, Dmitry Baryshkov wrote:
> On Fri, 22 Sept 2023 at 14:51, Sricharan R
> <srichara@win-platform-upstream01.qualcomm.com> wrote:
>>
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
>> critical temperature being 120'C and action is to reboot. Adding all
>> the 4 zones here.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v3] Ordered the qfprom device node properties as per
>>        Krzysztof's comments
>>
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..9e28b54ebcbd 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -93,6 +93,117 @@ soc: soc@0 {
>>                  #size-cells = <1>;
>>                  ranges = <0 0 0 0xffffffff>;
>>
>> +               qfprom: qfprom@a0000 {
>> +                       compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
>> +                       reg = <0xa0000 0x1000>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +
>> +                       tsens_base1: base1@249 {
>> +                               reg = <0x249 2>;
>> +                               bits = <3 8>;
>> +                       };
>> +
>> +                       tsens_base2: base2@24a {
>> +                               reg = <0x24a 2>;
>> +                               bits = <3 8>;
>> +                       };
> 
> Sort by the address, please, as usual.
> 

  ok.

<..>

>>
>> +       thermal-zones {
>> +               ubi32-thermal {
>> +                       polling-delay-passive = <0>;
>> +                       polling-delay = <0>;
>> +                       thermal-sensors = <&tsens 1>;
>> +
>> +                       trips {
>> +                               ubi32-critical {
>> +                                       temperature = <120000>;
>> +                                       hysteresis = <2>;
>> +                                       type = "critical";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               cpu-thermal {
> 
> 'c' < 'u'. Please sort the nodes here.

  ok

Regards,
  Sricharan
