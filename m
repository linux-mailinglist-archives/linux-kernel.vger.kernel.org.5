Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982DE7A287D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjIOUsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbjIOUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:48:01 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718EF2724
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:47:29 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id hAJeqk22sQFHRhFirqvXF1; Fri, 15 Sep 2023 20:47:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFiqq2AymOCehhFirqYFkM; Fri, 15 Sep 2023 20:47:29 +0000
X-Authority-Analysis: v=2.4 cv=feK+dmcF c=1 sm=1 tr=0 ts=6504c2e1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=7iih_Mw5sYxBUvFKUpMA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=aeg5Gbbo78KNqacMgKqU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sq+6+p57AmLbcxPtBEdqC/wNkATEpxAVKzlTJvsl6VE=; b=tmUMQ38WOswcSz2bnRSH1833Ic
        TwxU3WoxQJ/IsEXHnWck8PSXYl6rl5jl/RkthCZ1P/Ftc17HT39XOayrGaYxs5qpoaBta3SstWrBi
        wLVP0n0NreXc4ISJ92Q/tGSBShxwILyYdpvOiX2489j+j4w2dNoSD8DEuQb6S6J8TKnKEJJAv9pRd
        OtQW3Tdi4Qs4Q7Eb8S6rrlBTqvrPItYBrHkAMjbD4BdgmR9IG9BtFqZl3gqoJ8/DZpXOzzEwh2VWQ
        /QCk5nu0K9NCwJoAT4ZJvyV43+ToVA9UvnjRhpeRvgZ7K8t/eaQyCOgfCOKvwryKmYfiLj/4Qujve
        BUTkOAFg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:38810 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFip-002cMH-1v;
        Fri, 15 Sep 2023 15:47:27 -0500
Message-ID: <04aea2c0-8dae-8f45-211c-51304f3a88ca@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:48:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: cfi: Annotate struct cfi_private with __counted_by
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
References: <20230915201206.never.107-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201206.never.107-kees@kernel.org>
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
X-Exim-ID: 1qhFip-002cMH-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:38810
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 300
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGRcJCaHFcOep0HWJxXSTnub5ppZG/bQ6DZX5Jz42907efPc5qPtSwXh/4NVfkLEIsoNFeIi4Qz2L2UPKKJ8S5CVtpSSPufzycoX/rkOONdXooGLsAoq
 38TXd5s/vJuHpKLhceHP5bNv8FPTMS1+j5duG/BU4cXzkh33cAIZz0uM7bsDqMBgljxOSJDTrkFVc74evEX+nIytVJOjZ7WHEv1f5TEUbqy3qgGCY7bLvSK6
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct cfi_private.
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
>   include/linux/mtd/cfi.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index d88bb56c18e2..947410faf9e2 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -287,7 +287,7 @@ struct cfi_private {
>   	unsigned long chipshift; /* Because they're of the same type */
>   	const char *im_name;	 /* inter_module name for cmdset_setup */
>   	unsigned long quirks;
> -	struct flchip chips[];  /* per-chip data structure for each chip */
> +	struct flchip chips[] __counted_by(numchips);  /* per-chip data structure for each chip */
>   };
>   
>   uint32_t cfi_build_cmd_addr(uint32_t cmd_ofs,
