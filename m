Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656ED7B74FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjJCXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJCXdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:33:40 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3EB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:33:36 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id nlgjqUEM1MZBknotUqU3AI; Tue, 03 Oct 2023 23:33:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id notTq4kAv2F81notTqgAe5; Tue, 03 Oct 2023 23:33:35 +0000
X-Authority-Analysis: v=2.4 cv=a7wjSGeF c=1 sm=1 tr=0 ts=651ca4cf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=iEZwmkagaeyaR-ujPQYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZGNZBVKvev9TXchOa5hWx7nps+DYuiDzkuzUalGDAU0=; b=edJ2EQo4MagW2qPg11wClyPN6M
        mmtkmBylJvJb+98bbqQo40hdEELcuRmiUYXYBrjNtAcEq0/tdOtctYzS14IfaGd3WomMhxZ0RvVuV
        cVwfaEQYOp4ZSuSQ/egtjH4J9SDuimRdm0Z/oyyY75p7gND+fW04GQ9cYvUWMg8JwzmhHHjSRY3ac
        zZp4i0yxH8rvPfBTvD4Rz/1mUqvVNsaMi60MsekwOxLTgaSRs5K2rb+2zJ/2Mh1UrB1mcO2T4JGhm
        X+AVF1HCDRiKHdS1fLV7xfzwHfRdxyycvz+3Pk4i95pgYW8jijD48eiKysZ1eZWHCsnO+dDMC8PuJ
        vtJP5q8Q==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:56204 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnotQ-001Opf-2r;
        Tue, 03 Oct 2023 18:33:33 -0500
Message-ID: <dcc5978b-c77d-ce0d-7d49-b930984db1f8@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
To:     Kees Cook <keescook@chromium.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231718.work.679-kees@kernel.org>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231718.work.679-kees@kernel.org>
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
X-Exim-ID: 1qnotQ-001Opf-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:56204
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAARoS8dS/InAoRuC7Bkoieu1rptYrLi4YIJ7IMdiglBNTCmvvHEVSgfpNjRsJQuLpbTHNsdWt4VH7NaJZxqev3MLD3k+gTGC9x0kDy4Fm7I7XVpeLZM
 WGzOs+DzUSybb2CCP53rNOgbjRGgfT+SbvYHU5izNw+yiFT4dg853FYQ96Ju1NJnNC4gKWWIR3xzKwNx9tH8JY4ikna8xg3Xdfs/0bdKCuayLeyN5CbrQALO
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> index 17fe30a4c06c..0c26d707eed2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> @@ -539,7 +539,7 @@ struct mlx5_fc_bulk {
>   	u32 base_id;
>   	int bulk_len;
>   	unsigned long *bitmask;
> -	struct mlx5_fc fcs[];
> +	struct mlx5_fc fcs[] __counted_by(bulk_len);
>   };
>   
>   static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
