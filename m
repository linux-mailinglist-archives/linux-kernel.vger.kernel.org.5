Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32887863F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjHWXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbjHWXcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:32:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498E9CED;
        Wed, 23 Aug 2023 16:32:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NNK2lR007641;
        Wed, 23 Aug 2023 23:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OJ5B+/q5lckh/d0On//S3WsqlQkp/wV2Y4VthieMN/Y=;
 b=WDP5QbGehw5qfGon3s+O3Zbo/S5E4qyrWDSbST7n1q3nvgl0gJuJ+UYiCJII4CdMjz/m
 /EEAkY1Aug/RxG3Zir9upsY/4ABY10mi+FgtqpdsIOyJMgScw0w4upHd6mdCBRAZq9Jw
 RN2fEVgTOLxc/cAlE21sp6xrHp0KOk9k+URLYZHFsG8ldApLYIS9MvqeUJg3Hhw0vKF5
 kBp0vjS2v86m7fopMmCGakAxC0MwxxSlCOTtJACibZwpnrmGKCT0SB+ryB2HMIex3rhZ
 OuXGVKEKqtvDy+75GaUgZvqH2yNYWZPSKBYMWn1ppJvwP4W+3amkhaqtrHdIYNUX9Aa/ 2g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snqg3gfn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 23:32:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NNWb6I000307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 23:32:37 GMT
Received: from [10.216.6.154] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 16:32:33 -0700
Message-ID: <d44be821-228b-4035-aa1e-c4f58db90422@quicinc.com>
Date:   Thu, 24 Aug 2023 05:02:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
To:     <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
 <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
 <8479869b-9984-41e3-9812-c7f5727cfd2c@linaro.org>
 <b73106c5-74e4-479d-8733-b99454768c15@quicinc.com>
 <26bae022-c114-4871-8715-73d7e8aeaa52@linaro.org>
 <f61ef601-1561-45d7-8f4a-947458472668@quicinc.com>
 <dd3d28f1-ff5e-49e6-a9f7-0ec9265017cc@linaro.org>
Content-Language: en-US
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <dd3d28f1-ff5e-49e6-a9f7-0ec9265017cc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lim0d8mpGYh8pssCt_Lur4LLQFQfWR4X
X-Proofpoint-GUID: Lim0d8mpGYh8pssCt_Lur4LLQFQfWR4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2023 1:25 PM, Neil Armstrong wrote:
> Hi,
> 
> On 23/08/2023 02:10, Om Prakash Singh wrote:
>>
>>
>> On 8/22/2023 9:34 PM, Konrad Dybcio wrote:
>>> On 22.08.2023 16:54, Om Prakash Singh wrote:
>>>> PRNG Block on most of newer target from Qualcomm have some 
>>>> configuration where clock is configured by security firmware.
>>>>
>>>> Adding separate compatible string for each platform is overhead.
>>>>
>>>> We need to introduce common compatible string that can be used for 
>>>> all platforms with same configuration.
>>>>
>>>> I would suggest to use "qcom,rng-ee" for newer platform, dropping 
>>>> "p" also signifies it is not a Pseudo Random Number Generator.
>>> Please reply inline and don't top-post.
>>>
>>>
>>> Is this what you're trying to say?
>>>
>>> 1. sort out the clock requirements for designs where Linux manages it
>>>     vs where the FW does so >
>>> 2. introduce a new compatible for SoCs implementing a TRNG
>>>
>>> 3. for SoCs in 2., register the TRNG as a hwrng device
>>
>> Yes to all
> 
> I can send a proposal, but that means writing a new driver for this 
> compatible in drivers/char/hw_random/ right ?

We can add hwrng support in same driver like 
drivers/crypto/hisilicon/trng/trng.c

As Krzysztof is suggesting we need to have platform specific compatible 
string, we can go with your change. for hwrng support I will send 
separate patches.

> 
> Neil
> 
>>
>>>
>>>
>>> ?
>>>
>>> Konrad
>>
>> Thanks,
>> Om
> 
