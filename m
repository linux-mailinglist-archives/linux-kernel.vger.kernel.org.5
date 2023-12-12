Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1580F1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbjLLQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjLLQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:03:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F47F7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:04:02 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1e116f2072so1187498566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702397041; x=1703001841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvlXlTqT/1JI2ELUMbuVdrPIpZiYCzyJ2Z/v4btxXcU=;
        b=ZnZEzBF4ekVaxZEHEQ+EfaUNcf7PbqifWOTWzzwTMvWnUuMryoDEyyvTe79+xaSeTO
         ROK9FZiPXrZiSfT/W6wGI4Iq4kYDuXt5oD0ICsZQraxC4U7w2eyTCXtuInIERYmg7Tcv
         zhb9bG4wyS1A3fk+kFxw93Ln6ictDPzybiWhyWk7ThfN4sgGV0UvpEgIstrajeViIz0J
         qgvGokwcg3SdRvdmBSYGsRfEKJSHpRgd2jXnub5s69MK7dT9tq9Q7Z4jM0zdzHhQXTQH
         PKXrFl+36xBloUy8ee73jaeOY8EDUiC8iwtt830T1hWkxwcg7os+bmrEOM2oqVI3XMFS
         uPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397041; x=1703001841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvlXlTqT/1JI2ELUMbuVdrPIpZiYCzyJ2Z/v4btxXcU=;
        b=ei8LkgZL6x5EL/6DU77cbEjc72oPJSQwGWtUWhNrFQGLIVC8Pq6DTYGAFtof1S1av7
         R1kqts/rwarkt6C9LhmbjP3uqakNtxXWc7SN2T5LaEBHJPD44yhsKFk07NstwvFqiJac
         dJrZjDey3M1b9vIDBjqeQ53Y+pPgXVd+oGSFtqxPQgB6f5sLosFLET1F4W3+KHY3h6sl
         8CNeCHSbM7Mov3Q1dBQnbhx4cFWtk7ZSD8alVCYetrdaJSPgmf/wBUKOAvMKN+3ly94a
         KMveSSdRzzNTpqw0+ZZF09SvFxZyU2d3fDbLIuSLvXm/5PT6KOpHHjhn84NL/UOachgN
         ovGQ==
X-Gm-Message-State: AOJu0YxtOQTQXiKyx0Cuzrn+I3oP/Qmoe/53MAUsJgO5uW0POcKbY0cG
        icj9aTkk7Jf5MSqHt8jphK/cCA==
X-Google-Smtp-Source: AGHT+IFgMCuaknH0J4sB2gnWyA3n6vKJZYJRSK/Aynlmm9ST2Gm/oCk6X+fOmoucguw1kh7RBCdn5A==
X-Received: by 2002:a17:906:dfda:b0:a1d:9f8f:e54b with SMTP id jt26-20020a170906dfda00b00a1d9f8fe54bmr7433783ejc.33.1702397041050;
        Tue, 12 Dec 2023 08:04:01 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id mm19-20020a1709077a9300b00a18c2737203sm6505720ejc.109.2023.12.12.08.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:04:00 -0800 (PST)
Message-ID: <412d6500-7364-43b0-90a6-98e9c9e30e76@tuxon.dev>
Date:   Tue, 12 Dec 2023 18:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: soc: atmel: Adjust defines to follow
 aphabetical order
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231208194532.579893-1-Ryan.Wanner@microchip.com>
 <de0ddb41-8d78-45eb-bcb7-6d318bf154fd@tuxon.dev>
 <31d470f8-9f82-4c09-a6f9-dac528fda3bf@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <31d470f8-9f82-4c09-a6f9-dac528fda3bf@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.12.2023 16:47, Ryan.Wanner@microchip.com wrote:
> On 12/9/23 05:50, claudiu beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Ryan,
>>
>> On 08.12.2023 21:45, Ryan.Wanner@microchip.com wrote:
>>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>
>>> Move the defines so that they are in aphabetical order based on SOC.
>>
>> s/aphabetical/alphabetical but maybe alphanumerical a better term.
>>
>> Could you please explain what level of alphabetical sort you wanted to
>> achieve? I see SAM9X60/SAMA7G5 b/w AT91SAM9X5_CIDR_MATCH and
>> AT91SAM9M11_EXID_MATCH or, e.g., AT91SAM9G35_EXID_MATCH after
>> AT91SAM9M10_EXID_MATCH.
> 
> I wanted to make the CIDR match in alphanumeric, for the EXID I wanted
> to keep them alphanumeric but keeping them in the original SOC grouping.

Even so, it looks to me that there is mixed approach in overall file.

