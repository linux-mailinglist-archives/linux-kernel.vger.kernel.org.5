Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615D7AC300
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjIWPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjIWPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:01:55 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFCB1AB;
        Sat, 23 Sep 2023 08:01:42 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id jjIKqsSpLEoVsk48bqIOqN; Sat, 23 Sep 2023 15:01:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k48aqRRWRVpk9k48bqTYIL; Sat, 23 Sep 2023 15:01:41 +0000
X-Authority-Analysis: v=2.4 cv=CLw54DnD c=1 sm=1 tr=0 ts=650efdd5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=XYAwZIGsAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h2JnaxzcDOfYQhR06HHQsp2vfzPkaf6txflWyqVlfhE=; b=oopkxCbsRkvXM9XW1x+g55YR91
        oOfcgFDXPzV4KTEo0mc+IZrrDddM3I3sbpVEstDKfbKUYArJ5t5738R9cgrLHuXYQbdOTInB2+BfI
        cK5Q9GOeQ8TbeYgJVor8FR7RkEYL7k/Ic/kBoTZMsIN7gJnY+q1AE5r9fvHW3ktB48bsRzL84wKBF
        Rjom/3tlT0a5kgPaLYYURqpjlnuVfB/RG4mKaogAe3KgdqxDVerYkC1cD3PS5KXn61PDKBvuv0p+D
        pcqLxrrUxbl5+UwFHp6O9WsMgrEPiqkJveiydmRvm8pl2GvC9yn0P+abNc4onjYgNM+VuBwm2YKcE
        ms2d3tVw==;
Received: from [94.239.20.48] (port=43962 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy5d-003e2u-1l;
        Sat, 23 Sep 2023 03:34:13 -0500
Message-ID: <b98d51d3-5fbf-e627-4ffe-46392a28a447@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:35:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] memory: atmel-ebi: Annotate struct atmel_ebi_dev with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175215.work.122-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175215.work.122-kees@kernel.org>
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
X-Exim-ID: 1qjy5d-003e2u-1l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:43962
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBPWwgDw6OXnenb64JfkkWRIgYMOxYM+SqBAuxZU0DUSJwxmhmGqR6H6ZsyY9lRqi383y5s5RMDsOi4lynxtnHmsGL3yvNWCUdE5P5+q9S34WuTnvE8j
 3W5ZJUi1pl/eOoSDpOZpWb+Ti1eWtuCg73iAQUa7CplVAL4t8RXQ8Bb4na6kM0k6xHL21osxfXpBc6vAnZzK9TmEwQAEhrYcI/rRkVc5GGvwjdtq++nWxyRy
 VJsoR0L4bh+fYbcDVNMVLKV4XEHYFsPRkaRkCWhyBXc=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct atmel_ebi_dev.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/memory/atmel-ebi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index 635966d705cb..ec6100bc94c5 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -30,7 +30,7 @@ struct atmel_ebi_dev {
>   	struct atmel_ebi *ebi;
>   	u32 mode;
>   	int numcs;
> -	struct atmel_ebi_dev_config configs[];
> +	struct atmel_ebi_dev_config configs[] __counted_by(numcs);
>   };
>   
>   struct atmel_ebi_caps {
