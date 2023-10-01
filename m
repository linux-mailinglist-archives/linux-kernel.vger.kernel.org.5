Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B67B4681
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjJAJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjJAJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:13:38 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD85DBD;
        Sun,  1 Oct 2023 02:13:35 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id mektqJp77NWIemsW7qthYR; Sun, 01 Oct 2023 09:13:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id msW6qMDOEBsZEmsW6qFaZn; Sun, 01 Oct 2023 09:13:34 +0000
X-Authority-Analysis: v=2.4 cv=bax47cDB c=1 sm=1 tr=0 ts=6519383e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=cLZyiMI5l2q1nrJyhZUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IrcoHngMEI3PscYSp/Yz5U/Odq3VqzylH1QDFm3GoFc=; b=wENTTVexpEzDAK1AaTXmTVTBCH
        HcQdwyPj1nfMN7BPfWZyzbIGYDJbD4fpVkyOgDZ4uCN/lvfuDJbzj0JXwA7AFa75V0rR5+i8sVxr8
        q4s7FyxXzwBrSHLPeYKQiaFqNiuLfr8oESTuq2XH8j7rwA3pUS9qf7ois5YmGlbrNJcQI75t64Scb
        AVmiffu2dRGR2MrLvyyqq82EtDzbQIhx3TV5+vUHane82zJol+mtFN5PJzTTNBdG41t4RsZjzLe92
        uJn2gdKrbPBCbQj02bhQ/lSDIrV34rosz3Gzhs96y98LxBvN2nOOGxB1LhlV7VPd5RbrBD1OMt3FN
        tV56v4eA==;
Received: from [94.239.20.48] (port=43308 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmqnU-0020ti-1f;
        Sun, 01 Oct 2023 02:23:24 -0500
Message-ID: <7ae7737e-e32c-e9e7-880c-cafc240e7c33@embeddedor.com>
Date:   Sun, 1 Oct 2023 09:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bcachefs: Use struct_size()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
References: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
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
X-Exim-ID: 1qmqnU-0020ti-1f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:43308
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJV7R3hh1LzRfvAnjgMTJBwXQOSvgrtPZWtBNBaUWkODEpkynlZvciSgfBrKfALoIubDUo4K9IaHtYpUurxwyTUP8BRhNc1PzGR4P7PJHacdTRYeoOlp
 uE+X2zUYOMlut8e1hSTQLGgItGS3KhwvIef+pSSiTSOA6hnrHF62NdFOfBfAlnqzQ5u7hqqOtUVe58glwVln/X0MDhYkJLY6Nz8Rizu6GGes+MKzBCHY/oAi
 Q8x8dn/7KUHhVHsk2DISSNJzxvBGJFgZTtQsG//hPoDai9V0d5qXV0Rf7RkssuuOmIBF6KE2QiyXsms6/g4JOQocmhd2XN/BXLIOnebU+ZC/3ZeKiwSiMBWH
 m8Hm7VE+
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/23 09:13, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> While at it, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with __counted_by
> can have their accesses bounds-checked at run-time checking via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).

I would prefer this as two separate patches.

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

In any case:

Reviewed-by: Gustavo A. R. Silva <gustavors@kernel.org>

Thanks
--
Gustavo

> ---
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> In this case, struct_size() was not used to compute the size needed for the
> structure and its flex array.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>   fs/bcachefs/disk_groups.c | 3 +--
>   fs/bcachefs/super_types.h | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
> index b292dbef7992..224efa917427 100644
> --- a/fs/bcachefs/disk_groups.c
> +++ b/fs/bcachefs/disk_groups.c
> @@ -166,8 +166,7 @@ int bch2_sb_disk_groups_to_cpu(struct bch_fs *c)
>   	if (!groups)
>   		return 0;
>   
> -	cpu_g = kzalloc(sizeof(*cpu_g) +
> -			sizeof(cpu_g->entries[0]) * nr_groups, GFP_KERNEL);
> +	cpu_g = kzalloc(struct_size(cpu_g, entries, nr_groups), GFP_KERNEL);
>   	if (!cpu_g)
>   		return -BCH_ERR_ENOMEM_disk_groups_to_cpu;
>   
> diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
> index 597a8db73585..78d6138db62d 100644
> --- a/fs/bcachefs/super_types.h
> +++ b/fs/bcachefs/super_types.h
> @@ -46,7 +46,7 @@ struct bch_disk_group_cpu {
>   struct bch_disk_groups_cpu {
>   	struct rcu_head			rcu;
>   	unsigned			nr;
> -	struct bch_disk_group_cpu	entries[];
> +	struct bch_disk_group_cpu	entries[] __counted_by(nr);
>   };
>   
>   #endif /* _BCACHEFS_SUPER_TYPES_H */
