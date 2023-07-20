Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718075AB12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGTJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:39:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2AE26A4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:36:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso786017a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689845760; x=1690450560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbEixaOkxNJN74ak67fuMAe8qbP5jIXA+BkpUoZ/+vw=;
        b=DyBZCxUTKXm94FjQXQ7w8jrcELARpqFqL+Kg0e7f1vQIwD46ODVgs6YOY8OpfvDtAR
         KTDMJxfZqdo2XWn2fRr44udKWcP9k6VxBv7qTq9MQMSKPNr00WULucw30rJPezx7HU+r
         9oVqxAFlbNjB1i9UED2nkTueAVo5545WyqLFfUK1TvY6e+XOQoWL4hGOsYCirnhmKLxA
         GlvPrr6FtX/2aXYd5+c3sl4mDhH8MBSOnopNn+29pHLiEIPi6z9naAV74MRxqYKTa+WD
         vkGkyObwNkpGgXAnJ/Mmkmw8KxqrfFSmpXy7v6un9wZLIBGgDA/OBufg14vk9r9uEFOc
         l5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845760; x=1690450560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbEixaOkxNJN74ak67fuMAe8qbP5jIXA+BkpUoZ/+vw=;
        b=cHE88VvqNLKIdmdSlHzDALfD/81wVEM5b9bQDRfUU8Z9sfJCKfpsvuuScCYhpbEkOL
         OW8b+LqxSJv9Fz5l0VvtNo3JnaznTXGEo98pndxco4Q3B1rpwq6RTtJt4xGv5FgzikIv
         rhPrfGRyIkUFs1SVBkLsVla1gISWaocV5dYiv5UwRXLV4Zx3r5+uEZJ3dayj5p0nLgmy
         To+ef0y9wdUgXaudG1vZKNkXDLcn0b7KDsKcrpoAFyYi+qv22CAPIs7XQEJO8o9YAVht
         78szuk/l0FR/KpcSnhBnsj9ShnVDquHZRLRYH+uYJEsUFu1zUQnR+mHVoOf8PC3iM5z3
         VByA==
X-Gm-Message-State: ABy/qLaXpK4QjyRyLoqwr+84obyJ89pa+fhGm8G7DSc38PGuTnB7MRvP
        LuRRzWPdo5dYoUosLCuHdUpvPw==
X-Google-Smtp-Source: APBJJlHdcqWTCi4MqbmDQdedPbHXGtLDE+1AHMjwt6QtLxsX6n9wzm9peAh8UPM3H/gm2b/+7s6XsA==
X-Received: by 2002:aa7:d7d1:0:b0:51e:ebd:9f5b with SMTP id e17-20020aa7d7d1000000b0051e0ebd9f5bmr4608092eds.36.1689845759752;
        Thu, 20 Jul 2023 02:35:59 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7cb51000000b005217a24addbsm489507edt.20.2023.07.20.02.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 02:35:59 -0700 (PDT)
Message-ID: <2e497eb2-f927-90bf-daf4-684d6aa0fbd6@baylibre.com>
Date:   Thu, 20 Jul 2023 11:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3,2/3] drm/mediatek: dp: Add the audio packet flag to
 mtk_dp_data struct
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230720082604.18618-1-shuijing.li@mediatek.com>
 <20230720082604.18618-3-shuijing.li@mediatek.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230720082604.18618-3-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 20/07/2023 10:26, Shuijing Li wrote:
> The audio packet arrangement function is to only arrange audio.
> packets into the Hblanking area. In order to align with the HW
> default setting of mt8195, this function needs to be turned off.

-- 
Regards,
Alexandre
