Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6576CE3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjHBNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHBNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:17:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210B1718;
        Wed,  2 Aug 2023 06:17:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372CgH2d012943;
        Wed, 2 Aug 2023 13:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FfnsBQVxydqhiN/JB0ZUJwbiXvoySmM4wjN1KTJSqis=;
 b=A6sVvDW1i9TLsZN6ImAMO4aSa/ATIHoXv4BVv6OB3V/7HRuOUZGG/0NLnP2doeSX+GAG
 V6Un5eWORfbnsDINlVXnqLnBxgweQe5Q/xlmvxIDal0UWGgKJqG8la2dFgSN0i71zaO0
 j4Uuo30LfQ5B8p1A6joaezS8UReTHL29gs/Ty8+X1a42Woucuab7e8Egekcv9bVNc5Jn
 yrtjv1ekFkKezcD8UogXRd3SPWs3up4wyk/lP7pevU+jSAY5SFs/ImEoUmccXuZ7WSju
 0M3gxgln1IbYdz9HAkCyjP/uGC0aioHphB2YK+L0GvL/BSIR8BF17rFRW5kdeoVnVOJ5 zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b32fdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 13:17:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372DHS0g009177
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 13:17:28 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 06:17:25 -0700
Message-ID: <6653d101-c9d8-fff6-46af-149a2f28e4b6@quicinc.com>
Date:   Wed, 2 Aug 2023 18:47:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5/8] ARM: dts: qcom: sdx65-mtp: Update the pmic used in
 sdx65
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-6-git-send-email-quic_rohiagar@quicinc.com>
 <51902449-11ea-508e-002d-b4b772ffe754@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <51902449-11ea-508e-002d-b4b772ffe754@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kU7QnUqe990pmFuoe5Tq1aOrxpjLUTf5
X-Proofpoint-ORIG-GUID: kU7QnUqe990pmFuoe5Tq1aOrxpjLUTf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=654 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2023 6:16 PM, Konrad Dybcio wrote:
> On 2.08.2023 11:59, Rohit Agarwal wrote:
>> Update the pmic used in sdx65 platform to pm7250b.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
> Has this changed with a board revision? Was this wrong before?
>
> Need more explanation, and this definitely deserves a Fixes: tag.
Just went through the sdx65 pmics and found this mistake so updating here.
Although the validations were successful with the earlier pmic as well 
when originally pushed the patch.
Will add the fixes tag.

Thanks,
Rohit.
>
> Konrad
>>   arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
>> index 02d8d6e..fcf1c51 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
>> @@ -7,7 +7,7 @@
>>   #include "qcom-sdx65.dtsi"
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include <arm64/qcom/pmk8350.dtsi>
>> -#include <arm64/qcom/pm8150b.dtsi>
>> +#include <arm64/qcom/pm7250b.dtsi>
>>   #include "qcom-pmx65.dtsi"
>>   
>>   / {
