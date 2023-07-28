Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312B766387
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjG1FJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG1FJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:09:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FA22D67;
        Thu, 27 Jul 2023 22:08:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S4F6Nq030590;
        Fri, 28 Jul 2023 05:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iScrItQIzPsIt3AApI8NNBT+ho/72fIhG7KNr+pP66U=;
 b=S1qIaH+DofRLPMwv2eE5rgkh6bXaECZLvzKp9aAQKT3OH460k43aGSHFCpkIah/AuC/U
 PfTF5GYTHCEZdN1qKtpIdTynzhzv/pedYKyLLvEwKqjPWo5SxhGeKVSXt2mxPzcTD1OT
 ayo0FAZGGZOqDP0wc/LlZEVg9+lTZSykgUiuMCbXo38HI5Z60hYDdNrXFMjFXCW3AipL
 UwEO8od7FSsiY7wbMGEjnvIUPP/pkuTBIShstasUaV8fN8zBnuPNW7rDO8NI5zOkNTQe
 o8qU0IQMOBka9prdGxy3/1XbWYyXlR5/9IPFiyZz/tmw3Hu51aGSB5gpMPrKJWW/yQay XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3n2kaesm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 05:08:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S58iG2012467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 05:08:44 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 22:08:35 -0700
Message-ID: <98ef61af-8b90-cf9b-2c54-935156c39785@quicinc.com>
Date:   Fri, 28 Jul 2023 10:38:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <andersson@kernel.org>,
        <quic_abhinavk@quicinc.com>, <mathieu.poirier@linaro.org>,
        <quic_tdas@quicinc.com>, <mchehab@kernel.org>, <agross@kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <daniel@ffwll.ch>,
        <linux-media@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <vladimir.zapolskiy@linaro.org>, <neil.armstrong@linaro.org>,
        <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <jonathan@marek.ca>, <devicetree@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <airlied@gmail.com>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <rfoss@kernel.org>, <mani@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <bhupesh.sharma@linaro.org>,
        <linux-clk@vger.kernel.org>, <sean@poorly.run>,
        <ulf.hansson@linaro.org>, <robdclark@gmail.com>,
        <sboyd@kernel.org>, <quic_vgarodia@quicinc.com>
References: <1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com>
 <169046381501.1270011.10571652656239031435.robh@kernel.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <169046381501.1270011.10571652656239031435.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UJBo0UO0ZrykV2Zf3ieuP02yT_uehX8T
X-Proofpoint-ORIG-GUID: UJBo0UO0ZrykV2Zf3ieuP02yT_uehX8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=996 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280046
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2023 6:46 PM, Rob Herring wrote:
> On Thu, 27 Jul 2023 18:13:33 +0530, Rohit Agarwal wrote:
>> Update the RPMHPD references with new bindings defined in rpmhpd.h
>> for Qualcomm SoCs SM8[2345]50.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>
>> Changes in v2:
>>   - Removed the unnecessary inclusion of header rpmpd.h.
>>
>> This patch is dependent on the series that includes the new rpmhpd.h header
>> https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
>>
>>   Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml   | 4 ++--
>>   Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml  | 4 ++--
>>   Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml    | 4 ++--
>>   Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml   | 4 ++--
>>   Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml  | 4 ++--
>>   Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml   | 4 ++--
>>   Documentation/devicetree/bindings/clock/qcom,videocc.yaml         | 4 ++--
>>   .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml          | 4 ++--
>>   .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 8 ++++----
>>   .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml          | 4 ++--
>>   .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 6 +++---
>>   .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml          | 4 ++--
>>   .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++----
>>   .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml          | 4 ++--
>>   .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++----
>>   Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml    | 4 ++--
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.yaml              | 4 ++--
>>   Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 6 +++---
>>   18 files changed, 44 insertions(+), 44 deletions(-)
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dts:21:18: fatal error: dt-bindings/power/qcom,rpmhpd.h: No such file or directory
>     21 |         #include <dt-bindings/power/qcom,rpmhpd.h>
>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com
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
We can ignore this error as the dependency is mentioned in the changelog 
that adds
this new header. Also have tested locally with these dependencies in place.

Thanks,
Rohit.
