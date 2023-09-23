Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7E7ABED7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjIWIYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjIWIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:24:34 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79F180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:24:27 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id jnFoqh3m5OzKljxwBqHC2p; Sat, 23 Sep 2023 08:24:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jxwAqBDB13FgHjxwAqT9dS; Sat, 23 Sep 2023 08:24:27 +0000
X-Authority-Analysis: v=2.4 cv=F4tEy4tN c=1 sm=1 tr=0 ts=650ea0bb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=x_RLF880AAAA:8 a=IXr_WNlcAAAA:8 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=gQTog8Qx81Ab3WLl5k0A:9
 a=QEXdDO2ut3YA:10 a=jCPSC2jcP07J4OBJNHyf:22 a=K24ECnMRWNUKRqF_MnsZ:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KYMAErdkolcSoZbgUhBMI2wZn//SGSGFc89+vETw29c=; b=NPMGblqr6awDP5CreG5PI0zYu3
        dZq0M4yi5TmtWJS47EPpFYdUfHESrES1fT7eShNXCHIex3GK+j78ZeX6tZzJK1+O4Y3iBBhgKJhV5
        Zn8gFp/M0RYQ5iMRXgxDk7BTRwh82+miQcHHOi0cwCNZNvKg26zE6sGWiI8ZBYvxjMsoAZR8FhOBm
        q8okV+aRuyedi3IrkVhylkXkI3//9W4oOquC5ZliZSeD+Hv/h3T6tj3BV7aoLeEY0PWOnnJaQncPK
        IwqQ5LdNVJa5hLZs5tAn6vyma1XK5Qv1J1MRW8ry6freLNoJ5jUiKRpi1CGkRTitrCDMzhVPJrZnL
        94UfsgsA==;
Received: from [94.239.20.48] (port=46684 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjxw9-003TvN-2J;
        Sat, 23 Sep 2023 03:24:25 -0500
Message-ID: <2b9b1259-bff8-c82e-bd87-af3d2bfc4a54@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:25:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ocfs2: Annotate struct ocfs2_replay_map with __counted_by
To:     Kees Cook <keescook@chromium.org>, Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ocfs2-devel@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230922174925.work.293-kees@kernel.org>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922174925.work.293-kees@kernel.org>
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
X-Exim-ID: 1qjxw9-003TvN-2J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:46684
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCp1F9SUtRCnL7F8FitFpvOR2uCvWzO2fvK9ZgU6UfyTyYDkGso5zw61UvFv+WQkBXteLM8yefMBbqBCF+sUM/wYfhl/xPNfunRzkpvLTyIbUyF6Mwhq
 0ag8v3vhs9wI0c2Gby+/PjTm67uagwz5052rd7qHLc/3qfuzXnUguZbzdxAd2rXbkoGsUGiPc8JWyQ+oDuE2s6s8fKvyN6x0gAIlNcSWavEP+1+T9k2lr1fx
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:49, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ocfs2_replay_map.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: ocfs2-devel@lists.linux.dev
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/ocfs2/journal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index ce215565d061..604fea3a26ff 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -90,7 +90,7 @@ enum ocfs2_replay_state {
>   struct ocfs2_replay_map {
>   	unsigned int rm_slots;
>   	enum ocfs2_replay_state rm_state;
> -	unsigned char rm_replay_slots[];
> +	unsigned char rm_replay_slots[] __counted_by(rm_slots);
>   };
>   
>   static void ocfs2_replay_map_set_state(struct ocfs2_super *osb, int state)
