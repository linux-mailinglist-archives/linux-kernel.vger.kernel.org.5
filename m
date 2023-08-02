Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A676CDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjHBNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHBNIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:08:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C80DF;
        Wed,  2 Aug 2023 06:08:11 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372CpeJc000686;
        Wed, 2 Aug 2023 13:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Aak+kmw72Z4LWeb4q+Xj28N9GFyJZEdd0yYqO3oTKsc=;
 b=Gwh0hNnjr9QpEBRuLJKzyRTSIqJnmNFw+7G38SsYOrH9mUi7VtlXGabEjDT8964Lyytt
 2o8rtuWAK1SKBiCSUcB5SRSqWZoJqWLV5wmmJpxghoId0xV8cExrWmrvjgx3Ymwd8Th+
 amZ7u7ory9OKvJLuej5E/441pGf5whxJQiOOPaBBRnZ1w65r1R4rBd4LusjK5QlMWQt0
 tRzu1Tmbc+oZa6gUpZxFa/dIb5zi985r+ltHKovTbOHXBpPi5b+0KFmvKuVc/3y4p+9P
 CclzogrZ1rH4St2FjVroJpTjl40855lzu03sCDUkxfiJIQMbMQsaQhRKdaiFoO87Qww2 Og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b32eg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 13:08:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372D83gU005638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 13:08:03 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 06:08:00 -0700
Message-ID: <b3c2fa94-76ee-c903-d656-0dab6fd91687@quicinc.com>
Date:   Wed, 2 Aug 2023 18:37:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/8] arm64: dts: qcom: sdx75: Add spmi node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-2-git-send-email-quic_rohiagar@quicinc.com>
 <77d437eb-8edd-344d-61be-71aae7866a69@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <77d437eb-8edd-344d-61be-71aae7866a69@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _4I0ToN6QRU9ZaRn6goCnJZFrp-mOlgA
X-Proofpoint-ORIG-GUID: _4I0ToN6QRU9ZaRn6goCnJZFrp-mOlgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_08,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=580 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020115
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2023 6:10 PM, Konrad Dybcio wrote:
> On 2.08.2023 11:59, Rohit Agarwal wrote:
>> Add SPMI node to SDX75 dtsi.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index 21d5d55..5e9602cd 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -469,6 +469,29 @@
>>   			interrupt-controller;
>>   		};
>>   
>> +		spmi_bus: spmi@c400000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0x0 0xc400000 0x0 0x3000>,
>> +			      <0x0 0xc500000 0x0 0x400000>,
>> +			      <0x0 0xc440000 0x0 0x80000>,
>> +			      <0x0 0xc4c0000 0x0 0x10000>,
>> +			      <0x0 0xc42d000 0x0 0x4000>;
> Please pad the address part to 8 hex digits (add leading zeroes)
Sure will update this.
Thanks,
Rohit.
>
> Konrad
