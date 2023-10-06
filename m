Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F107BC2C1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjJFXCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJFXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:02:54 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91693;
        Fri,  6 Oct 2023 16:02:53 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id orR7qlPNnIBlVotpxqZGcX; Fri, 06 Oct 2023 23:02:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id otqNqfvLSOktuotqNqB7sq; Fri, 06 Oct 2023 23:02:52 +0000
X-Authority-Analysis: v=2.4 cv=QpBNYH+d c=1 sm=1 tr=0 ts=6520921c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=P-IC7800AAAA:8
 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8
 a=mK_AVkanAAAA:8 a=Ikd4Dj_1AAAA:8 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=csSI4ce9OAwHNZIND1oA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=aeg5Gbbo78KNqacMgKqU:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=AjGcO6oz07-iQ99wixmX:22 a=3gWm3jAn84ENXaBijsEo:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3wWS+KHIdA9zkMV46QWcShY3l4cnXlREbKpL1SFSwiA=; b=KmoqDeHEqpebkY25NU3zGnYeSv
        OdlLE46gwluT+8j88AXfTqeP9pvO6mtR48D9aYO990sPLej+I/pfa1Qf0JqIV1vSfO+IzT3dx2ElA
        nzT72OiaJjAxF39cY2rjbAPnjfl8ejL4qXicxjtIA97eK+U9vE7E4xU+gxFekDNqEAfySdrxKZFQj
        edM77xw59RmwNWyTJEjLPpQeHvSgak1ghNvAhLvILe1YxIEvWaUxmyJDclsJhvSuxp22YkiC1xfp7
        UxVAcyZCNU5D0smv6LtpqHnPugRoUMhwF7EtcVHYzHeN5lCjpuR95OFjdYojyVU1m1nu4ZFYpWCvh
        9P5xXg+w==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qorku-001Bge-1W;
        Fri, 06 Oct 2023 15:49:04 -0500
Message-ID: <e177380b-6216-4bc3-8232-41663a828821@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: Annotate struct mtk_nfc_nand_chip with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <treding@nvidia.com>,
        Roger Quadros <rogerq@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Chuanhong Guo <gch981213@gmail.com>,
        Rob Herring <robh@kernel.org>, Li Zetao <lizetao1@huawei.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201728.work.750-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201728.work.750-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qorku-001Bge-1W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAZrR6UG0AawH6X7c50pNmMFR2xmbszYHPjEM/f41uHUKKQfUmUTAPOLdi2YeLb150tGN53c6FVlb8MrwMsiKbz2+95pr+T+DCI5L03NqDeCaJaGOCy4
 MG2fn2FjsPJXkcpXrTdBa5u/mpqMWsoh6/DoL5RzCvBOzvnD8l1rXeWOJcu+MZXxAxPOHkv7oK+EzXNcUdMxxDO8UARUGhSUnoX1ujLBuICeSNpEJKXahKPv
 xeJdjbgEFoNMkQ+qjZU7D/sSPB2YojKR3htPFYkPqfM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 22:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> mtk_nfc_nand_chip.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Cai Huoqing <cai.huoqing@linux.dev>
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Li Zetao <lizetao1@huawei.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/mtd/nand/raw/mtk_nand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
> index 29c8bddde67f..60198e33d2d5 100644
> --- a/drivers/mtd/nand/raw/mtk_nand.c
> +++ b/drivers/mtd/nand/raw/mtk_nand.c
> @@ -130,7 +130,7 @@ struct mtk_nfc_nand_chip {
>   	u32 spare_per_sector;
>   
>   	int nsels;
> -	u8 sels[];
> +	u8 sels[] __counted_by(nsels);
>   	/* nothing after this field */
>   };
>   
