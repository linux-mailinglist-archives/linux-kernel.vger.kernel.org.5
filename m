Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FCD800D61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379189AbjLAOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379175AbjLAOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:38:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FAF10FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:38:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso16793835e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701441519; x=1702046319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMDJmSFiS1pB+vA0uKa5hIkNIMIqO+a3fOssGirSy4A=;
        b=FP7KqG99N1YJuIhK8cruX0FybXX5Rlnf7jW+hJV0sad4ep7351qXtsL0OydV5HU1u0
         dpSCLNIMv8P7jITPbCAbJjYnaweraUA7FMqkdOrgxstkittS0m98sFLz3KAFf8lb85yl
         WGGNj6RvpC8PFDMczbpo0fnhshAjZ4BgFqV4kev/SNfEfEbQ9ehYj+AzXCzAJVEW5n/c
         YUj9qkgnjsS4gZE2kTMnuY7daxt85u/avtutjSp123GKAycLQ4iLL4IFBOsIONP2lL/a
         kIuX2VAuk/bmng3H2V2txP39IPfSu849KXpOcv5NwOCxDMv/y4ehuY8SUmA94pf2uyUY
         8v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441519; x=1702046319;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMDJmSFiS1pB+vA0uKa5hIkNIMIqO+a3fOssGirSy4A=;
        b=M0/baTnvTUVeH/jyQK9di3a0kfPxkJrwkMUVg7aJ/r/VOjt+BQoZa3Oh4Hp9oKhAOW
         kbTTrExUiBAEze+GqZw/FvQDWVmKfmBEwTDYE/YNgYgOFh+Z5JzS8GMjFmQpvLOjOme2
         dGepERLDjboo1ZuOTcyVyWIHsUkzr38m0Pmns5GRZsSeU/kKrmpo8YSBLMBaJDXFd2ce
         HiXK13aP9bQwnIIE/tWAhIYReYvkfmzg2lJcSyW6ZVs27Tp1cEDIjb4c3Tnper6LiLQ/
         dnNGNo1FAK/zU3tMPan4InF3hVTlwvO41qy46Fj6iSayAsQtYURUP80RUpfUs5uKCr0T
         JhKA==
X-Gm-Message-State: AOJu0YyVOvgzTsviFqPjesllLjo9zt0WqhB3YA5lZpq4A0eRrfygFCA1
        ExNg4U4tMYYYL33UkMM7uGxtoQ==
X-Google-Smtp-Source: AGHT+IHcAUsl9lOeoHYBF0UO2bZlso/y11figd/jHfDFoBy0xhHnIIMo0BnMZVi++P80nh+RltGedg==
X-Received: by 2002:a7b:c4d1:0:b0:40b:5e1e:b3b4 with SMTP id g17-20020a7bc4d1000000b0040b5e1eb3b4mr465191wmk.50.1701441519242;
        Fri, 01 Dec 2023 06:38:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id d22-20020adfa356000000b0033332df65absm1374970wrb.50.2023.12.01.06.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:38:38 -0800 (PST)
Message-ID: <944c02f5-d0e6-4367-bb4d-b366054b3e4e@linaro.org>
Date:   Fri, 1 Dec 2023 15:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: marvell: move MMP boards to common marvell
 directory
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231201132306.60753-1-krzysztof.kozlowski@linaro.org>
 <1e25e2f4-e4b9-4219-a9c2-cb6230a62549@lunn.ch>
 <a44b7bb2-34ac-45ab-84c6-630d604f1bcf@linaro.org>
 <5d511e31-8ff5-4c23-a65e-8660833a9799@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5d511e31-8ff5-4c23-a65e-8660833a9799@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 15:34, Andrew Lunn wrote:
> On Fri, Dec 01, 2023 at 03:21:05PM +0100, Krzysztof Kozlowski wrote:
>> On 01/12/2023 14:51, Andrew Lunn wrote:
>>> On Fri, Dec 01, 2023 at 02:23:06PM +0100, Krzysztof Kozlowski wrote:
>>>> Marvell board bindings are spread over arm/marvell/ and arm/mrvl/
>>>> directories.  Move MMP board bindings from the latter to the former, to
>>>> keep all of them together.
>>>
>>> Hi Krzysztof
>>>
>>> Did you test get_maintainers.pl? MMP has a different maintainer to
>>> many of the other Marvell SoCs. We want emails going to the correct
>>> Maintainers, and ideally not spamming the others.
>>
>> The old binding was not referenced in MAINTAINERS, at least I could not
>> find it.
>> My change does not affect status quo - orphaned files.
>>
>> OTOH, some entries like Orion list specific files. Others like Marvell
>> list entire directory, which is their mistake in the first place.
>>
>> There is a mess in this approach, but the mess exists before my patch.
> 
> I think these moved files will now match:
> 
> ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Gregory Clement <gregory.clement@bootlin.com>
> M:      Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
> F:      Documentation/devicetree/bindings/arm/marvell/
> 
> But these files are not Gregory or my problem.

Yeah, that's what I meant by listing entire directory.

> 
> If they were orphaned before, i would prefer they are either orphaned
> after the move, or associated to the correct maintainer. Being
> associated to the wrong maintainers is worse than having no
> maintainers at all.

I can add this to existing maintainers entry. Which one? I see only two
ARM/Marvell.

Best regards,
Krzysztof

