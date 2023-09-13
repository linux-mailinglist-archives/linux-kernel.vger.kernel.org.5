Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957379E41A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjIMJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:48:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47690198C;
        Wed, 13 Sep 2023 02:48:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D8M8Xc021910;
        Wed, 13 Sep 2023 09:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Gyzp7W0KHU087D+/0uH5jMA9TVCUiQFVZ9mTNREIz3Q=;
 b=RZybnIz2BneGNMW5x2l2/8vfbt1iwIZ54qTGThQ5w10lCeDdobWWUkV0au8Be3GRnw4N
 +74Ur8rvxCNrioAFx/XXnbHo/y/QlvZLp7AgSQEqbgEPG6SXvHiv8MtSIwiwPmYmxX77
 oqfsiTJULRB+IanWA7ksRdoQ19uEa+pfpPKZCfNNVXCQmU5DqdjbyED1TEngCgOxImx3
 Q6oyaxil7hd/1wd5CiCjb6Q6MFLE1jvDVz5D0uOUw+k+iSp8g/PxmWUZrZFYnL2AkM5o
 B8Dcvqpzkr4Gl296f/2K/urFXOTuZoDnjLDLvqIjsxGVdeJRaK7PxZyom+Jw5RwVorMa Hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2ygr9a7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:48:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D9mCZf031836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:48:12 GMT
Received: from [10.217.217.202] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 02:48:06 -0700
Message-ID: <13571aeb-7f99-4f59-b528-5555c7ed9cf5@quicinc.com>
Date:   Wed, 13 Sep 2023 15:17:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: sa8775p: pmic: rectify phandle for
 gpio-ranges used by pmm8654au_1_gpios
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <bartosz.golaszewski@linaro.org>, <kernel@quicinc.com>,
        <quic_anantg@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230913094111.14744-1-quic_shazhuss@quicinc.com>
 <c373345b-6b6b-429d-9a62-5b325b34527b@linaro.org>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <c373345b-6b6b-429d-9a62-5b325b34527b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S82VZWkAEOpGAL49QJqrzRNugXisc8h-
X-Proofpoint-ORIG-GUID: S82VZWkAEOpGAL49QJqrzRNugXisc8h-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=306 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 3:15 PM, Konrad Dybcio wrote:
> On 13.09.2023 11:41, Shazad Hussain wrote:
>> Use correct phandle pmm8654au_1_gpios referred by gpio-ranges for
>> pmic pmm8654au_1.
>>
>> Fixes: e5a893a7cec5 ("arm64: dts: qcom: sa8775p: add PMIC GPIO controller nodes")
>> Reported-by: Anant Goel <quic_anantg@quicinc.com>
>> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
>> ---
> https://lore.kernel.org/linux-arm-msm/20230818135538.47481-1-krzysztof.kozlowski@linaro.org/
> 
> Konrad

Thanks Konrad for pointing this out :)

-Shazad
