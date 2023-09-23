Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835FD7AC41A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjIWRlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjIWRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:41:48 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A355136;
        Sat, 23 Sep 2023 10:41:42 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id jx8ZqvAY6EoVsk6dRqJ0e8; Sat, 23 Sep 2023 17:41:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k6dQq4GXIHmohk6dRqMgX5; Sat, 23 Sep 2023 17:41:41 +0000
X-Authority-Analysis: v=2.4 cv=Avz9YcxP c=1 sm=1 tr=0 ts=650f2355
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=iox4zFpeAAAA:8 a=foHCeV_ZAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
 a=qjWHau5h7Oqj65Zv8QkA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=h8a9FgHX5U4dIE3jaWyr:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=93ZnapHLAzhfjp9su+EviZJ/5xXSQ8EviN5S7/1wWMQ=; b=mSOS2op9ZyaNpjPP1tXCBZePjp
        1quPoFjTeldDvJvK7unBQqp9pqubI2qRl+FZTR5U5ictKyLN7xckfnyZRLkAbdKQoYlgs8bzeghy2
        iL6OdUSW4F+uqSC7P5jDsiphQrtXxD2ZQZsF1cdfGUELJT5myIK03/P3/ILrQuIA71JKtkh79vV2L
        o3ru78NibuG85lVIj2FHVukbs88u9w8Uv4R7IUvmXUIfLTJvOJ1aQOKCVbicxWE5GTubbozvXtTVL
        qYUNoe8tIIXMHeAek8/6eeRnugQqSV6LWPsUiKr67VILxlBLnNsuBkRk22zYJUqYBJ2DDXSQO3Trx
        ohHDolRA==;
Received: from [94.239.20.48] (port=44874 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy1H-003Yer-1S;
        Sat, 23 Sep 2023 03:29:43 -0500
Message-ID: <672fa6b5-d311-40cc-65b0-b042ccae69b5@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:30:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ALSA: usx2y: Annotate struct snd_usx2y_urb_seq with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175046.work.766-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175046.work.766-kees@kernel.org>
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
X-Exim-ID: 1qjy1H-003Yer-1S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:44874
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPuhRgahiVklsdVff3Kdq4nP9ouj6jajC5qZZdJjC9S9tX3beh8WFywkBYxqv3Umj6gpHnv9OmiHerUIwPGySG2xRFrwadvZQkTWSov1F8N5juH437SG
 R1U4KYHvbIW6smpPYvvf+4iCv05W8HADNtzS6EwEA9w/kDPR3ikfs6Ywidu5yzxpFqvIm8qsgxghlG9ExdZUapuYSNLWxREh1F//7amnerL6PtrbOMdzh2sL
 jAkIJysU2kgOADLzH568LpJU3Q1xemij6C5/kQKBERk=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:50, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct snd_usx2y_urb_seq.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   sound/usb/usx2y/usbusx2y.h      | 2 +-
>   sound/usb/usx2y/usbusx2yaudio.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
> index 8d82f5cc2fe1..391fd7b4ed5e 100644
> --- a/sound/usb/usx2y/usbusx2y.h
> +++ b/sound/usb/usx2y/usbusx2y.h
> @@ -18,7 +18,7 @@ struct snd_usx2y_async_seq {
>   struct snd_usx2y_urb_seq {
>   	int	submitted;
>   	int	len;
> -	struct urb	*urb[];
> +	struct urb	*urb[] __counted_by(len);
>   };
>   
>   #include "usx2yhwdeppcm.h"
> diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
> index 5197599e7aa6..ca7888495a9f 100644
> --- a/sound/usb/usx2y/usbusx2yaudio.c
> +++ b/sound/usb/usx2y/usbusx2yaudio.c
> @@ -681,6 +681,7 @@ static int usx2y_rate_set(struct usx2ydev *usx2y, int rate)
>   			err = -ENOMEM;
>   			goto cleanup;
>   		}
> +		us->len = NOOF_SETRATE_URBS;
>   		usbdata = kmalloc_array(NOOF_SETRATE_URBS, sizeof(int),
>   					GFP_KERNEL);
>   		if (!usbdata) {
> @@ -702,7 +703,6 @@ static int usx2y_rate_set(struct usx2ydev *usx2y, int rate)
>   		if (err < 0)
>   			goto cleanup;
>   		us->submitted =	0;
> -		us->len =	NOOF_SETRATE_URBS;
>   		usx2y->us04 =	us;
>   		wait_event_timeout(usx2y->in04_wait_queue, !us->len, HZ);
>   		usx2y->us04 =	NULL;
