Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1581769A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjGaO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGaO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:56:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD050C6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:56:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso62154681fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690815402; x=1691420202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa1SB02KtfMLxNE4mkxxs1OYoxXlIjwBI7+LigCTgCc=;
        b=Bps7HKIGU1d7zGk6EnCBSZB+lUHreffolw38t62M9CWeJ/hAtTcLbWEyRGx0OLdxN+
         tVMbbmbRF2ohu2WxxLjNYl3IyaP6ok/GnwlqlRN29C3tUtFbSqIks28iNf8Ip0n3TGVQ
         ZauRAK3cDiIdUD/7Fu+6khTozBYPwXrwsueNQklYPH4vrbltQb4xTuyZ2h2GKYMpFzYh
         5Q9Lc9qZWNJwsss83IMWvph8fAq0e2bgQavQ2H3qcjE5rf3kzV+sqjYnCqFfs+Lc8znr
         R2I9f4B8oxB6w1zJ5akEPy0M0Q7S5mHA5OPRYR+cBxdd/K8CBZV/lFEYIJcLPjhl60FZ
         ahYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815402; x=1691420202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa1SB02KtfMLxNE4mkxxs1OYoxXlIjwBI7+LigCTgCc=;
        b=VH6EyhNEaRuQYQJG3+VVVjA4+DxMZ0EoEHbPwlQcuaATNPfsh+M6yG5q2gCNsYKv6V
         iAuh4mysDECFWEyycqz4A/8XMIG9maqb83u1mRI655EjkxkBDHbtMTynZB8aileP3+ui
         VPUmf+9YQR+31v/VwcCqoI5adEVn/CDmTbuTJdY3r1e8EhR/yE0B0JqP3rro2CDXCVf/
         fm8yBhE+S7XJjYT2G4xgbAKab6qOeTBUG4VSqcWUJGHnh/aiDF5h8ejXDskUMzzvXVnw
         h8WOxj4T1PBpvEFElOi9bg7ECc6SfqiQ539JFB0u+/+8YWZPE7LkhvPhzF0cTru2mlHZ
         oVjw==
X-Gm-Message-State: ABy/qLZg3si1gAmepg8ZXlJivNty42mWv4q4DQHPWCJL9i7guGwiMo5l
        UzSo2bLNCRuswNBnSPQtoVHR3Q==
X-Google-Smtp-Source: APBJJlF7zuWD7Kp6ngSgGXo2OLttXqzIQ2Sxj/NgV2Jy37GYeVH1VK7pokm/jJZBd1ud+kDxL8TYug==
X-Received: by 2002:a2e:8e92:0:b0:2b9:edcd:8770 with SMTP id z18-20020a2e8e92000000b002b9edcd8770mr138066ljk.43.1690815402023;
        Mon, 31 Jul 2023 07:56:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709060b1100b00992bea2e9d2sm6335878ejg.62.2023.07.31.07.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:56:41 -0700 (PDT)
Message-ID: <26224f81-9993-0a4c-4c46-91acd1ff5f42@linaro.org>
Date:   Mon, 31 Jul 2023 16:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-6-maso.huang@mediatek.com>
 <7d70f893-ee75-d355-4b4c-4afe7a72cd7c@linaro.org>
 <5f794f6d3595e845433aab3c48eb47ec7962c929.camel@mediatek.com>
 <ab66c8a4-6a5e-651b-8f77-047980ebc238@linaro.org>
Content-Language: en-US
In-Reply-To: <ab66c8a4-6a5e-651b-8f77-047980ebc238@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 10:14, Krzysztof Kozlowski wrote:
>>>> +  mediatek,audio-codec:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: The phandle of wm8960 codec.
>>>> +
>>>
>>> How did you implement Rob's comment? Or did you just ignore it?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi Krzysztof,
>>
>> Sorry, I did not mean to ignore Rob's comment.
>> I waited for some suggestion in mail below, but it seems Rob was a
>> little busy.
>>
>> https://lore.kernel.org/lkml/8c6316e79e40406e4d46709f602dcb14a4c00562.camel@mediatek.com/
>>
>> After gentle ping last week and receiving your advice, I thought that
>> means to send the v3 patch and might discuss dtbingding in v3 series.
>>
>> So sorry for misunderstanding it, I'll check the details with Rob in v3
>> series then refine it in v4.
> 
> The problem is that you did not reference in this patch any ongoing
> discussion and further questions, so comment looks like addressed, while
> it was not.
> 
> Rob said:
> "in a common schema and reference them "
> You said:
> "common part yaml and reference to it"
> so I think you both agreed on the same.
> 
> The advice would be to create common binding which is then referenced by
> other and your bindings. However if you start doing it, you will notice
> that it is impossible, because you have conflicting types for
> "audio-codec", so you cannot have one definition.
> 
> This leads to the point - property is probably wrong and you need
> dai-link with sound-dai property, just like most cards are doing.

BTW, might be useful for you, just sent:
https://lore.kernel.org/linux-devicetree/20230731094303.185067-1-krzysztof.kozlowski@linaro.org/T/#t

Anyway you need dai-links, I think.

Best regards,
Krzysztof

