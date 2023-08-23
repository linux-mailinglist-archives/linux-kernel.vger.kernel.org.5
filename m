Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9578640C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbjHWXoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjHWXn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:43:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CDB10CA;
        Wed, 23 Aug 2023 16:43:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NN4nwW007908;
        Wed, 23 Aug 2023 23:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DxGrKd/dqdkJDyi8ZiBGDXWYIDhPCimBvDZfM4qyYjM=;
 b=MXFcPO+v7IGhxqf/8h85i5PWOyStzoiBIHdWzjfmRPRwS5Tecx7Aprqsa9n6AJnfU7JO
 EA/PORiM3fucu49dHw3ULKLOAQekbX1RydI6WnHwl7cTCQAMThmdYySnXD+19RqpcsZ4
 Yyr1P3yQHpQgcAYvs9cBdB4UxHFrn/BE6cZA8MQJyHgP6IxyQCqIQxaFvDZxvyKD4jAs
 /sKtVDWjTPnLuFShZFydffKj8svOf3OEK2MwBp9UZEmh6IS4Wn7xdfaJnlMuUj0fZbLG
 Xnz8nwTSaMfXrSqPGdJhLczrVDXnk4HGFzJ6mWihQjVEyoZMMHaTvCSvhAHgN5BpW24K tQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkums389-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 23:43:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NNhjTA025073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 23:43:45 GMT
Received: from [10.216.6.154] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 16:43:40 -0700
Message-ID: <eaf16efa-9185-4570-b275-1b0158e6b715@quicinc.com>
Date:   Thu, 24 Aug 2023 05:13:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom,prng: document SM8550
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
References: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
 <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20230822-topic-sm8550-rng-v1-1-8e10055165d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4UhBzfxYtN2rpufdXQgg4r_zvhpn8Tg0
X-Proofpoint-ORIG-GUID: 4UhBzfxYtN2rpufdXQgg4r_zvhpn8Tg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 7:41 PM, Neil Armstrong wrote:
> Document SM8550 compatible for Pseudo Random Generator,
> like SM8450 doesn't require clocks setup done by the secure
> firmware.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Acked-by: Om Prakash Singh <quic_omprsing@quicinc.com>
>   Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> index 36b0ebd9a44b..60fc9f261b83 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -16,7 +16,9 @@ properties:
>             - qcom,prng  # 8916 etc.
>             - qcom,prng-ee  # 8996 and later using EE
>         - items:
> -          - const: qcom,sm8450-prng-ee
> +          - enum:
> +              - qcom,sm8450-prng-ee
> +              - qcom,sm8550-prng-ee
>             - const: qcom,prng-ee
>   
>     reg:
> @@ -39,7 +41,9 @@ allOf:
>           properties:
>             compatible:
>               contains:
> -              const: qcom,sm8450-prng-ee
> +              enum:
> +                - qcom,sm8450-prng-ee
> +                - qcom,sm8550-prng-ee
>       then:
>         required:
>           - clocks
> 
