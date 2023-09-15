Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8408C7A2871
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjIOUrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjIOUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:47:44 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EFE273F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:47:14 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id h8dGqbD6cez0ChFiFqBwUQ; Fri, 15 Sep 2023 20:46:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFibqTfjTyBEYhFibqk0kI; Fri, 15 Sep 2023 20:47:13 +0000
X-Authority-Analysis: v=2.4 cv=durItns4 c=1 sm=1 tr=0 ts=6504c2d1
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
        bh=OJCQwVBr4oMmx1OajRhUTQW8+WMKMrIsQ1SjzAZI0kw=; b=iLVLOqm/ucWxBdREakyaAZKEZW
        VyWAV4xwP/gdKvpIXbyLjtyVtj5G0qiLMdtI4MpK0B5MXMoOWm7vPCfqLm+lIder34rh2kjBdSHKJ
        0X/kumYodifIFYehekFVjfFKsu52UTk+0r6JCGI0KOOUTnVNtYrwrmfSosWHhp3t/KY85qxKHA8X7
        zBmvAp3bJ7jD559M/SrLjKmDAPk6hTJMjSf0xIre7zJ95KVwm5O9yBMgK1DSpM0CNEUItK+PZoAbL
        jY8Hjw6tc+GS39Ce0FFc2/+MXHg/EmtSAprs+nLPyG+P7TzzuRnzuse4EeJq6i2aYMgLAgF4HiEGJ
        gXlqB6Jw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:49856 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFiZ-002c5c-3D;
        Fri, 15 Sep 2023 15:47:12 -0500
Message-ID: <e0fba1f9-fc9d-81eb-4bd9-9f6db9d75df8@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:48:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: Annotate struct lpddr_private with __counted_by
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
References: <20230915201159.never.112-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201159.never.112-kees@kernel.org>
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
X-Exim-ID: 1qhFiZ-002c5c-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:49856
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 289
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLtONZVm0Mh3AsO5TxHlNUffkeM+G5rzkc6f3r7atmB5DfGVZKo+sY6K004SW39tbWvRyMdA/sZJE+R5YD5PiZvLohDUgyqk7fyGh047/QV0jVqzxQWX
 Ce+24JrtIMyyQ4ojoigI0a9u3sq8yQHYbbo/kZiRJrlSNUQoMzBcilW4gu94nhF2Ptu8J1xq9f/Mcd7HlJvzmt/3NK1Fu1vzC7qTnZ2OXrHUL4qrTOAgMaC4
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
> As found with Coccinelle[1], add __counted_by for struct lpddr_private.
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
>   include/linux/mtd/qinfo.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/qinfo.h b/include/linux/mtd/qinfo.h
> index 2e3f43788d48..0421f12156b5 100644
> --- a/include/linux/mtd/qinfo.h
> +++ b/include/linux/mtd/qinfo.h
> @@ -24,7 +24,7 @@ struct lpddr_private {
>   	struct qinfo_chip *qinfo;
>   	int numchips;
>   	unsigned long chipshift;
> -	struct flchip chips[];
> +	struct flchip chips[] __counted_by(numchips);
>   };
>   
>   /* qinfo_query_info structure contains request information for
