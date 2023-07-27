Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA0764F77
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjG0JVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjG0JVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:21:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C461AB;
        Thu, 27 Jul 2023 02:11:33 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R5YK05009590;
        Thu, 27 Jul 2023 07:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eseq8ZzD3Dvq62NkFGvHlXs3ONEHLuPN1Y5ZVBwSuQQ=;
 b=Wvo45ocoV43Pr2UY1aCtcxLJBdUnVM4mkgjEE8RF72+WAM+F/4S7aVFixrLrXByrokpN
 XAJSPcHK0MsVODiBfP9UFEVpU8v17S+cdhlo/Gpbgnxm8LjiSvL2bDunOZ1ANI/QUxpe
 HCSCOaw91re24hGhR3gHLoGD+I+YJ+V8usjWKvoJZyye5I/ireCNWAX2bj+B6IFTnhSV
 MGta5EXxS62LWhGg6xn8US9NcfWXgkoDyMMhIBxq6J+unV0/sIX2nKb8vErpm/HNn0h+
 vTONoud2nCuPCWpXge2YdOdmDeliRJ0hleUF44RJuDHEUro+CKQLrHZ8xjuqfevzG09C 1A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s336t1ymm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:09:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R79WMY011314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:09:32 GMT
Received: from [10.216.40.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 00:09:20 -0700
Message-ID: <4dce1330-55eb-bbee-8374-987533b6a877@quicinc.com>
Date:   Thu, 27 Jul 2023 12:39:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <conor+dt@kernel.org>, <robdclark@gmail.com>,
        <quic_abhinavk@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <sean@poorly.run>, <marijn.suijten@somainline.org>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <mchehab@kernel.org>, <ulf.hansson@linaro.org>,
        <mathieu.poirier@linaro.org>, <jonathan@marek.ca>,
        <vladimir.zapolskiy@linaro.org>, <quic_tdas@quicinc.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <bhupesh.sharma@linaro.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <1690433470-24102-1-git-send-email-quic_rohiagar@quicinc.com>
 <edac596d-2b3d-4632-9468-4af863aff6f4@quicinc.com>
 <86c6e8b1-d286-6858-5de6-b8faf6557fe4@quicinc.com>
 <3da310cc-b866-4829-8411-befaa719f10d@quicinc.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <3da310cc-b866-4829-8411-befaa719f10d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g-uXOygpocTyBnxtmMGatXEAqimXMHdy
X-Proofpoint-GUID: g-uXOygpocTyBnxtmMGatXEAqimXMHdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxlogscore=657 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270063
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2023 12:38 PM, Pavan Kondeti wrote:
> On Thu, Jul 27, 2023 at 12:24:10PM +0530, Rohit Agarwal wrote:
>> On 7/27/2023 11:06 AM, Pavan Kondeti wrote:
>>> On Thu, Jul 27, 2023 at 10:21:10AM +0530, Rohit Agarwal wrote:
>>>> Update the RPMHPD references with new bindings defined in rpmhpd.h
>>>> for Qualcomm SoCs SM8[2345]50.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml    | 3 ++-
>>>>    Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml   | 3 ++-
>>>>    Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml     | 3 ++-
>>>>    Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml    | 3 ++-
>>>>    Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml   | 3 ++-
>>>>    Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml    | 3 ++-
>>>>    Documentation/devicetree/bindings/clock/qcom,videocc.yaml          | 3 ++-
>>>>    Documentation/devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml | 3 ++-
>>>>    .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml          | 7 ++++---
>>>>    Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml | 3 ++-
>>>>    .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml          | 5 +++--
>>>>    Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml | 3 ++-
>>>>    .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml          | 7 ++++---
>>>>    Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml | 3 ++-
>>>>    .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml          | 7 ++++---
>>>>    Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml     | 3 ++-
>>>>    Documentation/devicetree/bindings/mmc/sdhci-msm.yaml               | 3 ++-
>>>>    Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml  | 5 +++--
>>>>    18 files changed, 44 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
>>>> index d6774db..d6b81c0 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
>>>> @@ -83,6 +83,7 @@ examples:
>>>>      - |
>>>>        #include <dt-bindings/clock/qcom,rpmh.h>
>>>>        #include <dt-bindings/power/qcom-rpmpd.h>
>>>> +    #include <dt-bindings/power/qcom,rpmhpd.h>
>>>>        clock-controller@af00000 {
>>>>          compatible = "qcom,sm8250-dispcc";
>>>>          reg = <0x0af00000 0x10000>;
>>>> @@ -103,7 +104,7 @@ examples:
>>>>          #clock-cells = <1>;
>>>>          #reset-cells = <1>;
>>>>          #power-domain-cells = <1>;
>>>> -      power-domains = <&rpmhpd SM8250_MMCX>;
>>>> +      power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>>          required-opps = <&rpmhpd_opp_low_svs>;
>>>>        };
>>>>    ...
>>> Does this file still need to include old header? The same is applicable
>>> to some of the other files in the patch also.
>>>
>>> We also discussed on the other thread [1] to move the regulator level
>>> definitions to new header. should this change be done after that, so that
>>> we don't end up touching the very same files again?
>>>
>>> [1]
>>> https://lore.kernel.org/all/a4zztrn6jhblozdswba7psqtvjt5l765mfr3yl4llsm5gsyqef@7x6q7yabydvm/
>> Removing this header directly would also be fine as we are not using any
>> macro defined directly in these
>> bindings.
>> I already checked with dt_binding_check by removing this header.
>>
> Thanks for checking, then we should remove the old header in this patch
> it self, right?
Yes

Thanks,
Rohit.
>
> Thanks,
> Pavan
