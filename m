Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4580ED81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbjLLN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjLLN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:27:13 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96567BD;
        Tue, 12 Dec 2023 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702387638;
        bh=bORQa449volAyT+EMZHJvP/KuwY9i8DhbUIZ63euxMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jzPgk9VpkKV0fyriB7dHtcuDiQiXIp7w4XYDgCGGGdxIGa7V17zVpEAa4vvK8LokN
         Y9T/mwQTVlchSTjlJfz7UOd/WS3ssJXCBtdb/f1L3UdXittnqS8CkK46Eyz3j41CUu
         O91taj9MdqhHul2r9rH5mM+QFkIRuQKINyKbAEbMU0+GcRGZSKOUgxk8M0cYr1ywfF
         T2oy8yfo3K/fqI2UlVo8WfoX+ZFteWofeBFAvnCvnLB8lrzUUa2SY/M6IiFWex+80F
         xQri1CebiCNRwW0FqRYBDujV4oT4BmHcmNaJ6CwBnfr2c1CURfiUDJkyTI4h8uevTA
         tRMMaqDCZnEBQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CD513781461;
        Tue, 12 Dec 2023 13:27:17 +0000 (UTC)
Message-ID: <315011be-59c6-42b1-be9b-cd2eaf6debd9@collabora.com>
Date:   Tue, 12 Dec 2023 14:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/17] drm/mediatek: Turn off the layers with zero
 width or height
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Sean Paul <sean@poorly.run>,
        Fei Shao <fshao@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
 <20231212121957.19231-12-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231212121957.19231-12-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/12/23 13:19, Hsiao Chien Sung ha scritto:
> We found that IGT (Intel GPU Tool) will try to commit layers with
> zero width or height and lead to undefined behaviors in hardware.
> Disable the layers in such situations.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

This commit needs a Fixes tag. Please add the relevant one.

Thanks,
Angelo

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 2 +-
>   drivers/gpu/drm/mediatek/mtk_ethdr.c            | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 10d23e76acaa..8789442c039f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -156,7 +156,7 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
>   	merge = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MERGE0 + idx];
>   	ethdr = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0];
>   
> -	if (!pending->enable) {
> +	if (!pending->enable || !pending->width || !pending->height) {
>   		mtk_merge_stop_cmdq(merge, cmdq_pkt);
>   		mtk_mdp_rdma_stop(rdma_l, cmdq_pkt);
>   		mtk_mdp_rdma_stop(rdma_r, cmdq_pkt);
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> index 73c9e3da56a7..e95331c06815 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -163,7 +163,12 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
>   	if (idx >= 4)
>   		return;
>   
> -	if (!pending->enable) {
> +	if (!pending->enable || !pending->width || !pending->height) {
> +		/*
> +		 * instead of disabling layer with MIX_SRC_CON directly
> +		 * set the size to 0 to avoid screen shift due to mixer
> +		 * mode switch (hardware behavior)
> +		 */
>   		mtk_ddp_write(cmdq_pkt, 0, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_SIZE(idx));
>   		return;
>   	}

