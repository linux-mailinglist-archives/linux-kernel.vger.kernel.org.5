Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA97FD393
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjK2KGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjK2KGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:06:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E581BE8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:06:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a011e9bf336so897761466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701252375; x=1701857175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=za2yJkzzBy3V8ZBT/Ld4CZE8pNBS1Zu1vvkdsZhT4Jo=;
        b=yT278aJwUcLvatl6DJNDKCTbn4nRwbd6RmnClf70+1Trgo4oKhCAEC5bJI5TK/zar/
         DSIVVkvQFJcGUntvStIaitAqEpHN0mCA32JXaeaS8fR5VS9cXJGSymDNup2Nd5j5/fns
         iZa0v0gUlUa2FevrlLDF7KyCldcgbMm+yNk1Z5xIhmjZXUQFaQ8GMgsrbEoALHZhekz1
         qoJIJfnR6U9m25HxsWBq3AsjHkYyRe5rWMW0QREJe1bTErDZUndul+PbGVQKg0ypj0iJ
         LZO3DMt8VVwdZS0hjJmN7x+usJSQ1lrU+B3TmM4IW5HUzoJ/locnhXfxxJVA0Rb5keo0
         YjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252375; x=1701857175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=za2yJkzzBy3V8ZBT/Ld4CZE8pNBS1Zu1vvkdsZhT4Jo=;
        b=Vx5zpd/g+TyLx2MOF+aBL15Aa3jUtJuxLoquFv8Id3dd/jVeShV64yfjJdIFkxGwLK
         ncgozGvtGjTaIPjQ+x6cG2ymSOSNeeJkVLLzGNA/mZSyFm+KZQOD8F9gu6k4IUuqOBVA
         hXJUP7vNoPdD4njRbWmWl9y4zk9bHiuH1onbxrHCXEtbceb3ErjFk3o+hkjSFpudAKnq
         p1OUbbM7V/eg4YcJhRI0ZkeDRGzp+vASQs9KVhtU0TUNt8VOMdCmoHl5CqeD3i2r188A
         JiIprLRmsU1DpF+NQepO0ofckumj62iXlfPc1XhA/nsosoU7o8WvIysl2rdIImq6xXYW
         w3zg==
X-Gm-Message-State: AOJu0YzoYKaJOy4BMZB/PEWl98+O9CCqSPTHrjaRLnNp7fox52yoEP2F
        /XWLSiiwyd62eyXbn22VfVe/xw==
X-Google-Smtp-Source: AGHT+IGJuApRen3EBmEwMd5p364lmU7PTBcgXOWX8oNwUiNEQief4We8JeVPD62DOEA/pzjlIjZuIw==
X-Received: by 2002:a17:906:3f88:b0:9ff:1dea:83b6 with SMTP id b8-20020a1709063f8800b009ff1dea83b6mr11989413ejj.4.1701252374796;
        Wed, 29 Nov 2023 02:06:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id gx26-20020a170906f1da00b009ad89697c86sm7757685ejb.144.2023.11.29.02.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 02:06:14 -0800 (PST)
Message-ID: <ae9ef5a6-bb66-4b15-ad6a-fc71206e2795@linaro.org>
Date:   Wed, 29 Nov 2023 11:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
 <a3b65c90-afc9-4caf-8744-112369a838d2@lunn.ch>
 <15292222-39b3-4e9e-a6c1-26fba8f5efcd@linaro.org>
 <4fa1e860-48bd-456b-ab0b-88215c2b8d1b@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <4fa1e860-48bd-456b-ab0b-88215c2b8d1b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2023 18:48, Andrew Lunn wrote:
> On Sun, Nov 26, 2023 at 11:38:38AM +0100, Krzysztof Kozlowski wrote:
>> On 25/11/2023 20:47, Andrew Lunn wrote:
>>>> +=====================================
>>>> +Devicetree Sources (DTS) Coding Style
>>>> +=====================================
>>>> +
>>>> +When writing Devicetree Sources (DTS) please observe below guidelines.  They
>>>> +should be considered complementary to any rules expressed already in Devicetree
>>>> +Specification and dtc compiler (including W=1 and W=2 builds).
>>>> +
>>>> +Individual architectures and sub-architectures can add additional rules, making
>>>> +the style stricter.
>>>
>>> It would be nice to add a pointer where such rules are documented.
>>
>> Subsystem profile or any other place. The generic doc should not point
>> to specific ones.
> 
> That is not so friendly for a developer. A reviewer points out that a
> file is not consistent with the coding style. So they go away and fix

Then it is poor reviewer. If reviewer does not mention specific issues
to fix or specific style to use, but just "coding style", then he has no
right to expect some other output.

> it, as described here. They then get a second review which say, no,
> you to do X, Y and Z, despite them actually following the coding
> style.
> 
> Maybe add to the paragraph above:
> 
> These further restrictions are voluntary, until added to this
> document.

"can add" already expresses this.

> 
> This should encourage those architectures to document their coding
> style.
> 
>> The root node is a bit special, but other than that mixing nodes with
>> and without unit address is discouraged practice.
> 
> If the root node is special, maybe it needs a few rules of its own?
> All properties without an address come first, then properties with
> addresses. Sorting within these classes follow the normal rules
> already stated?

This document ought to be simple at the beginning. Also, root node has
only nodes without addresses and soc@ node.

> 
>>>> +Indentation
>>>> +-----------
>>>> +
>>>> +1. Use indentation according to :ref:`codingstyle`.
>>>> +2. For arrays spanning across lines, it is preferred to align the continued
>>>> +   entries with opening < from the first line.
>>>> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
>>>> +   shall be enclosed in <>.
>>>> +
>>>> +Example::
>>>> +
>>>> +	thermal-sensor@c271000 {
>>>> +		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
>>>> +		reg = <0x0 0x0c271000 0x0 0x1000>,
>>>> +		      <0x0 0x0c222000 0x0 0x1000>;
>>>> +	};
>>>
>>> I'm not sure i understand this. Is this example correct?
>>>
>>>                 gpio-fan,speed-map = <0    0
>>>                                       3000 1
>>>                                       6000 2>;
>>>
>>> It exists a lot in todays files.
>>
>> Depends on the binidng. Is it matrix? If yes, then it is not correct.
> 
> It seems to me, rules 2 and 3 should be swapped. You can only align
> the <, if you have <. So logically, the rule about having < should
> come first.

Hm, sure, I'll reorder them.

Best regards,
Krzysztof

