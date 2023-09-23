Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91A57ABEDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjIWIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjIWIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:25:13 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C6198
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:25:06 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id jjN2qsUKvEoVsjxwoqGtkm; Sat, 23 Sep 2023 08:25:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jxwnqaV0H22LNjxwoqgClj; Sat, 23 Sep 2023 08:25:06 +0000
X-Authority-Analysis: v=2.4 cv=c7O4/Dxl c=1 sm=1 tr=0 ts=650ea0e2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=xOd6jRPJAAAA:8 a=KS6gg5_tAAAA:8 a=cm27Pg_UAAAA:8
 a=9o_zG6Dhc6zXjm0x12cA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=hZ4L7c2QG0rhM108vGPe:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qWZdHccnt1fvi8xDwRL+9uDuNFG1guvBJy7s0ev0k3A=; b=kCrXN2UxanPx6VovsFtA6QureC
        2ttIT0s7GS2snyH6TkQoX8w2UyKOpqNrmfP7bwdYuS6gb/9tc4SicVw1W8l950SAl33+a0veAk7fG
        YREJ+V2bAi3h0MD58oqAFiQwMR6HsGVpwqrTHZwP/1Zryc0BdLIkjrMvduhw4N69AvFsHTES1JlMl
        iRwx4pFfNjTnNIg9bk0pJ0NVMe24+xm/N2PWrEywPb0HH8PSYAzgdAoc5m3TVcRDpljnZxaux3HZf
        C5kQfbLW8k9tvDkUSQkwF0BeOxG8IwryPnEUadVl9PGV6du/PeaThb2+PoON8dzMS5gpifkG+01LI
        5W9rDSbg==;
Received: from [94.239.20.48] (port=54178 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjxwm-003UfP-2R;
        Sat, 23 Sep 2023 03:25:04 -0500
Message-ID: <03569fde-125a-f4af-4501-a47ce2440a0f@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:26:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] media: v4l2-event: Annotate struct v4l2_subscribed_event
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        lijian <lijian@yulong.com>, linux-media@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922174951.work.160-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922174951.work.160-kees@kernel.org>
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
X-Exim-ID: 1qjxwm-003UfP-2R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:54178
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEhpGcofgOUKVEbCugfCqjiCxDy3aJxJP99FmN7D94kYxl3NDqlEEULmXqjn6oufS4VmrxJ4eFfsFXEY8m4/Vn5/XiNS+ZZ6I4bZi+jTHiMTKyGwsU1c
 aHOv924GsfE/K753pc4hv8VmVUMad8Xx0n64gNTX4VZGm4KYSJ9LOELfeimwlLUYbxgO0QvJ2usKImN6TJefkizszlaFI/+5JwzyTgkXdvbck82YoYc5d9oZ
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct v4l2_subscribed_event.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: lijian <lijian@yulong.com>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/media/v4l2-core/v4l2-event.c | 2 +-
>   include/media/v4l2-event.h           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
> index c5ce9f11ad7b..3898ff7edddb 100644
> --- a/drivers/media/v4l2-core/v4l2-event.c
> +++ b/drivers/media/v4l2-core/v4l2-event.c
> @@ -238,6 +238,7 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
>   	sev = kvzalloc(struct_size(sev, events, elems), GFP_KERNEL);
>   	if (!sev)
>   		return -ENOMEM;
> +	sev->elems = elems;
>   	for (i = 0; i < elems; i++)
>   		sev->events[i].sev = sev;
>   	sev->type = sub->type;
> @@ -245,7 +246,6 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
>   	sev->flags = sub->flags;
>   	sev->fh = fh;
>   	sev->ops = ops;
> -	sev->elems = elems;
>   
>   	mutex_lock(&fh->subscribe_lock);
>   
> diff --git a/include/media/v4l2-event.h b/include/media/v4l2-event.h
> index 4ffa914ade3a..3a0e2588361c 100644
> --- a/include/media/v4l2-event.h
> +++ b/include/media/v4l2-event.h
> @@ -78,7 +78,7 @@ struct v4l2_subscribed_event {
>   	unsigned int		elems;
>   	unsigned int		first;
>   	unsigned int		in_use;
> -	struct v4l2_kevent	events[];
> +	struct v4l2_kevent	events[] __counted_by(elems);
>   };
>   
>   /**
