Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51C7A7C62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjITMAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjITMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:00:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F3F0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:00:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F167C433C7;
        Wed, 20 Sep 2023 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211231;
        bh=Gpo7IFxOMHVfLfErDMr8zJLUwe68KnlMTkhGYKp8fE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+1uJB+lC0jlX5JbcWUOlg1r1lKINlxPDY4xDrERrG7jCmAomAlmnaM6e7BczxRPa
         LZyWB7DfOm6dGp/jIva0ieg6Sz4uZLG73jHECfPprSQ/1tQvOjlLUYEcVKc/Cbx3bp
         iNNtn5OqaFuz8/pS/P+jllzR4nAtPChwDhZu8fcRotIvzpHtJisUrshnem67hhaXMC
         o+/5B+D5flMcS68o1MVRyYJiNahYCULmXEnoYcOg3AWw+gD2aVNd9osc/Mb5KxnlDr
         1hxMdzuO7zCqmWXEudNau/7WEpukfHjoEiRFzOv8WHh97BNIdBoemPeRM5LpsOhVFr
         zextEa7yGmvhw==
From:   Robert Foss <rfoss@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v4 00/12] drm/bridge: tc358768: Fixes and timings improvements
Date:   Wed, 20 Sep 2023 14:00:21 +0200
Message-ID: <169521116429.2929556.5545990396411063334.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
References: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 09:50:47 +0300, Tomi Valkeinen wrote:
> This series contains various fixes and cleanups for TC358768. The target
> of this work is to get TC358768 working on Toradex's AM62 based board,
> which has the following display pipeline:
> 
> AM62 DPI -> TC358768 -> LT8912B -> HDMI connector
> 
> The main thing the series does is to improve the DSI HSW, HFP and VSDly
> calculations.
> 
> [...]

I fixed formatting warnings.

Applied, thanks!

[01/12] drm/tegra: rgb: Parameterize V- and H-sync polarities
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1716b1891e1d
[02/12] drm/bridge: tc358768: Fix use of uninitialized variable
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a2d9036615f0
[03/12] drm/bridge: tc358768: Default to positive h/v syncs
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=aa23099f4733
[04/12] drm/bridge: tc358768: Fix bit updates
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=66962d5c3c51
[05/12] drm/bridge: tc358768: Cleanup PLL calculations
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1e08e78871df
[06/12] drm/bridge: tc358768: Use struct videomode
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e5fb21678136
[07/12] drm/bridge: tc358768: Print logical values, not raw register values
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=013ea98cdfcc
[08/12] drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=89cfd50e13f1
[09/12] drm/bridge: tc358768: Rename dsibclk to hsbyteclk
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=699cf62a7d45
[10/12] drm/bridge: tc358768: Clean up clock period code
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b3aa7b34924a
[11/12] drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f1dabbe64506
[12/12] drm/bridge: tc358768: Attempt to fix DSI horizontal timings
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9fc75c40faa2



Rob

