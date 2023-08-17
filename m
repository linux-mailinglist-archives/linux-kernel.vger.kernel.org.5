Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142ED77FF72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355129AbjHQVCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355138AbjHQVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:02:17 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAFA30F6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:02:11 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id Wj2CqZXGdWU1cWk8AqLy8b; Thu, 17 Aug 2023 21:02:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id Wk8AqvbL8nVnbWk8AqUcE1; Thu, 17 Aug 2023 21:02:10 +0000
X-Authority-Analysis: v=2.4 cv=IuUNzZzg c=1 sm=1 tr=0 ts=64de8ad2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tARRQMv9SG0j8Ou7zFS+GX9Wit7Gyy3VndsgD0vYGeY=; b=jE9eQFREWs8M7/YqBeDH8qcAtC
        onRCpjN6/tuW6IjRfIYHir8zSTHUg8O8EDjl6fvXknSp5DM2orhwhP9Q81BrGqeHNHsIg950eCESS
        LZrk9pRe2fB6lrsN/f3553OTZ5/dqfu9tphZ7HI9jXAWQg9c4+Wok2JUi7bzNe9gCnOiZIs1SZlSx
        t+ZbXD37VZuzCEmMFtlVpcWYp4M2k4OTqfLvtzuDF/eQ1yY7XIv97wpMWztmZH+K3MlcO8sgrdlQW
        gDF+OT+EeymqW8Rzj3dcxEs2wuznkLsM3Dj1jnBJqKnDpMGpm6SigZotqxMI3JxfY2eazcOjt9uKX
        2XQrE/hg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:47346 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWk89-001SRk-0L;
        Thu, 17 Aug 2023 16:02:09 -0500
Message-ID: <35dcbb0a-4dd6-39bf-3948-a069484b622c@embeddedor.com>
Date:   Thu, 17 Aug 2023 15:03:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: rtl8192e: Annotate struct rtllib_txb with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817204523.never.034-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817204523.never.034-kees@kernel.org>
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
X-Exim-ID: 1qWk89-001SRk-0L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:47346
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKSPjzMZFrH0Bd+MDGkdG+PUgDw7mNMrwgZjYJeqT+F0+RF50KtAmUUB4Ma6IgmaGpPnVkHoh7EfghF2cUHOCbEH7rILvL15WU3Rbq4grPP4hnvsNibY
 pW9ZyaXXwg5Iuh7tKSJmVcd7HERFkoG5UMmuWyXnpsP1G8eClcKMmdApsal73ozzJAQYyYyDc5rZn1vWz5lMMKt4o89xviC7LJHWzLrRzM3vpKjT8ZFXzvud
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 14:45, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct rtllib_txb.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/staging/rtl8192e/rtllib.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index c5a692dfcd17..543d8671281d 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -818,7 +818,7 @@ struct rtllib_txb {
>   	u16 reserved;
>   	__le16 frag_size;
>   	__le16 payload_size;
> -	struct sk_buff *fragments[];
> +	struct sk_buff *fragments[] __counted_by(nr_frags);
>   };
>   
>   #define MAX_SUBFRAME_COUNT		  64
