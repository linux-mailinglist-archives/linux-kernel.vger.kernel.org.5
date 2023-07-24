Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646E75EDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGXIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjGXIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8B171F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA31960FCA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E84C433C7;
        Mon, 24 Jul 2023 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690188030;
        bh=C+g9lG7y+eHxmO1DwvFohayuG7Vw2U1uWFRqR4wxhvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zp+lKC9DOiigHNG7q4UTl4zLFUZ3u+UJNI538qU43plYIE2VKFmGOeZwCOSS2BZ3d
         e0l45C0PzhcsLBN6UWj1A/25BZUQ70BgTD4hItlo290nJWbMz0WGz6pHnJ54dcIfvm
         C62bJnH8MiuHNRXx7UK4PYWEM0ryG7KIrngsSzGw3aLlzPLpzdqdah9OEgees9xN2Q
         pUq06vnn8fJ03YBc9HGWqzBs03qgNBstAWgQ9Se6Y7BlVaFOYsiTAo3K7DCancBEQ9
         F/OMBfgBU5JMeLtMYsMHLEWZzT8Ry7KLMpjDqO8DBztR4FyjKSIFbEvRx7gHVZ3uu0
         DtVthmtXskZCw==
From:   Robert Foss <rfoss@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     Robert Foss <rfoss@kernel.org>,
        Pin-yen Lin <treapking@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v13] drm/bridge: Remove redundant i2c_client in anx7625/it6505
Date:   Mon, 24 Jul 2023 10:40:22 +0200
Message-ID: <169018800611.622568.1753290816240362291.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718110407.1005200-1-wenst@chromium.org>
References: <20230718110407.1005200-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 19:04:05 +0800, Chen-Yu Tsai wrote:
> From: Pin-yen Lin <treapking@chromium.org>
> 
> These two drivers embed a i2c_client in their private driver data, but
> only strict device is actually needed. Replace the i2c_client reference
> with a struct device one.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: Remove redundant i2c_client in anx7625/it6505
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d65feac281ab



Rob

