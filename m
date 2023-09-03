Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2F790F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjICWjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349120AbjICWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:39:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD1C4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:39:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so629271f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780744; x=1694385544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCW5fhzFPO36VkzYsA4ot6wHveFpsnR8+rOVU4lQ1Wc=;
        b=trFWq8yv8zyFWOeEtHB2fLfgTz9T4pjH2KyvPJtKoZ+SLLwWtvIZNd0hLm/2Vkp+XN
         dMXBxmZRd+h2AoYcLFKRjCvmTlOSj4JEssIwzO1YU5iCfMbTV5yYwVtU9SxhTRt/FjVh
         NAhy3mZekPXF5SLX0LkBFNWnjWvklZdX/FT8HULSOZp02pCBJV0ojtM9mDU9PLv6iYsY
         bun1wuZtu28tq8SakvEjgIFRhZHcGSvaCnB1/kUmCrdKgLVh+IlVvBs+BH534pRFoZ5G
         ykywFrgmte5GluMhg2Z6yQ1eXF87koZWVhtr7/VBVvJ5pm4vBSVOGL+DBNOob1Bu7Yqw
         eQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780744; x=1694385544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCW5fhzFPO36VkzYsA4ot6wHveFpsnR8+rOVU4lQ1Wc=;
        b=Nz8tJmO++NF+gTixqD8mte3qd6xoDicaNb4J3wdPqrGhnzrvWcpMWuXnxc+owf1xn8
         92o4rGIU+qgEw6LHbzb5SFZOB4s6PeIyrsprIGzsczJbp5ZD9+1itQHEEDMftdcelhfp
         1wObx8Sg6sEaxuHISVzoGAzlyQUoDun6+bgrehfNDpmzFZ2DGNCSKlG7FUQeM7vjRVDx
         KKeBmRzJqp8V0JwRHGPf6epr4qTAkYKZagiTFm6UtgM/3ReXeCS56wzpIr7yefCZ9tcv
         G8yqutrmoEW78mqCD2XpbPoZ1xN5jhfBqF52O5J7WXFSbO07UCoY2EERnOdCfHTFOTns
         y1MA==
X-Gm-Message-State: AOJu0Yzxxw/1q1J2SFO1yVwOPd7o3sHNtUkTjHiLjBZ+7D8BvonO03ZS
        9ZzYc2mVqDkcL8Eb04GHqDHmCA==
X-Google-Smtp-Source: AGHT+IHC4LmuKmR0sAciVcZpljh/BF5lACIe0GOW90jgSls+WPgeE839R/LmWZIlDExfc1NZ5qUZvw==
X-Received: by 2002:a05:6000:1749:b0:31f:3cfd:c700 with SMTP id m9-20020a056000174900b0031f3cfdc700mr2629921wrf.32.1693780744491;
        Sun, 03 Sep 2023 15:39:04 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:39:04 -0700 (PDT)
Message-ID: <db42e1b4-3ef7-4af9-80d2-23d84ec5f8dc@linaro.org>
Date:   Mon, 4 Sep 2023 01:39:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/msm/dp: Remove dead code related to downstream
 cap info
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230829184735.2841739-1-swboyd@chromium.org>
 <20230829184735.2841739-4-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-4-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 21:47, Stephen Boyd wrote:
> We read the downstream port count and capability info but never use it
> anywhere. Remove 'ds_port_cnt' and 'ds_cap_info' and any associated code
> from this driver. Fold the check for 'dfp_present' into a call to
> drm_dp_is_branch() at the one place it is used to get rid of any member
> storage related to downstream ports.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 25 +++----------------------
>   drivers/gpu/drm/msm/dp/dp_panel.h |  6 ------
>   2 files changed, 3 insertions(+), 28 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

