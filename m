Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63AA7D4E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJXLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjJXLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:07:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124210C9;
        Tue, 24 Oct 2023 04:07:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O9UPQH010513;
        Tue, 24 Oct 2023 11:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zw1Vl4UXWdOGwHXgSaTvEAFKvHGzn9SXnQ7rMcUBl7w=;
 b=Z1/oGFXxhYyrv742Ee5ei8TgC+T6gdX4vB5oSqKlHrF2nHO+VacMfAKYH6iGi+cPudoi
 zaUULUnmLIBAmscQGIMlTzDWVPd8KkMPr4ZTWj+JiV0UoLwdkvq7vwQyLIggM+xfkWk5
 fGlUyDjAy1RN417iQV00QWKLvUuhN+rbmxiMf0j9+XDU9hhlFcFVps2ppJAT9KwWzyhH
 Zxz8DtqwPtq07BwYmAseo7kCUYQb9wRy/W0Jh5cJNTCxSgXopWBqQ4LNAWOFntSL39Ll
 th7gsKFFww4fB1SKurod+/LO480xC0F8Jw8lplBp8mYrulP0gFHgRFmNGi7uBfjXKMKQ Jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxa0hp3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 11:07:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39OB7aTh014072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 11:07:36 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 04:07:31 -0700
Message-ID: <b8b6ea74-8e25-ecf4-1ab2-0d4ffca9e743@quicinc.com>
Date:   Tue, 24 Oct 2023 19:07:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/5] dt-bindings: sram: qcom,imem: document sm8250
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <quic_tingweiz@quicinc.com>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-3-git-send-email-quic_zhenhuah@quicinc.com>
 <169808266064.861239.7420927840211548252.robh@kernel.org>
Content-Language: en-US
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <169808266064.861239.7420927840211548252.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HUIbpJlwLIf7gHQHfPoFEOGN0AmccWs0
X-Proofpoint-ORIG-GUID: HUIbpJlwLIf7gHQHfPoFEOGN0AmccWs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_10,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=885 impostorscore=0 clxscore=1011
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240093
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/24 1:40, Rob Herring wrote:
> 
> On Mon, 23 Oct 2023 17:20:54 +0800, Zhenhua Huang wrote:
>> Add compatible for sm8250 IMEM.
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/sram/qcom,imem.yaml:56:1: [error] duplication of key "patternProperties" in mapping (key-duplicates)
> ./Documentation/devicetree/bindings/sram/qcom,imem.yaml:73:1: [error] duplication of key "patternProperties" in mapping (key-duplicates)
> ./Documentation/devicetree/bindings/sram/qcom,imem.yaml:120:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/sram/qcom,imem.yaml:120:1: found a tab character where an indentation space is expected
> ./Documentation/devicetree/bindings/sram/qcom,imem.yaml:120:1: found a tab character where an indentation space is expected
> 

Sorry for my carelessness... Will be more careful next time..

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1698052857-6918-3-git-send-email-quic_zhenhuah@quicinc.com
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
