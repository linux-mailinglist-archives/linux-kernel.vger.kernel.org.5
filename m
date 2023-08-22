Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E17838CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjHVE1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 00:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHVE1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 00:27:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C21189;
        Mon, 21 Aug 2023 21:27:32 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M1tVfi021558;
        Tue, 22 Aug 2023 04:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QniPCjLtVSIkZtdAeBysdSVbGht8lRNNImNVXI04g+k=;
 b=HscGlS3HMzFbB21yhT/HjPziKGfnODraY1PaKY0YSXu+X/TCVo9xlOr4urEPXHUXg5xu
 fgJK3le6GaqGicYC66xqAYiVILVY2eknqJz61vTVKcZhhoqwavRnluOS+pAGzox2/jTs
 4JlHWthE46/NLZTkMKOsgLujIxIL/0I09Jg5iro0Lc5UXgSF2Ut08gQUIvzDbGvgKGNT
 yp18hKlX4t64yHGrYwQbZ/Iw09ldY/Hw1aVqatZ8Z/Vsq1GAfnUZ8N9nGImIyaGUhAqQ
 zaHOOXLoGpkleOnIvxzltydaGIBP1sgbNGa8i+BNXuKwceEYuI1HVDEXaXLXOdO3rGDN qQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm6uuhy3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 04:27:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M4RI9f032596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 04:27:18 GMT
Received: from [10.218.47.181] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 21:27:13 -0700
Message-ID: <d93902ee-c305-42cb-9d0d-1f0971ab3a70@quicinc.com>
Date:   Tue, 22 Aug 2023 09:57:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: crypto: qcom,prng: Add SM8450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
References: <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
 <20230818161720.3644424-1-quic_omprsing@quicinc.com>
 <2c208796-5ad6-c362-dabc-1228b978ca1d@linaro.org>
 <1cadb40e-b655-4b9b-9189-dfdb22a2c234@quicinc.com>
 <1f492c4e-2125-73eb-8523-389e24727516@linaro.org>
Content-Language: en-US
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <1f492c4e-2125-73eb-8523-389e24727516@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lv2vqt4tLV3CPMy9_UBfTlR6HBNb0ETT
X-Proofpoint-GUID: Lv2vqt4tLV3CPMy9_UBfTlR6HBNb0ETT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_02,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 11:37 AM, Krzysztof Kozlowski wrote:
> On 21/08/2023 02:52, Om Prakash Singh wrote:
>> I meant first one. using "qcom,rng-ee".
> 
> Then please provide some reasons.
> 
New IP block available on SM8450 and newer platform is true random 
number generator with it's entropy source. Also it is NIST SP800 90B 
compliant.
By introducing "qcom,rng-ee" I am also planning to add hwrng support in 
driver.

>>
>> I am looking for generic compatible string for all SoCs for which core
>> clock can be optional, same as we have "qcom,prng-ee".
> 
> There is a generic compatible already... but anyway, is the clock really
> optional? Or just configured by firmware?
>
Clock is configured using security firmware.

>>
>> If we are using SoC name in compatible string, for each SoC support we
>> need to update qcom,prng.yaml file.
> 
> So you were talking about second case from my email? Still not sure what
> you want to propose, but just in case - please always follow DT bindings
> guidelines:
> 
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> Best regards,
> Krzysztof
> 
