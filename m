Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903678FDDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348517AbjIAM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbjIAM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:56:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7910FC;
        Fri,  1 Sep 2023 05:56:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3817dnOv027910;
        Fri, 1 Sep 2023 12:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iQDpE3oUzsQpFX7y4ICrAyxTrW4xNtItubvy27V7X6w=;
 b=blc+JGa/O/6sU0yVVfkeB7lDoZemDsthXnhOPnR0q2Jg48MTQA1nn13MjIi6YhrAg6LW
 0lRK6PsDhcliQMnN6jL8HcgAYwdfdsZktw3BdmPHNN1dQ3sRG4QAArRv25YhBYs2nW/4
 z1taGlcdSz26vQUDjlmrVMSh5n1GIkmaJDv8g+7e/mmmeJ6OKoRzcAz7gxrXMq6UHsKV
 OSzF5SFS+OLmrKaCKwyfPnUF8IV/QHmixuuG6fY6qbS4IjNhxzJf+GmIAPsH+cinbhME
 0QzFo0BkBvR4d5pvH6C2o1c+hH+3siJ4/7AbU5i2crfdpXM0uwE7uROshVByTu/KT2MG 4A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sua0brv3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 12:56:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381CuBhX028522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 12:56:11 GMT
Received: from [10.216.45.103] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 1 Sep
 2023 05:56:06 -0700
Message-ID: <3d09f47f-b0b8-4429-944a-df3de19c7a6c@quicinc.com>
Date:   Fri, 1 Sep 2023 18:26:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] crypto: qcom-rng - Add support for trng
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
 <20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org>
 <29fb1e51-1e18-4e45-be64-190df52e1156@quicinc.com>
Content-Language: en-US
In-Reply-To: <29fb1e51-1e18-4e45-be64-190df52e1156@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HiK5IzspJB4nPNxUEVUqaX2pFvvdu8Ws
X-Proofpoint-GUID: HiK5IzspJB4nPNxUEVUqaX2pFvvdu8Ws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=786
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I missed to notice. Please correct "-" to ":" in subject line

On 8/28/2023 10:29 AM, Om Prakash Singh wrote:
> 
> 
> On 8/24/2023 5:03 PM, Neil Armstrong wrote:
>> The SM8450 & later SoCs RNG HW is now a True Random Number Generator
>> and a new compatible has been introduced to handle the difference.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
