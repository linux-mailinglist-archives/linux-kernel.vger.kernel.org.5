Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198737A281E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbjIOUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjIOUbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:31:13 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC270B2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:31:08 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id h8ddqODi7WU1chFT1qTZqd; Fri, 15 Sep 2023 20:31:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFT1qTUV9yBEYhFT1qjqYI; Fri, 15 Sep 2023 20:31:07 +0000
X-Authority-Analysis: v=2.4 cv=durItns4 c=1 sm=1 tr=0 ts=6504bf0b
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
        bh=Kkdv2FJEvxjxaC4VEgUyFSnp9zdXMhA+UqJk1lfUv04=; b=P1vZ9/BIZEmMhWZg6NtsSmsyS6
        k3+xBIz6F/xhUbnrdVN8g8vPBFzwSk+M16qQD4eEmQL0HsTExvEqX5NJHsohlKfYyDcugnNxT5h6y
        LlRECYdm7A1sOtzdEZliw4TPbjFV4La0MN7PasbA5J9UP0xi59IBO8wNLAdmGozU4T0aOu5lICqWs
        C5hSIXrswTxvCNAfvCZ3DLmzWB+Kk4i2XnCcr2beP4VvwLXl3RvEDdyiK5+1CPjIQloPR2Mf8s1EY
        VPAmExPwZMLWufnErsJpIrOsKsWyf2SsUxORhAAOLqvrpO+qMsz5Y9KG+jivItDudQoUbQu6yitDk
        3Wx4Rv9g==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:47108 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFT0-002MyN-0C;
        Fri, 15 Sep 2023 15:31:06 -0500
Message-ID: <7f1577d3-a3f4-3c5a-3761-f56a85eb9c8e@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:32:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dm: Annotate struct stripe_c with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915200352.never.118-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200352.never.118-kees@kernel.org>
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
X-Exim-ID: 1qhFT0-002MyN-0C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:47108
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 97
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBOvxNMoQH4GLoIXQ8SLxcJNzzXoR6+eKgsZ/QeW/Y/Sc0z4Q1Vl1Skb6HdV7mh1mvhnV3ZVSBRoaTAq4tjfkMegVQnsb9oVYq3WHA55S33rd9yjrWPY
 CSjsj8eQxcVPtmpsyUm9aYIvyWs+/IfT2O8C5l4178W2nZXRdODQ9g2GRUGuShP780+wTBuSRNBWCPeOpIAwPULgWFSJwo5RGZPx4CLFqHArb5rQ0vkKTgmB
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:03, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct stripe_c.
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
>   drivers/md/dm-stripe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index e2854a3cbd28..5e70f5ae394d 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -44,7 +44,7 @@ struct stripe_c {
>   	/* Work struct used for triggering events*/
>   	struct work_struct trigger_event;
>   
> -	struct stripe stripe[];
> +	struct stripe stripe[] __counted_by(stripes);
>   };
>   
>   /*
