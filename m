Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182F7A3F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjIRAzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIRAyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:54:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943010C;
        Sun, 17 Sep 2023 17:54:47 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38I0s4V7012533;
        Mon, 18 Sep 2023 00:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XDG2ljxBeUxeHHBhrk4xLiH9mIRami7tkvQKXbXseCU=;
 b=MN+MugP/e0cay3G0L3Riwp9x5IWmekcBhSRxbWswD7RZ3Sn2I29W7OHoHbUVsdZ1rce5
 qWVg2jSSw5H589luI54zEJ7SjRcBmQaF8Nku9HOVaUJ+VmdC2ueN5B8FYLCXS6XAmWdQ
 HHXlHznnbQwTuNDFuiz4JHcNXrqN1CgVklMhgO6aP/Y6YqZYGh0zFtbM6+Aih/b2ttyR
 O2CfPYhCoMDCkBZQm6NkrdSMTT1FR8moOF7sBKZvjNn48zl/ay+87eKW96DnyS6YG1Qa
 VAqnJX32ABHHb5xCi7cFzLn24Q/ufybsQVn8i1mo5Z4V4YShTsnjufeiifa3nJJn2byW mA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t53aya7dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 00:54:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38I0s219019178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 00:54:02 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 17 Sep
 2023 17:53:53 -0700
Message-ID: <a3053932-6aca-4250-8a5d-11fcdd42413e@quicinc.com>
Date:   Mon, 18 Sep 2023 08:53:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
 <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
 <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
 <accb4814-4826-ff97-3527-4e3fbadcd4ff@linaro.org>
 <c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org>
 <54fcf0c2-c8e2-6ee8-5f6c-4de914c56c19@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <54fcf0c2-c8e2-6ee8-5f6c-4de914c56c19@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jvzNWUpvxfNVINAdElnZAEis8Imc0opD
X-Proofpoint-ORIG-GUID: jvzNWUpvxfNVINAdElnZAEis8Imc0opD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=964 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/17/2023 3:35 PM, Krzysztof Kozlowski 写道:
> On 17/09/2023 00:55, Georgi Djakov wrote:
>> Hi Krzysztof,
>>
>> On 16.09.23 23:32, Krzysztof Kozlowski wrote:
>>> On 16/09/2023 17:13, Georgi Djakov wrote:
>>>>
>>>>>
>>>>> Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
>>>>> the reasons somewhere on why they are added as =y?
>>>>>
>>>>> CONFIG_INTERCONNECT_QCOM=y
>>>>> CONFIG_INTERCONNECT_QCOM_MSM8916=m
>>>>> CONFIG_INTERCONNECT_QCOM_MSM8996=m
>>>>> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>>>> CONFIG_INTERCONNECT_QCOM_QCM2290=m
>>>>> CONFIG_INTERCONNECT_QCOM_QCS404=m
>>>>> CONFIG_INTERCONNECT_QCOM_SA8775P=y
>>>>> CONFIG_INTERCONNECT_QCOM_SC7180=y
>>>>> CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>> CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>> CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>>> CONFIG_INTERCONNECT_QCOM_SM8150=m
>>>>> CONFIG_INTERCONNECT_QCOM_SM8250=m
>>>>> CONFIG_INTERCONNECT_QCOM_SM8350=m
>>>>> CONFIG_INTERCONNECT_QCOM_SM8450=y
>>>>> CONFIG_INTERCONNECT_QCOM_SM8550=y
>>>>
>>>> If the device can boot (to console/initramfs) with =m, we go with that.
>>>> But if something critical like the UART depends on the interconnect
>>>> provider, then we make it built-in.
>>>>
>>>> On SM8550 for example, we have enabled bandwidth scaling support for QUP
>>>> and that's why it needs to be =y.
>>>>
>>>> It looks like on SM4450 this should be =y too.
>>>
>>> I asked why SM4450 has to be =y and there was no answer. The argument
>>> that SM8450 is a module, is not applicable.
>>
>>   From the hardware description i see in patch 7, the serial engine depends
>> on some interconnect provider. But as the serial console driver is only
>> available as built-in, the interconnect provider also needs be built-in
>> for the UART device to probe and register the console.
>>
>> So the answer to your question should be that this is needed by the UART
>> device (at least).
>>
>> Such details of course deserve to be mentioned in the commit message of
>> this patch.
> 
> If you mean here the debug UART with console, then it is the same valid
> reason as in my change for others. This should be mentioned in commit msg.
> 
> Best regards,
> Krzysztof
> 
yes, will mention this valid reason in next patch commit message detailly.

-- 
Thx and BRs,
Tengfei Fan
