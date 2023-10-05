Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144347BA2BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjJEPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjJEPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73514527B;
        Thu,  5 Oct 2023 07:31:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3956Pq8h000838;
        Thu, 5 Oct 2023 07:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TfuqxHYAcJwXqzQfsplkE3/qAKcLiHAqFynBI2piMhk=;
 b=XwmL57wFp77agmE54kbG6jQBOtXmJ0zupKhcJuXuUSGXhQoEj3jb+84i3Uc1RPaOadsQ
 TjsbyjNGsrxiZiHxKsUC/IIbsYgsb8A4hSRoP3HQ+wkeB2mJ6LfViYBwUhLEwcPkj6fQ
 uFULV0umXm22zGYfC9zhpE6YPRp49DtcN6tGZJBmu9e9XRAMOQs84pGBWKOqYOw01C+7
 MIg6g84S2DEZ6zPSFXhzF4aRWOzioJuGOI9NkWQoSnQ25u6AxCDXyMKZiSRdl8BCfPTU
 e8izV8RM95UbK+vVG+uvDtGFdac3mz//w/DA1ivOoU+UqqEGPL8Iw5cRyXryYUCmN0no sA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thj6ggpyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 07:34:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3957Y3em029605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 07:34:03 GMT
Received: from [10.216.40.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 00:33:56 -0700
Message-ID: <4de85592-ab53-4528-cc98-3ad5fc128032@quicinc.com>
Date:   Thu, 5 Oct 2023 13:03:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V14 4/4] arm64: dts: qcom: ipq6018: add pwm node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
References: <20231005043127.2690639-1-quic_devipriy@quicinc.com>
 <20231005043127.2690639-5-quic_devipriy@quicinc.com>
 <9afe38a1-193b-494e-a47f-83610d6dabac@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <9afe38a1-193b-494e-a47f-83610d6dabac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -HJhifkoLiIuVaFSyslCRkT2QsMv8hXB
X-Proofpoint-ORIG-GUID: -HJhifkoLiIuVaFSyslCRkT2QsMv8hXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050057
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 1:00 PM, Krzysztof Kozlowski wrote:
> On 05/10/2023 06:31, Devi Priya wrote:
>> Describe the PWM block on IPQ6018.
>>
>> The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
>> &pwm as child of &tcsr.
>>
>> Add also ipq6018 specific compatible string.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>> v14:
>>
>>    Moved ranges just after reg as suggested by Krzysztof
>>
>>    Picked up the R-b tag
>>
>> v13:
>>
>>    No change
>>
>> v12:
>>
>>    No change
>>
>> v11:
>>
>>    No change
>>
>> v10:
>>
>>    No change
>>
>> v9:
>>
>>    Add 'ranges' property (Rob)
>>
>> v8:
>>
>>    Add size cell to 'reg' (Rob)
>>
>> v7:
>>
>>    Use 'reg' instead of 'offset' (Rob)
>>
>>    Add qcom,tcsr-ipq6018 (Rob)
>>
>>    Drop clock-names (Bjorn)
>>
>> v6:
>>
>>    Make the PWM node child of TCSR (Rob Herring)
>>
>>    Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
>>
>> v5: Use qcom,pwm-regs for TCSR phandle instead of direct regs
>>
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index e59b9df96c7e..565e61ce382f 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -390,8 +390,21 @@ tcsr_mutex: hwlock@1905000 {
>>   		};
>>   
>>   		tcsr: syscon@1937000 {
>> -			compatible = "qcom,tcsr-ipq6018", "syscon";
>> +			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
>>   			reg = <0x0 0x01937000 0x0 0x21000>;
>> +			ranges = <0x0 0x0 0x01937000 0x21000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			 pwm: pwm@a010 {
> 
> Broken indentation.

Oops, sorry! will fix it up

Thanks,
Devi Priya
> 
> Best regards,
> Krzysztof
> 
