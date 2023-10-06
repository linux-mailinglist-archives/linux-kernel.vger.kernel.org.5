Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BC7BC0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjJFUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJFUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:46:09 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D90BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:46:05 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id oUxKqiv3HNWIeori0qivdR; Fri, 06 Oct 2023 20:46:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id orhzqfru4AwmiorhzqnUcy; Fri, 06 Oct 2023 20:46:03 +0000
X-Authority-Analysis: v=2.4 cv=DN+cXgBb c=1 sm=1 tr=0 ts=6520720b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=0yL73Cyy68KADmUz8mEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BRGB0NNwE8hDgjYAd2KbQaPiR2c564MmUQFT4MQXCS8=; b=ftxxo9hJw61JRpQuu6HdG7d+W4
        bxpt7e2vZYKe3mjDxgN3zkzzvZFDmbmkvPlJZtZhCDi+QjV6zuddVimrTWiRoh00JErWaG279i52c
        QjwhC8+7UF7RgUbL+awusED3/kBKuMP87idsx2YLTf8I0fRWq5/1baJYkJ+e9/g7vMcUXD+MdMqy0
        xjRtCZFap4WaNWMIeTAcJBJSnCu83tGOnezwaY09s2R4UjpYFAgiXhMx55Z8g3fcFgd27CgC5RZ2v
        0NiPIkX+8aTbOzj30hb3swM8y1gelQjdi4/ugEz/NcqGxxPOl+dlzQ9PUj1Hcy+S0XZKLbeC4Q61Z
        dFlArn6A==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qorhy-001Bge-23;
        Fri, 06 Oct 2023 15:46:02 -0500
Message-ID: <94848cc3-6f5c-46d7-8cc7-98a4f10865b3@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: intersil: hostap: Annotate struct
 prism2_download_data with __counted_by
To:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201901.work.278-kees@kernel.org>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201901.work.278-kees@kernel.org>
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
X-Exim-ID: 1qorhy-001Bge-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBe9A/RaiFg6j62luUpX9ms/BMiWjZl0bNIKzpZN4R+A2WNLfM8IeN221E5R1dzh4H/H4lsYj/aq7fh0/tG9tTNK51V6QHzqbeWS3l64SV4g0ZTvMetK
 uc/vbLYi+ElwGsfvLBtUGoBXi4i4kOu9Vfu4IFKUpyqmd+clNpYSJ/t8TpPoFtoqRtP/cjj1/fCj89F9Xkwaj6MJIrF28/0b2dvvDHvTwmXW5yMjO+eyKyQE
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 22:19, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> prism2_download_data.
> 
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/intersil/hostap/hostap_wlan.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> index c25cd21d18bd..f71c0545c0be 100644
> --- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> +++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> @@ -617,7 +617,7 @@ struct prism2_download_data {
>   		u32 addr; /* wlan card address */
>   		u32 len;
>   		u8 *data; /* allocated data */
> -	} data[];
> +	} data[] __counted_by(num_areas);
>   };
>   
>   
