Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC3783176
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjHUTqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHUTqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:46:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499CCC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:46:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso58338241fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692647194; x=1693251994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twYIe11VURfMi70AkdnWaRrcCYBj/ZlPgX57Ec3XcJo=;
        b=A2YWsUp19BXqCHbQ86kWJjkFaYDEgSmUasbXvENrQ3zTYnAgaYVRL5NnwaCpwJoVPX
         cOAC/+dP/2nhtpvURjjZFgzjWwoD4e9Jq6BRZFYYy8sP5fSfZCS/m7wyuqVz/H7CwzVE
         Vs9s4kyrxhIkF45mHtfyLayijUXWE6emD8hjLUZ7kv4rrYP7Ez/aH3B8fMeoyBNtDF/y
         PQGnWKZY4fmQES7i2Tfre+xq4JAAUxiOcTx4sRxpATx4l8MeV+jLdZ2BluodLvww3oX7
         LLApy40ayD/f4KVPe8Wgj+H3Syq9CI7vknQAmSjwbvMUas1ZllwwHY/u4+ywcadU+eo2
         vWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647194; x=1693251994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twYIe11VURfMi70AkdnWaRrcCYBj/ZlPgX57Ec3XcJo=;
        b=PInYXfaAG3+3UWCZrRs0/gMsFxCGfY2AY9FefRYuMX1Y0UN7WBmLO12MmVUFh8m5Bg
         xLNnuuGNZwdZ3mlJie4k+xYU8yGEq2BBREVDjY8Aod7cf5sq9XeOCcEIIWan4cyj/sB3
         WgjL+Ov1B9rBNf2P8wPrEghBmzr2OFFnHb5t5chOlMw+NcoCozB/fryJqvOIm0c/7pve
         l3GFe1aXFgvw+lBNsaxEIzIJW6/KhWa4KIcKlMD6pix6KkSnhCiuRIyiijSST/06YPIl
         N2M7gtfW8QZVWr6P6dl7w0I4S+a2KIfcqYMo9YoU+oYx0ukVSZLSjz6JfE+I07cQN17F
         LQfA==
X-Gm-Message-State: AOJu0Yxn2cIK4SUReyi3jvD/7CMidnbHqfFZsHHH2vDmrWykVaXvjP6l
        awOgsF2wmxM7lFqi2J8+W+s=
X-Google-Smtp-Source: AGHT+IHDWeE8l4/UcKsCVtzoTD6z0PhdM+PlACh9d0iDsqCqrpOiD2jkNzBa8zUD/7Xzp/cDvOWRjQ==
X-Received: by 2002:a2e:8295:0:b0:2bb:aaec:abad with SMTP id y21-20020a2e8295000000b002bbaaecabadmr5360070ljg.30.1692647194102;
        Mon, 21 Aug 2023 12:46:34 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e9691000000b002b9ebdf70b7sm2440313lji.27.2023.08.21.12.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 12:46:33 -0700 (PDT)
Message-ID: <5822a76d-6f63-4bf6-a102-e1341aa4db45@gmail.com>
Date:   Mon, 21 Aug 2023 22:46:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] drm/bridge: tc358768: Fixes and timings
 improvements
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2023 14:25, Tomi Valkeinen wrote:
> This series contains various fixes and cleanups for TC358768. The target
> of this work is to get TC358768 working on Toradex's AM62 based board,
> which has the following display pipeline:
> 
> AM62 DPI -> TC358768 -> LT8912B -> HDMI connector
> 
> The main thing the series does is to improve the DSI HSW, HFP and VSDly
> calculations.

Thanks Tomi for the updates, I cannot test it or verify against the
datasheet, but codewise the series looks nice:

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
>  Tomi
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v2:
> - Add "drm/tegra: rgb: Parameterize V- and H-sync polarities" so that
>   Tegra can configure the polarities correctly.
> - Add "drm/bridge: tc358768: Default to positive h/v syncs" as we don't
>   (necessarily) have the polarities set in the mode.
> - Drop "drm/bridge: tc358768: Add DRM_BRIDGE_ATTACH_NO_CONNECTOR
>   support" as it's not needed for DRM_BRIDGE_ATTACH_NO_CONNECTOR
>   support.
> - Link to v1: https://lore.kernel.org/r/20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com
> 
> ---
> Thierry Reding (1):
>       drm/tegra: rgb: Parameterize V- and H-sync polarities
> 
> Tomi Valkeinen (11):
>       drm/bridge: tc358768: Fix use of uninitialized variable
>       drm/bridge: tc358768: Fix bit updates
>       drm/bridge: tc358768: Cleanup PLL calculations
>       drm/bridge: tc358768: Use struct videomode
>       drm/bridge: tc358768: Print logical values, not raw register values
>       drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
>       drm/bridge: tc358768: Rename dsibclk to hsbyteclk
>       drm/bridge: tc358768: Clean up clock period code
>       drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
>       drm/bridge: tc358768: Attempt to fix DSI horizontal timings
>       drm/bridge: tc358768: Default to positive h/v syncs
> 
>  drivers/gpu/drm/bridge/tc358768.c | 381 ++++++++++++++++++++++++++++----------
>  drivers/gpu/drm/tegra/rgb.c       |  16 +-
>  2 files changed, 295 insertions(+), 102 deletions(-)
> ---
> base-commit: 4d49d87b3606369c6e29b9d051892ee1a6fc4e75
> change-id: 20230804-tc358768-1b6949ef2e3d
> 
> Best regards,

-- 
Péter
