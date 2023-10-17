Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF887CBFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjJQJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjJQJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:40:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09C19A;
        Tue, 17 Oct 2023 02:40:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9D38660576A;
        Tue, 17 Oct 2023 10:40:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697535632;
        bh=8obL4OVXO9sFwfVYUpTBsRzHOYzSvmoihOjSYGp9i44=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EMkihf8Fk5OjNDu/XsvQ+cb8204a4y0/7NV8g8FdPb91aX9NH9oYVLrnYYAW4FWDX
         pZsvh16JKElW7AcogvZ7CViJ0M3fKcBOvyyapBk3W/swlu1VkQPG3IiHmYAHFKVsrJ
         dBSG/1RqG6hJBRPx7JfMUyO4nVHXq9APO/i7b/LU3qFrF+P3MLm+tPI9xLJfKZh4Qj
         487vlCT4T3tbNgL312hIbS52yTqX91qdivxcRTS7UDrsfs/K26FOvOFe/sQb2vcB7L
         SWUUfNPj0oWM4Z4zdgej3AswW2hiEuJ8nQSWmFyon/WX+FnbFjKJG8u9MC+suRmCrt
         Cd+w+Iv/2CdIw==
Message-ID: <c186ca79-a347-4f93-a439-54ca9b0d3323@collabora.com>
Date:   Tue, 17 Oct 2023 11:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/23] drm/mediatek: Rename OVL_ADAPTOR_TYPE_RDMA
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
 <20231016104010.3270-12-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231016104010.3270-12-shawn.sung@mediatek.com>
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

Il 16/10/23 12:39, Hsiao Chien Sung ha scritto:
> Rename OVL_ADAPTOR_TYPE_RDMA to OVL_ADAPTOR_TYPE_MDP_RDMA
> to align the naming rule of mtk_ovl_adaptor_comp_id.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

