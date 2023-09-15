Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94A7A1A13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjIOJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOJN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:13:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039DC1;
        Fri, 15 Sep 2023 02:13:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F7MuJh024975;
        Fri, 15 Sep 2023 09:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M8AcAOmpO2/N7p91G3xot8HpP2eNGiE59Sy1UTk9gHQ=;
 b=HeCDvm6tI4eyPVOv9jlsw1JOKFjuxSrrGjTex8+RUxdH2oF5zCC1uU/MooqzVISF4aMa
 1kh2xTN9Zim+q2+fGYCB4koFGMbDXqjfbJppEe9HUDefW/Qa7sDDEWJtY75puBb5JqSc
 81JLET+zFuVlaOtcqh8a/mRHtYfkbgPTY9/il5o2A+j5X/4dssaT5YvVmJYe8blYMeGD
 BMJYdS+vr2HDOXWzJX3vlRDIrQUkkDD2OWLrJs6Ql1cDjf0B4htNCD3SoX/J7SGp52yu
 siYiBa+tDdmBCuQT7evBSRjhsGbgQZYuUjQ3/GYsXSrtV1kcG+RORL82akuEw6rtrGsC 1w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4fsf8nep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 09:12:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F9CQXv016948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 09:12:26 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 02:12:17 -0700
Message-ID: <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
Date:   Fri, 15 Sep 2023 17:12:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _HUvVFVcgFkop8a71zbPlKCRzhCMNCKj
X-Proofpoint-GUID: _HUvVFVcgFkop8a71zbPlKCRzhCMNCKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxlogscore=857 mlxscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
> On 15/09/2023 04:15, Tengfei Fan wrote:
>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>> support the Qualcomm SM4450 platform to boot to uart shell.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/configs/defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index ec59174b14db..e91993de865e 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>   CONFIG_PINCTRL_SDM660=y
>>   CONFIG_PINCTRL_SDM670=y
>>   CONFIG_PINCTRL_SDM845=y
>> +CONFIG_PINCTRL_SM4450=y
>>   CONFIG_PINCTRL_SM6115=y
>>   CONFIG_PINCTRL_SM6125=y
>>   CONFIG_PINCTRL_SM6350=y
>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>   CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>   CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>   CONFIG_INTERCONNECT_QCOM_SDM845=y
>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
> 
> Why it cannot be =m?
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,
Because system haven't capacity of loading ko files at this time on 
SM4450 platform, so setting to "Y".

-- 
Thx and BRs,
Tengfei Fan
