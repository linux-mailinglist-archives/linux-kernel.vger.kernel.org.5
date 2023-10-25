Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12C17D63BD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjJYHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjJYHoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:44:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350411BEC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507be298d2aso7842406e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698219345; x=1698824145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBbMMGXhgW9dj85vLrlAsi/scxI5pUmqL1hVksSIORg=;
        b=yK9rF/SY2yK1krSgnPghSkFbqcU6sG9vgvEiHjZwGUpJN+IrGyKqEfRIuQ6Or6/5m0
         TGqC9PqJRXetnndOmM3afx516YOzH9AiWnUTsCJFh6teb9gkhyTLEHENLj3ckpCVrPO1
         NG97PVYojzYt+6X3cRR7YLrPSSHWbvLf73csO5fXlnch7xw87pqsrOnv47qCFV8NR65V
         YQTBKza1qDJJh7Zxmr7H10sxReXwcAqghNVhJHhte9aWRyKp/+xHQl+gSKSszK68BK9E
         +XYKGdUD3sl+Q2+crd75oPZe3EyPFghTRNOeP8yszcyi8r2S17EZcBwoo69OrEi2Xt88
         o0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219345; x=1698824145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBbMMGXhgW9dj85vLrlAsi/scxI5pUmqL1hVksSIORg=;
        b=AMvIsfDKesvjQnFROAoQO9Z8Qf4EP/uR4G8XJX2HdFjDBX5ymfmDYrsOlxlNPRekMW
         T8w8hGM271yufJvoqEfypqbmTrKFnr+8IpFE1vu6u1dCoNXtTwZ9kBElIAIloswKVrww
         +/QTpRvZnQDCbx+WQIbxPlR2fWHQAUDtbWKhuacQJQ+ZxvTbilmuycEzBM1p15BNuXS+
         oY0TQnKxuMjqKPOayOafQtDgjGntCjQhbpVy643x5cHE4Jnl6+7+k0m5LgO6PoCnWMw7
         3MBlPRND0iTdq5qi/RfIBY3/Phs2XofDzA8V+8unyzKaAJE/MurHMpElTjvVAnwkA43K
         lKVg==
X-Gm-Message-State: AOJu0Yy3rth+ExG+78fCOzxylWF2Upd4KfK2OMMlRHK4EhvJx3sHpOo1
        wvDReFseBTE8qE7H8bmSa83UzA==
X-Google-Smtp-Source: AGHT+IGfDcK6b789W6RGHEquV5YMHBAiCzfv/Rctz+XtFqNQN0vhdNvDDXE2hLiVtblka3kNhM2IfQ==
X-Received: by 2002:ac2:5147:0:b0:507:9777:a34a with SMTP id q7-20020ac25147000000b005079777a34amr10168194lfd.39.1698219345170;
        Wed, 25 Oct 2023 00:35:45 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003fe1fe56202sm13962243wmq.33.2023.10.25.00.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:35:44 -0700 (PDT)
Message-ID: <d7d40b45-ca7c-4f84-bdb3-02555094126b@baylibre.com>
Date:   Wed, 25 Oct 2023 09:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] dt-bindings: display: mediatek: dsi: add binding
 for MT8365 SoC
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
 <20231023-display-support-v1-5-5c860ed5c33b@baylibre.com>
 <20231024203010.GA518520-robh@kernel.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231024203010.GA518520-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 22:30, Rob Herring wrote:
> On Mon, Oct 23, 2023 at 04:40:05PM +0200, Alexandre Mergnat wrote:
>> Display Serial Interface for MT8365 is compatible with another SoC.
>> Then, add MT8365 binding along with MT8183 SoC.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
>> index 12441b937684..2479b9e4abd2 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
>> @@ -34,6 +34,8 @@ properties:
>>             - enum:
>>                 - mediatek,mt6795-dsi
>>             - const: mediatek,mt8173-dsi
>> +              - mediatek,mt8365-dsi
> 
> Not valid YAML nor json-schema. Please test your series before sending.

The serie has been successfully tested with the 2 following command 
before being sent:

make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=mediatek,dsi.yaml

dt-validate -s Documentation/devicetree/bindings 
arch/arm64/boot/dts/mediatek/mt8365-evk.dtb


I made a rebase error, that will be fixed for the next revision thanks.

> 
>> +          - const: mediatek,mt8183-dsi
>>   
>>     reg:
>>       maxItems: 1
>>
>> -- 
>> 2.25.1
>>

-- 
Regards,
Alexandre
