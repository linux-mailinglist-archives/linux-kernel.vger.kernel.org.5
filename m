Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B797B45D6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJAHt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjJAHt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:49:27 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4EEDA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 00:49:25 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id mKShqx0ZkQUgRmrCeqc6Vw; Sun, 01 Oct 2023 07:49:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id mrCdqv9UvXQGamrCequ72L; Sun, 01 Oct 2023 07:49:24 +0000
X-Authority-Analysis: v=2.4 cv=DJGcXgBb c=1 sm=1 tr=0 ts=65192484
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=cLZyiMI5l2q1nrJyhZUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ctbPsvlFsKyDYeo7FjRggIA8ffQtTboXoPN4rM9I5Ak=; b=U+nXmy3Z6LSZdtXmnO3XiLegSK
        kdboceARJMpolXbgZGHt1Q1rWpezLjLdiErLTqBd2mzmn3CC3IbiBpOMxWiqAp8bsn6hZ20xwEYBI
        3nwEETsTZoe9O9rniIN+IWKzHpl3uvm4f6T0BV3wfu+YALy2zdzRmSwi5nc+7o4GMS0g/FPpTwSUb
        IYlNt64qP9L7Gn0FIRsijCjALoZmQyXHc1aaYEqI6njCWnSOl6psjMYnltkCeJTa/zQbEvJom0JQc
        1LC6bqtPcC1cw6RW9r3MiztBpSwz4HVLA+8hCMQfbgLgTlPca2HgkSyZTzIgfyiyO7aVtZg3b38T+
        otR7PGDQ==;
Received: from [94.239.20.48] (port=43776 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmrCb-002Jj3-1w;
        Sun, 01 Oct 2023 02:49:21 -0500
Message-ID: <1bcde585-f740-8959-6e2e-19793795b60e@embeddedor.com>
Date:   Sun, 1 Oct 2023 09:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mtd: rawnand: rockchip: Use struct_size()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmrCb-002Jj3-1w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:43776
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfETcIOj8yK0JQ4cLCYr3/EOoJnKq8dYOVRCF/GX+/53Hq1+wSO/lYj8jf+9iHzyHPMujDDVRZWFzT2u8oWUxa7H6RLDWOnw37uYWGPw10EDLL2vtGe9r
 tEIM1x4EKnvNqhxarFNQhxds1V7lHqGyWib48IRTNoPfdeTa9bB/pXp8O9Xi3Ej/WLWPBYjYD7XHeBIiUBNChIsXQbyutuvOD3arLnnC57dSZfL6DbyD/CVQ
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/23 09:44, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> While at it, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with __counted_by
> can have their accesses bounds-checked at run-time checking via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).

Again, I'd prefer this as two separate patches.

> 
> Also remove a useless comment about the position of a flex-array in a
> structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

In any case:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> In this case, struct_size() was not used to compute the size needed for the
> structure and its flex array.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>   drivers/mtd/nand/raw/rockchip-nand-controller.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> index 5bc90ffa721f..596cf9a78274 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -158,8 +158,7 @@ struct rk_nfc_nand_chip {
>   	u32 timing;
>   
>   	u8 nsels;
> -	u8 sels[];
> -	/* Nothing after this field. */
> +	u8 sels[] __counted_by(nsels);
>   };
>   
>   struct rk_nfc {
> @@ -1119,7 +1118,7 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,
>   		return -EINVAL;
>   	}
>   
> -	rknand = devm_kzalloc(dev, sizeof(*rknand) + nsels * sizeof(u8),
> +	rknand = devm_kzalloc(dev, struct_size(rknand, sels, nsels),
>   			      GFP_KERNEL);
>   	if (!rknand)
>   		return -ENOMEM;
