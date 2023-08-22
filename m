Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA887844C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjHVOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjHVOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:55:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F2126;
        Tue, 22 Aug 2023 07:55:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MAttru009628;
        Tue, 22 Aug 2023 14:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6eMQNrgqHLU00wjLkJ1Kb7ZQimnUmm3q3EnMMewUbqE=;
 b=Q2tTnXajY14lxamm5/0NcWa5C0iGBhyU/5H144PbQkfh68qmse/0C3W0Vh8rnWMQ+nkS
 f5yUMqmlUkhhOMmqFWRM19G/7CII88OPQEWznTQvZR1PQhNwM6jCbvugDbMZwP+rY305
 o2BMBVyGI1BjfgESxlokoigVgT+o/q6AfCSmajU5VnBFSsZjfgJfICC5FXAYG4w0Omsf
 5Ptz87fGbGlc5MWgpnzquuvTdYxejAQD/qXd5O8DIdXN5//ch5S5TsJREnqs7g0T/AoI
 QjsVFEDaI/nUvXDUTc7UO+UONohPmYxud4tMQ7CYY1OACno8eKXQm8MuEqO2EUVZ4fom Zg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smreu0ycr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:54:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MEsqqw004750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 14:54:52 GMT
Received: from [10.216.6.154] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 07:54:47 -0700
Message-ID: <b73106c5-74e4-479d-8733-b99454768c15@quicinc.com>
Date:   Tue, 22 Aug 2023 20:24:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <8479869b-9984-41e3-9812-c7f5727cfd2c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5hcqZvyc_Ev1y0_cCYlRb8yVHZ5-cDUg
X-Proofpoint-ORIG-GUID: 5hcqZvyc_Ev1y0_cCYlRb8yVHZ5-cDUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=972
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRNG Block on most of newer target from Qualcomm have some configuration 
where clock is configured by security firmware.

Adding separate compatible string for each platform is overhead.

We need to introduce common compatible string that can be used for all 
platforms with same configuration.

I would suggest to use "qcom,rng-ee" for newer platform, dropping "p" 
also signifies it is not a Pseudo Random Number Generator.

On 8/22/2023 7:58 PM, Konrad Dybcio wrote:
> On 22.08.2023 16:11, Neil Armstrong wrote:
>> Document SM8550 compatible for Pseudo Random Generator,
>> like SM8450 doesn't require clocks setup done by the secure
>> firmware.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> + CC Om
> 
> As mentioned in [1], perhaps we should rethink the compatible as
> it may be a TRNG and not a PRNG?
> 
> Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/d93902ee-c305-42cb-9d0d-1f0971ab3a70@quicinc.com/
