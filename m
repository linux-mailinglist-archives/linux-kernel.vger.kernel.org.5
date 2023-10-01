Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1A7B45A9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJAGhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjJAGg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:36:57 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BBDA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:36:53 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id mkyfqFUE9IBlVmq43qir3R; Sun, 01 Oct 2023 06:36:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id mq4Squ215XQGamq4SqtCns; Sun, 01 Oct 2023 06:36:53 +0000
X-Authority-Analysis: v=2.4 cv=DJGcXgBb c=1 sm=1 tr=0 ts=65191385
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
        bh=YW4LnEq/eBLDUviFpnXJ6qtKfen1E/plxXVxSih4JEM=; b=bsDCHjTJh4jyfLGIOdd4ITxnUQ
        GOWCqpr1c7oQ8vZuXFQHPBt3eemH/1DQRxz9UqneUkoUu97nqWG+Ofw3JqALssKkJWmfn7r26axKe
        ApVhcDQVz2U9cZrqlmNq/Oz1Yyw4K6GP5wf7nLF/CpitDYmXnVsTyQIMMA1iv5zsNDvHiLQ+3LAOX
        /bFYvYg6I1zFZq3d1wOWdGXZ4H5D45rbcNumhNF0ZyAErQugxCCCQlTafqLVA1gq7yeObWlZaxzxk
        15u/wUEjnaIDqESwnQX4y+/Y9A0U4k+UYy1Hz7sFbifoFL7aGTl913ct2yxeWfYybsQDKAnFSnzdg
        nEccV3sg==;
Received: from [94.239.20.48] (port=51586 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmq4Q-001KEL-2q;
        Sun, 01 Oct 2023 01:36:51 -0500
Message-ID: <7f0b1ca5-c0e9-0415-58ab-6fb6bcf9d73f@embeddedor.com>
Date:   Sun, 1 Oct 2023 08:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/5] cxgb4: Annotate struct sched_table with __counted_by
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
 <20230929181149.3006432-4-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230929181149.3006432-4-keescook@chromium.org>
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
X-Exim-ID: 1qmq4Q-001KEL-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:51586
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 45
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMkg8Y3lV+AzQtzf7375lSITuGKcEdy7DNMZw+oJwOGPGC3MgLcIGPFy798QMXgbAjTbVCSp41CkK73eyjQEc3l2/bjJe8Q1rQOQSTBrRRYfho1H+X8N
 8XzdBBm41cbrnOPa8o+YZIA4y/yLAKU5IClmquy2TP3Kh/ZpkZ1+Eg3rmTw+i2gFDkOhgIn0P+LK9dVdvBmbG+TcVshzYaJqxOaK9CBQpvQY8xtA1IF2/gh/
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
> As found with Coccinelle[1], add __counted_by for struct sched_table.
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
>   drivers/net/ethernet/chelsio/cxgb4/sched.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.h b/drivers/net/ethernet/chelsio/cxgb4/sched.h
> index 5f8b871d79af..6b3c778815f0 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sched.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sched.h
> @@ -82,7 +82,7 @@ struct sched_class {
>   
>   struct sched_table {      /* per port scheduling table */
>   	u8 sched_size;
> -	struct sched_class tab[];
> +	struct sched_class tab[] __counted_by(sched_size);
>   };
>   
>   static inline bool can_sched(struct net_device *dev)
