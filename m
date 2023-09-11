Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FB79A34E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjIKGIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIKGIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:08:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C3126
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:08:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401da71b85eso44209335e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694412481; x=1695017281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znV8c1nZy2khF5/iHvM02K3LRI4Usqz/zkO1WU9q06M=;
        b=YAMKnKbSX5WCsl0XXpfPHDg2uAuHDeFTYkEME6roHSzKYifHx+y1PJ9ABftUK+ZLeK
         JImeM2Pz25h36rpbRx6yq67vKrSVJdBV7SZh1HfDk1uxfu8+lKBRcxc/uxtoZN2al0J7
         jz3A9xK+2TgUI6BbdhWjRhrhL9jnrdf3zSyA0lf5A0pvtvfLFbRMSP8Nq41zIgprZOXF
         kqwtgRhxqtEDmAw8EbEmJPRf9lxG5Y4CSZd948n8HXUMzeN4NC7T3ywBLrbtdol4wX/S
         3cac/wqJor3hE1HIASHRX9noSCBFODnfhbRi8TgRT82A0IutTUMbjFqazH92dOaRdqKF
         dFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694412481; x=1695017281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znV8c1nZy2khF5/iHvM02K3LRI4Usqz/zkO1WU9q06M=;
        b=CSQmSK926TIwLU7NGnVJokpj3xrU6FGdVnP1LrLE3FnenAsxRciZ+cZadwChOvgEJ2
         kTDJ09GAZG7LGPQ1uvIjtFvseVUxrCWwamoFs8IvGksqTfZs7cBcn9BjniEktqTicJr4
         ksY+TSRZNumFlqvsZm2Kqh+RB7zCZYzOxsR401pknCCY3o2I91CxkwdnLj2FV4J5lHhO
         DTiYssdx7o8LAHxQkMoWAqQHBkUua7Tq8/8i+pHO/Sh0F3N2HpDBG+GHSsmrXmEie/09
         zTkZROBcJ3ECauPXmGb+2wAJxgPuEZKxYAW9ACq0DzpVUJlvpDdg4OG57SoLFfhvXR6H
         29GA==
X-Gm-Message-State: AOJu0Yy3aqJWAdGcR/x3REC1/K1lSPqFulgXEDDp1V95COyjXT9kav4X
        /Lr7trAk9vi0aS7kXDVmXYBBqw==
X-Google-Smtp-Source: AGHT+IHMyTBUANYOv0uuLp74+1jLiLUu+Hfx5s3BwTAkzuzS/yebG+o7dj4lGFDQg2Xg4Mlst3xdFA==
X-Received: by 2002:a05:600c:5128:b0:402:f501:447c with SMTP id o40-20020a05600c512800b00402f501447cmr7275655wms.0.1694412480731;
        Sun, 10 Sep 2023 23:08:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c218600b003fe1c332810sm12125267wme.33.2023.09.10.23.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 23:07:59 -0700 (PDT)
Message-ID: <fc4bd212-c112-0d42-e94c-c3ba569d2d32@linaro.org>
Date:   Mon, 11 Sep 2023 08:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230909132819.21626-1-macpaul.lin@mediatek.com>
 <2318be3d-5687-8b6c-3669-1d2ae1c94d2c@linaro.org>
 <946ee1c5-77af-3ce0-83ba-2966fab70a5f@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <946ee1c5-77af-3ce0-83ba-2966fab70a5f@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2023 14:23, Macpaul Lin wrote:
> 
> 
> On 9/10/23 18:56, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do nost click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 09/09/2023 15:28, Macpaul Lin wrote:
>>> 1. Add compatible for MT8395.
>>> 2. Add bindings for the MediaTek mt8395-evk board, also known
>>> as the "Genio 1200-EVK".
>>>
>>> The MT8195 and MT8395 belong to the same SoC family,
>>> with only minor differences in their physical characteristics.
>>> They utilize unique efuse values for differentiation.
>>>
>>> The booting process and configurations are managed by boot
>>> loaders, firmware, and TF-A. Consequently, the part numbers
>>> and procurement channels vary.
>>>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Changes for v4:
> Changes for v5:
>   - No change, update Reviewed-by tag only. Thanks.
> 
> The explanation is here. The version v4 and v5 are the same.
> For sending v5 is because "Patch v5 2/2" has been updated and these 2 
> patches were in the same patch set. I think to update the whole patch 
> set together with a single modified patch should be a usual operation.
> Did I miss anything?

Yeah, like not top-posting.

Why do you change the same line in other patchset?

> 
>> Confusing. You just sent a patch changing the same hunk - adding
>> description, without any explanation.
>>
> 
> The marketing naming rule of MediaTek SOCs are usually confusing people. 
> I guess the previous patch just confused you. Ha.

?



Best regards,
Krzysztof

