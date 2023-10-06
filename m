Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED577BC0B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjJFUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjJFUrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:47:43 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85239F2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:47:40 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id onwlqG7KhaLCxorjXqnpQq; Fri, 06 Oct 2023 20:47:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id orjWqOhHoZLueorjXqrr92; Fri, 06 Oct 2023 20:47:39 +0000
X-Authority-Analysis: v=2.4 cv=E+reGIRl c=1 sm=1 tr=0 ts=6520726b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=0yL73Cyy68KADmUz8mEA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uutu2d96GOUWoDaNZkSgG8iTdQ1zETIvXR8LQU44b6c=; b=zp+qGE273mXifSnwj9eRj3iYCP
        xQO6KK9aQwBPhPKnhKBMPnFbrObfSfjawnGJv2BXXqOl6EVmSsa02ad0UZZ19xZ+0IDNRtJwQg1G/
        dKTYyHNyTULKWzmZZRO0rzTH8hzJRJQLG0RSbnHsmPcOlJsvr66LRQv1wCy19ijuVaLLhkYWOUa7z
        9qEmidpfXeG5jHQTUr4eS26qJdDG8/tTaDiVIe9gb8RQqUFoMbIeE21ZPWxqWdIqaK/sNsMGX8sIT
        n4sAlV5lZcQg1AVmUYVFUuYeHLPLyTMM1Ei/KNZwcQppTek5utZFho+0Mc6np9+5EvLdSI69P2cJr
        up4vErBw==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qorjW-001Bge-0I;
        Fri, 06 Oct 2023 15:47:38 -0500
Message-ID: <07438cd0-0bd2-4505-a787-cc30b2340719@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: Annotate struct ff_device with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-input@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201739.work.350-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201739.work.350-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qorjW-001Bge-0I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 69
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCzogL7nVlZoeGgtZ3fPblJt/PLqmC4tCRqwI/SKH82gIuTwep0sqh5ceji2Y2oSpvIylJR2kZfm3BXtnGtubnHj7nnEvc+8t9Vo3mtYk2G8NNpwvzki
 s8ELNwH96Oi7LLDM5DwCv52fIMLDCk/vX4Ygs5src9gFk2PZ+FUXrlsLNa998f0YVin3nOQ3OIFZyB6XwZgW05zi8FrZnvT+blPtzi45z8xVMhyDo/lU9dcX
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 22:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ff_device.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   include/linux/input.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 49790c1bd2c4..de6503c0edb8 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -562,7 +562,7 @@ struct ff_device {
>   
>   	int max_effects;
>   	struct ff_effect *effects;
> -	struct file *effect_owners[];
> +	struct file *effect_owners[] __counted_by(max_effects);
>   };
>   
>   int input_ff_create(struct input_dev *dev, unsigned int max_effects);
