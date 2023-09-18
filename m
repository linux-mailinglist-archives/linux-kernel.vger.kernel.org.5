Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78D7A4544
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbjIRI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbjIRI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:58:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093DEE4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:58:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52EA16607038;
        Mon, 18 Sep 2023 09:58:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695027498;
        bh=SUXiUUTJBd6EsiVrsXV6DfZkNyX+jZm8fkuFz0ratxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FXV+c/ERhX3eMolpXIjwEvqYoyhXSTQ3ptIBGDw/n6dWDNRlQsUesqpCkr/yJ58e4
         NbGvw+XSiMGGBT26UxNpHnjEuhswjuvx+zeeQDMIbnHE6L9bG76wTTYjk2dfVyZmrp
         M/eDosVlznjzrLWp2iAEeRR5kbE2fYRKWwUy7oLQ1TRnB83GaLjiUgb4sT6cfmQ8iT
         PUC3LbPxoDJ7H9wrnA1nUMrUb+G3mixhwhrIUHo6rbNX0jEMONDRDt8tbz+dBqCsrK
         nGrlxyT6VAHSXUg3Xduhsns9tl/ULKdGrJEmf8IoHPIj5UlAJOFaVE7pqDOOuzaMcj
         uyF6dFBk5HKvg==
Message-ID: <4327d3d3-49fe-14ce-6556-31f4ccd7f02a@collabora.com>
Date:   Mon, 18 Sep 2023 10:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230918071011.18481-1-shawn.sung@mediatek.com>
 <20230918071011.18481-2-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230918071011.18481-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 09:10, Hsiao Chien Sung ha scritto:
> For CRTCs that doesn't support rotation should still return
> DRM_MODE_ROTATE_0. Since both OVL and OVL adaptor on MTK chip
> doesn't support rotation, return the capability of the
> hardware accordingly.
> 
> Fixes: df4444577118 ("drm/mediatek: Support 180 degree rotation")
> Fixes: 84d805753983 ("drm/mediatek: Support reflect-y plane rotation")
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


