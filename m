Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFE7543C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjGNUdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjGNUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:32:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC535AD;
        Fri, 14 Jul 2023 13:32:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EJRF0V032181;
        Fri, 14 Jul 2023 20:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wOEuZ0axDfpKHVOu0u/ZkL+Xp0dWtcUrVMCcIi3yLtQ=;
 b=T3n94NJgFrWm5u6CDeOYjOsRLB05FcOfMssSwbQiD2+n/HI02B+rhTEvXyQhrC4IjLtJ
 8gP/zKLi6feqdMr3kj2UJwrDHaAIbTVb3OOIbRFISeVKNlWNAg4zt1uhIV7OSH09TK/1
 AejVXUfoRwrIlBEk2j7frnVm+h+jNw8QDp7VAPD9I2VB7Tx5waFZN9RPb3JG1ONsW+Uk
 pQv8uWgot/M0sqDbIGoTQ+Ny8v/VkNhZtJY12JPWIqyhQ6YjbDxSQ90+pLka70BAGWgw
 QFQBkXebOkZhvscGMWXGSL5LK6AViyvbZ+a2TfY43IRTzINUpUElqTRVJMIV4bHC5uFa Iw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpu92t68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 20:32:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EKWiTf012707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 20:32:44 GMT
Received: from [10.110.52.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 13:32:43 -0700
Message-ID: <511a84a8-ecb4-13bb-2eab-982b19758ba5@quicinc.com>
Date:   Fri, 14 Jul 2023 13:32:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Rob Herring <robh@kernel.org>, <pavel@ucw.cz>, <lee@kernel.org>,
        <thierry.reding@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
 <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
 <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
 <431faa87-d152-5f7a-40fd-8b6fe26f0bb9@linaro.org>
 <71e1f36f-8fd8-9d61-d563-577d4fb54f10@quicinc.com>
 <69c01f0f-4eb0-bb44-a238-5c9ce5beede9@linaro.org>
 <CAA8EJppCSnEg1GjX8CavxRPiiE19JwVAOTspjWJR-OzdQMcu+g@mail.gmail.com>
 <7ecf968b-45b2-c6b7-86a7-8d8caccf5002@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <7ecf968b-45b2-c6b7-86a7-8d8caccf5002@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FpwwqSAF9ChKQNg_KKIZS6HGqS4kVtvO
X-Proofpoint-ORIG-GUID: FpwwqSAF9ChKQNg_KKIZS6HGqS4kVtvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=781 clxscore=1011 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140188
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 1:11 PM, Krzysztof Kozlowski wrote:
> On 12/07/2023 16:35, Dmitry Baryshkov wrote:
>>>>> Rob asked you - "Is there more than 1 instance in a PMIC?" - and you did
>>>>> not answer positively, just mentioned something about drivers in
>>>>> downstream, which do not matter. So is the answer for that question:
>>>>> yes, you have two instances of the same PMIC differing by presence of
>>>>> PBS and other features"?
>>>>>
>>>> Sorry that was a misunderstanding on my part.
>>>> Yes, answer to Rob's question should have been "We have two instances of PMI632,
>>>> where one instance holds the pbs peripheral and the other holds the lpg
>>>> peripherals. The child node for pbs is needed so lpg client can access
>>>> the PMI632 regmap which contains the pbs peripheral."
>>>
>>> I guess I miss here something. What is "LPG client"? I don't understand
>>> why this LPG client needs existence of PBS node, to be able to get the
>>> regmap.
>>>
>>> PBS is a child of PMIC, so it can get regmap from the parent. What's
>>> more, which DT property passes the regmap from PMIC to LPG client?
>>
>> There are some PMICs which claim two SPMI SIDs. For such PMICs, each
>> SID is a separate device, so it is not directly possible to get the
>> regmap of the other SID.
> 
> OK, maybe after implementing all the review changes - including dropping
> that singleton pattern - this will be clearer. Please send new version
> and we will discuss it from there.
> 
Sure, will work on getting that new version sent but I did just have clarifying question.
When you say "dropping that singleton pattern" are you referring to dropping the 
PBS node?
Want to make sure we are all on the same page with what the next version will include :)

Thanks,
Anjelique
