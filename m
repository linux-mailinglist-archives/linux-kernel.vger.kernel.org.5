Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690157D4A78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjJXIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjJXIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:37:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54A120;
        Tue, 24 Oct 2023 01:37:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F2036607324;
        Tue, 24 Oct 2023 09:37:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698136666;
        bh=b3hTgipRW+886R6FBsLygN4L72yjGIgmU9zLWuzpo3o=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Xd+v3I16W7Ru4Jf3AYHTV0CFW5XwhEBZqYtNMSHps/DrHYiBAu3MCvYI7reaWAV4u
         yfqjXYbzv6fWT9WUkubjxVMRv7/GWj4AcakbfAXbLZICEfUOwWZMpxA0gY7Pzx9o8Z
         1YHE9FhQ+Jr9g6VZRlLWHjNcK9RJeTMdVMSqGY3lwM5S/X2cRWoBweSyIlxVtuQkiV
         yTVQ0p9eyCfKgcUCdSman/gaGB9k4C65WQbiMd1PEtkgxUqcPwYEslUIQtkTNVfcYb
         5/inotH8/Z8UygntUeEr59+og5ZcyW7B0ihRjgJq5fnSSZLzHxalFEKuWUUegzXK5h
         wBP0SD7+L2GMA==
Message-ID: <e3198dd5-48da-498c-9f21-4f6845b37675@collabora.com>
Date:   Tue, 24 Oct 2023 10:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 05/11] drm/mediatek: Add mtk_ddp_sec_write to config
 secure buffer info
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
 <20231023044549.21412-6-jason-jh.lin@mediatek.com>
Content-Language: en-US
In-Reply-To: <20231023044549.21412-6-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 06:45, Jason-JH.Lin ha scritto:
> Add mtk_ddp_sec_write to configure secure buffer information to
> cmdq secure packet data.
> Then secure cmdq driver will use these information to configure
> curresponding secure DRAM address to HW overlay in secure world.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 12 ++++++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  4 ++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 771f4e173353..3dca936b9143 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -111,6 +111,18 @@ void mtk_ddp_write_mask(struct cmdq_pkt *cmdq_pkt, unsigned int value,
>   #endif
>   }
>   
> +void mtk_ddp_sec_write(struct cmdq_pkt *cmdq_pkt, u32 addr, u64 base,
> +		       const enum cmdq_iwc_addr_metadata_type type,
> +		       const u32 offset, const u32 size, const u32 port)
> +{
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	/* secure buffer will be 4K alignment */
> +	if (cmdq_pkt)

	if (!cmdq_pkt)
		return;
	cmdq_sec_pkt_write....

Regards,
Angelo


