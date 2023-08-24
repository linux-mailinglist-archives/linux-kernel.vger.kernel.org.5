Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B10786DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjHXLYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjHXLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:24:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B010FA;
        Thu, 24 Aug 2023 04:24:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O9vOaD011109;
        Thu, 24 Aug 2023 11:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2Dz1+hAiDbVufNU3Br/8pVgbKQsoS6jl9qrvTruWUIk=;
 b=L1IX3zJWLeCPAv23/fCw26uSN95XD9jk0GVb8W5OaMLhvMwAFmn9ecisEUTsvhZM256E
 DlVpLqajjoBg4tczYSzZJQ/T7SHWpIolZd7HsQQNKKHbzZkS6ww9SiEV1Lb8gwYTfe+5
 OKaCo8nN0TNLYh0GKSSfg2zJtLavY/8RVhpXTfnaR+i0o+v6gqAOBoynyGSlHmFLZWOQ
 FLdF6RdDFNjsGqTZqmnHD8Wu/NlQuPdF+tToEjUySGviuDFDctUGRuOcjeDbo8MFsvRC
 MZdTUJjrI0EWwkbWfj6U8RfhAHxalb6/OLihMpLSwWtkIvThnuNPXeQ4TwXCs9vusm7w YA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumt5xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 11:24:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OBOBUm022309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 11:24:11 GMT
Received: from [10.216.60.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 04:24:04 -0700
Message-ID: <389f9df4-bcdb-4ec4-57d0-978b03fa862b@quicinc.com>
Date:   Thu, 24 Aug 2023 16:53:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Enable tsens and thermal for
 sa8775p SoC
Content-Language: en-US
To:     Konrad Dybcio <konradybcio@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_manafm@quicinc.com>
References: <20230821112928.19284-1-quic_priyjain@quicinc.com>
 <20230821112928.19284-3-quic_priyjain@quicinc.com>
 <ac153c9b-f698-47f4-9d52-b3ea5c9ba213@kernel.org>
From:   Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <ac153c9b-f698-47f4-9d52-b3ea5c9ba213@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QtilqEFlvBBJQg9hBqzSiOSUPzXNtoXS
X-Proofpoint-ORIG-GUID: QtilqEFlvBBJQg9hBqzSiOSUPzXNtoXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=768
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240092
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 8/21/2023 5:25 PM, Konrad Dybcio wrote:
> On 21.08.2023 13:29, Priyansh Jain wrote:
>> Add tsens and thermal devicetree node for sa8775p SoC.
>>
>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1096 +++++++++++++++++++++++++
>>   1 file changed, 1096 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index b130136acffe..b9c622b3bf7e 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -2306,6 +2306,1102 @@
>>   
>>   			#freq-domain-cells = <1>;
>>   		};
>> +
>> +		tsens0: thermal-sensor@c222000 {
>> +			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
>> +			reg = <0x0C263000 0x1ff>,  /* TM */
>> +				<0x0C222000 0x1ff>; /* SROT */
> 1. Test your patches. This will obviously not work due to the
>     #address/size-cells values of /soc@0.
Yes this needs to be updated, Will update in the next revision.
> 
> 2. Use lowercase hex.
Sure will update in next revision.
> 3. Align subsequent entries for a property with the previous line
> 
Sure will update in next revision.
> 4. Are you sure SROT is 0x1ff-long?
> 
Yes it can be updated to 0x8 , will update in next revision.
> 5. The usefulness of these comments is questionable, many DTs have
>     them because of copypasta but I think it's time to stop that.
> 
Yes will remove them in next revision.
> 6. No pdc wake-capable interrupts?
Yes they don't need to be pdc wakeup capable.
> 
>> +			#qcom,sensors = <12>;
>> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
>> +				<GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "uplow","critical";
> Missing space after the comma
Yes will update in next revision.
> 
> Please move interrupt properties right after 'reg'.
Sure will update in next revision.
> Konrad
