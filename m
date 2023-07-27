Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1A76505D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjG0JyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjG0Jxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:53:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEDD116;
        Thu, 27 Jul 2023 02:53:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4830629A;
        Thu, 27 Jul 2023 11:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690451565;
        bh=S3liQ/d6FwSzzCoPdbALdZsw0tGVl7kVb2/34t88+6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPXnz5r4lNoIDIaDgVw37PZl1ZwGaMIa+1333/CfKF/S2hDHUmjJ0AVHjDsLO6x+s
         nqGV31/st8a1/ZOlpLL4knmsq4GVqwAVupg2BS69lAoRq/ZamGvb3lVJknRNdWjfMq
         LvNf8nrTww/mMtgmLaAIlcQ8gPBPsSBm7jqopUPA=
Date:   Thu, 27 Jul 2023 12:53:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     mirela.rabulea@nxp.com, linux-imx@nxp.com, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] media: nxp: Remove redundant dev_err()
Message-ID: <20230727095350.GF25174@pendragon.ideasonboard.com>
References: <20230727102154.2757410-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727102154.2757410-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruan,

Thank you for the patch.

On Thu, Jul 27, 2023 at 10:21:54AM +0000, Ruan Jinjie wrote:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c      | 1 -
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 9512c0a61966..b7a720198ce5 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -2742,7 +2742,6 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
>  	dec_irq = platform_get_irq(pdev, 0);
>  	if (dec_irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
>  		ret = dec_irq;
>  		goto err_irq;
>  	}
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> index c4454aa1cb34..65d20e9bae69 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> @@ -791,7 +791,6 @@ int mxc_isi_pipe_init(struct mxc_isi_dev *isi, unsigned int id)
>  
>  	irq = platform_get_irq(to_platform_device(isi->dev), id);
>  	if (irq < 0) {
> -		dev_err(pipe->isi->dev, "Failed to get IRQ (%d)\n", irq);
>  		ret = irq;
>  		goto error;
>  	}

-- 
Regards,

Laurent Pinchart
