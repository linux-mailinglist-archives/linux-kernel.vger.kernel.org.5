Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66444811CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjLMSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjLMSjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:39:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C93D0;
        Wed, 13 Dec 2023 10:39:39 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDI7u2S015354;
        Wed, 13 Dec 2023 18:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fEx/rim947811PkyR5Ib8bCcfmjQUMsWMBx0jmD8wro=;
 b=mcTMy7EbuN77YCarY71ife9P537tehZ9gPelI4hUPLtwBuKD3pmaNIXB6j2xH2EooC6m
 YTq2aUv4iVns6b18vuuo52Tr6LWQq85YkglTM6cr0tPEgYqw5NBnVYfLc3fDwo4MCugH
 oKDdlECb8Kk/V8/AKp87AXjFAfGAdG6ju/gy3uJ55WmgnaXKI4/rOAw8bW5jB956BuaB
 lAPkqxYDqbus/TeoFEwJ3Y2LvbLuK9M3qpf+hY9VjjCRG1g5RfS3GCOUXTKkmG8VXe8j
 GON7Tlq00hlb6Ycqc2ZcIehSpycgDWFaUOZVQvs+Gk9shdN+S3L9T8IZ8rOzq04LTf9t Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyhm8gu24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 18:38:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDI8ZAO018923;
        Wed, 13 Dec 2023 18:38:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyhm8gu1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 18:38:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDGZU24008450;
        Wed, 13 Dec 2023 18:38:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jtk6q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 18:38:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDIcOvk21627514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 18:38:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C75E58054;
        Wed, 13 Dec 2023 18:38:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9AB55803F;
        Wed, 13 Dec 2023 18:38:22 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 18:38:22 +0000 (GMT)
Message-ID: <719949a9-ddd5-451f-a765-d875cea85ba5@linux.ibm.com>
Date:   Wed, 13 Dec 2023 12:38:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes.holland@infineon.com,
        linux@roeck-us.net, broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
 <CXNEWTC7G66C.8KM5X4BWMK7P@suppilovahvero>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CXNEWTC7G66C.8KM5X4BWMK7P@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TA5ugVitoI4LBCCP5dmzUD_ldTLYTHkW
X-Proofpoint-ORIG-GUID: Qxhptd4olsjIjL_1qbdboQzdGrQTp--Y
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jarkko,

On 12/13/23 12:20, Jarkko Sakkinen wrote:
> On Tue Dec 12, 2023 at 6:39 PM EET, Ninad Palsule wrote:
>> From: Johannes Holland <johannes.holland@infineon.com>
>>
>> Add a dt schema to support device tree bindings for the generic I2C
>> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
>> Specification for TPM 2.0 v1.04 Revision 14.
>>
>> This includes descriptions for the Nuvoton and Infineon devices.
>>
>> OpenBMC-Staging-Count: 3
> Please don't invent your own tags.

Yes, Sorry. I have cherry-picked this commit from openbmc. Now I have 
removed this line.

Thanks for the review.

Thanks & Regards,

Ninad

>
>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>> new file mode 100644
>> index 000000000000..de1e34065748
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: I2C PTP based TPM Devices
>> +
>> +maintainers:
>> +  - Johannes Holland <johannes.holland@infineon.com>
>> +
>> +description:
>> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^tpm(@[0-9a-f]+)?$"
>> +
>> +  compatible:
>> +    oneOf:
>> +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
>> +        items:
>> +          - const: infineon,slb9673
>> +          - const: tcg,tpm-tis-i2c
>> +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
>> +        items:
>> +          - const: nuvoton,npct75x
>> +          - const: tcg,tpm-tis-i2c
>> +      - const: tcg,tpm-tis-i2c
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      tpm@2e {
>> +        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>> +        reg = <0x2e>;
>> +      };
>> +    };
>> +...
>
> BR, Jarkko
