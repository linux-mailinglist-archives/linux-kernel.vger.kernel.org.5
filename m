Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8187ABEE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjIWI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIWI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:27:34 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D955719B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:27:27 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id jx8Zq18xZWU1cjxz5qSadk; Sat, 23 Sep 2023 08:27:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jxz4q9Ycge2vMjxz4qwJq0; Sat, 23 Sep 2023 08:27:26 +0000
X-Authority-Analysis: v=2.4 cv=H4zIfsUi c=1 sm=1 tr=0 ts=650ea16e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=08UecPEuAbG0l+x/YFl55F1N++K/4bmSxvCFHQB9S5g=; b=WZJsv7aLhUeUqdRKWMwr7Z/VBe
        aw0zDu/2rwadgrRSu0C/OBrB2VFYO2VZo3Do6d2eMPb+cmHrF1NbrhQ+Ohct4/llYYmk5CpHs2EOS
        sK/fC43uSRgN3uPeTnLZdyxX32SNxvC/5BcrhuJA2ihoGDpkFVNh5P1DsTms5MLT+Ipd9M56sL8+K
        WRPYkL8Xip6fib/rJUbCmkLhW49oZcLigaZ/WqRnHVEt8PsitJcnPpLfDUyvyqlvFTdhLO/afX6bD
        5lE7D3uh0zA4l2p1hKkpxV9DA20Z+N/1Gc6j4KAaeH7Ym4rkDKSKp4KvJqCYpwbKEz1+2NLNUgMn6
        7wShJruw==;
Received: from [94.239.20.48] (port=39284 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjxz3-003WvM-11;
        Sat, 23 Sep 2023 03:27:25 -0500
Message-ID: <49eab142-35ba-bc75-9af8-9dfed8b96f00@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:28:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pinctrl: uniphier: Annotate struct
 uniphier_pinctrl_reg_region with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175006.work.421-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175006.work.421-kees@kernel.org>
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
X-Exim-ID: 1qjxz3-003WvM-11
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:39284
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 46
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF1ybXJkf6JEh5C7Ml62CQZ8fuW96VXnYfNlRn9+V1G2aoQAoGWyyQvprGEbXiY/Wi5dD/b4oRXi7ybMmbfaicfPMMu+mKMCONLmBcRMi7Ds5vW68iwu
 7fRHQuxOeRfTt/H7T5VxfN1EwIaKkOxGCCz/18aw5uIy48FBQYHkNlE4oKZm2+LR8gUktcZAssf9rsDJy8yEJI925kXjfQxQUF9ne7BEFDN+ASTVskWeZ+o0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct uniphier_pinctrl_reg_region.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
> index 18d3a4f69e63..fbd0fcdb42c8 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
> @@ -31,7 +31,7 @@ struct uniphier_pinctrl_reg_region {
>   	struct list_head node;
>   	unsigned int base;
>   	unsigned int nregs;
> -	u32 vals[];
> +	u32 vals[] __counted_by(nregs);
>   };
>   
>   struct uniphier_pinctrl_priv {
