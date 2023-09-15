Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF37A2887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjIOUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjIOUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:48:19 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6AC2703
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:47:55 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id hAJhq8d40OzKlhFjGqIGzf; Fri, 15 Sep 2023 20:47:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFjGqx6zkZRGzhFjGqOTdA; Fri, 15 Sep 2023 20:47:54 +0000
X-Authority-Analysis: v=2.4 cv=PLscRNmC c=1 sm=1 tr=0 ts=6504c2fa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=aeg5Gbbo78KNqacMgKqU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RqOUINYtZnX/Of+yTyHFYCaBJKqXskU5mxpeljwMPIY=; b=pukAyExiqsVBM3/174lVjFczXB
        /UHmgwxH7KQ2j2h4GHZJGw9tIHJnaQDVLbjQRbmuXfaN8lZfwmtiONe5yIoy9P3xX5khIAW3XtS17
        MZ2PvbJukE8IAzmob31EM7COq2n96cppK+HOfyWSMEWGsBsLdGF4/VlN4C31aRYgtUHaLFtNN+dFw
        SM+wu4aPhH7cGUL1WTeGhibVpcAmXnOFzg3zNyRPiukNsQLItREk4Hl7V0kZAPRBxPMJNl28HgmGN
        1SlqZwHmbJBumiwpfz/n7wuanPtvNyDtEwzNRgYgGd8oZg8Iz5MKPiwDfkADArNozU4k41ARn4taK
        KrcrLKmQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:49250 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFjF-002cqE-0c;
        Fri, 15 Sep 2023 15:47:53 -0500
Message-ID: <14906ef8-63e4-046b-1e18-8d02e1e77eb9@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:48:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: rawnand: denali: Annotate struct denali_chip with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201227.never.483-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201227.never.483-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFjF-002cqE-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:49250
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 327
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG7Son+0AX2NMEogUoNTF5WSmExCOWKpalpIiSPAaEcBjdG3mip3vpcRVH4cm9IzQcGzjCIG+qJNx/onzSutFUYrFMmvmJbgEvsBtlPewxx9DBo8ANRN
 48fSBxOBR2Zn+Ab4NZM0Bf+8azgLefLM3TqwDGoq8i/CBd2DuSz7MfvCg0TIuh4RD0RowIrk1EJv/kxxbxJWTbMtmH0iRnyUTBowv9EyfBzO7skt0b5llLoO
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:12, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct denali_chip.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/mtd/nand/raw/denali.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
> index ac46eb7956ce..5f2fab022fc5 100644
> --- a/drivers/mtd/nand/raw/denali.h
> +++ b/drivers/mtd/nand/raw/denali.h
> @@ -328,7 +328,7 @@ struct denali_chip {
>   	struct nand_chip chip;
>   	struct list_head node;
>   	unsigned int nsels;
> -	struct denali_chip_sel sels[];
> +	struct denali_chip_sel sels[] __counted_by(nsels);
>   };
>   
>   /**
