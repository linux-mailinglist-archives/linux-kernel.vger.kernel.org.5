Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9078A50E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjH1E6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjH1E6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:58:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0798127;
        Sun, 27 Aug 2023 21:58:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S4eG2n009203;
        Mon, 28 Aug 2023 04:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nteOutDuYilmeryWePqbESc1chx6OQv9mLNHCnnxr/c=;
 b=KCmSqMkZKIStWkmZBzcHY8pBMbAcVQ+AIjlFLZWPZsIdB6YVuJZCdFBt3pkpVmQGsa61
 3ridLry0hUyANLgNWlpM8IKxbomay7PJTlgYbSyQdlA4ZhU1NAhQOAfC8u44bT72Hk25
 6Jbr/4SXWf07sGfkg5vDe+W93LA9LqTQ/SVuhzJ4hPgI4SCewoMnQur9+glPDozDN8hc
 h7bxeKw51LvHnjXOcSQoyFxILMHxELJEacntg7Q2jZKIR9FbgPTt+W8Ez5cCX0iy2zd1
 gcCS/u5+0g9nCmXw9na34wZdACYLuWvFEgOLS3S9YGKwxkK6PbMuIUYQ4EOHy31kUgew yA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq907jjjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 04:58:04 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S4w3g9027833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 04:58:03 GMT
Received: from [10.216.31.112] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 21:57:57 -0700
Message-ID: <5b722eb1-4515-4f21-805f-8823b9030132@quicinc.com>
Date:   Mon, 28 Aug 2023 10:27:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: crypto: qcom,prng: document that RNG
 on SM8450 is a TRNG
Content-Language: en-US
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
 <20230824-topic-sm8550-rng-v2-3-dfcafbb16a3e@linaro.org>
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20230824-topic-sm8550-rng-v2-3-dfcafbb16a3e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K2oBQPvHbstnnEIm8z0fbUKrKmxBDN5r
X-Proofpoint-ORIG-GUID: K2oBQPvHbstnnEIm8z0fbUKrKmxBDN5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_01,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=672 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/24/2023 5:03 PM, Neil Armstrong wrote:
> It has been reported at [1] the RNG HW on SM8450 is in fact a True Random
> Number Generator and no more Pseudo, document this by adding
> a new qcom,trng and the corresponding SoC specific sm8450 compatible.
> 
> [1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/
> 
> Suggested-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
