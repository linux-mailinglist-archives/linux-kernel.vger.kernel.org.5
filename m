Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE147B84C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbjJDQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjJDQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:17:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E0CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:17:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso3980534a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696436273; x=1697041073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IboRMXWE799EUNN9JDL2Tv/P+eapXOiA7kGcWk1PU9o=;
        b=IlSRzsL3DqY/SW22OmJ4YeSKXUvLvwbN4vNoMiyrwTgbcZ9chCoyh+zqMJeCTBKQgV
         Mp+pnrVJ2bzjqLcW1IslWt47niWIbAahgkGVIZuiElXgujWI1hrJvxyy9Z+4Hfc+pF9N
         pXbiCoGvluywE+dT6uSjmrPZiRur7h9l8ECejbrp97SW4W4/EDaar/nkFlapHLO7Wrua
         /5ppVtfo1cBMcgP1kmxsTtIgUzHWS/SJCHTDrTySoPOkQBGQr3a0oNgM53a6HfeAjAXq
         /rAUnbQP3eEWbE/RTGFSmga37ywSVZnORKs9h+jobkPLy7/Wc2Wn40d/xlwMqr7u+9wV
         RWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436273; x=1697041073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IboRMXWE799EUNN9JDL2Tv/P+eapXOiA7kGcWk1PU9o=;
        b=WpUjV2ag/tFi1OSXbExoCV0rNm9slMvYUHKsIeaTIEykhKAbia08Viz1/7denIlEXE
         KCmJ9bnyw8X7CXviqhXdtFMQmg+Z5eW9AZX5a5XzmHTX5V3O+DOv2+B4cnr719iljMpB
         TwTjLlmxd7lWo5lHieGxR+h73j1MYyKTUvEJtbInkVf5b56dCWXl70TOtoRRvSLoSYcI
         pQVU/s5t+hrJ3Vsj4XTPq4puRTwNCHcN3fXSSE+jB2YN+LNrzE1fyM99aAxt8N43bZYN
         U9ZyCVM4fT5gvRs94yiZiFgJ0hRa/WZKknRywyAPhpBJYrPN96HchbfpGA1Oltw4iRGU
         CCUg==
X-Gm-Message-State: AOJu0YyyxwUa/jxi+X5aZNYTfAB+vNNePYjqpUvJJt/R2z8hjMjcKPsl
        ZzL/exCMVc/vUV6CtZhfs0tsZA==
X-Google-Smtp-Source: AGHT+IGxOeqnR4/4kozPd8vGztjp/+DmdrVb7jcdZSkFUd46at+lIJgvhTUzH7MccQN+WduUqYwZjw==
X-Received: by 2002:aa7:c508:0:b0:523:100b:462b with SMTP id o8-20020aa7c508000000b00523100b462bmr2617775edq.5.1696436272722;
        Wed, 04 Oct 2023 09:17:52 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d151000000b005346bebc2a5sm76257edo.86.2023.10.04.09.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 09:17:52 -0700 (PDT)
Message-ID: <72fb244b-e4b8-4eb2-cb20-1d3d37f813ab@tuxon.dev>
Date:   Wed, 4 Oct 2023 19:17:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] ASoC: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>, nuno.sa@analog.com,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kiseok Jo <kiseok.jo@irondevice.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20231004-dt-asoc-header-cleanups-v2-0-e77765080cbc@kernel.org>
 <20231004-dt-asoc-header-cleanups-v2-1-e77765080cbc@kernel.org>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231004-dt-asoc-header-cleanups-v2-1-e77765080cbc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.10.2023 18:58, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  sound/soc/atmel/atmel_wm8904.c                             | 1 -
>  sound/soc/atmel/mchp-i2s-mcc.c                             | 2 +-
>  sound/soc/atmel/tse850-pcm5142.c                           | 1 -

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev> # for at91
