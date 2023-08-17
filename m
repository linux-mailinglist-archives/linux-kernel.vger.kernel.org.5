Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56B77FF50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355048AbjHQUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355082AbjHQUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:52:09 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B33588
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:52:08 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id We1vqwOsdfaVXWjySqLZ4M; Thu, 17 Aug 2023 20:52:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WjyRqXAAtDHerWjyRqkLHw; Thu, 17 Aug 2023 20:52:08 +0000
X-Authority-Analysis: v=2.4 cv=MN5zJeVl c=1 sm=1 tr=0 ts=64de8878
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=xVhDTqbCAAAA:8 a=pGLkceISAAAA:8 a=77d_1CzMAAAA:8 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=GrmWmAYt4dzCMttCBZOh:22 a=QN4qkdld4szc5MSp8JWP:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VioEz5G8YTOEnVp9KTSVuftAiGJ+QqIcrXKXiyfBXxo=; b=gRfj77ASVgwk7W9vj9NUd5LT59
        x2/zDeRrxkJDlOexjziQTrEXg9RvoGfgTQbIRnbKHs8VDFX5DdyC2IcAfxcfPhzQR0X6sbNcS8/jX
        +ajCNDc0xvIWbU8xHxkalORbTahdOyEkySt1Tm5z2TCOITNMTadT07SwjyJkCtbsvTQyVb5JTQtZ/
        9G71q4cbbM8cofQtQPjE9jDldyHRTMmsNBfVj/L8xPV0vEGq8UrqMtA1OCSc3wpv/VYo9wxSFMvPl
        OCHRhv3pGiieTrdO9LGdNj7yeDAaBY7suszXDHmIYKccIli+AvBhchfm0g7ueBx58HMlfmDqof/9h
        FrsLBRWw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39854 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWjyP-001JbT-22;
        Thu, 17 Aug 2023 15:52:05 -0500
Message-ID: <ae4756a2-55a4-fe0b-50e0-b87c17151354@embeddedor.com>
Date:   Thu, 17 Aug 2023 14:53:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selinux: Annotate struct sidtab_str_cache with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817202210.never.014-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817202210.never.014-kees@kernel.org>
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
X-Exim-ID: 1qWjyP-001JbT-22
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39854
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 55
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK5joA3Ffn7jhs9XPoTwFg4kaEeULHQmbfYmo+QD74pLvdVNDIkYCinFRSkm4TIewgDMQClc4s/pMYCjL0dtp3pY7VqJkYGZNeOT9sxte50C7KJhB6uJ
 JGLSF+M/HTLM68gDINS/PE432zVErdGqV7fVQxrwu1g1/gweDPHTUY29ZBY/tgzS3exi783Q5byZ5bZwtrgIgDqBOLXslDYVIjcdnIV/UMCP6ej3WWOXGRud
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 14:22, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct sidtab_str_cache.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: selinux@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   security/selinux/ss/sidtab.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index d8ead463b8df..732fd8e22a12 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -25,7 +25,7 @@ struct sidtab_str_cache {
>   	struct list_head lru_member;
>   	struct sidtab_entry *parent;
>   	u32 len;
> -	char str[];
> +	char str[] __counted_by(len);
>   };
>   
>   #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
