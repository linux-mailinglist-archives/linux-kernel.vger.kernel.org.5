Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14547B45A7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjJAGgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJAGge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:36:34 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6D99F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:36:31 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id mekrql2braLCxmq47qyAE1; Sun, 01 Oct 2023 06:36:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id mq46qpqanQjw7mq46qzqTh; Sun, 01 Oct 2023 06:36:30 +0000
X-Authority-Analysis: v=2.4 cv=YqYc+qUX c=1 sm=1 tr=0 ts=6519136e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=bOnWt3ThIoLzEnqt84vq:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l94u8xNBfZNlbl7wM7/4FCAq7L1psobhc0IxdIbvqVQ=; b=frElGOPdBImCXcHhDIL8JLVwQJ
        WDscQnv2YPzFgNcYCPNJ9d43igZpHI+X2e+6yK3bCWcWi24JvvS3hCh9kgQC6FaoOqvNtBo7bseZ8
        qh2pl7dCB/ObEeylTFHLVRGRxKNkYuy8uCkJ4MNojrtAxAtgP4n2wNMDZzu+5hNpuYwymCpLus3aq
        KIqP194JcWzWAVq6G4yuaQ0TpLpxe4JbESWrTgccJnqZU2RDR60FuTMUIRHART4WJku4yplAwZFXP
        v3t9MMechRilCqjF3RLFpTmMjBQKem7onWJDFnqf+EEZF4XhgcEMsRPUdrvc0IdTCB8krPOFCmMjk
        nJ/C2yUg==;
Received: from [94.239.20.48] (port=33478 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmq44-001Ju3-26;
        Sun, 01 Oct 2023 01:36:28 -0500
Message-ID: <a3c9a0f8-7634-fe30-95b0-fb18adaf443e@embeddedor.com>
Date:   Sun, 1 Oct 2023 08:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] cxgb4: Annotate struct cxgb4_tc_u32_table with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Raju Rangoju <rajur@chelsio.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20230929181042.work.990-kees@kernel.org>
 <20230929181149.3006432-3-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230929181149.3006432-3-keescook@chromium.org>
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
X-Exim-ID: 1qmq44-001Ju3-26
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:33478
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD9cZfWarp7WOXt8eVckUY40BpF0Vw4pPn5SexI2+YBaS5KctqI+B+dp9+Pb+BLRw/4X9I4mcjUxhsJldOjtes2X9M9X93FXCpM9NxLhBPQSlSxQVRKR
 J+1zuR9Y2b4Sm3fvBi0eVgAVG+iRGr/Hra6OHq/R2tBYfUiOw8zDKRkNsknWUGPe2wH7GdJs4pDy7TONn7+Fu2hfE77V2vppsh0z08AbGtK1fPTSN4tM8wki
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 20:11, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cxgb4_tc_u32_table.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Raju Rangoju <rajur@chelsio.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
> index f59dd4b2ae6f..9050568a034c 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
> @@ -331,6 +331,6 @@ struct cxgb4_link {
>   
>   struct cxgb4_tc_u32_table {
>   	unsigned int size;          /* number of entries in table */
> -	struct cxgb4_link table[]; /* Jump table */
> +	struct cxgb4_link table[] __counted_by(size); /* Jump table */
>   };
>   #endif /* __CXGB4_TC_U32_PARSE_H */
