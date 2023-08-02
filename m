Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743B676CEEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHBNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjHBNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:38:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0CB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:38:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so67918751fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690983499; x=1691588299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMJcLgqq+qsMssEfJ2CwIRiJpFGbiB0yAWJkA5kXxOU=;
        b=tuWtLApQI+lJ9MCuv940aXrM7xsyVP5NFmuEK4Pr05+2YTVnoffT80ISBeUFH2ITdU
         DsA8KS1ixGcx0g4iIB1/8h2J39Wd/iznNHJm4E8o5NwJVVOgjjJiw32i8/sKCti8uQrM
         UkEVRZeVXFSLuGAK5IYdH9QWjvsJ/tdSo1Hv2zoErgEhmxwBMxRQM+rktUTWWn8+4DWq
         nCQ8vUksJCgNv6MUec2HbR2TmVA0T7IEi0YKaOPaKmJZwckoFnWo1UNMPwguYklaCFiO
         CtmaCPxt2NS5qKbh0c0E7tiI4s+lzDWkBrCEfNScLGUf63yvPnx0XmRNXSOG2RYqthxm
         puDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983499; x=1691588299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMJcLgqq+qsMssEfJ2CwIRiJpFGbiB0yAWJkA5kXxOU=;
        b=agEPHote470x0YtbsFERq2GFdWcX1gH3DzzlvusGMz60xW2K45UrbbTDozxwu+Q5av
         L9C0Irse6pHUMXik2e/wjJmbMBGePHWKIuZdpe2K3xRhfJ+oCC09G7OeQ2wq0kmwasAi
         uIqol+TFYOmKGijG4dv5LNucC6k5sAf3OtKoJG3unyFtjE6jv0otLJh63ZKLCEtSl7oA
         1kqlQBiMAO1ugR0/pCGAkwMZZ2KPWOtR5Si/PxcPiR+kKfj68thR5QWAKf3mJNsOcYvi
         Sl0iuvSHqvTemM2k57TYHCWrUlPAPBk5GwNh7iQG650cpDZBGfK+cMnRQWKLqDrYAPvg
         t00w==
X-Gm-Message-State: ABy/qLbXt74GgEmNXBgt2SOEVgzMDaqPwnGr5EDXUJytt3ZiVwDt5K9w
        Sfen/VX5fe9gZd6ucJVGWfexzw==
X-Google-Smtp-Source: APBJJlHzyf/zEcrCxTCJVBOveSBn5qEYuzHmJSmt5lAZM8FgyvRHeoYIVOW4SGs/6XhBbP37lGkKrw==
X-Received: by 2002:a05:651c:1028:b0:2b6:a763:5d13 with SMTP id w8-20020a05651c102800b002b6a7635d13mr4864222ljm.27.1690983498799;
        Wed, 02 Aug 2023 06:38:18 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j8-20020a2eb708000000b002b9e65912cesm1842077ljo.140.2023.08.02.06.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:38:18 -0700 (PDT)
Message-ID: <5cf0e3fa-f66d-06c4-cfda-c48efd8c6508@linaro.org>
Date:   Wed, 2 Aug 2023 16:38:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
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

On 02/08/2023 11:52, Neil Armstrong wrote:
> This reverts commit [1] to fix display regression on the Dragonboard 845c
> (SDM845) devboard.
> 
> There's a mismatch on the real action of the following flags:
> - MIPI_DSI_MODE_VIDEO_NO_HSA
> - MIPI_DSI_MODE_VIDEO_NO_HFP
> - MIPI_DSI_MODE_VIDEO_NO_HBP
> which leads to a non-working display on qcom platforms.
> 
> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Link: https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #fix db845c

The boards broken by [1] are used in production by different parties 
since 5.10, breaking them doesn't seem more acceptable than breaking the 
new out-of-tree iMX8m hardware.

-- 
With best wishes
Dmitry

