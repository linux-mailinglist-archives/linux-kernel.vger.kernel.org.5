Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB677977F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjIGQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjIGQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE4559A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:50:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC0A76607308;
        Thu,  7 Sep 2023 13:11:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694088713;
        bh=kZmzmGdZjTp+pv+nFULwgyI8KjWwGKWBpiBdon/MuOQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AeTWCkiDqD6f6FOITG/CljMPbT9mYAoEZvyFi3Cfj6tonymBBm/2twaiCSpnjDbmf
         gPFGyadrak/wld94EhKUePT1PZAglGN2ZbZYHjg0ExUOP4LEOUqCrBoltr7NYjgWzU
         dTYe+1OZsk49MA+OfckLS3URBrZ9mvWWyMBEiw7NzNqk6Ou7+Fzj5DrbghhvoTkYlU
         oUX5lOxD3yNijtQRm7wpjE+NXaDtHI6l9YzevNWfFz1HsV5LM2Xzd49TYZnWmc8JPK
         znKu5mSvDDg+mhPG9pZH6mTe1GkYuMCU0NuA2OjpnYgrOARWT6g1h2A7JdT+5IQFh7
         qQUIk4kE9s5+Q==
Message-ID: <a0b60e8b-7fb7-b2d9-8c91-1be665e43800@collabora.com>
Date:   Thu, 7 Sep 2023 14:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/15] soc: mediatek: Add register definitions for GCE
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
 <20230823151332.28811-2-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-2-shawn.sung@mediatek.com>
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
> Add register definitions for GCE so users can use them
> as a buffer to store data.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   include/linux/soc/mediatek/mtk-cmdq.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 649955d2cf5c..3eb95ef34c6c 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -14,6 +14,13 @@
>   #define CMDQ_ADDR_HIGH(addr)	((u32)(((addr) >> 16) & GENMASK(31, 0)))
>   #define CMDQ_ADDR_LOW(addr)	((u16)(addr) | BIT(1))
>   

Please add a comment explaining "TPR"

> +#define CMDQ_TPR_ID		(56)
> +

Please add a comment explaining what those definitions are, what is "SPR"?

Regards,
Angelo

> +#define CMDQ_THR_SPR_IDX0	(0)
> +#define CMDQ_THR_SPR_IDX1	(1)
> +#define CMDQ_THR_SPR_IDX2	(2)
> +#define CMDQ_THR_SPR_IDX3	(3)
> +
>   struct cmdq_pkt;
>   
>   struct cmdq_client_reg {

