Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9002D759425
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGSL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjGSL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:27:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF4E52;
        Wed, 19 Jul 2023 04:27:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21A2B6607072;
        Wed, 19 Jul 2023 12:27:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689766054;
        bh=9qfxcH3j/f1CvIfaXnqo7k8AyMuw1imrFFbrAy1NN+Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GNpDP7Q0uS/pd0YDhXY/68aBQJHQuMCg1qdYuhwFUkj/97xlrHPc35Tk9ag6atbKw
         8brHWC+4X3p4P8/v5BU1DCm2Im55xWAUdFFo2bzrOvZM7JGLH3bngz9oSLAHDQMYhG
         U7IB5eY+2lUx8Lvlm8TJiUFd6TeLW68PF0m0mVQx3w8qK/dOFg44N7IwqVKomytO29
         R/Zo1tVFu3p3o35ajnNwWG+U4zj6ONhzEVmGGZeNv13ppTYNglQXkQZT9eWpeFjjF6
         hJPo4Blo4oKAvOgzi4K8Mf0wet52LwbKp/6sXXIIcezPXu2dNPQG2EOFm13ANCsm6g
         phbqFUB7LtD9g==
Message-ID: <c32d744a-c711-fdd9-0601-0ec27a0af733@collabora.com>
Date:   Wed, 19 Jul 2023 13:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: mdp3: Fix resource leak in a
 for_each_child_of_node() loop
Content-Language: en-US
To:     =?UTF-8?B?6Lev57qi6aOe?= <luhongfei@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Deepak R Varma <drv@mailo.com>,
        Sun Ke <sunke32@huawei.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230719100137.41161-1-luhongfei@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719100137.41161-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/07/23 12:01, 路红飞 ha scritto:
> for_each_child_of_node should have of_node_put()
> in error path avoid resource leaks.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

That's still HTML; please avoid Cc'ing a bunch of people if you're testing
your email sendout.

Please test internally and once working send it again.

Btw, the code looks good... but I can't give you a R-b because of HTML format.

Thanks,
Angelo

> ---
> Changelog:
> v1->v2:
> 1. Change the subject line of this patch to include driver name.
> 2. Remove the unneeded of_node_put.
> 
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index a605e80c7dc3..40c4b79a5090 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -1135,6 +1135,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>   		comp = mdp_comp_create(mdp, node, id);
>   		if (IS_ERR(comp)) {
>   			ret = PTR_ERR(comp);
> +			of_node_put(node);
>   			goto err_init_comps;
>   		}
>   


