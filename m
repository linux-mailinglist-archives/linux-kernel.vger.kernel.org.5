Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC797BC2C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjJFXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjJFXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:02:58 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92572A2;
        Fri,  6 Oct 2023 16:02:57 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id oX3oqSDOhnGhUotqSqPGld; Fri, 06 Oct 2023 23:02:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id otqRqdBJ7wATbotqSqK3Ps; Fri, 06 Oct 2023 23:02:56 +0000
X-Authority-Analysis: v=2.4 cv=LtCBd1Rc c=1 sm=1 tr=0 ts=65209220
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=mK_AVkanAAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=0yL73Cyy68KADmUz8mEA:9
 a=QEXdDO2ut3YA:10 a=3gWm3jAn84ENXaBijsEo:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ckZ+2ni0ap9A3fZ0AsoDx3MuEYvELQsfTGY0z3qXUm8=; b=hfleqODQEvWoPvdpqcmjoMGFS5
        LBprket2n/51h4OP+E/tdKLiOEkv4pzsCaVM3ymKvIkxjVUOE/YocphM2rXOt8ulZSl+tIz4CtpCr
        tPEg9W+i2X2KYw+p/gLWTk3/ZjysFC90zN902iQwC6KM1Jd634+J9gdxbnUtMAgSqlSuX2h2RnFAF
        c9uzF7Rsuy+y4xyhbwKIdWCJ2KrkQgKH3S45tBuIEaFlwDIjIkGWN7+7smKtLlWC4Cc7BekfR5bVF
        aJL7ecPrx8Tae5PMIhsr0T6CPZG4BxPU9zuRkpGGRdQpxuT3YhOxUam+A2XgkSwe5Sv06Q3I8mnHX
        taJ/4HeA==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qorlC-001Bge-2D;
        Fri, 06 Oct 2023 15:49:22 -0500
Message-ID: <d152533b-e4a8-4881-a10b-31835d3a32d9@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: p54: Annotate struct p54_cal_database with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Christian Lamparter <chunkeey@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201719.work.356-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201719.work.356-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qorlC-001Bge-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIDBOL24QZA9cDZTHhu95AIJyp85a1s7bttZGDb+wCi7b/DHU8sSBjr23i0H7+GU8TTyCPdquqRkh96qmWuA+vmV4akzmyZKppe79BqRxR+bCCJlgDOI
 LAx2A61qvzu1a6WFVn6aIsc4u0uBk64Ey5ynkpjDM/i5P8a21gPwtlytsbEJoXga4JSdxJTvP6VlrIwGge1EtTO7PcHbJfz3VGSaB/YkHY4bu6AKrPFIcq/b
 Chc12cyYAGYahcO2V9A69Lz+wlq/zRQeVUpM69reP0OC2XENyG/a8OQWJ5lD6zWyojoEPvMdwLYrHZQpUeTNjw==
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
> As found with Coccinelle[1], add __counted_by for struct p54_cal_database.
> 
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/net/wireless/intersil/p54/p54.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
> index 3356ea708d81..770e348d1f6c 100644
> --- a/drivers/net/wireless/intersil/p54/p54.h
> +++ b/drivers/net/wireless/intersil/p54/p54.h
> @@ -126,7 +126,7 @@ struct p54_cal_database {
>   	size_t entry_size;
>   	size_t offset;
>   	size_t len;
> -	u8 data[];
> +	u8 data[] __counted_by(entries);
>   };
>   
>   #define EEPROM_READBACK_LEN 0x3fc
