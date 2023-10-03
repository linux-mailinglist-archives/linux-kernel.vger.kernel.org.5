Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F217B7669
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbjJDBxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:53:05 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25472A1;
        Tue,  3 Oct 2023 18:53:02 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id nn1tqLtVsqBU3nr4Pq3jBX; Wed, 04 Oct 2023 01:53:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nr4OqI3h2SMqynr4Oqc1yC; Wed, 04 Oct 2023 01:53:00 +0000
X-Authority-Analysis: v=2.4 cv=ZfUOi+ZA c=1 sm=1 tr=0 ts=651cc57c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=sIshrF94AAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=9VsTxJehNoVBklTQRoEA:9 a=QEXdDO2ut3YA:10
 a=39svzKx7NMVfYuMjZabV:22 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QeRYPjQJyJoIBevbZJo+AiAvu415EP/CLV5hVIXO6mQ=; b=l7vKUf1Oz1C/M/sAJGB6Xsztea
        /+xNt7RpGH/GjIwfLlRG4NBA8aBQ7g2krWd+r/uVe3T+WAXMx21oGWDpR/KjoiaRlkkWNzEUw0T5F
        7qQUSVWJGo2xdqBsZbk4cBE33vM9/vP5l9SzQGpAcwwFQms45aqHMIC9PDfMEdSpp4R3WoAIkPpCk
        yVKXAPZq3u5Cq73l8CZ5pdCVifpAoJ+Z76vVaI2ly4OEyc15jlv7Sc4W5y/ZfgrBgWRRZ7+7Q6yTk
        UCjOShR4U9Z9rOADmj0tqBJz35FwWqxTv/EXwtBDdRRjY43w33pxQt52oqkTHxiwWBgpKkDhnpyV9
        a9jkeD6Q==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:37212 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnozb-001U4H-0w;
        Tue, 03 Oct 2023 18:39:55 -0500
Message-ID: <b45072ab-feaa-e2a7-0cdf-5bab68e066f4@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nfp: nsp: Annotate struct nfp_eth_table with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Simon Horman <horms@kernel.org>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yu Xiao <yu.xiao@corigine.com>,
        Sixiang Chen <sixiang.chen@corigine.com>,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        Louis Peens <louis.peens@corigine.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231850.work.335-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231850.work.335-kees@kernel.org>
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
X-Exim-ID: 1qnozb-001U4H-0w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:37212
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHPjGphMR4Oq/fuv7MKsOL3ySaFXan+rlOLbJpWbucvoFe1pwNH6AxAJW/Yv6nLsnlX6MbPjAccRoTiZx2QnO2xiifQxfNbPRt0gRW77C9KWeCE84YsC
 9Z5AApZfym1sXLhqkFXP9ybgBiFwSVE61ajfvLV6cSs2/3dHBPjNaUmyHJ0H3pG7a/SiEwoZiYNOyUmGXphdsQPBj6bsUSVeGFLsfgpWCqITaQjxc2uhwg76
 6rZjTbhQim3awAO2cu8oYppEvtZs49kRlzyy43MwrYGQ3HqeGiaeYty8NSyy5Ciw
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct nfp_eth_table.
> 
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Yinjun Zhang <yinjun.zhang@corigine.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Yu Xiao <yu.xiao@corigine.com>
> Cc: Sixiang Chen <sixiang.chen@corigine.com>
> Cc: oss-drivers@corigine.com
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
> index 6e044ac04917..00264af13b49 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
> @@ -241,7 +241,7 @@ struct nfp_eth_table {
>   
>   		u64 link_modes_supp[2];
>   		u64 link_modes_ad[2];
> -	} ports[];
> +	} ports[] __counted_by(count);
>   };
>   
>   struct nfp_eth_table *nfp_eth_read_ports(struct nfp_cpp *cpp);
