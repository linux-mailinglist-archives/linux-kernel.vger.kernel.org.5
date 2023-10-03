Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693897B771E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjJDE3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjJDE3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:29:14 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456ABB8;
        Tue,  3 Oct 2023 21:29:11 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id npJ5qpBfCytxcntVXqKgLp; Wed, 04 Oct 2023 04:29:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ntVWqKhUzSMqyntVWqe8LF; Wed, 04 Oct 2023 04:29:10 +0000
X-Authority-Analysis: v=2.4 cv=ZfUOi+ZA c=1 sm=1 tr=0 ts=651cea16
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Np9nBiTxn0Rc+Jk0CzgnPnVSZDyeBFquSntzh3G3+Ts=; b=phpkRVPgP5Chj1PUdqe/oOqQex
        2s03lrJ+a32GyoaU36/fuprX+I5vC5wsm8AFyteRRelc2HJfElWVSekpcO63A6waG8Xr9H6cAqYN2
        9ThRttvrJL5aqTyYrnSHKTMWuZYZRrD1yTcZKz552NeTY88B+Tz9qCbWZ36Z911VznCTmVch3i6Yk
        fjIIaYpsESeROmjF01yfeqZF1KRT6qkE4qCN7jHVUeklDHQk6xd0LZY9ToI59ZDD7r8XIcuN+DPkc
        ZQ1OAkjwvi1i8v041eM3sBKu++qOFxPrPV41krooz/2P3VCX/P6YFXfrh0rXNLQFVaWTa6LpiLsiP
        5WTaEvpA==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:48072 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnp0p-001VnQ-1H;
        Tue, 03 Oct 2023 18:41:12 -0500
Message-ID: <2ce176e8-4e5a-762d-d615-544a7b0d2b42@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_grp_info with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, David Ahern <dsahern@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        llvm@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231003232146.work.248-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003232146.work.248-kees@kernel.org>
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
X-Exim-ID: 1qnp0p-001VnQ-1H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:48072
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGb3Pr657yM4d83ojOghobrQHKlftdJni5S7GmodhOw7c6MYw20LQqQvAj2t639my8ZhxR/huzc4aFiE6OYx/0W2vP1whL0Hofi37jYMW4mHl6CMNq/m
 S4i6G386Z75twrgMfZLR7GAB+UlDv1E72IHrrLWXhwE4ORMEX5XNl/U0v6p/iZNZ2i7I60ICz9/zKWXAbM2jWEBGjL7xO4NkWrLuF8Hw3NBH8yMY8R60FuiC
 TkL1lCgI/Ku++5B0XTyJ35/PFfXRG5c4CJQeAN0f3qYTEkKR4rnJqxXi7BW2h5N4
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:21, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_notifier_grp_info.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/net/nexthop.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/nexthop.h b/include/net/nexthop.h
> index 2b12725de9c0..5dc4b4bba8a5 100644
> --- a/include/net/nexthop.h
> +++ b/include/net/nexthop.h
> @@ -187,7 +187,7 @@ struct nh_notifier_grp_entry_info {
>   struct nh_notifier_grp_info {
>   	u16 num_nh;
>   	bool is_fdb;
> -	struct nh_notifier_grp_entry_info nh_entries[];
> +	struct nh_notifier_grp_entry_info nh_entries[] __counted_by(num_nh);
>   };
>   
>   struct nh_notifier_res_bucket_info {