>>
>>>
>>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>>> ---
>>> Changes from v1 -> v2:
>>> - Remove defines that are not yet in v6.7.
>>>
>>>  drivers/soc/atmel/soc.h | 38 +++++++++++++++++++-------------------
>>>  1 file changed, 19 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
>>> index 7a9f47ce85fb..1f2af6f74160 100644
>>> --- a/drivers/soc/atmel/soc.h
>>> +++ b/drivers/soc/atmel/soc.h
>>> @@ -39,10 +39,10 @@ at91_soc_init(const struct at91_soc *socs);
>>>  #define AT91SAM9261_CIDR_MATCH               0x019703a0
>>>  #define AT91SAM9263_CIDR_MATCH               0x019607a0
>>>  #define AT91SAM9G20_CIDR_MATCH               0x019905a0
>>> -#define AT91SAM9RL64_CIDR_MATCH              0x019b03a0
>>>  #define AT91SAM9G45_CIDR_MATCH               0x019b05a0
>>> -#define AT91SAM9X5_CIDR_MATCH                0x019a05a0
>>>  #define AT91SAM9N12_CIDR_MATCH               0x019a07a0
>>> +#define AT91SAM9RL64_CIDR_MATCH              0x019b03a0
>>> +#define AT91SAM9X5_CIDR_MATCH                0x019a05a0
>>>  #define SAM9X60_CIDR_MATCH           0x019b35a0
>>>  #define SAMA7G5_CIDR_MATCH           0x00162100
>>>
>>> @@ -61,23 +61,15 @@ at91_soc_init(const struct at91_soc *socs);
>>>  #define AT91SAM9N12_EXID_MATCH               0x00000006
>>>  #define AT91SAM9CN11_EXID_MATCH              0x00000009
>>>
>>> +#define AT91SAM9XE128_CIDR_MATCH     0x329973a0
>>> +#define AT91SAM9XE256_CIDR_MATCH     0x329a93a0
>>> +#define AT91SAM9XE512_CIDR_MATCH     0x329aa3a0
>>> +
>>>  #define SAM9X60_EXID_MATCH           0x00000000
>>>  #define SAM9X60_D5M_EXID_MATCH               0x00000001
>>>  #define SAM9X60_D1G_EXID_MATCH               0x00000010
>>>  #define SAM9X60_D6K_EXID_MATCH               0x00000011
>>>
>>> -#define SAMA7G51_EXID_MATCH          0x3
>>> -#define SAMA7G52_EXID_MATCH          0x2
>>> -#define SAMA7G53_EXID_MATCH          0x1
>>> -#define SAMA7G54_EXID_MATCH          0x0
>>> -#define SAMA7G54_D1G_EXID_MATCH              0x00000018
>>> -#define SAMA7G54_D2G_EXID_MATCH              0x00000020
>>> -#define SAMA7G54_D4G_EXID_MATCH              0x00000028
>>> -
>>> -#define AT91SAM9XE128_CIDR_MATCH     0x329973a0
>>> -#define AT91SAM9XE256_CIDR_MATCH     0x329a93a0
>>> -#define AT91SAM9XE512_CIDR_MATCH     0x329aa3a0
>>> -
>>>  #define SAMA5D2_CIDR_MATCH           0x0a5c08c0
>>>  #define SAMA5D21CU_EXID_MATCH                0x0000005a
>>>  #define SAMA5D225C_D1M_EXID_MATCH    0x00000053
>>> @@ -113,6 +105,14 @@ at91_soc_init(const struct at91_soc *socs);
>>>  #define SAMA5D43_EXID_MATCH          0x00000003
>>>  #define SAMA5D44_EXID_MATCH          0x00000004
>>>
>>> +#define SAMA7G51_EXID_MATCH          0x3
>>> +#define SAMA7G52_EXID_MATCH          0x2
>>> +#define SAMA7G53_EXID_MATCH          0x1
>>> +#define SAMA7G54_EXID_MATCH          0x0
>>> +#define SAMA7G54_D1G_EXID_MATCH              0x00000018
>>> +#define SAMA7G54_D2G_EXID_MATCH              0x00000020
>>> +#define SAMA7G54_D4G_EXID_MATCH              0x00000028
>>> +
>>>  #define SAME70Q21_CIDR_MATCH         0x21020e00
>>>  #define SAME70Q21_EXID_MATCH         0x00000002
>>>  #define SAME70Q20_CIDR_MATCH         0x21020c00
>>> @@ -127,6 +127,11 @@ at91_soc_init(const struct at91_soc *socs);
>>>  #define SAMS70Q19_CIDR_MATCH         0x211d0a00
>>>  #define SAMS70Q19_EXID_MATCH         0x00000002
>>>
>>> +#define SAMV70Q20_CIDR_MATCH         0x21320c00
>>> +#define SAMV70Q20_EXID_MATCH         0x00000002
>>> +#define SAMV70Q19_CIDR_MATCH         0x213d0a00
>>> +#define SAMV70Q19_EXID_MATCH         0x00000002
>>> +
>>>  #define SAMV71Q21_CIDR_MATCH         0x21220e00
>>>  #define SAMV71Q21_EXID_MATCH         0x00000002
>>>  #define SAMV71Q20_CIDR_MATCH         0x21220c00
>>> @@ -134,9 +139,4 @@ at91_soc_init(const struct at91_soc *socs);
>>>  #define SAMV71Q19_CIDR_MATCH         0x212d0a00
>>>  #define SAMV71Q19_EXID_MATCH         0x00000002
>>>
>>> -#define SAMV70Q20_CIDR_MATCH         0x21320c00
>>> -#define SAMV70Q20_EXID_MATCH         0x00000002
>>> -#define SAMV70Q19_CIDR_MATCH         0x213d0a00
>>> -#define SAMV70Q19_EXID_MATCH         0x00000002
>>> -
>>>  #endif /* __AT91_SOC_H */
> 
