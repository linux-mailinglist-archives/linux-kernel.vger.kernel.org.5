Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08879B4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350758AbjIKVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbjIKKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:16:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E086E69;
        Mon, 11 Sep 2023 03:16:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BAFa4h027624;
        Mon, 11 Sep 2023 10:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LdFrAlvzPKBbLcF+PjGVstvmsDqiyhErhlETAHTBnvM=;
 b=Sy2Ilr63oalu31epkcKToiBe8kahqsOOw8WEmQ5aQIL1hn2c4lhfOIDQUfGLvRiBW5YG
 MptiKIZg9rGo3tQskTynrv4tFJ6x0X8cYAltm7Sm1CwNEP0oMZCK8Seczz6a7EWEvRxE
 hrDC4n2XS7Q9vOF/U092hPnOC89ft5RFI82J5QwI0gK6/LA8N76pr2D/wP+FnXOVrhkG
 h6tKzi11rwF3w/N5BPSsBD3t50V9seSWJ5QFaScrULQzhvmCucVpHltaMDs8GhCyODjR
 9DcxtczrVobnnweyNQt0niaZsE7DIOG4ON6JlfbMlEMPg7u5BtSzi2/qap8hPn7vy2g5 Wg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t20yy0012-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:16:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BAGAWL007457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:16:10 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 03:16:01 -0700
Message-ID: <5f172a8f-ecd7-44b0-9b02-48eb13d40497@quicinc.com>
Date:   Mon, 11 Sep 2023 18:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
From:   Tengfei Fan <quic_tengfan@quicinc.com>
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
 <375df554-e661-42ad-8a6f-f862aa05b654@quicinc.com>
In-Reply-To: <375df554-e661-42ad-8a6f-f862aa05b654@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qxoaG2xWMLC40vtljendagrAt4UdPG-R
X-Proofpoint-GUID: qxoaG2xWMLC40vtljendagrAt4UdPG-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=862 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 4:25 PM, Tengfei Fan 写道:
> 
> 
> 在 9/8/2023 3:42 PM, Rob Herring 写道:
>>
>> On Fri, 08 Sep 2023 14:44:25 +0800, Tengfei Fan wrote:
>>> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
>>> and tuned dynamically according to the bandwidth demand.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   .../interconnect/qcom,sm4450-rpmh.yaml        | 133 ++++++++++++++
>>>   .../dt-bindings/interconnect/qcom,sm4450.h    | 163 ++++++++++++++++++
>>>   2 files changed, 296 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.yaml
>>>   create mode 100644 include/dt-bindings/interconnect/qcom,sm4450.h
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sm4450.h: No such file or directory
>>     18 |         #include <dt-bindings/clock/qcom,gcc-sm4450.h>
>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[2]: *** [scripts/Makefile.lib:419: 
>> Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dtb] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: 
>> dt_binding_check] Error 2
>> make: *** [Makefile:234: __sub-make] Error 2
>>
>> doc reference errors (make refcheckdocs):
>>
>> See 
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230908064427.26999-2-quic_tengfan@quicinc.com
>>
>> The base for the series is generally the latest rc1. A different 
>> dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your 
>> schema.
>>
> Thanks review this patch, will setup new env for verify again.
> 
this error is due to have dependence with: 
https://lore.kernel.org/linux-arm-msm/20230824173410.550126-1-quic_ajipan@quicinc.com/, 
will add this link to coverletter.

-- 
Thx and BRs,
Tengfei Fan
