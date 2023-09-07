Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032B7976D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjIGQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbjIGQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:16:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CD49E1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:15:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 692EB6607313;
        Thu,  7 Sep 2023 13:33:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694090012;
        bh=jc2UvrrZDMDCN5bgnaY8vkhBi8ZpUIWYdaEXMG6s9sU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ui7b2zrJo+ssZiDi9E0vSrxlBE+DazJqtVv8lC++DLGn3kP2QFt9S0NBGWTCFsDBV
         wfAd0PoXN9vSyq0IzSvVYYSe4fa9owZ7t9H3JvmZGJiQr0W2DK0Nd4Yaqkms5lhcVk
         TY6nYQ65XHqIEvcYUQ7C+gQW09HtuPCtw+Hz7+eQZ8b4BO7eVlQkPUFNQS1r8100eQ
         SnNPPmmuVL8ABKvtEV8jwCqkiz2yIS0bboCiCofOsU9w6A8bAXK4nkUU0uDXW7D2VG
         UEeggcXvChnEazxC5AetBiLaFE+xIem71kWye8nN0LsAec+EoUeKLgQ1/WXtvYzSPV
         CueDkq31ZquCw==
Message-ID: <d43e0d7b-1e93-f9ae-df3f-cbf8a3381a70@collabora.com>
Date:   Thu, 7 Sep 2023 14:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 13/15] drm/mediatek: Add missing plane settings when async
 update
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
 <20230823151332.28811-14-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-14-shawn.sung@mediatek.com>
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

Il 23/08/23 17:13, Hsiao Chien Sung ha scritto:
> Fix an issue that plane coordinate was not saved when
> calling async update.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

 From what I understand, this is a fix for an issue that was present before
your newly introduced code.

This means that you want to add a Fixes tag, and that you should also send
this commit separately from the IGT series. Please do that.

Thanks,
Angelo

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index ca22d02375d5..dc19827f6927 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -210,6 +210,8 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
>   	plane->state->src_y = new_state->src_y;
>   	plane->state->src_h = new_state->src_h;
>   	plane->state->src_w = new_state->src_w;
> +	plane->state->dst.x1 = new_state->dst.x1;
> +	plane->state->dst.y1 = new_state->dst.y1;
>   	swap(plane->state->fb, new_state->fb);
>   
>   	mtk_plane_update_new_state(new_state, new_plane_state);

