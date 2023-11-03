Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2187E004A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjKCI1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjKCI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:27:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BD131;
        Fri,  3 Nov 2023 01:27:33 -0700 (PDT)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54DB166073C9;
        Fri,  3 Nov 2023 08:27:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699000052;
        bh=kQYtpasdSDbX4pdFU8I6JnSdF+myp1yFX1gld+RQjmY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YrFnO0gM0RKayDoldHI+mOt2OVS1jGHJ58/eDn/yls7tAqxKN2lNovb72cQU2pgWM
         Yv1Hj9nv+DMZ0xuJ+VLAL3rDEngS5gLiOMoXJsF9eKrhbHqr2ggNP2/sLCIcjtNnP4
         QZI3WK0IMLLWE/dJbso8SKy6yAE/YACux2PGoHI+1nv1mBewgg/i1osRfPxQpOEu//
         Y/pxwZSjvTqTCVdBPruojF6B6CAaC6wSKaSEp/NeLCQlGfmvllHXhlaZbWwIEYwIlI
         Z6AoGWaQNsqfW3l1eDKqb8mZ4BLjgD571nH1ImiIXRuN2ko/ZxrH8VQy4m8ryJDPBv
         7VYZs3q8V4DwA==
Message-ID: <63fecefb-61bf-4232-ab91-db04e3212f14@collabora.com>
Date:   Fri, 3 Nov 2023 09:27:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: add wp_grp_size node
To:     Bo Ye <bo.ye@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     yongdong.zhang@mediatek.com, browse.zhang@mediatek.com,
        lin.gui@mediatek.com, qilin.tan@mediatek.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231101154927.119312-1-bo.ye@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231101154927.119312-1-bo.ye@mediatek.com>
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

Il 01/11/23 16:49, Bo Ye ha scritto:
> From: "lin.gui" <lin.gui@mediatek.com>
> 
> Detail:
> Add node "wp_grp_size", corresponding to WP_GRP_SIZE
> (write protect group size) of eMMC's CSD register.
> 
> Scenario:
> The eMMC card can be set into write-protected mode to
> prevent data from being accidentally modified or deleted.
> Wp_grp_size (Write Protect Group Size) refers to an
> attribute of the eMMC card, used to manage write protection,
> and is the CSD register  [36:32] of the eMMC device.
> Wp_grp_size (Write Protect Group Size) indicates how many
> eMMC blocks are contained in each write protection group on the eMMC card.
> 
> Final rendered file:
> "/sys/class/mmc_host/mmc0/mmc0:0001/wp_grp_size"
> 
> Signed-off-by: lin.gui <lin.gui@mediatek.com>
> Change-Id: I73952dbde2db375ba918daadb3264380b7863096

The change-id tag means nothing upstream. Please remove.

Also, the recipients list doesn't look right. Please use scripts/get_maintainer.pl
to get the right recipients list, or your patch will be ignored.

> ---
>   drivers/mmc/core/mmc.c   | 16 +++++++++++++++-
>   include/linux/mmc/card.h |  2 ++
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4a4bab9aa726..9b67e49a9e63 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -136,6 +136,17 @@ static void mmc_set_erase_size(struct mmc_card *card)
>   	mmc_init_erase(card);
>   }
>   
> +
> +static void mmc_set_wp_grp_size(struct mmc_card *card)
> +{
> +	if (card->ext_csd.erase_group_def & 1)
> +		card->wp_grp_size = card->ext_csd.hc_erase_size *
> +			card->ext_csd.raw_hc_erase_gap_size;
> +	else
> +		card->wp_grp_size = card->csd.erase_size *
> +			(card->csd.wp_grp_size + 1);
> +}
> +
>   /*
>    * Given a 128-bit response, decode to our card CSD structure.
>    */
> @@ -186,6 +197,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>   		b = UNSTUFF_BITS(resp, 37, 5);
>   		csd->erase_size = (a + 1) * (b + 1);
>   		csd->erase_size <<= csd->write_blkbits - 9;
> +		csd->wp_grp_size = UNSTUFF_BITS(resp, 32, 5);
>   	}
>   
>   	return 0;
> @@ -791,6 +803,7 @@ MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
>   MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>   MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
>   MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
> +MMC_DEV_ATTR(wp_grp_size, "%u\n", card->wp_grp_size << 9);
>   MMC_DEV_ATTR(ffu_capable, "%d\n", card->ext_csd.ffu_capable);
>   MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
>   MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
> @@ -851,6 +864,7 @@ static struct attribute *mmc_std_attrs[] = {
>   	&dev_attr_date.attr,
>   	&dev_attr_erase_size.attr,
>   	&dev_attr_preferred_erase_size.attr,
> +	&dev_attr_wp_grp_size.attr,
>   	&dev_attr_fwrev.attr,
>   	&dev_attr_ffu_capable.attr,
>   	&dev_attr_hwrev.attr,
> @@ -1759,7 +1773,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   			mmc_set_erase_size(card);
>   		}
>   	}
> -
> +	mmc_set_wp_grp_size(card);
>   	/*
>   	 * Ensure eMMC user default partition is enabled
>   	 */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..62873ecc52f1 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -32,6 +32,7 @@ struct mmc_csd {
>   	unsigned int		r2w_factor;
>   	unsigned int		max_dtr;
>   	unsigned int		erase_size;		/* In sectors */
> +	unsigned int		wp_grp_size;
>   	unsigned int		read_blkbits;
>   	unsigned int		write_blkbits;
>   	unsigned int		capacity;
> @@ -304,6 +305,7 @@ struct mmc_card {
>   	unsigned int		eg_boundary;	/* don't cross erase-group boundaries */
>   	unsigned int		erase_arg;	/* erase / trim / discard */
>    	u8			erased_byte;	/* value of erased bytes */
> +	unsigned int		wp_grp_size; /* write group size in sectors */

There should be a tabulation before the comment, not a space.

Regards,
Angelo

