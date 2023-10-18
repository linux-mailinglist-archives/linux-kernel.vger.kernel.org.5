Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2677CD923
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjJRKYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjJRKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:24:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F61B4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:24:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B32BF66072F7;
        Wed, 18 Oct 2023 11:24:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697624665;
        bh=uHLAE7NLmQVbBRFl49l71ZZ0a4YX4vaL+aj4ZDekqUg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FYiWQKGYS6VICc8IcmuQq3Q4mMEoZyCIlkCfVc9mBT+AMMX0CvXg2eY5Cy/jE5Tyd
         ADtS+aWoVPTKR3FnhcL54PTL9rV1RdgeTwWF480HaZQNvkwxAFT1MGB4F6v1LTgvVQ
         uPfLqJjGhpKdU0tT+Bx89aK2th25X3F64TXR2OwTU02vt4cCbBPdEUV6Egd0x2C/BZ
         fE54WJFpx2T1ctFqOGWzkFq89Hbs0onoNRKA7UInio6E7eipnUOqIinOSeFQT9PjKe
         OpooGiiAOt6Yh3AmOzqhZriVK+VZkFYG+3D85+auNAtVNeXt5CKZKXUFxIqo7JOR85
         hQKbXsaGlCmLw==
Message-ID: <85277960-8c6a-485d-8dd4-9c1eb37f5818@collabora.com>
Date:   Wed, 18 Oct 2023 12:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] MediaTek DRM - DSI driver cleanups
Content-Language: en-US
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Alexandre Mergnat <amergnat@baylibre.com>
References: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/05/23 11:34, AngeloGioacchino Del Regno ha scritto:
> This series performs some cleanups for mtk_dsi, enhancing human
> readability, using kernel provided macros where possible and
> also reducing code size.
> 
> Tested on MT8173 and MT8192 Chromebooks (using a DSI<->DP bridge)
> and on MT6795 Sony Xperia M5 (DSI video mode panel).
> 
> Please note:
> This series depends and can be applied only on top of [1].
> 
> [1]: https://lore.kernel.org/lkml/20230523104234.7849-1-angelogioacchino.delregno@collabora.com/
> 
> AngeloGioacchino Del Regno (4):
>    drm/mediatek: dsi: Use GENMASK() for register mask definitions
>    drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
>    drm/mediatek: dsi: Use bitfield macros where useful
>    drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
> 
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 198 +++++++++++++----------------
>   1 file changed, 88 insertions(+), 110 deletions(-)
> 

Hello CK,

this series still applies and it's a nice cleanup.

Is there anything wrong with this? Can you please check it out?

Thanks,
Angelo
