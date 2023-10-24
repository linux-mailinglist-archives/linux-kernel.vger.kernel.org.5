Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47A87D4A83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjJXIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjJXIh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:37:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C4E10C0;
        Tue, 24 Oct 2023 01:37:54 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D30766072F1;
        Tue, 24 Oct 2023 09:37:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698136673;
        bh=zP6vOilkZ0sm+tw53oGfhBi7YFiKClwvxIzUr5yGLpI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=LGQgRQS/VTjZqKg/j9fomOFt2RWMhGEpZj0kzuxJI55ULzIweIUjZP5mnTXgqDeZX
         Ej/PRdJpmMO3gkPKa6lcfdmKxDHBGwpXvSW+482Kd5mNonPFPeXMq/sT+/+tz8C8YN
         /AsrD2dDo08jvpbXFgBIUGsa5P8OqbmnLVC5SpqAS7E+s9imGhmIlYS2ve205xKoK1
         ICMBBSUe4Bk31NVDn0LBa6/jMlBu8LZGHTNAxodVafW2gRHiIfzGHDJVFbiLVUzXO1
         0wkLr8OpBYK6Fe9FisOI2qsEgdmCFfPIjnw/xmI69sV3QmKVCa7x/yKZHlMAJxOkQH
         eU46ccydvDnMA==
Message-ID: <f7fa1c3c-8233-40ab-858a-fdf8a2117a04@collabora.com>
Date:   Tue, 24 Oct 2023 10:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 02/11] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATED_ENCRYPTTED flag
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
 <20231023044549.21412-3-jason-jh.lin@mediatek.com>
Content-Language: en-US
In-Reply-To: <20231023044549.21412-3-jason-jh.lin@mediatek.com>
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
> Add DRM_MTK_GEM_CREATED_ENCRYPTTED flag to allocate a secure buffer
> to support secure video path feature.
> 

You have a typo in both the commit description and the title. Please fix.

> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   include/uapi/drm/mediatek_drm.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/drm/mediatek_drm.h b/include/uapi/drm/mediatek_drm.h
> index c050de320a84..93f25e0c21d7 100644
> --- a/include/uapi/drm/mediatek_drm.h
> +++ b/include/uapi/drm/mediatek_drm.h
> @@ -48,6 +48,7 @@ struct drm_mtk_gem_map_off {
>   
>   #define DRM_MTK_GEM_CREATE		0x00
>   #define DRM_MTK_GEM_MAP_OFFSET		0x01
> +#define DRM_MTK_GEM_CREATE_ENCRYPTED	0x02
>   
>   #define DRM_IOCTL_MTK_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + \
>   		DRM_MTK_GEM_CREATE, struct drm_mtk_gem_create)

