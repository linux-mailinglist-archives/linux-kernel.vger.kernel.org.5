Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F679D1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjILNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjILNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:10:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E110CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:10:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so6777488a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694524218; x=1695129018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkg4dOxircu0CypR4iVJaC4UA5MgleI1a7GPOXfeFc0=;
        b=e8xVoYnNoPWWEOhgclw8Xn+E5HMqVmPzPy+iT/2nOtMUw9RO+kHFoxe5FAejyWFyuJ
         wZHcgUnu2/XqrvpfKhuRpMT+q/ZMtTdOCa8fBVkKvrTSLK/jEn1RhvHNRv5zuRPkRI+K
         0lFbkihY37FtgN34IHa09l395N2w3mfmVc0J3P16nz2jnLqwvMNUMUdhrgL3rfwZJejy
         M/qY8ywu0DzNHTMfnKvBs8G6eCIGyy6Mv7LRfC3CoYUZA098euFUs2cqwSddvtyQZ9be
         l8aCK2vaf4ii1HUrEwHR4r97MBPQwVrwTOf4uo544pYHQ6P8J+H38lilCS8QbpxgVdqt
         VnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524218; x=1695129018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkg4dOxircu0CypR4iVJaC4UA5MgleI1a7GPOXfeFc0=;
        b=TFB92b92oG+XyXchR3E4ViRsrkjTIEbeG4Lh/F3oEtI7oBWjHlBE8AlIl5FXdLA14h
         Sng6jS3GSrwhGxxtwIso/cuSbk+fmFTznuhpctXmitZK6EZl4do0mgrUNZX5RIE0BXLm
         tlGtzwOfOqfVaUCUfWzzPmKzfruo+rNoNnRdxHalIJQfx9fxl1bVKJirpBn5B4wLaEzm
         9L4B4Od0gT+uQhm8gZQdN6wIeZhmInysSJiSo0CAlghdh6sYUiVN6C9Fi5HntihQgioO
         l4a8sDIxGCqwQGz68FAZiXd3Fvav5GkX66lmJ01Npb5C+0ZsSwV+pgWVuQEnzFLLnJ4U
         1uBw==
X-Gm-Message-State: AOJu0YzDXPMZOPlCQUtdfG0aFP+iJPzgvWT9JHc/37Rob5s0fLP+AQpp
        SSgisPjFfbkTaAC643WjQnwJZw==
X-Google-Smtp-Source: AGHT+IF9FtG/P/CA2bdUyaN9tNAyaXDTWKcSZgO8Knq6251cqFC3kMveGTT42yqBJk4qwEUbkIX6tg==
X-Received: by 2002:a17:907:2cc9:b0:994:577:f9dd with SMTP id hg9-20020a1709072cc900b009940577f9ddmr9981438ejc.9.1694524218002;
        Tue, 12 Sep 2023 06:10:18 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906338e00b00992b1c93279sm6758341eja.110.2023.09.12.06.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:10:17 -0700 (PDT)
Message-ID: <4c99c180-3b79-6aef-6ff2-d430e575957d@baylibre.com>
Date:   Tue, 12 Sep 2023 15:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH] arm64: dts: mediatek: Fix "status" values
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>, soc@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20230804225813.12493-1-robh@kernel.org>
 <f8759d51-f808-8082-ceaf-6c6dcaebe2d9@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <f8759d51-f808-8082-ceaf-6c6dcaebe2d9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2023 14:54, AngeloGioacchino Del Regno wrote:
> Il 05/08/23 00:58, Rob Herring ha scritto:
>> The defined value for "status" is "disabled", not "disable".
>>
>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Arnd, Please take this directly I guess. I think Mediatek maintainership
>> needs some help. Maybe AngeloGioacchino should be co-maintainer as
>> that's the only response I seem to be getting.
> 
> Sorry but I've seen this message just now as I've been on holiday in 
> August.
> 
> Thing is, the MediaTek scene is starting to see more and more code, 
> bringing
> an obvious increase in the amount of reviews to be done and in the required
> efforts to maintain the MTK bits - and we will possibly (hopefully) see 
> even
> more of that.
> 
> If Matthias needs/wants a co-maintainer for MediaTek I'm here and I will be
> proud to become one.
> 
> Cheers,
> Angelo
> 

I started reviewing MediaTek patches for some months now, so I'm still 
new. From my PoV, I'm agree with Angelo when he say the amount of patch 
is increasing. I support Angelo if he wants to become a co-maintainer 
and continue to do my best to review patches. ;)

>>
>> I think for future .dts patches I will not bother splitting them up by
>> sub-arch because it's a pain to chase down the maintainers to apply
>> stuff in a timely manner. /rant
>>
>>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts 
>> b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
>> index e4605d23fdc8..86cedb0bf1a9 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
>> @@ -585,11 +585,11 @@ &pwrap {
>>   };
>>   &sata {
>> -    status = "disable";
>> +    status = "disabled";
>>   };
>>   &sata_phy {
>> -    status = "disable";
>> +    status = "disabled";
>>   };
>>   &spi0 {
> 
> 

-- 
Regards,
Alexandre
