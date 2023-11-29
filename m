Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0D7FDF38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjK2SVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjK2SVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:21:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A6B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:21:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5098e423ba2so147770e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701282115; x=1701886915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNuPgKhDMKw80uiT85WqUBhO+7U/KHdwtlx8g1D/Ez4=;
        b=dzj/PVR31C56wdQYnpVQY+D9JI3CkomWOw7np5QUwh7e8U0cE7N12Bs0znvHINPuXy
         yUIw14gd1iN08xRSe93PZxvgIzqZi1kB1WWh691jm+5vfi1BNN/kRpvNQTrOmRXGHbxB
         aplVpvtDGi9WXzZW47vK2hLnZIOtlcDrED4idJQHl8CNEMstLUdjD6zlDByuGQ3n35Kr
         DH9FB6S7Zm6znBoVq3vmA7xH/Cn8JAtM3iRaqBzOMVlkqM4xT4uaJdn0OmQyCQruWcOK
         a362eC0mf0BpHs5C5iZo1GQJzBqjy7pVxGQSYF8kqRLDRJpwl34woQqKSjzZkGSRtZ0a
         uJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701282115; x=1701886915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNuPgKhDMKw80uiT85WqUBhO+7U/KHdwtlx8g1D/Ez4=;
        b=jPhgVEGhePvaUzW9On8UwL/VlQ7b9athyfCl+OdDTezou+7iblEQ99Kk4LbEqv+08r
         25gz86G2NzWeCwXEFMYnnIEDtE26RChqqDZzMCMz7yifO3LQz3PUQNk0sCRRzBwG4qek
         qp048TbSgeA7o1tNDWItkRDfyp3JnH+Jj03zvI5tUa8E6F66zw8PfgGlazi8MxDXsiCX
         pwieWhAN3hg2RrYHmzROg9bdKPbBL6YSUUCf1aqqQN8AGs7A3ZGsm0q//GTDzcJu0kz7
         QKn7Wtn26ienpM3x2mFGRyfdCvTQqe8Y3deBpnLToZEiyHOnRd0l8crYQuh+pn5XnSv/
         kiAg==
X-Gm-Message-State: AOJu0Yzlsp1dMIodzFaw64i/PQ0Fjcj+LQ0op3egMooyu2kTjEJDPYtO
        ELVt4CdZaSbEU9sxZ55+mM2A1g==
X-Google-Smtp-Source: AGHT+IFqkXir0yMNo4WlvHXSFsKouuLysrWRfeYdK/tqF7ZvNNadMknVBKVHogi0sZlUOEooHchfbg==
X-Received: by 2002:ac2:4887:0:b0:50b:c970:cc9b with SMTP id x7-20020ac24887000000b0050bc970cc9bmr653271lfc.61.1701282114687;
        Wed, 29 Nov 2023 10:21:54 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id sd22-20020a170906ce3600b009fc576e26e6sm8119002ejb.80.2023.11.29.10.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:21:54 -0800 (PST)
Message-ID: <791d7271-87a4-4ce9-9beb-e8c3ef235737@linaro.org>
Date:   Wed, 29 Nov 2023 19:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ASoC: codecs: Add WCD939x Codec driver
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
 <ad9a7c4b-82f4-4347-b4dd-a394e4ba95f0@linaro.org>
 <42a6f6e0-2846-4cdc-8702-493fadbafb98@linaro.org>
 <eaa034cb-06e8-4204-befa-4389bcb7d9e8@linaro.org>
 <0140f49d-c463-4011-8159-f4e56466e6bd@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <0140f49d-c463-4011-8159-f4e56466e6bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.2023 16:12, neil.armstrong@linaro.org wrote:
> On 29/11/2023 14:46, Konrad Dybcio wrote:
>> On 28.11.2023 16:01, Neil Armstrong wrote:
>>> On 25/11/2023 13:07, Konrad Dybcio wrote:
>>>
>>> <snip>
>>>
>>>>> +
>>>>> +static int wcd939x_io_init(struct snd_soc_component *component)
>>>>> +{
>>>>> +    snd_soc_component_write_field(component, WCD939X_ANA_BIAS,
>>>>> +                      WCD939X_BIAS_ANALOG_BIAS_EN, 1);
>>>> All of these values are BIT()s or 2-4 ORed BIT()s, can you check what they
>>>> mean?
>>>>
>>>> Same for almost all other snd_soc_component_ write/modify functions
>>>
>>> It uses snd_soc_component_write_field() with is the same as
>>> regmap_write_bits(REGISTER, REGISTER_MASK,
>>>                    FIELD_PREP(REGISTER_MASK, value);
>>>
>>> So the 1 mean write in enable mask in this case, and mask is single bit,
>>> read it exactly like if it was using FIELD_PREP(), but even for BITs.
>>>
>>> I did check every single snd_soc_component_write_field() so far to check
>>> it matches.
>>>
>>> Or it's another question ?
>> What I wanted to ask is whether it's possible to #define these magic
>> values within these fields
> 
> OK, so most of writes are to boolean enable bits, I can use true/false
> instead of 0 & 1 for those, would it be more readable ?
Yes, I think that would convey their meaning quite well

> 
> For the rest, those a integer values to a field, those are not bitmasks
> and I do not have the definition of the values.
> 
> I did a full cleanup and tried to define as much as possible,
> there were still lot of places where not defined bitmasks we used,
> but there's still some integer values, but I think it's acceptable.
No worries, what you say already sounds very cool!

Konrad
