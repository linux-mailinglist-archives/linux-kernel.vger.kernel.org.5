Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591FB76CD16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHBMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjHBMj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:39:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED811272B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9338e4695so104685511fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979924; x=1691584724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu7ImHe9BF/wKqscLqA+TxdeQBiXlIVRVBMiuB/kjjo=;
        b=kKxmV3etpREz4jcInH9s4vPpD4RGAkuUPthMnVqDiu1ybF60kn4ffnk/3z7EmSkvnP
         PoU3F4F//hEFcSxYny4+R1KrHLMUhKZ7+0hlJ/EIvuKoaAesEckQAtmuys9lAr40hwqr
         B8c0MVIKvObOfmqr5daxRjfxc5k7vaGJrHLKRzzKcrLOVTzGbCSJwXQ0DVgGl+1jvrBC
         RR53Ji58al9vLfd+J4B+WvCqjkh0mKKIiwx3IsUe+tViwiEelPdF+P54tXjbEl5MMSHK
         ZfNWVgsyoawt81+ykeJExwHfkxULhLbDfgBSXN8uIh4XGlws4X9sb4MRQ/jR6wxvv6kX
         vg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979924; x=1691584724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu7ImHe9BF/wKqscLqA+TxdeQBiXlIVRVBMiuB/kjjo=;
        b=k3or6ATvgt+L9BNcfesGOXwjPKi6IMJnI0hvPfXqWrw3RGmSnTOaLehQoOvGqmrb2D
         KgZGkzr1tgZZVRNSNyXrau7e79Fjt5y107/n9iE99QwV/e2J/Mdyh8EmBC7xxDFxyRRJ
         3R5Bh8rs3GlOL8WMOW++n1LfKzu/c5O955nLu30OKnD9gxCFXRrnftORBCR5ICE5a49p
         rIj1mrM3QlFTVcEYX2Os+NknxuBhzskkUzbhi2QkGlyXRNHVsL8AcFhPK9U0Q3n2LPiw
         z4smT5rEQxLzPJwOciadrHF2wJK/srGqczgJuvG5Cii0QJMYbKajkPTqzaBCZnB2I4H1
         Qtjg==
X-Gm-Message-State: ABy/qLY6z7IkzUVy0u0Xoav2nrhbjOWgqYo4O7T7YKl6saT8qnKKM15t
        Q4QE8EfK1dREeGmYsqdzOXG4eg==
X-Google-Smtp-Source: APBJJlFXGf9zDlg/as28BI/NRgQLAjUlMBqGpkLB4hqdUr16qDL5WbwNwlGM5Qw7G2tfEqbSxJ4tpw==
X-Received: by 2002:a2e:97c6:0:b0:2b7:2ea:33c3 with SMTP id m6-20020a2e97c6000000b002b702ea33c3mr5099880ljj.22.1690979924053;
        Wed, 02 Aug 2023 05:38:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a4-20020a2e8304000000b002b6ad323248sm3570622ljh.10.2023.08.02.05.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:38:43 -0700 (PDT)
Message-ID: <ce99a777-10cc-f380-65c8-ef76843ca181@linaro.org>
Date:   Wed, 2 Aug 2023 15:38:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-GB
To:     Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <6cd079a4-2f5b-0169-cbaf-b59a72f1b32b@denx.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6cd079a4-2f5b-0169-cbaf-b59a72f1b32b@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 15:07, Marek Vasut wrote:
> On 8/2/23 10:52, Neil Armstrong wrote:
>> This reverts commit [1] to fix display regression on the Dragonboard 845c
>> (SDM845) devboard.
>>
>> There's a mismatch on the real action of the following flags:
>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>> which leads to a non-working display on qcom platforms.
>>
>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and 
>> EOT packet")
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Robert Foss <rfoss@kernel.org>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA 
>> and EOT packet")
>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>> Link: 
>> https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> This breaks LT9611 operation on i.MX8M Mini/Nano/Plus, so, NAK.
> 
> I am currently using this LT9611 with Linux 6.1.y in production and this 
> is not acceptable. I also believe the correct fix is on the MSM side, 
> not on the LT9611 driver side, since MSM incorrectly implements these 
> flags.

Up to now we saw no proof that MSM incorrectly implements the flags.

-- 
With best wishes
Dmitry

