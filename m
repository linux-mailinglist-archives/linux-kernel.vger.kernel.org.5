Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0278479A433
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjIKHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjIKHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:12:49 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF7CD9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:12:38 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id fLw6qhsttOzKlfb66qWn5a; Mon, 11 Sep 2023 07:12:38 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id fb63qG6I8fN5Mfb65qF9H7; Mon, 11 Sep 2023 07:12:37 +0000
X-Authority-Analysis: v=2.4 cv=TMJW9npa c=1 sm=1 tr=0 ts=64febde5
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=CKMxHAookNUaJbGn3r6bzg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8
 a=gEfo2CItAAAA:8 a=6mVVujuaWLD2RSIlgPwA:9 a=QEXdDO2ut3YA:10
 a=rsP06fVo5MYu2ilr0aT5:22 a=sptkURWiP4Gy88Gu7hUp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QwK69sTp47zzTxJYCYeDtYYJkekjiU87kUvd/a6irY0=; b=FK8SkZGaN1qDF2eagOyHMzuz7q
        0zemE53JshI4zJKlOwsaKtJzgHHMzUTgDTUZqTF9C9UmF+Lz5ANZaFfa3JjhDE5Cmc7QywK5OC/Sb
        uM0zkzQBOohF0GNAWJ/UtnoBjpH+sFfBkww3QIc7aAKCB5bMec0Rsgt7hv/vGq+Q1w1FqWCOwfpCQ
        fmCRtIqoNkhuijNIdTP4XRmaGushDzvS1IT4gsYE61dKo8WyXrXJVxmgB5M6b/BggWhlziJuBDjJb
        N1d9jjkVyPKb25ZFFehA1fS6fuFP17fLP2jS/C++Cz6GYWUh6sbkxsls4EvP6lhjshurJRvDUl7Qk
        wYu+2fHA==;
Received: from [103.163.95.214] (port=49564 helo=[192.168.1.105])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <saravanan@linumiz.com>)
        id 1qfb61-001Jaz-1T;
        Mon, 11 Sep 2023 12:42:33 +0530
Message-ID: <d7eb272e-8abb-c307-4aa8-b0af3f943453@linumiz.com>
Date:   Mon, 11 Sep 2023 12:42:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add mps,mpq2286
 power-management IC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-3-saravanan@linumiz.com>
 <34ede760-d612-4628-17e6-600c133ee878@linaro.org>
Content-Language: en-US
From:   Saravanan Sekar <saravanan@linumiz.com>
In-Reply-To: <34ede760-d612-4628-17e6-600c133ee878@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 103.163.95.214
X-Source-L: No
X-Exim-ID: 1qfb61-001Jaz-1T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.105]) [103.163.95.214]:49564
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 3
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIvykdVJKxQzo9E/Xj2SfJPtKgkAkmFzRwSWfsc7MYO0l7duz5BDk8Iquw05ZOSyOlUVkxX7bhj8+mCrjC2OQS8iPhX9clqkn0VkAThzXd0GcX/mVNht
 QfQ7zNnwAAvx+6xw9Zk7nSkxua8/8AW7VPbUpUTHi765NnBAfH/XsYcPJ/P1aDd/1jcCNOJn3TlJH0I5RtGqrsMNfAzbtpe7mAA=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/23 11:56, Krzysztof Kozlowski wrote:
> On 11/09/2023 05:41, Saravanan Sekar wrote:
>> Document mpq2286 power-management IC
>>
>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. It's: regulator: dt-bindings:

Thanks for your time to review. git log has mix of "regulator: 
dt-bindings" and "dt-bindings: regualtor". I had referred my own 
accepted driver regulator/mps,mpq7932.yaml

> 
>> ---
>>   .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
>> new file mode 100644
>> index 000000000000..d00d887870a9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Monolithic Power System MPQ2286 PMIC
>> +
>> +maintainers:
>> +  - Saravanan Sekar <saravanan@linumiz.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mps,mpq2286
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  regulators:
>> +    type: object
>> +
>> +    properties:
>> +      "buck0":
> 
> You did not test it... Sigh. Anyway, there is no need for entire
> regulators node for one regulator. Can the device do anything else than
> being a regulator?
> 

I tested it, but documentation is not updated with test findings (buck0).

Other chipset has multiple regulator so dts has regulators node to keep 
the driver common

Primarily device is a regulator with pmbus capability like fault status 
(OV,OC, VIN, VOUT, Power good status), temperature status.

> Best regards,
> Krzysztof
>
Thanks,
Saravanan


