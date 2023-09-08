Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED677983FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbjIHI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjIHI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:26:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B2173B;
        Fri,  8 Sep 2023 01:26:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3888O0mI012802;
        Fri, 8 Sep 2023 08:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Qvpv+YSxTwMVDczhu49b8KBaEyDvXaLOmT+Pd/+SCZ8=;
 b=kFW6om3Rmh0hHhsCCz5CSn9GTGGvkXxL+stI7OYGbcr/Sf6ZftamwRB0OeTKcjBC3Eba
 dTj389GnXdQwR09Ts3sDqBqBrE7pw5tEl+fJ5tmyBTXdwl/2g2+flyHXV2Mwu3HzTQHh
 k+SfIsFlAlCx3K67+a2s9cpa1QfrxDFQPgdYK3j1varu3g3wCjd9R9qs+OLf1PHHP1eE
 bRcLuP/lNKH5FxkjcH6jYuhzqwi1BF8JNgMuLZD1N1vYwDJ+VZTfAjgTFN6WCWc1V/8R
 EYkQ775u2aIMVLe3QtoN9E148ks5s2xAaer9/eUKksXuITU8s0SagulHGcQlLcZxniYl KA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syfj2j40f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:25:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3888PuuP031839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 08:25:56 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 01:25:48 -0700
Message-ID: <375df554-e661-42ad-8a6f-f862aa05b654@quicinc.com>
Date:   Fri, 8 Sep 2023 16:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
To:     Rob Herring <robh@kernel.org>
CC:     <will@kernel.org>, <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_kaushalk@quicinc.com>,
        <peng.fan@nxp.com>, <kernel@quicinc.com>,
        <catalin.marinas@arm.com>, <rafal@milecki.pl>,
        <krzysztof.kozlowski+dt@linaro.org>, <nfraprado@collabora.com>,
        <quic_shashim@quicinc.com>, <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <geert+renesas@glider.be>,
        <andersson@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <agross@kernel.org>,
        <quic_tdas@quicinc.com>, <djakov@kernel.org>,
        <konrad.dybcio@linaro.org>
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
 <20230908064427.26999-2-quic_tengfan@quicinc.com>
 <169415894359.3239551.14338430937225080028.robh@kernel.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <169415894359.3239551.14338430937225080028.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uts8CPmZviThs9wdkuVaaJe0R2MEyUIO
X-Proofpoint-GUID: Uts8CPmZviThs9wdkuVaaJe0R2MEyUIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=882
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 3:42 PM, Rob Herring 写道:
> 
> On Fri, 08 Sep 2023 14:44:25 +0800, Tengfei Fan wrote:
>> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
>> and tuned dynamically according to the bandwidth demand.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   .../interconnect/qcom,sm4450-rpmh.yaml        | 133 ++++++++++++++
>>   .../dt-bindings/interconnect/qcom,sm4450.h    | 163 ++++++++++++++++++
>>   2 files changed, 296 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
>>   create mode 100644 include/dt-bindings/interconnect/qcom,sm4450.h
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sm4450.h: No such file or directory
>     18 |         #include <dt-bindings/clock/qcom,gcc-sm4450.h>
>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230908064427.26999-2-quic_tengfan@quicinc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
Thanks review this patch, will setup new env for verify again.

-- 
Thx and BRs,
Tengfei Fan
