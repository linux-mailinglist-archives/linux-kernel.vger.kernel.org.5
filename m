Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28947B766B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbjJDBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbjJDBxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:53:24 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7541BF;
        Tue,  3 Oct 2023 18:53:21 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id nlgnqXGW2NWIenr4iqHV7t; Wed, 04 Oct 2023 01:53:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nr4iq7OMFfxkCnr4iqAoOl; Wed, 04 Oct 2023 01:53:20 +0000
X-Authority-Analysis: v=2.4 cv=Ncf1akP4 c=1 sm=1 tr=0 ts=651cc590
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EWowgCo6Jaqfnu4yfj8jnGH8w3mBI4yI1LPs54X3rg0=; b=h/OElHGxhqfPCpTefoffiusH9y
        eVZVym6+lToWuYsaqt2jhYciELXfJfK9I+eCpnlGKUrxoooRwfX/GACl0LpohN6O9z/Y6LvfK/VXA
        erqDkxrPKpGbfsYf1LMTv/MzHTFauUht4DX2ELneacOcCasukX55marDh7a3fGV0913Ud3rtmfqw6
        M3Q2tiU+DdsIlJKdZpcKvP3T2Xyp8F+HdYrA45gUUMt27z4ULFA0sorbWarJYwQCw+6ZU6jNRXj8V
        ymF8bPvBnNTMXWtA2/dtGBYAmg7NaUN+R6Hx1ff8LVLdkP2t/A0fw4aJrFQXF0/ZGzWDPV9IXmOKC
        PTv6yLgQ==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:44320 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnoys-001TRc-2W;
        Tue, 03 Oct 2023 18:39:10 -0500
Message-ID: <58e41869-1e2f-a28d-1bbc-1de1e033359e@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:39:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] flow_offload: Annotate struct flow_action_entry with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231833.work.027-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231833.work.027-kees@kernel.org>
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
X-Exim-ID: 1qnoys-001TRc-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:44320
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfITXxWIK1Fk/0VJfPaUCofQGfNSE6Xe0eE4pZFv6uRmK92hy1Vl+GlWiTdMG/nQ8N5tPyhrFy++kwj6Y9lC62oOBRyIZX9ex6n3Y5DT5T/cjTBn6AgmT
 VtCEYS1/SdXQFmFIxUpwAJ/4zqRFOhuWNzvIZCMx6bRNdZwLurW0iljYm3ks8OSPKwgeEBjgJSFlMzR/UIGkpJY9dXLAEs27p7usYbu9cB9DCIFeL+g4XYQn
 jaED2KD06dRZy45rIgAIqVC5m6VPli6RVXsuAhvyOzgeR6XfP9ImFgK6uODD+kQz
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:18, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct flow_action_entry.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/net/flow_offload.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 9efa9a59e81f..314087a5e181 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -333,7 +333,7 @@ struct flow_action_entry {
>   
>   struct flow_action {
>   	unsigned int			num_entries;
> -	struct flow_action_entry	entries[];
> +	struct flow_action_entry	entries[] __counted_by(num_entries);
>   };
>   
>   static inline bool flow_action_has_entries(const struct flow_action *action)
