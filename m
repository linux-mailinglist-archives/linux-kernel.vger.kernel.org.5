Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563B27771DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHJHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHJHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:47:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3C9C3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:47:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1c66876aso87243766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691653647; x=1692258447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhpGgdbtPxtlzBnzGvNtLx/+CntVAPL8Getc9S/EtvE=;
        b=TCouXo8hPM/jVxiHx4HiCypCk6rJQPbI9AuhBPVcn/DeoHQoGs0K/qmCBg/fXBxrnm
         x9ndiKsg6ceAeVt7oq4Ax2tf5qYsxftiA8FXg4oYaev50pnzZ0Ndp7Q5YOHJqxUNhVod
         qyQi4hFrls3IYYHvBlt23AoWpVRhRZnIhEm6+jfNyVfgIKcmJD7VmucVkf172J7NdzpT
         U497GQCzvnuf6QEpie6uMYEQDyvoVDoisfnAMpwkqdfcq6xl+xKIgUtw8M/p2sM5uLkM
         WTcUgemTcfTqlK7Yij1gZunpx3csb95oeh96TtGz7ByTAQRAZNyRkHay/kkaLS5hAU4N
         jkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653647; x=1692258447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhpGgdbtPxtlzBnzGvNtLx/+CntVAPL8Getc9S/EtvE=;
        b=Y/3f0FCJglAHRwPg5siGdfvtVLL7dkUO3DfeOR3AG0vPLo6493Y4j3ow3GQdURg87X
         hLyB/QkQtgaD55ugYYes+zmD6a94kL8f/aeOqcVGjPK9aCun8jLIoWgycF9mGppszPzs
         5zt3ZbHJ/LBnyfS7HbHYSJxcy+UPsquwofEhfMcp/b1aqBLpJb4uNbnPRWLiy4hEk9bO
         FntkxrleGb3AkIHGhWsPdhviqPQbukiPXcC0nXm5qPQXpcBOC9p0khU/OM7YKgNZ6Yig
         5fioodBP5OnP9xw+iWQcb7boF+zukSK4HRGq4Nau5UNXvJ5hzgEr5CBPlAr/BeEG+Hg5
         e18A==
X-Gm-Message-State: AOJu0YxCPWjQ8c9h7zlbNHQ9vWWof/9nwhh3FItfTiUQxVp+1Oemg4MR
        Ar4+/8sFLS1Dp6WIFMTe9o9Zog==
X-Google-Smtp-Source: AGHT+IF9zsTmioOuHxTFGoxEizbPFEc/AaHn3qyFS7Ire5UldEq2+XXEFPOCEZP4aWihn4A+p0JOyg==
X-Received: by 2002:a17:906:2189:b0:99b:cf0c:2cb1 with SMTP id 9-20020a170906218900b0099bcf0c2cb1mr1357849eju.66.1691653647608;
        Thu, 10 Aug 2023 00:47:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906385400b0097404f4a124sm560321ejc.2.2023.08.10.00.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 00:47:27 -0700 (PDT)
Message-ID: <137a734e-0e5a-5fcb-f0d3-1fdbb5e8da34@linaro.org>
Date:   Thu, 10 Aug 2023 09:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 02/11] ASoC: dt-bindings: mediatek,mt8188-mt6359: use
 common sound card
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
 <20230810063300.20151-2-krzysztof.kozlowski@linaro.org>
 <169165201641.3911557.18445521260746432395.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <169165201641.3911557.18445521260746432395.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 09:20, Rob Herring wrote:
> 
> On Thu, 10 Aug 2023 08:32:50 +0200, Krzysztof Kozlowski wrote:
>> The mediatek,mt8188-mt6359 Linux sound machine driver requires the
>> "model" property, so binding was incomplete.  Reference the common sound
>> card properties to fix that which also allows to remove duplicated
>> property definitions.  Leave the relevant parts of "audio-routing"
>> description.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/sound/mediatek,mt8188-mt6359.yaml  | 17 +++++++----------
>>  1 file changed, 7 insertions(+), 10 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 

I think the bot responds like this if the patch could not be applied.
Probably we can ignore it.

Best regards,
Krzysztof

