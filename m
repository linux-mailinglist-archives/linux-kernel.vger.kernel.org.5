Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470957E7F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjKJRxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjKJRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103723A23C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:20:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so3515029a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699629648; x=1700234448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q60cvDzUAK+1xfeayy1L5bVvq0mLnjZeOOvCKBuUzG0=;
        b=lnc9ZWqKwOpuEYm+0/MHJxilg1zVGq5GOsXT+yVer+YrnijFDN8DiBQd9a2MyFdS5i
         fPCpjtkeb4PJ/+je0WaDAtYeyayT/B0C37zFH23YuC+HQFH2JO+d5nb6mplQrOFM8DVD
         EBe6ZcGIaXtOwvQRrpjzkWKBAJzSUyBS35Jlo7oWsGyo4yT3ao2aU2L0Vgebkcr4gbog
         1iVC04j2WREztilWdtOyzIl7ye+Ag8x5yNAhy7lFhG5+mVRXcDGcEqv9kogbDN4Oo+Pb
         AWAidtaUblH3D8SYy79m68FarS//BIVOCG61GPVgNmhSIPWi3i1y6tTV7C9GIAhF5CPD
         h9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699629648; x=1700234448;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q60cvDzUAK+1xfeayy1L5bVvq0mLnjZeOOvCKBuUzG0=;
        b=uA4pKDt7+QL4d6JA+hWuYoEwS1/KYQ0xodlNW4SXqXr4BwJFqD+eh2wGUCRLGXZKtg
         Dpp6l2sDpGxMXo7xmtoN4vvpLWWksc1IdgsKArkmg35KXi+SQcxxLp0YEqzSdcqacWgc
         XVPkLFtrs2bn9lV4LFnKhZmNHAkPfqaTNqXpMQXlRFw96W5z+FjTf8SJqy21UsU+BmST
         YD6ieRR6qYPzsTI2YAhM2wm1htASlJ+89JjJrniiekWb8lYyvMHNujUvFH3eytfMdWQ1
         bFf2wG4z8NU8m06G1ckejwMNwp+b2XJ9gO7BzPDHqbVNONlINbBuuyfi6oZde1gyiP+K
         b34A==
X-Gm-Message-State: AOJu0YzYNJTBAfHKT+eeDfrWks0KmsfykSAVMY4X8ye+HgMZwX3kOuOu
        Vep4g2OnNlnp2iFvoSgvNmJeMw==
X-Google-Smtp-Source: AGHT+IG8736pkNhNNdVrvSwcfmtDnAXVoUjv2Cj4/lEv2B3oApCfgwELeonWsFiocMNu9PYcPv1TFg==
X-Received: by 2002:a50:d70d:0:b0:543:56c8:f84b with SMTP id t13-20020a50d70d000000b0054356c8f84bmr6961108edi.19.1699629648476;
        Fri, 10 Nov 2023 07:20:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id b98-20020a509f6b000000b00533dd4d2947sm1287058edf.74.2023.11.10.07.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:20:48 -0800 (PST)
Message-ID: <fc52c1df-e414-49a9-a3a7-7a4ce45c403e@linaro.org>
Date:   Fri, 10 Nov 2023 16:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Golle <daniel@makrotopia.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org>
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

On 10/11/2023 09:09, Krzysztof Kozlowski wrote:
> On 10/11/2023 01:30, Daniel Golle wrote:
>> Add binding description for mediatek,mt7988-wdt.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> ---
> 
> ...
> 
>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>> new file mode 100644
>> index 0000000000000..fa7c937505e08
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +/* TOPRGU resets */
>> +#define MT7988_TOPRGU_SGMII0_GRST		1
>> +#define MT7988_TOPRGU_SGMII1_GRST		2
>> +#define MT7988_TOPRGU_XFI0_GRST			12
>> +#define MT7988_TOPRGU_XFI1_GRST			13
>> +#define MT7988_TOPRGU_XFI_PEXTP0_GRST		14
>> +#define MT7988_TOPRGU_XFI_PEXTP1_GRST		15
>> +#define MT7988_TOPRGU_XFI_PLL_GRST		16
> 
> IDs should start from 0 or 1 and increment by 1. If these are not IDs,
> then you do not need them in the bindings.
> 
> Where is the driver change using these IDs?

You nicely skipped my email and keep pushing the idea of putting this
into separate patch.

No. Respond to received comments.

> 
>> +
>> +#define MT7988_TOPRGU_SW_RST_NUM		24
> 
> Why 24? I see 7. Why having it in the bindings in the first place.
> 
> It's quite likely I asked the same question about other bindings for
> Mediatek. I will be asking every time till this is fixed.

No response to this, either.

Best regards,
Krzysztof

