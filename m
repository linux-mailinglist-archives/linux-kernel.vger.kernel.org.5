Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EFB7F5BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjKWJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKWJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:56:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1D1A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:56:20 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CF5C6607390;
        Thu, 23 Nov 2023 09:56:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700733378;
        bh=gAu++mm0U9mt5g8RN6c84qdtHW1L8vp8uMGDwrRFt2w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cYpgxRvXSU7lshcYEGilzhAYIy537CqAcQ8D/ubmzEPpgsvAdTARo54CTvvSOicjf
         RuerpVWNozkRfg9DHrHYt7jdwaNWPZyF5lgNWvPz+IlCa0HrQFp+ugT/FYkNcjTWu4
         2hC08R353s8zSVumTEgY8bSG+jxMQKWYIDTp4UFrlK4T0isEXyfekSwRukxaSZ/ecR
         jK7DyHfN+23ph+i+1biWwPba3r9qeBLgyU4QoEhiLtswXprz+31BBwsgNdiIUpHBx1
         FEzWbyxpYb+FVu9y0ktRSy71pGspK6abkZqSQQT8ybEISanVaNx/657zlGPuVeAsVj
         SGVKlwej9j08g==
Message-ID: <fff2faef-6f3c-4009-840a-3ce83db90288@collabora.com>
Date:   Thu, 23 Nov 2023 10:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: mediatek: mtk_disp_gamma: Fix breakage due to merge
 issue
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, ck.hu@mediatek.com,
        nfraprado@collabora.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231025104940.140605-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231025104940.140605-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/23 12:49, AngeloGioacchino Del Regno ha scritto:
> While the commit that was sent to the mailing lists was fine, something
> happened during merge and the mtk_gamma_set() function got broken as
> a writel() was turned into a readl().
> 
> Fix that by changing that back to the expected writel().
> 
> Fixes: a6b39cd248f3 ("drm/mediatek: De-commonize disp_aal/disp_gamma gamma_set functions")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

This was a urgent patch one month ago, and it got ignored.

Friendly ping.

Regards,
Angelo

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> index 2fada9d6c95f..52c752bc5f41 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -203,7 +203,7 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
>   	/* Disable RELAY mode to pass the processed image */
>   	cfg_val &= ~GAMMA_RELAY_MODE;
>   
> -	cfg_val = readl(gamma->regs + DISP_GAMMA_CFG);
> +	writel(cfg_val, gamma->regs + DISP_GAMMA_CFG);
>   }
>   
>   void mtk_gamma_config(struct device *dev, unsigned int w,


