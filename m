Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA97B765D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbjJDBqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDBqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:46:04 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33CAB;
        Tue,  3 Oct 2023 18:46:01 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id npJ5qY89aNWIenqxcqHTNl; Wed, 04 Oct 2023 01:46:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nqxbqBPih3s6Tnqxbq6DO7; Wed, 04 Oct 2023 01:46:00 +0000
X-Authority-Analysis: v=2.4 cv=EoDBEAQA c=1 sm=1 tr=0 ts=651cc3d8
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
        bh=Hln1ZH+P279DPfU6DvTo+WLQ5/zWlyvXgx6IBvAK7tc=; b=Rsqkmy20Bd0Hj/aUt1kEFlt4wO
        UXDU5uqYJhoNjew4RY7i5/p1OozvdQTIODUjDGIUf+NYIxddQf27npT0RweBg/kaFaUJqUk5V0KMP
        SXBFV+r4v78oVnGYWOU3epg65ajaxHg2xJxvZus1pPla4w2wDPaJpznwQgjeFNgp3g8Gpy6PGNA21
        gLo5CjeXLomoWXuImB4mK3kdzoAVL2SiEcWKpEu16LhtppUrsLLkgvF6NwNyS/2nHmsdBUlhW0zSJ
        lf/fyOB8+dZN0VWAwfSEaoNsjoJ70djDXM1gm6V2qh99oPNjwhP/f2fw4PAWs2iD10GzUutqXlfiG
        Zvccsa+g==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:41938 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnozK-001TqT-1b;
        Tue, 03 Oct 2023 18:39:38 -0500
Message-ID: <63f3d89e-41f3-65c7-0a29-fb667960243f@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nfp: Annotate struct nfp_reprs with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Simon Horman <horms@kernel.org>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, Louis Peens <louis.peens@corigine.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231843.work.811-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231843.work.811-kees@kernel.org>
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
X-Exim-ID: 1qnozK-001TqT-1b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:41938
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCSK8tNWkHs/VqYoum/MtjJrNiGBoQUuP+UzAzTCmnJV2g3FAYnnrJzKgfL7eZeh5dA1nt1wknGzmbnpPx+bvHQiK3fyaLZBbBz/t1nv9y12BpSSij02
 uYSiRzTQpIwqYv4qBI09iD2B3ougGodJeFeMwyY71DJZOozUGowZfQF2A7n2pFrVntDgoF/M9wvhOkUsaCdMreM0VNPMRXpsJnNXBAt0lq3Gu83TwQiVsABS
 j7DhTqrHh4S6RCbQqjePj24XEPtHXcZcj7dzVRuRXVi2VwnTC0Rq2z/t5jn4jiMm
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
> As found with Coccinelle[1], add __counted_by for struct nfp_reprs.
> 
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: oss-drivers@corigine.com
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/netronome/nfp/nfp_net_repr.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
> index 48a74accbbd3..77bf4198dbde 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
> @@ -18,7 +18,7 @@ struct nfp_port;
>    */
>   struct nfp_reprs {
>   	unsigned int num_reprs;
> -	struct net_device __rcu *reprs[];
> +	struct net_device __rcu *reprs[] __counted_by(num_reprs);
>   };
>   
>   /**
