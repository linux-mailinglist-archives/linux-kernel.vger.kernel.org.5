Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD717D89F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjJZVBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:01:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0FB1A6;
        Thu, 26 Oct 2023 14:01:13 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QKvtk6027731;
        Thu, 26 Oct 2023 21:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sEvMtIr7neQtXxPbZtaebPWIEdYxlif33988BkAWMXw=;
 b=f+UCuqzCw8PcKy2DDGI/YGKA3ungpyK1YGaG5asXhbE9Th7E8GQMmCqieeWaO5S6kAg1
 ratrfPe0B10lTuWqXW3NTvujc4unb5glST2Rj/X+7KpEW3NptS0z730c9jiBdj82iGU9
 gXFX9PCmECxG1zEPufv3aIr2fj9z+SYsgGRww3Scd6mBvZ+IbU7xxp2omodSfoKqU/tI
 slBC6aP18p0buqSaVA3c1enopql5aoXR67ETgGde/nD9U6ai9TinS//MHwi8gvvrtx1H
 rvWyF83uRct5XZSyZf4JO2RcsFt5zLrxIIKxCOHxY/lB2tR9bOMxyCq/owHWzMMDmM2M /A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxbv8516-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 21:01:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39QL178w028652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 21:01:07 GMT
Received: from [10.110.87.103] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 14:01:04 -0700
Message-ID: <dc248635-4aa0-40b9-8837-3145027b0ac9@quicinc.com>
Date:   Thu, 26 Oct 2023 14:01:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dt-bindings: soc: qcom: Add memory_dump driver
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-2-git-send-email-quic_zhenhuah@quicinc.com>
 <27fcdcc1-b29b-43b2-8b1a-c648dd9e696c@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <27fcdcc1-b29b-43b2-8b1a-c648dd9e696c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FYMb0UM2Q5bUob_F1AO2QArFhe9g1kgc
X-Proofpoint-GUID: FYMb0UM2Q5bUob_F1AO2QArFhe9g1kgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=878
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310260181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenhua,

On 10/23/2023 2:27 AM, Krzysztof Kozlowski wrote:
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
> 
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>  .../bindings/soc/qcom/qcom,mem-dump.yaml           | 42 +++++++++++++++++++++
>>  .../devicetree/bindings/sram/qcom,imem.yaml        | 44 ++++++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
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

Could you create platform driver which binds directly to the

compatible = "qcom,qcom-imem-mem-dump-table"

You can look up the size from the dump table driver or have 2 reg properties 
in the -table node itself (so no need for the table-size node either).
