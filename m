Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2094791A29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjIDO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjIDO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:57:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9C6CC3;
        Mon,  4 Sep 2023 07:57:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384Edo9R020123;
        Mon, 4 Sep 2023 14:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2QLlz+ibPLtisaeOAIEGvPuiElCxJ7taiSVtcQ5RIU8=;
 b=QplOTN7Z7rG4AkUPN4nQBvq8H3Usgci1UqGFEyvpic2ktrPMlgclIywCPYpqmrtY/AwO
 bLNKLcvuSwzyhztoVR9EsnWso3lVf44lrwfaUMqevd2jrhMQUKw3peSQqMEJqNAfk9fs
 eEAQe567jGjLyrj3NDYsWOfTveP8Mc7dQa+VylpxovuP57pCnWvRk8Mc6yMRuz9P2wU4
 GVRtYFA3KHzTGR59ELc2SwIGUipdOg0Ner2cb6+H0UCl6gl5+7nEjFR/MiOL6VFowcuY
 ZTBUlFJEPKXFZBJrciIOc0rTIGtTeW75EBwZ5GWjyaYMKJEU7RnnY6z3zeVGxLqMXlEc sQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvn6knd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 14:57:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384EvShN006956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 14:57:28 GMT
Received: from [10.216.2.19] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 07:57:22 -0700
Message-ID: <c029093b-7e94-4e65-9e4c-a5d0aae1f4f1@quicinc.com>
Date:   Mon, 4 Sep 2023 20:27:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] crypto: qcom-rng - Add support for trng
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
 <3d09f47f-b0b8-4429-944a-df3de19c7a6c@quicinc.com>
 <100bc802-b706-e923-463a-705522650ecb@linaro.org>
Content-Language: en-US
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <100bc802-b706-e923-463a-705522650ecb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gL4slR-pROzm0K_obZLf3_MmrTFm8969
X-Proofpoint-GUID: gL4slR-pROzm0K_obZLf3_MmrTFm8969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=617 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2023 11:03 PM, Krzysztof Kozlowski wrote:
> On 01/09/2023 14:56, Om Prakash Singh wrote:
>> I missed to notice. Please correct "-" to ":" in subject line
> 
> Hm? What do you want to correct? The subject prefix is correct, why do
> you ask to change it?
Previous applied patch using different subject line format-

"crypto: qcom-rng: Make the core clock optional regardless of ACPI presence"

But looks like What Neil is using is the right way, looking at change 
log for the file.

> 
> Best regards,
> Krzysztof
> 
