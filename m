Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B37D4CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjJXJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjJXJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:47:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0044DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:47:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso36537355e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698140851; x=1698745651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6MWUd7aqJU+RyKZEkGxK6HLsZy1LBZI2NHtQ/z43aI=;
        b=fHJUspksWLBRv5KXFjTYEVzCvvLZGzV3lJroX+TmNZfQJqlZbUZ65Yd9MdgSUQ3fep
         Tb/aN4OPq7PGJPbhAp1gng6gNV84rF08EdwHuYCB6LyxzfKurO5U5W0Zc+hh3vdc54Hw
         VLaKh25D1cUHICorYtHU06YJxAerjUcqiOdMMCFaKArNLsRLzdq4syCEoq4o9cqCFK6K
         KqsMhYU/aaAo1AH4sK5wRKfCQbr1Xe803vALnDYFkcKwrYViDRrpAas0Xb2FPtDzl8Mz
         MwopLtBifKOSfneo+ejg6YfDMpS2cYyR6NkFqu8V9q0z8Eu6sNps5NT3Z+zu+spetdee
         Ft7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140851; x=1698745651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6MWUd7aqJU+RyKZEkGxK6HLsZy1LBZI2NHtQ/z43aI=;
        b=DCZSE07qa2twRmOq2jV6dfAMqzNcdTIGwqTCwa9+uCgqctkry97NvQQC2sH1xJLW98
         /lXRdhpo1fvMYv0xjoj4wKVRaFZsWrUkJQGcXj9RUVHKFpeDihOmkEWdd/OosW2Isift
         Q9dP1FqEUbsEVACFgEb2HMhjHCMpfmxIAHiKpbqkisGLpS+vjRIf72UuJaoN9XxMiYGK
         A+tNIV00U7wVByT0Ktt9D077iLTN2udWdESj21+GOnK40/3sc3Ut8aT1jJ+j1fTFT6WC
         JddLq+zMMO0O90LWTh9nC8Ys7QOZLm9L0KEH95C4S3FEi7o9EywLXvYTIZXR63E/hQXl
         EUAg==
X-Gm-Message-State: AOJu0Yz6x3lJSJp1e0kofhDMCGL3zSdleRf2wVzPJpVCHVPeDAZasTJ5
        CJCEOQPDBW+VCKFOkwkLEurqDw==
X-Google-Smtp-Source: AGHT+IEQBKgigKRTPFTRZ1HUumAXzBLooE6sUMLZ71bOwGt4iZlfl+uviaSnAYq2eru3B4WrrZD2NQ==
X-Received: by 2002:a05:600c:1907:b0:408:6fae:1aae with SMTP id j7-20020a05600c190700b004086fae1aaemr6443536wmq.31.1698140851135;
        Tue, 24 Oct 2023 02:47:31 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id r8-20020adff108000000b0032db1d741a6sm9602052wro.99.2023.10.24.02.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 02:47:30 -0700 (PDT)
Message-ID: <037d24b9-38ea-4da5-a1d2-8ace4d9dfa5c@baylibre.com>
Date:   Tue, 24 Oct 2023 11:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] dt-bindings: display: mediatek: color: add binding
 for MT8365 SoC
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-3-5c860ed5c33b@baylibre.com>
 <CAGXv+5Hwe8jhgthnxwXEPezhwvhfcE=WMp_My3W8FisRagRTKQ@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <CAGXv+5Hwe8jhgthnxwXEPezhwvhfcE=WMp_My3W8FisRagRTKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 11:40, Chen-Yu Tsai wrote:
> On Mon, Oct 23, 2023 at 10:40 PM Alexandre Mergnat
> <amergnat@baylibre.com> wrote:
>>
>> Display Color for MT8365 is compatible with another SoC.
>> Then, add MT8365 binding along with MT8183 SoC.
> 
> This unfortunately doesn't match what the patch is doing.

Yeah, I fixed it for v2.

> 
> ChenYu
> 
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
>> index f21e44092043..fbf15242af52 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
>> @@ -39,6 +39,7 @@ properties:
>>                 - mediatek,mt8188-disp-color
>>                 - mediatek,mt8192-disp-color
>>                 - mediatek,mt8195-disp-color
>> +              - mediatek,mt8365-disp-color
>>             - const: mediatek,mt8173-disp-color
>>     reg:
>>       maxItems: 1
>>
>> --
>> 2.25.1
>>
>>

-- 
Regards,
Alexandre
