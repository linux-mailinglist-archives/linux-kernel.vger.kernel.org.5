Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212278A904
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjH1JeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjH1Jdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F3FF;
        Mon, 28 Aug 2023 02:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF91661541;
        Mon, 28 Aug 2023 09:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0CC433C8;
        Mon, 28 Aug 2023 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693215222;
        bh=+ZA8KikFnAGsBsfoNqy/fVpDbZJ0zOlAuvqXE/frRxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2GrYkJHtJKUagZq409xqq5xehkqsk2FgM2+97UL6tdTJT7xKcmrWGKMglRcDkaG+
         ciGaX6lGwOUCzccZRmVCsvJpumVo2BT522tvF9PeohmII06N3kNCSfczv4GQM8zMOb
         H5zNiGylEssQgDR+cFVk4aWLfw7CaudjAvoXk8AwDPWCYmglD+wvbYyYHCQBn8KKsK
         HO1q2bw7N7OSL6Jke6I1w5Mz8H83mFmHPonicLmVH+3kzm0WUBlarPjFg+dPX66QT7
         ApdtaSoBKSow6zTmvy2otCgJ50VpWEXLsoKvMK1KzJbjjwmhAYrK07eMmbswWLYNfk
         cxdToLzvof5HA==
From:   Michael Walle <mwalle@kernel.org>
To:     macpaul.lin@mediatek.com
Cc:     angelogioacchino.delregno@collabora.com, bear.wang@mediatek.com,
        broonie@kernel.org, chunfeng.yun@mediatek.com,
        fparent@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, macpaul@gmail.com,
        matthias.bgg@gmail.com, pablo.sun@mediatek.com,
        Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH] spidev: add compatible string for MediaTek IoT (Genio) boards
Date:   Mon, 28 Aug 2023 11:33:26 +0200
Message-Id: <20230828093326.3255275-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828080909.16610-1-macpaul.lin@mediatek.com>
References: <20230828080909.16610-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add compatible string for MediaTek IoT (Genio) boards.

This has already be discussed [1] and was naked.

https://lore.kernel.org/lkml/20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com/

-michael

> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/spi/spidev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index d13dc15cc191..9d7952dbbaa6 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -714,6 +714,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
>  	{ .name = "spi-authenta" },
>  	{ .name = "em3581" },
>  	{ .name = "si3210" },
> +	{ .name = "genio-board" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
> @@ -742,6 +743,7 @@ static const struct of_device_id spidev_dt_ids[] = {
>  	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
>  	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
>  	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
> +	{ .compatible = "mediatek,genio-board", .data = &spidev_of_check },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, spidev_dt_ids);
> -- 
> 2.18.0
