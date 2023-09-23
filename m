Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF71A7ABF66
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjIWJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjIWJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:41:45 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B154180;
        Sat, 23 Sep 2023 02:41:39 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id jx8RqAQaqyYOwjz8sq070B; Sat, 23 Sep 2023 09:41:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jz8rqYoDyI7vxjz8rqBoGO; Sat, 23 Sep 2023 09:41:37 +0000
X-Authority-Analysis: v=2.4 cv=YKeMdDKx c=1 sm=1 tr=0 ts=650eb2d1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=AgWW5FNtAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=8DkScU8FlKhdH4yH5W0q:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jtCXrZWqpgNvF4IRmj9O1vy7JiLl7EHS4J1sxz8kGJU=; b=Cmq39EokFJooLrmvWTUtH/fW7T
        80rgt/jSCPGnIFbvUz+s4vgYNlcnXFS/Ok2FR+LKgyAnNUGkr1SDBbINa95sshBkd0qNNWvZaJ7gh
        paKAwBL3jmJfrDDs22NuwQVraPyc5wgcsXoOWFWpdhGa6McGlVlhmTQtFf4PS3sS8AAcpyJnUC/Sc
        2sPmCnb7NkAgq54CoWchmeerg2XzLNTcLA3qSVRss+pwygBOk+8gj7N6uIpmKZMMChbkQrMbQPoMC
        qViPi/IHct8IzqXvZAwrdAsKftsMPsefav7WzcBiFHVewC+Ekk6oHKIG0TorK8DIPHdeJx5XoeQe6
        M/8vajVw==;
Received: from [94.239.20.48] (port=58468 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy1h-003ZS4-01;
        Sat, 23 Sep 2023 03:30:09 -0500
Message-ID: <7ab3ff29-dee4-7df6-f668-ab90211e6ba0@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:31:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hwmon: Annotate struct gsc_hwmon_platform_data with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175053.work.564-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175053.work.564-kees@kernel.org>
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
X-Exim-ID: 1qjy1h-003ZS4-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:58468
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBtUGMMsV5m2eoyFokxAT93+77l6rEofOBXCVsXvrOW45wyALM7Wga/0K5RoEWfovn/AFYwxrcqgEukw6cxb9Q/3pzrMuvTyT/ZIthQu7c5xCF0uSgUF
 xiNYDLnp6AAnChcLuoNjsq2J8bqyIRDISaOWMSuQ65gdUWAu8Hgg8wWKHI9pUUsRpFi6QQZrLxtaT0AXsOswdut0k9kmlfevz2dJc/aEk1VqMq+p+Za5ckEU
 hn5qzJTbWwD2pMjkUunZwwEiYD40he6gfYsMnFo+Pgw=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
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
> As found with Coccinelle[1], add __counted_by for struct gsc_hwmon_platform_data.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/platform_data/gsc_hwmon.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
> index f2781aa7eff8..70e8a6bec0f6 100644
> --- a/include/linux/platform_data/gsc_hwmon.h
> +++ b/include/linux/platform_data/gsc_hwmon.h
> @@ -40,6 +40,6 @@ struct gsc_hwmon_platform_data {
>   	unsigned int resolution;
>   	unsigned int vreference;
>   	unsigned int fan_base;
> -	struct gsc_hwmon_channel channels[];
> +	struct gsc_hwmon_channel channels[] __counted_by(nchannels);
>   };
>   #endif
