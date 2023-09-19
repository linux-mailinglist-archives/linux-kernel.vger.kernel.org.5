Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C047A5AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjISH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjISH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:28:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8D116;
        Tue, 19 Sep 2023 00:28:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6Anl1007820;
        Tue, 19 Sep 2023 07:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z1930RYNMY8QCWBZ8oDZEVFEgbvg9qin0zy01lwYogE=;
 b=HrW1lxRPWnqDOrUUHo9OQDiPSNwb/z23YVx3EkQwBgKwHoZulxl1mtDzEVVgqqfnQem+
 8GQuMsu4YBUIZ53AIvqgGBPFEnTrQ4vKtZ4GM4C248Eo32BjToYGnFQPDHBFtFSpWp6L
 FR0y1DPx+fIxtI29QvH2UZy00CvGiWF4HPb5Q9DbTHXYx2dVmZG4nSgpxi+JMynWwTX/
 UAOv6+egqblf7ALqGfQHDtbzVpVlWl1Nsz/fYkIO4/vOFKUuYNwItVBnppp9vfYQdqBs
 /9T2NJRWuL359AbrRTWVoXaMwqZcsnUeZFsIdRqbg9HY5guSpOSE8n0h4+3aHGfhRizj iA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t746g09p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:28:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J7SeY8024765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:28:40 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 19 Sep
 2023 00:28:35 -0700
Message-ID: <b40c6439-ab73-d796-589e-ffee21cedfc9@quicinc.com>
Date:   Tue, 19 Sep 2023 12:58:32 +0530
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
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <b0fe17e4-e4d8-02af-4e09-06b3930b38fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4dS0KCBHHqGuPoBNX3_ebDk0AdslBfDu
X-Proofpoint-GUID: 4dS0KCBHHqGuPoBNX3_ebDk0AdslBfDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190061
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 6:16 PM, Krzysztof Kozlowski wrote:
> On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
>> critical temperature being 120'C and action is to reboot. Adding all
>> the 4 zones here.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v2] Fixed node names, order and added qfprom cells for points
>>        seperately to use the calibrate_common and squashed thermal_zone
>>        nodes here
>>
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..d53aea5342e2 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -93,6 +93,117 @@ soc: soc@0 {
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		qfprom: qfprom@a0000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 

  oops, moved the compatible to first, but missed it on posting version.
  Will fix it in V3.

Regards,
  Sricharan
