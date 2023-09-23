Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E77ABF65
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjIWJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjIWJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:41:43 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD0196;
        Sat, 23 Sep 2023 02:41:36 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id jjN2qg1JNOzKljz8qqHS6a; Sat, 23 Sep 2023 09:41:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jz8pqbtnf22LNjz8qqgsww; Sat, 23 Sep 2023 09:41:36 +0000
X-Authority-Analysis: v=2.4 cv=c7O4/Dxl c=1 sm=1 tr=0 ts=650eb2d0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=pGLkceISAAAA:8
 a=ag1SF4gXAAAA:8 a=R1r_ra8lAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=gn-ZpEr0G92kGvUifwg3:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wuizgGGQjlTa5qcBpkishL6sAk1xS1xgcz8EsCc/g6E=; b=Yt0H/eZjshf+wcW4Qoad0EXPKe
        uxm82Mu3xvIiuKlrG4qdWt7t4tOWjaH8CjBgpHLyOlZLJj4rTNsfaBTk0erZ1uyecWRTO/VSExARQ
        nbyMYph8h1V9iTNV5rclPa/5J6Yo1jNzHf2T2n9UpBE0MHIPi14UeVhuG2QQP2JnI7zHripaaoALq
        UJFGVx35drYEJeRznvGZyaJLDXEKY4zOju6sfKrW47fhaohMIr6O+BKvE9fDKE6X49s4kXKSP3MIR
        4ihSZo59TLz7gowO/wkoA6C7lPzyVrGLHwQhaJHhTAaAy/2J/hSLgqU40MdBFYYM5DC7vNkMC3G01
        6vRtia3g==;
Received: from [94.239.20.48] (port=32992 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy49-003bnR-1p;
        Sat, 23 Sep 2023 03:32:41 -0500
Message-ID: <8635d213-d841-a26f-0406-30eb7511f6a6@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:33:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] platform/chrome: wilco_ec: Annotate struct ec_event_queue
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Dawei Li <set_pte_at@outlook.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiang Jian <jiangjian@cdjrlc.com>,
        chrome-platform@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175146.work.219-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175146.work.219-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjy49-003bnR-1p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:32992
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDmqHurpvFohC9rsmOORmbp+Z+v9behE9eBbWnQVEudA7hvAYYOWCNcu+tUiYgD9puzYzBkjTa3snxPHL5fKIGfYFjD4GTH8wQZSx+R00Qwvk6/CX+0W
 MlrI3kzQ4vR6yycmXALcR0bgU145eqTp5tFVGOEANAYJxOxTxnfmCsTmUViDapdmy+HrFhP9h+C3s8dxMKMfHQcLabYNpL04QV/sM6quG3uRNM32xpB3pjZz
 rvjdOxBqi4xjrDefVgTk75owLd4jyEGqLM7VWJuXq0c=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:51, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ec_event_queue.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Dawei Li <set_pte_at@outlook.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiang Jian <jiangjian@cdjrlc.com>
> Cc: chrome-platform@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/platform/chrome/wilco_ec/event.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> index a40f60bcefb6..f80a7c83cfba 100644
> --- a/drivers/platform/chrome/wilco_ec/event.c
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -95,7 +95,7 @@ struct ec_event_queue {
>   	int capacity;
>   	int head;
>   	int tail;
> -	struct ec_event *entries[];
> +	struct ec_event *entries[] __counted_by(capacity);
>   };
>   
>   /* Maximum number of events to store in ec_event_queue */
