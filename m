Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002447C5A05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbjJKREo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjJKREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:04:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292AE0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:04:37 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qqcdM-0006JO-Tw; Wed, 11 Oct 2023 19:04:32 +0200
Message-ID: <3ce3b7b7e7c4344b8a36b2f73ff560e4e3cf8459.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Drop the 'len' parameter of
 etnaviv_iommu_map() function
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Oct 2023 19:04:32 +0200
In-Reply-To: <20231007070312.1026296-1-suijingfeng@loongson.cn>
References: <20231007070312.1026296-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, dem 07.10.2023 um 15:03 +0800 schrieb Sui Jingfeng:
> The 'len' parameter is the 4th argument, because it is not get used, so
> drop it. No functional change.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks, applied to my etnaviv/next branch.

Regards,
Lucas

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> index 4fa72567183a..1661d589bf3e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -70,7 +70,7 @@ static int etnaviv_context_map(struct etnaviv_iommu_context *context,
>  }
>  
>  static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
> -			     struct sg_table *sgt, unsigned len, int prot)
> +			     struct sg_table *sgt, int prot)
>  {	struct scatterlist *sg;
>  	unsigned int da = iova;
>  	unsigned int i;
> @@ -314,7 +314,7 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
>  		goto unlock;
>  
>  	mapping->iova = node->start;
> -	ret = etnaviv_iommu_map(context, node->start, sgt, etnaviv_obj->base.size,
> +	ret = etnaviv_iommu_map(context, node->start, sgt,
>  				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
>  
>  	if (ret < 0) {

