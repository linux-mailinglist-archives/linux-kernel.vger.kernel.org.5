Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634567B6B18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbjJCOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjJCOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:10:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832E95;
        Tue,  3 Oct 2023 07:10:01 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DgtWm009413;
        Tue, 3 Oct 2023 14:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=87QjkhkNe0UCFi80m17pbbshMliLOnzAKZdrUYxm7vY=;
 b=PF0aBGv3cSiqRIe5fU6FaiB6HtgQWCluflt1YVb4Xq1oKQQlQTZfIbxq6+K3i9Xu72wy
 BdqN01ESssu65zsSlGlL2txF7VAhRhmYqYjfAWe8znSrsl6jdBD6gF1FmCk3HzNxg2DV
 NTy/0mTt/4Oj8ztpIHq42U1aThV7mzdxM72pMmVWeJRVhEGefPtTDw0hHd85a33TwMi1
 o6Aos9XlHP1sgoGLJp4SrbQbLtUhc6NvsuKTIUhkqQnbUBAYXllLbA2ZOAlFdN6/USMe
 +CcYGd+9SGLaGONOSWFoqCibGUhYD81Fl0m/1zQ3UfNCpxiWrxe6VMmyqKNbaZFapGL2 Fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg1v3adce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 14:09:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393E9R1r006838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 14:09:27 GMT
Received: from [10.216.32.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 07:09:17 -0700
Message-ID: <0bad6499-becb-43ea-a066-1c626f11d754@quicinc.com>
Date:   Tue, 3 Oct 2023 19:39:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: phy: qcom,uniphy-usb: Document
 qcom,uniphy-usb phy
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-2-quic_ipkumar@quicinc.com>
 <d1536449-d80b-4ee7-a3d8-ab68a67be986@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <d1536449-d80b-4ee7-a3d8-ab68a67be986@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8jHrdKGK9zfIX3mee58pg3qR2yKhihH
X-Proofpoint-ORIG-GUID: f8jHrdKGK9zfIX3mee58pg3qR2yKhihH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=960 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2023 8:26 PM, Krzysztof Kozlowski wrote:
> On 29/09/2023 10:42, Praveenkumar I wrote:
>> Document the Qualcomm USB3 22ull UNIPHY present in IPQ5332.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   .../bindings/phy/qcom,ipq5332-usb-uniphy.yaml | 83 +++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-uniphy.yaml
> Filename should match compatible.
Will address it.
>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-uniphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-uniphy.yaml
>> new file mode 100644
>> index 000000000000..90434cee9cdd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-uniphy.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-uniphy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm USB Super-Speed UNIPHY
>> +
>> +maintainers:
>> +  - Praveenkumar I <quic_ipkumar@quicinc.com>
>> +  - Varadarajan Narayanan <quic_varada@quicinc.com>
>> +
>> +description:
>> +  USB Super-Speed UNIPHY found in Qualcomm IPQ5332, IPQ5018 SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    items:
> Drop items, not needed.
Sure, will drop.
>
>> +      - const: qcom,ipq5332-usb-ssphy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ahb
>> +      - const: cfg_ahb
>> +      - const: pipe
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description:
>> +      Phandle to 5V regulator supply to PHY digital circuit.
>> +
>> +  qcom,phy-usb-mux-sel:
>> +    description: PHY Mux Selection for USB
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle of TCSR syscon
>> +          - description: offset of PHY Mux selection register
>> +
>> +  "#clock-cells":
>> +    const: 0
>> +
>> +  clock-output-names:
>> +    maxItems: 1
>> +
>> +  "#phy-cells":
>> +    const: 0
> You miss required: block.
Sure, will add.

--
Thanks,
Praveenkumar
>
> Best regards,
> Krzysztof
>

