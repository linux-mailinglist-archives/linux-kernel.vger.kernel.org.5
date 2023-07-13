Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763137519F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjGMHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjGMHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:31:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D992684
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:31:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC0DC6607035;
        Thu, 13 Jul 2023 08:31:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689233474;
        bh=H+CV57KKU5YOchvpQhf4UeBBdOfwLF5gSkEruFhwdhg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Twd83G8qfsh7ml3i8rQVN+4JuNr7fJZYwviEPXRVYzYfgx2PcRNRJS2cpDpnjx2er
         pfidQLHN5H0i0Gxyb4TcXW2pEcVYXvWto7ANtJRM2s19jtdRIsFh1+eMJTotYaz2XM
         aL4CR/igU0n3rFXBZAkES11bWUXmovpFsMHne1QLTIq6K4u/hoLU5iaNx24f7Ncnms
         0SOy0U7a4DgLXVJynZhnSvcmzxt6E073X/hCDwnawfMIB5DAq3SlrckHi/EghDSIUX
         ObqeUkNuHdsIGFZXXr43YGsefoQZ/Vxd3oSqwWREN1uIXDomrz8ZQESPLnYumIlQ+Y
         omNfxT5Q0XDBw==
Message-ID: <52970189-dcb1-e48c-578b-4cd0679e56ab@collabora.com>
Date:   Thu, 13 Jul 2023 09:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] drm/mediatek: Small mtk-dpi cleanups
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 13:52, AngeloGioacchino Del Regno ha scritto:
> This is a small cleanup of the mtk-dpi driver, switching it to devm
> variants where possible and where it made sense, and reducing lines
> while retaining and improving human readability.
> 
> AngeloGioacchino Del Regno (4):
>    drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()
>    drm/mediatek: mtk_dpi: Simplify with dev_err_probe()
>    drm/mediatek: mtk_dpi: Switch to devm_drm_of_get_bridge()
>    drm/mediatek: mtk_dpi: Use devm_platform_get_and_ioremap_resource()
> 
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 59 +++++++++++-------------------
>   1 file changed, 21 insertions(+), 38 deletions(-)
> 

Ping for a fully ready and well tested series that I've sent *3 months* ago.

Thanks,
Angelo
