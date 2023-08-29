Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0EF78BE69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjH2G16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjH2G1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:27:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672B198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:27:37 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 656B62D8;
        Tue, 29 Aug 2023 08:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693290372;
        bh=rV1sMffANDs2Q8NDzHSDqg3CB3HCkmpBR86pv0p8M6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iAARYR8nZKGu8YZsrOjyCgdHRpvB1wURqJ8VXtjj23fTFf/Rt8m1KHauL8baEs63t
         VNyrrHWBc3vKKZkQZ+h4DemnyC2m0Aio6JcLHRSLsPY2C2cFopYnjcVCjevLoz3Mrv
         jFd3ngQsopr3/Ise4jh1Qt2Tm+irM6KBHfqXujLk=
Message-ID: <6ecafdd1-e60a-afe6-ea2f-adab168d22fe@ideasonboard.com>
Date:   Tue, 29 Aug 2023 09:27:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/12] drm/bridge: tc358768: Fixes and timings
 improvements
To:     Maxim Schwalm <maxim.schwalm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
References: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim,

On 22/08/2023 19:19, Tomi Valkeinen wrote:
> This series contains various fixes and cleanups for TC358768. The target
> of this work is to get TC358768 working on Toradex's AM62 based board,
> which has the following display pipeline:
> 
> AM62 DPI -> TC358768 -> LT8912B -> HDMI connector
> 
> The main thing the series does is to improve the DSI HSW, HFP and VSDly
> calculations.
> 
>   Tomi

Does this version work for you? Can I add your tested-by?

  Tomi

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v3:
> - Add Peter's reviewed-bys
> - Move "Default to positive h/v syncs" earlier in the series to avoid
>    regression in the middle of the series
> - Link to v2: https://lore.kernel.org/r/20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com
> 
> Changes in v2:
> - Add "drm/tegra: rgb: Parameterize V- and H-sync polarities" so that
>    Tegra can configure the polarities correctly.
> - Add "drm/bridge: tc358768: Default to positive h/v syncs" as we don't
>    (necessarily) have the polarities set in the mode.
> - Drop "drm/bridge: tc358768: Add DRM_BRIDGE_ATTACH_NO_CONNECTOR
>    support" as it's not needed for DRM_BRIDGE_ATTACH_NO_CONNECTOR
>    support.
> - Link to v1: https://lore.kernel.org/r/20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com
> 
> ---
> Thierry Reding (1):
>        drm/tegra: rgb: Parameterize V- and H-sync polarities
> 
> Tomi Valkeinen (11):
>        drm/bridge: tc358768: Fix use of uninitialized variable
>        drm/bridge: tc358768: Default to positive h/v syncs
>        drm/bridge: tc358768: Fix bit updates
>        drm/bridge: tc358768: Cleanup PLL calculations
>        drm/bridge: tc358768: Use struct videomode
>        drm/bridge: tc358768: Print logical values, not raw register values
>        drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
>        drm/bridge: tc358768: Rename dsibclk to hsbyteclk
>        drm/bridge: tc358768: Clean up clock period code
>        drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
>        drm/bridge: tc358768: Attempt to fix DSI horizontal timings
> 
>   drivers/gpu/drm/bridge/tc358768.c | 381 ++++++++++++++++++++++++++++----------
>   drivers/gpu/drm/tegra/rgb.c       |  16 +-
>   2 files changed, 295 insertions(+), 102 deletions(-)
> ---
> base-commit: 25205087df1ffe06ccea9302944ed1f77dc68c6f
> change-id: 20230804-tc358768-1b6949ef2e3d
> 
> Best regards,

