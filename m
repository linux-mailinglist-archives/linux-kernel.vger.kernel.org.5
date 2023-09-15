Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C77A27F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjIOUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbjIOUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:18:21 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3422D5B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:16:49 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id hD7oqPbfiWU1chFFAqTTlM; Fri, 15 Sep 2023 20:16:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFF9qUpnd5ftlhFFAqfpKY; Fri, 15 Sep 2023 20:16:48 +0000
X-Authority-Analysis: v=2.4 cv=K8UxogaI c=1 sm=1 tr=0 ts=6504bbb0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=VwQbUJbxAAAA:8 a=PW-KNzBFAAAA:8
 a=20KFwNOVAAAA:8 a=bUQKSiCPAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22 a=AjGcO6oz07-iQ99wixmX:22
 a=84zbTXrhsdUYOv-GFPQN:22 a=-fHZXUhsFbuwFN3fwQAr:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KtMnX6dW2uHowtokVprvS0xbcPmVacza6Mwf4ovlm7w=; b=EbirQaotkGX6sWPICYXtUjafnE
        K5Fz5wFHy8qSGnU7st/4bZkpJoi5AJfGYoJKDWVSm3LPzpyZF4jjD0wLj3bXnxT2E0gpilJ2nAnzc
        oAAuuTwxVYi7E9AAvHJDoLKJ2n0ljTRHjrgjaEAeq8sbzwzrpUD3YU5Uwh7U5TYrrgyHJrmu1R2na
        F7ultmNNhHqszIdAVJOTRmQARekSBr3yjtewPZIecgO+q82YmmCcMZkuZIWHebH0QROncxbQCywdi
        QfGw9PbYmgrTces/Oq2tr50AgwqXOGY0i26gmG46us4VYrSk+OHM2X1LyT/mAnr7VVGxxAYFN0GGD
        5Ppbrtnw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:59654 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFF6-002AbG-2w;
        Fri, 15 Sep 2023 15:16:44 -0500
Message-ID: <fe901465-7820-104c-1761-2095d45cb96a@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:17:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: brcmfmac: Annotate struct brcmf_gscan_config with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230915200542.never.417-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200542.never.417-kees@kernel.org>
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
X-Exim-ID: 1qhFF6-002AbG-2w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:59654
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF679Qrno5iJCAidWRETzhXCSG/nu4M1GhkrlIn94lZdHWF6CrKk6AtsUSeYNE+2R5+y74IwLfogBl4JlU+CcMjFbdRGuKaiDSbQEJfbPm+SVNPcQ2e7
 s5G6Q8LXxLXJYTp35ZRLxLCo6VCloQbOhLczUWu1te4RxyRClOuKmgnuX7X0lJpGdY9MMrL4PkxhywJSMeqpYhj5WTDDznHtG17FVflYrsOqDWmp3Y2Yi28U
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:05, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct brcmf_gscan_config.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Ryohei Kondo <ryohei.kondo@cypress.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> index bece26741d3a..6eef6bc430e2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> @@ -1209,7 +1209,7 @@ struct brcmf_gscan_config {
>   	u8 count_of_channel_buckets;
>   	u8 retry_threshold;
>   	__le16  lost_ap_window;
> -	struct brcmf_gscan_bucket_config bucket[];
> +	struct brcmf_gscan_bucket_config bucket[] __counted_by(count_of_channel_buckets);
>   };
>   
>   /**
