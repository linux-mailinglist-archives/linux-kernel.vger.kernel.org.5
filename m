Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6A7F2221
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjKUAar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjKUAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:30:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC00C9;
        Mon, 20 Nov 2023 16:30:41 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKNVUhL022184;
        Tue, 21 Nov 2023 00:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sIMJNfMgNrKWrPVaMaEIKJO+SGuGELyCfGjdsy3CAno=;
 b=MyudhcV8jQtUtf31gvjp3vHie3j04U9mnN1bsFM9ya9PYec/Bh2WF5WBierB7ZAi7/Dp
 XArXPy4Wgy7DegzPWmi79XGEAWVbo6ZYBL5gaMERvN31ihdUqIoqKffkhoz8Ieo9fZnq
 uUnQcHT02Itk0m9hV4fHXEeYffrIvTL33OFvYh1DNeywHezOnfZ8t6dJnoc2ZH3I52fI
 ksbxGS8Z9cD4X6OTMIJCb7IQLiobuv6RI/1MAqU505zfW4BDlds+plIK6FMZMAbLjSe1
 6wNfSqViKQCJpElPs/ouWXp6OGqYVkTuuhR12qLhyYOkDCcXzwuNreSAT43RCE+rOzII mA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7ea9hsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:30:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL0URLU023067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:30:27 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 16:30:24 -0800
Message-ID: <7bf18b1e-463d-4030-99cd-4fcf2126fda2@quicinc.com>
Date:   Tue, 21 Nov 2023 08:30:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] dt-bindings: arm: qcom: add SM8550 AIM300
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <-cc=kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-2-quic_tengfan@quicinc.com>
 <519b89a2-550e-44a2-bff0-a6a86c50d073@linaro.org>
 <54b68923-f670-482b-b4a2-ff5f5c867a91@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <54b68923-f670-482b-b4a2-ff5f5c867a91@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 733mOHfHhzZ8eeNIgeI4dFVWGBQQsjO9
X-Proofpoint-ORIG-GUID: 733mOHfHhzZ8eeNIgeI4dFVWGBQQsjO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=717 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/20/2023 4:53 PM, Krzysztof Kozlowski 写道:
> On 17/11/2023 11:22, Krzysztof Kozlowski wrote:
>> On 17/11/2023 11:18, Tengfei Fan wrote:
>>> Add board compatible for SM8550 AIM300.
>>
>> Subject, commit msg and compatible tell basically the same... and none
>> of them tell me what is AIM300.
> 
> Due to lack of explanation it is difficult to judge what's this. However
> based on pieces of information I got, it looks like it is not a board,
> so it is not suitable to be DTS, but DTSI. You still need a board...
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,
AIM (Artificial Intelligence Module). This hardware platform can be used 
to develop AI related software based on Qualcomm chipset. I also will 
update this message to patch commit message.

I also will sync with internal team about if we should create DTSI file 
as your suggestion.

The email update was delayed because I asked for a day off yesterday.

-- 
Thx and BRs,
Tengfei Fan
