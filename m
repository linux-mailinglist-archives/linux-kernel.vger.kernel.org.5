Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A37D35DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjJWLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjJWLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:55:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC6AF;
        Mon, 23 Oct 2023 04:55:04 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NBsPc9031622;
        Mon, 23 Oct 2023 11:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GdM270Ymk4GmaoE8s1C0BZCXZ4sHC1MXNy0TNyH38c4=;
 b=HmZlQbwHKZ3saMsMm13Mh1hc9Z1qVfTwDCuQy4k8GJXlwrAR57KxcZw5PXsCmNdeAzR7
 bXL0eqH7MsAzshtO0JtU61UmIUBPCYsHA2xv7NL203UNEQyj5kIYuLSlf0obmXjimsiq
 pbhAhj+By6IF6umBZXHFk3hn0a/FknsoOgSQ2CFvIPTD/lPRLJ8aVPCv3SfThNtGSzSh
 m3nwyX5qBsOvbCGrdYPpUGC80lbh1talrGlZR4qyOPuCR99yW0ppEcrgQBwG8bUlpWHQ
 ww7p2ezuw5IspjSPMRAcwnxyJYTFpd6AWAGGbnJfOTqRJPfdhfKHmgp7zPn4iZK1KERT pQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7u3v8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 11:55:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NBt0GU025086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 11:55:00 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 04:54:55 -0700
Message-ID: <d3b62002-c29c-a45e-279f-7d07c697aa77@quicinc.com>
Date:   Mon, 23 Oct 2023 19:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/5] dt-bindings: soc: qcom: Add memory_dump driver
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-2-git-send-email-quic_zhenhuah@quicinc.com>
 <27fcdcc1-b29b-43b2-8b1a-c648dd9e696c@linaro.org>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <27fcdcc1-b29b-43b2-8b1a-c648dd9e696c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PmZJVdcFGMnJ25jI4nqqVqd7lWtZ3dWf
X-Proofpoint-ORIG-GUID: PmZJVdcFGMnJ25jI4nqqVqd7lWtZ3dWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=934
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230104
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/23 17:27, Krzysztof Kozlowski wrote:
> On 23/10/2023 11:20, Zhenhua Huang wrote:
>> Add bindings for the QCOM Memory Dump driver providing debug
> 
> Bindings are for hardware, not driver. This suggests it is not suitable
> for bindings at all.
> 
>> facilities. Firmware dumps system cache, internal memory,
>> peripheral registers to reserved DDR as per the table which
>> populated by the driver, after crash and warm reset.
> 
> Again driver :/

Thanks for pointing out. Qualcomm memory dump device is a reserved 
memory region which is used to communicate with firmware. I will update 
description in next version.

Thanks,
Zhenhua

> 
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>   .../bindings/soc/qcom/qcom,mem-dump.yaml           | 42 +++++++++++++++++++++
>>   .../devicetree/bindings/sram/qcom,imem.yaml        | 44 ++++++++++++++++++++++
>>   2 files changed, 86 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
>> new file mode 100644
>> index 0000000..87f8f51
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,mem-dump.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop quotes.
> 
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
> 
>> +
>> +title: Qualcomm memory dump
> 
> Describe hardware, not driver.
> 
>> +
>> +description: |
>> +  Qualcomm memory dump driver dynamically reserves memory and provides hints(id and size)
> 
> Again, driver, so not suitable for DTS and bindings.
> 
> Best regards,
> Krzysztof
> 
