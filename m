Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACBE77F56F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350374AbjHQLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350373AbjHQLjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:39:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DCF10C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:39:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so5609625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692272359; x=1692877159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTEZsdCY4/ROvTDegYueu3UoNKVTo+C9n4Jn+JaTP2o=;
        b=oX5yPVth+PHIjocLUBndePdGLypDvYq2solc5BzuflSzikrFXb3kjbOOxCzeIXUOc2
         eMRRn1Y5UkU4Y7HoKz9ahfaZy2mVS5ClWAtrqtSr5TZ+Zxe/kyZM8J1YkzTb+9LS5T7c
         iEawd+lQth5ZCOZC1GA5tHDPx4dG/nU+F9hV4Rg4zFa/seAonVVXc7XYFbWzxdN7l/yi
         yZ2YYFXEsbbBOg2qRfFt9dPWobIgklKKF1O9yB5b/8u4n3ehRrRCpcqoojzhPe5mG2Ae
         KqeCVbtlKG4lP6k/0BhYNtRVHXy7GVEcVY2etFpfdOQmrcff1COpd+rvL+gcXg/Vg1+n
         yWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272359; x=1692877159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTEZsdCY4/ROvTDegYueu3UoNKVTo+C9n4Jn+JaTP2o=;
        b=Ck7SUYowm3MlELryaL7znwrTMA2cfbCVNmLewVQwtCZUsxMpYh1KfES2So6rSK5CJA
         8eFrqXN+6ZE2IBezVaooDTrdCgwfWwYxfHgB0pIBZ8DHUXOFPMwuYrzgmIGD07DNbpiz
         wFH6oqqaljCxel5JIpYrwtCdVuzEAuHI7PSYN2Q0insne+jZYV8vfJGvGjHg7Ka+hAJ0
         SZ8xm8Yc0URObS2PIV0R+y8J4rOCD1/0WeKq6yHb0Jbh7EXEyeGJMSHBhtnnjNE4QexO
         HfolKLPftWUS6SmpNN2iBmZpmr57Kjds8LKaozLxCRFRFzzfnEBxC7f0YxuqlmGHPqn1
         hF/g==
X-Gm-Message-State: AOJu0YzEcz1zTAlH7M6fiMUXQn8jxuIJwPQxR2rU75Ugx3jaJ4zzp3vP
        UEZMDeIw9IMTG8dRQVHFU90c2g==
X-Google-Smtp-Source: AGHT+IGplJUJS6D5RdP0gSy2QTohSeSR4gSIA81af/fmBPrRIPnGjoUraXeZu9PIoTjkHGZhXLeFjw==
X-Received: by 2002:a05:600c:3c8b:b0:3fe:4c29:e626 with SMTP id bg11-20020a05600c3c8b00b003fe4c29e626mr1942612wmb.13.1692272358746;
        Thu, 17 Aug 2023 04:39:18 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a23-20020a05600c225700b003fe1cdbc33dsm2749722wmm.9.2023.08.17.04.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 04:39:18 -0700 (PDT)
Message-ID: <d5393131-602f-c9ae-8ca9-1ee69479c705@linaro.org>
Date:   Thu, 17 Aug 2023 13:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <107678ff-c3d5-4c3a-ad0e-fa292a125daa@notapiano>
 <a97efd71-23e2-5ac9-8d3d-427a431353c6@linaro.org>
 <CAGXv+5EFD_yMF7q0P5rqiRWeyRqm016Or8iB0niwj26HFVp93Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGXv+5EFD_yMF7q0P5rqiRWeyRqm016Or8iB0niwj26HFVp93Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 10:45, Chen-Yu Tsai wrote:
> On Thu, Aug 17, 2023 at 4:49 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> On 16/08/2023 21:57, Nícolas F. R. A. Prado wrote:
>>
>> [ ... ]
>>
>>> Hi Daniel,
>>>
>>> just a gentle reminder. As you've just applied [1], there are no longer any
>>> concerns with this series, and it'll provide both working interrupts and
>>> reliable thermal readings on MT8192.
>>
>> There are still concerns and questions in the series for patch2 and 3.
> 
> FWIW the readout errors raised in patch 3 were fixed by
> 
> "thermal/drivers/mediatek/lvts_thermal: Make readings valid in filtered mode"
> 
> So I guess the remaining concern is on patch 2 about whether the noirq
> suspend callback should be used instead.

Yes, and the reordering of the lvts_of_match


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

