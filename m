Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1B76F076
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjHCRQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHCRP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:15:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB31BF0;
        Thu,  3 Aug 2023 10:15:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so11981645e9.2;
        Thu, 03 Aug 2023 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691082957; x=1691687757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxWLUNvKnma2N/DrU+9PlRX5fAyS26zOQ3cMeji8DWg=;
        b=fk8BdpZYwKWlJ7rWQTs/uhygGNhMpHslFVAmGoeDj7A3XZR3bOQayYzFgLnCgeFGQE
         o5AbtrxAobque7fJdDRb2jcJl0KlmGIloNHFBmaceFzRjrTQ36CsmZut/edaMLHVyX8C
         rHuHpMUKUlcGt0HgLsmmNBIgpHeCxiZWxDC863zzhXI6Uv2a3bUJwkorJVLjxJ9VMpDI
         4PaUtJDxUOY9Kpk3+8UapZ+KMzK5AlSoUHVCAlgxMi1pPS+D3TpCn+Bga+KDou0cuNFf
         m4fPmmJcrIQjnF9udZb6EBUDA/ujefa8Vp3dicItQxo94FP62KwivC006+G5H3z+dvY6
         0WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082957; x=1691687757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxWLUNvKnma2N/DrU+9PlRX5fAyS26zOQ3cMeji8DWg=;
        b=hwqFvJEDzdljfYL1BV5uA+N+pFg0DI0Pl1DUSlUBQ7d9iXLwA4GB+LxpIKLeE6bVw+
         68Nvh3SVX48Wt6JfPlIw678BABnKqiZ1g+puY/ECjknU7ozjZq7tdU6ZLwx4smcIn1K9
         oQutPI4TwnomGnMhSc7YwmlIcQS7G5DsSDCjZXaqadmPa92YUPE3aiGeN+ex1Lq1gEYj
         1lVRO7fg91o8di/BmqY5V7dkRo6S1X5Z40bierjjfi1Q5DmKM+f4TUSUvFZFhxAMEM8l
         EYYedgoAlxCMmKJCDQLisd079h5JbVq2jmBUglowaB5ginACKWKdjki+h0SMTlmck0gH
         MA6A==
X-Gm-Message-State: ABy/qLYfzF7yVNH2jr/i0HCbWFp2W66p405mg2hwia0yyltRpZvKtbJt
        2XDeZWorAJ+afKtSLTsxtQE=
X-Google-Smtp-Source: APBJJlEkOHSmbp3qXVAzIozmxruwUVMDflFzZK2RXc2qrB42WWSnqUl64kb1/UE7M99kS9pM/VWaZw==
X-Received: by 2002:a7b:cbd8:0:b0:3fe:228a:e782 with SMTP id n24-20020a7bcbd8000000b003fe228ae782mr7896492wmi.37.1691082957107;
        Thu, 03 Aug 2023 10:15:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e? ([2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e])
        by smtp.gmail.com with ESMTPSA id z25-20020a7bc7d9000000b003fbaade0735sm4745410wmk.19.2023.08.03.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 10:15:56 -0700 (PDT)
Message-ID: <4edab8d2-5b01-c406-332a-49a7305df5c0@gmail.com>
Date:   Thu, 3 Aug 2023 19:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Content-Language: en-US, fr
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        fabrice.gasnier@foss.st.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230801220559.32530-1-rgallaispou@gmail.com>
 <20230802080238.d3nam6elnern65rb@pengutronix.de>
 <8e74af01-36c6-3a41-6d31-91b09ea62026@gmail.com>
 <20230803085645.svrrcritdifbjwdz@pengutronix.de>
 <20230803-sandbox-prideful-4f23b78ddc67@spud>
From:   =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20230803-sandbox-prideful-4f23b78ddc67@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 03/08/2023 à 18:09, Conor Dooley a écrit :
> On Thu, Aug 03, 2023 at 10:56:45AM +0200, Uwe Kleine-König wrote:
>> On Thu, Aug 03, 2023 at 09:18:14AM +0200, Raphaël Gallais-Pou wrote:
>>> Hi
>>>
>>> Le 02/08/2023 à 10:02, Uwe Kleine-König a écrit :
>>>> Hello,
>>>>
>>>> On Wed, Aug 02, 2023 at 12:05:59AM +0200, Raphael Gallais-Pou wrote:
>>>>> +  st,capture-num-chan:
>>>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>>>> +    description: Number of available Capture channels.
>>>>
>>>> I have the theory that nobody actually uses the capture feature and I'd
>>>> like to get rid of it. People who do use it, should better switch to the
>>>> counter driver.
>>>
>>> TBH I only found two drivers using it, including this one.
>>>
>>> $ grep -rinI "\.capture" drivers/pwm/ | wc -l
>>> 2
>>
>> Right, there is pwm-stm32 and pwm-sti that support capture.
>>
>> There are a few machines that have a st,sti-pwm device:
>>
>> 	$ grep -rl st,sti-pwm arch/arm/boot/dts/*.dtb
>> 	arch/arm/boot/dts/stih407-b2120.dtb
>> 	arch/arm/boot/dts/stih410-b2120.dtb
>> 	arch/arm/boot/dts/stih410-b2260.dtb
>> 	arch/arm/boot/dts/stih418-b2199.dtb
>> 	arch/arm/boot/dts/stih418-b2264.dtb
>>
>> but to actually use capture the device tree must have a property
>> st,capture-num-chan. "st,capture-num-chan" isn't set by any of the
>> devices.

This is also what I came across, this is the reason why I'm not 
reluctant to remove it.

>>
>> I think for stm32 it's not that trivial to show that it's unused.
>> While the capture code isn't a big maintenance burden, I still would
>> prefer to get rid of it if nobody uses it. Still more given that there
>> are better alternatives available.

Regarding stm32, I think the owner of the driver would prefer to handle it.

>>
>>> If there is no opposition about removing this feature I suggest to do it in
>>> a second time, in a serie.
>>
>> Does that mean you will do that? I guess not, but at least this means
>> you're not using capture support.
> 
> It seems like it should either be done as part of the conversion or as a
> second patch in the series doing the conversion /shrug

Splitting the conversion and the capture removal is clearer IMO. Mixing 
both could lead to confusion. I'll send another serie to do this.


Regards,
Raphaël
