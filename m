Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB507A739F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjITHEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjITHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:04:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE4E90;
        Wed, 20 Sep 2023 00:04:26 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K5J11D014364;
        Wed, 20 Sep 2023 07:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sirRTSMtALGb40cFMEEIy3VWwp5E5wl1OmAjQoPdOKU=;
 b=Ujy2+bvZro+UN5VKEriI7WKasObZZe0boUUYk3Y14fDOWtf5/71GCjU02BK7gu/dvoSb
 M5e2CiD7mJu17DahaBA/sTvXTf7jDk5ZamWhveuhgaZHR6c506IBkdeczXzfOOAfO0rC
 U8972mMih38JPCUNzolfDlGngI9jrmKf5fNJeBNLSSISnVL+XRZ2q2CESEeQ8zvn4WO8
 e5pHcZKjK3QoMrUd7QlBpz/3FgzgDHji2D2rveKojsc1X4J2Ft2KAsiQqvdpd0ibf+Du
 Zn4oGDCxn2Q35GiFvVoIVQAQ0cZGKmKS6sTicA/sMgp8NRHCF654PwId6rrIzBe/aX9p bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6v2dkkhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 07:04:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K74Ljd009072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 07:04:21 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 00:04:14 -0700
Message-ID: <dbf09ddd-910b-4c1f-8dbe-8d1bcb7183d0@quicinc.com>
Date:   Wed, 20 Sep 2023 15:04:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <quic_ajipan@quicinc.com>, <kernel@quicinc.com>
References: <20230920064739.12562-1-quic_tengfan@quicinc.com>
 <20230920064739.12562-2-quic_tengfan@quicinc.com>
 <d2f6bfbb-fd08-a551-51d3-f81d9237e060@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <d2f6bfbb-fd08-a551-51d3-f81d9237e060@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6pu_d-fLPeyPjqGHJlwS0likcd-WIFlJ
X-Proofpoint-GUID: 6pu_d-fLPeyPjqGHJlwS0likcd-WIFlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=774 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 2:58 PM, Krzysztof Kozlowski 写道:
> On 20/09/2023 08:47, Tengfei Fan wrote:
>> Add device tree binding Documentation details for Qualcomm SM4450
>> TLMM device.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> 
> 
> 
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in this
>> +          subnode.
>> +        items:
>> +          oneOf:
>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-5])$"
> 
> Your driver and gpio-ranges in example tell you have 136 GPIOs, not 126.
> It's v3 but still counting GPIOs is incorrect :/
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,
my fault, misunderstand to other platform's setting when reference, will 
update.

-- 
Thx and BRs,
Tengfei Fan
