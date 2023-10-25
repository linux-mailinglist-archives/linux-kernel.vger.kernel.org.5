Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBD7D6F00
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjJYO21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJYO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:28:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E275199
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso9115351a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698244101; x=1698848901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+rBNd3iOEE3KUvPYugV8YOCkksc/xnPzMUm+flKumE=;
        b=h/Rkl9Olk5JseXa8sEhW3wHXHY+CsZKc1JKYwH6CJhaz2vuA+npoPi9DOLTI5rUzGu
         S4ueDl/DjMMBBU8dbLgs13LpjzwQcvq3SrL5N06KuaJBHMXyy3q+lKoeXfVntAAKQLmN
         sELUeAHD6iTRBM0nT62r7mskUjGKj32U1KYr1/CIJPhNL9eBlxbWVi9SA6Q8+xoJUvCv
         uwlvev/bgfdSlxr6/xt6rxo9cJVNlkwp34wkTsieprT49DUBI9vequvAkFg+fmQ34G/0
         BgOGvWmr8pV/xmv+Pmpa6O1havqMzKuQY2thV+K3bFLkNVCAQxfECoteeMhk9do1yqwa
         dW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244101; x=1698848901;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+rBNd3iOEE3KUvPYugV8YOCkksc/xnPzMUm+flKumE=;
        b=QC/ZIy8eEnAo2EDfKGj6gQRhcHgrFCz/azcwqerKE6Vi7e+TIf8KM5Y+PnXuYa1x5+
         prhLVTJy3qJM2xslshF6tEt/ErlYjt0kxlMQnLHdeHlpBCBStVbJhOK2pwsDQt41NbhC
         aMHEn/OTGW86bH0YVU9BpIlSneoIluPAVPhT171S3G6SIKC0adsE2nqaAJEbC4rV7H5o
         LeamipdvPrwjwDuUiacsfNilCRGzjRG3KrmUZaZZcOglL4NkktwLH3188RZ9XLIqxBuX
         KFJq4n/qyD335YxH/NZHCbM7q/5W17ibU6k3DhAKxcm0+PDLqxRUOGPajE3EFM2E4onm
         6pvQ==
X-Gm-Message-State: AOJu0YyaDx4+T1wDJeyx4giA1keZ2LnLFpO0YvHQAXkg3jM/TfgqB/l4
        KjyLbdDHxiocPJlO7KmjF9oMww==
X-Google-Smtp-Source: AGHT+IEjokKlJRnmbdlJV1vZrul2MBvPP0TGVCXFxg9oN4VIT/mgWxEsKw9XXt8szV5Bu7EDiCGjSg==
X-Received: by 2002:a05:6402:520b:b0:53b:3225:93c2 with SMTP id s11-20020a056402520b00b0053b322593c2mr11628664edd.8.1698244100909;
        Wed, 25 Oct 2023 07:28:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id n25-20020a509359000000b00530bc7cf377sm9761788eda.12.2023.10.25.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:28:20 -0700 (PDT)
Message-ID: <e5adb0cc-746c-4ca4-9052-af60b9655d5a@linaro.org>
Date:   Wed, 25 Oct 2023 16:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: add ti,ina238
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Richard Leitner <richard.leitner@linux.dev>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-2-a0196119720c@linux.dev>
 <20231025-hut-omnivore-f4b44a7b928d@spud>
 <qoxgyho5twbm4jopfveaf5ee3z4tkyb2z5f2vsyrpglffegmxf@v2z5ckcaa5jc>
 <20231025-eatery-backup-ad85c043cb01@spud>
 <8cd5c34e-f733-445d-bc1e-d4dea1bcb47d@linaro.org>
 <20231025-epilogue-preset-962b88985ea3@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231025-epilogue-preset-962b88985ea3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 16:25, Conor Dooley wrote:
> On Wed, Oct 25, 2023 at 04:18:31PM +0200, Krzysztof Kozlowski wrote:
>> On 25/10/2023 16:11, Conor Dooley wrote:
>>> On Wed, Oct 25, 2023 at 04:07:31PM +0200, Richard Leitner wrote:
>>>> On Wed, Oct 25, 2023 at 03:00:01PM +0100, Conor Dooley wrote:
>>>>> On Wed, Oct 25, 2023 at 10:34:12AM +0000, Richard Leitner wrote:
>>>>>> The ina238 driver is available since 2021 but lacks a dt-bindings file.
>>>>>> Therefore add the missing file now.
>>>>>
>>>>> Seemingly it is documented in Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>>>
>>>> Thanks for the feedback. True. So is it fine if it's left there or
>>>> should it be removed from ti,ina2xxx.yml as this is a separate driver
>>>> with different properties?
>>>
>>> Merging them would seem like the most straightforward thing to do, no?
>>
>> Sorry folks, I don't quite get what do you want to merge or move and
>> why. Drivers are not related to bindings. The point is the compatible is
>> already documented, so is anything wrong with existing documentation?
> 
> If it was not clear, I meant merging the bindings, not the drivers. IOW,
> adding the new compatible for the ina237 to the existing ina2xx.yaml
> binding.

Yes, this sounds good. Maybe ina2xx is indeed not matching all of this
hardware (e.g. supplies, shunt resistors), but then we need to talk
about specifics.

Best regards,
Krzysztof

