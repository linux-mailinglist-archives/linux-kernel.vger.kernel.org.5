Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24F7A281F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjIOUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjIOUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:31:30 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA52106
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:31:23 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id hFEbqkPMcbK1VhFTHqlFLf; Fri, 15 Sep 2023 20:31:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFTHqwvmBZRGzhFTHqOJSJ; Fri, 15 Sep 2023 20:31:23 +0000
X-Authority-Analysis: v=2.4 cv=PLscRNmC c=1 sm=1 tr=0 ts=6504bf1b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=1rGUjaHSoLxGkM6IGjIA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sEj9TaLmgQVbeOxveAR1hIt1TkUwVYJDz01Bb1bSBRI=; b=sGZg0wpXweHx+Ci3tEobbCu++o
        TJxHYYeWbbDR+4vJ1ry4LXCe9pmORLbWxGluCBTLgnAqDKRLaEMGfcV2sJYDL8MJIy+pV/34zkg3t
        TxnokqGg05Ba//0kZhDNu4kMTJKAktOmCENX0LM8Da/sSsBUN50YLFzM8vN5SwGZp8XPIwhaxffKB
        s5RTmiyBy57t3BbizWHW3ZP9Y49LJKlAwhfPuYf6C9rJ+2b1BXBL1P2cpFSew9UGmLZmBMDmJdBvV
        tRxZHg9cNULumjc3e4ACJ8djb+2Pn5eTX8KYI8Ey1f5q8/hBTkQgkq2O88BjWXWgLprv8/XOdwLpE
        arkl8sbQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:54882 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFTG-002NAG-0E;
        Fri, 15 Sep 2023 15:31:22 -0500
Message-ID: <13649f74-874c-c2bd-769a-87b6b4559ff4@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:32:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dm: Annotate struct dm_stat with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915200400.never.585-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200400.never.585-kees@kernel.org>
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
X-Exim-ID: 1qhFTG-002NAG-0E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:54882
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 107
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE8cTLKmTtKAU39+hLVzyJcoQpLqY9fq4OGq2F0mgrCK4vo+gQ+vIl7kJfRHYd8lhT99+Zkbo6ZvdkOHQbRPt1wuco/HtJtJRM1HgiQejqzEcGImHoWO
 Q3rVrkOvd3Zp6o9cx4Xwqy0W6ZrvOgQzGsGZmxqdfuapBAQ6pV9dOwHSkCgu8gU7NSU2TNgxU4BKPEeThkLRGaHEQz4QaAahdUas7wJ5yv/Vukhr6HGsRrMN
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:04, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct dm_stat.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: dm-devel@redhat.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/md/dm-stats.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
> index db2d997a6c18..bdc14ec99814 100644
> --- a/drivers/md/dm-stats.c
> +++ b/drivers/md/dm-stats.c
> @@ -56,7 +56,7 @@ struct dm_stat {
>   	size_t percpu_alloc_size;
>   	size_t histogram_alloc_size;
>   	struct dm_stat_percpu *stat_percpu[NR_CPUS];
> -	struct dm_stat_shared stat_shared[];
> +	struct dm_stat_shared stat_shared[] __counted_by(n_entries);
>   };
>   
>   #define STAT_PRECISE_TIMESTAMPS		1
