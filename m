Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B327A68B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjISQQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjISQQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:16:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA5AB;
        Tue, 19 Sep 2023 09:16:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JAphEU023378;
        Tue, 19 Sep 2023 16:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PHUbtJEzjbMFZuHtcDHBZZbSPs5viejV11pTdFjLUTQ=;
 b=R4IE6g13ZSkfxduyBMWw4rbjl9O/CZTx/K13ki1x7EDG3c1YJR6gMtNzSPWWCJXNeGou
 sD9Kp8Hovrh6fugJJshW8+V5+9yATZfufybr1Tvvh3Y3KJ8FOU46XUueLwzyThu7j+D7
 6gqib4rP/NuukIEJOmZYyVfLg3dDQgJLsxyf/Ky8guOetYAkx8t0JrjgAZh8SxF78zIv
 1d3TGRx64DrTc9k87Ib+LrEKvuHPXtpNV49XGy6ltje4D9khGSDcFGRbBBPp7Tqp/lD9
 u1LsYtu/E4goye7ox4LC9jvhvLNsYg+evXDBOehy1wSsR73EZ3kx06vT5VAmVoOORm7M Zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6mtsbexe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 16:15:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JGFwDf002121
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 16:15:58 GMT
Received: from [10.216.36.122] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 19 Sep
 2023 09:15:53 -0700
Message-ID: <62147eab-aa1b-34c2-b6d2-7e5700a46cb6@quicinc.com>
Date:   Tue, 19 Sep 2023 21:45:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-5-quic_srichara@quicinc.com>
 <b0fe17e4-e4d8-02af-4e09-06b3930b38fe@linaro.org>
 <b40c6439-ab73-d796-589e-ffee21cedfc9@quicinc.com>
 <463923fe-7938-ad1b-fd79-6491329289af@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <463923fe-7938-ad1b-fd79-6491329289af@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ywFUsbtpKLShfYHjl9BIzYo50TACc1QU
X-Proofpoint-ORIG-GUID: ywFUsbtpKLShfYHjl9BIzYo50TACc1QU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_07,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190140
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2023 6:07 PM, Krzysztof Kozlowski wrote:
> On 19/09/2023 09:28, Sricharan Ramabadhran wrote:
>>
>>
>> On 9/15/2023 6:16 PM, Krzysztof Kozlowski wrote:
>>> On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
>>>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>>>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>>>> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
>>>> critical temperature being 120'C and action is to reboot. Adding all
>>>> the 4 zones here.
>>>>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> ---
>>>>    [v2] Fixed node names, order and added qfprom cells for points
>>>>         seperately to use the calibrate_common and squashed thermal_zone
>>>>         nodes here
>>>>
>>>>    arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>>>>    1 file changed, 169 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> index 9f13d2dcdfd5..d53aea5342e2 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> @@ -93,6 +93,117 @@ soc: soc@0 {
>>>>    		#size-cells = <1>;
>>>>    		ranges = <0 0 0 0xffffffff>;
>>>>    
>>>> +		qfprom: qfprom@a0000 {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my previous comments were not fully addressed. Maybe my
>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>> Please go back to the previous discussion and either implement all
>>> requested changes or keep discussing them.
>>>
>>
>>    oops, moved the compatible to first, but missed it on posting version.
>>    Will fix it in V3.
> 
> What do you mean by "posting version"? If it is not the same as your Git
> version, then your process is buggy. You must work on mainline tree and
> send patches from that tree. Not edit patches and edit Git separately...
> 
   Working on mainline tree only, just that i had 2 different build
   servers (one build machine and other local machine). Usually develop
   all on build server, copy/apply patches to local machine (mainline)
   and send. This time missed copying to local finally.

Regards,
  Sricharan

   one for
