Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E3768749
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjG3TGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3TGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:06:48 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535710F0;
        Sun, 30 Jul 2023 12:06:47 -0700 (PDT)
Received: from [192.168.0.116] (unknown [109.229.201.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 91F131605BB;
        Sun, 30 Jul 2023 21:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1690744006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ginkyU5PPEsZQW5/XO7Md/8EcwIhhreU3ETKq76/MyU=;
        b=SR9+A6q8DujbWly+/d6g15RRWGYDPZu1yn0KQ2XPyX1U02QWsH476/aEzoK/RG3owTzvDy
        ernVxbLJHAezW1q5Wo+qj7IJvIOzmIpztVieBtT/4K6HjrKTUb9cgiyiMvnCgMw5qXkHqh
        MMNqJDRaNNCSvovgaCFrcauZwZJLs4k=
Message-ID: <8403b94b-f0ff-39b6-8a36-01b020db61c1@ixit.cz>
Date:   Sun, 30 Jul 2023 22:06:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] dt-bindings: sound: gtm601: convert to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>
References: <20230730115150.38887-1-david@ixit.cz>
 <acd8e4ea-0d8f-3dc2-16ef-4c1deee281d8@linaro.org>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <acd8e4ea-0d8f-3dc2-16ef-4c1deee281d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review. Version 3 has been sent, and I'm hopeful that 
I have correctly implemented your feedback.

David

On 30/07/2023 20:54, Krzysztof Kozlowski wrote:
> On 30/07/2023 13:51, David Heidelberg wrote:
>> Convert GTM601 binding to the YAML format.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>
> No need for blank line between tags.
>
>> Cc: kernel@puri.sm
>> ---
>> v2:
>>   - add #sound-dai-cells
>>   - put kernel@puri.sm into maintainers
>>
>>   .../devicetree/bindings/sound/gtm601.txt      | 19 ----------
>>   .../devicetree/bindings/sound/gtm601.yaml     | 36 +++++++++++++++++++
> Filename like compatible, please, so option,gtm601.yaml
>
>>   2 files changed, 36 insertions(+), 19 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
>> deleted file mode 100644
>> index efa32a486c4a..000000000000
>> --- a/Documentation/devicetree/bindings/sound/gtm601.txt
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -GTM601 UMTS modem audio interface CODEC
>> -
>> -This device has no configuration interface. The sample rate and channels are
>> -based on the compatible string
>> -	"option,gtm601" = 8kHz mono
>> -	"broadmobi,bm818" = 48KHz stereo
>> -
>> -Required properties:
>> -
>> -  - compatible : one of
>> -	"option,gtm601"
>> -	"broadmobi,bm818"
>> -
>> -
>> -Example:
>> -
>> -codec: gtm601_codec {
>> -	compatible = "option,gtm601";
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/gtm601.yaml b/Documentation/devicetree/bindings/sound/gtm601.yaml
>> new file mode 100644
>> index 000000000000..e81a6aa75522
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/gtm601.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/gtm601.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: GTM601 UMTS modem audio interface CODEC
>> +
>> +maintainers:
>> +  - kernel@puri.sm
>> +
>> +description: >
>> +  This device has no configuration interface. The sample rate and channels are
>> +  based on the compatible string
>> +
> Missing $ref to dai-common.yaml
>
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: broadmobi,bm818
>> +          - const: option,gtm601
>> +      - items:
> No "items" needed here, just use enum.
>
>> +          - enum:
>> +              - broadmobi,bm818  # 48 kHz stereo
>> +              - option,gtm601  # 8 kHz mono
> This does not make much sense. bm818 is either compatible with gtm601 or
> is not. Cannot be both.
>
>> +
>> +  '#sound-dai-cells':
>> +    const: 0
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    gtm601_codec {
> No underscores, generic names, so "codec" or "audio-codec".
>
>> +        compatible = "option,gtm601";
> Add dai cells also to the example to make it complete.
>
>> +    };
> Best regards,
> Krzysztof
>
-- 
David Heidelberg
Certified Linux Magician

