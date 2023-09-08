Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F53579833F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbjIHHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIHHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:30:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119E1BC8;
        Fri,  8 Sep 2023 00:30:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3887BkCg002871;
        Fri, 8 Sep 2023 07:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tjETNQR7Qbjn8moY75mNH7bm6GbWzUOROl2QSxDzkM8=;
 b=FlXK3zMAFWE3UBbqZG2G/8XA1MqkVsBl/i+kUsQtrFpx1R1r53PahOUtq9jMa/MhHWeP
 4OAzQyWk57JptAkAKJ7FbP4HjoqKu9VHztmOZmZv1dtCoAb81Xil21yyAajsBLROr631
 DV02gJiztYRuESmW64UoxrsK0MRhxDdk0YTR+iii2oFZNwcZD/60AWxnrz84cJBwtx2q
 B+PoA6Uc23ZtmOqpBRiSpQ+aW+iPozTk15kRf1ZvpZno5TYyk8ZDU5sJqNnAkz6/NHpV
 OYa+B8blXkGojQoXN53l1WOGvlJPyVinx+Po0zrjqslAuOJXlI/sFaIfZj1B0LkGnnCM 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy7m0k20s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 07:29:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3887T7tt006191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 07:29:07 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 00:28:58 -0700
Message-ID: <1407c2f0-3abf-4cb0-93c0-e19f821ff2fb@quicinc.com>
Date:   Fri, 8 Sep 2023 15:28:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
To:     Rob Herring <robh@kernel.org>
CC:     <quic_tingweiz@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <rafal@milecki.pl>,
        <conor+dt@kernel.org>, <nfraprado@collabora.com>,
        <devicetree@vger.kernel.org>, <catalin.marinas@arm.com>,
        <quic_kaushalk@quicinc.com>, <andersson@kernel.org>,
        <quic_shashim@quicinc.com>, <linus.walleij@linaro.org>,
        <quic_tsoni@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>,
        <peng.fan@nxp.com>, <quic_tdas@quicinc.com>,
        <konrad.dybcio@linaro.org>, <arnd@arndb.de>, <will@kernel.org>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230908063843.26835-1-quic_tengfan@quicinc.com>
 <20230908063843.26835-2-quic_tengfan@quicinc.com>
 <169415774033.3172287.2910545525997528344.robh@kernel.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <169415774033.3172287.2910545525997528344.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G0yg3CgXkxq4nOWlY_DqugIkk635XNFq
X-Proofpoint-ORIG-GUID: G0yg3CgXkxq4nOWlY_DqugIkk635XNFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=875 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 3:22 PM, Rob Herring 写道:
> 
> On Fri, 08 Sep 2023 14:38:41 +0800, Tengfei Fan wrote:
>> Add device tree binding Documentation details for Qualcomm SM4450
>> TLMM device.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 129 ++++++++++++++++++
>>   1 file changed, 129 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/pinctrl/qcom,tlmm-common.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230908063843.26835-2-quic_tengfan@quicinc.com
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
> your schema. However, it must be unset to test all examples with your schema
> 
Thanks review this change detailly, do update env and do verify again.

-- 
Thx and BRs,
Tengfei Fan
