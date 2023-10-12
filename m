Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F17C6ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377623AbjJLKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347110AbjJLKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:17:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B9B8;
        Thu, 12 Oct 2023 03:17:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F39E660730F;
        Thu, 12 Oct 2023 11:17:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697105861;
        bh=g3ns2c4RoQU8nzXEQ8VUyBiWwm9Ooa52x4tpLHq9B+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fC555cNGl+Ly1HW1tK2ksVyK0MG/FjTo1j7THokikv5Pi+FlMYaEBcFRQIq/sOJPq
         gG8CzEadDaVkkrjxrtNyi12WdRGBXqVWmTcsB0emaDAOaTXsv4J1cbYFWlurVuC8Tr
         6CgODM0m3/HeVgY6dTl+qoBlhstBeHXlbkLdQqX0CxnDpSJzWb/V6VQ0ZTupzKmH7c
         LVaIRests9W7dMrsDPtZmcD4iplXgD0o2NbQrBB2sDIOxYVMqFd/6Yl9eIQHcTx6OY
         mwSwZBOOJSCir8hJTx0yTTvX2jIWRnD8CiwjAJTPDpoG5txZRgj+VsbFf36wXe0beU
         66/Mjz8eo1p+w==
Message-ID: <bf2cf999-7a1a-df14-7ba9-ac5047c998c0@collabora.com>
Date:   Thu, 12 Oct 2023 12:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 09/16] dt-bindings: media: mediatek: mdp3: add
 component TCC for MT8195
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231012084037.19376-1-moudy.ho@mediatek.com>
 <20231012084037.19376-10-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012084037.19376-10-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/10/23 10:40, Moudy Ho ha scritto:
> Add the fundamental hardware configuration of component TCC,
> which is controlled by MDP3 on MT8195.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   .../bindings/media/mediatek,mdp3-tcc.yaml     | 62 +++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
> new file mode 100644
> index 000000000000..f134160f85b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-tcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Media Data Path 3 TCC

MediaTek Media Data Path 3 Tone Curve Conversion


after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
