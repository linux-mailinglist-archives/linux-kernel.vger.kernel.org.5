Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC77AC504
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIWUVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjIWUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:21:50 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F69F127;
        Sat, 23 Sep 2023 13:21:43 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id k7PaqKg7vbK1Vk98Iqmvq8; Sat, 23 Sep 2023 20:21:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k98HqPjuaIN41k98Iqx1fm; Sat, 23 Sep 2023 20:21:42 +0000
X-Authority-Analysis: v=2.4 cv=Ub5C9YeN c=1 sm=1 tr=0 ts=650f48d6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=Ikd4Dj_1AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mDPsy6zOFKzGEAQrBMZNIHmEMotwQ5IX96a0BW3Jho0=; b=vgiYfPeZV/vP3n6tKjO2L7IEpo
        CkChvIFq2/3AKpG6MNrdqiDFkQpXU+O5xuZUU8RGSEPJC1wvrJ63xg5Tnte3zbhyRjaCnRjvlfr2Y
        Q6Qap6NgsYe+zM3yqEviGjYMnCuGls4YRgnXMUWXPEn5pFQ/bNlDfjzymLuAbg7PXEBwWbmXbA/uQ
        CiGhmcHOOwTq73fV4Rd0U8PSn/vOUwRyxFg9dhaKbCkYGbRELJUp7oZoVm75yfhD2kjV2scbSj3LW
        vcceHZnGGHfvaeUXwClvBimkIgI+OsdAdqk+kniSZqGlloqo4VSITxBiZSCfw3HcbxkrLbb0Q/QnA
        E/jyWZlw==;
Received: from [94.239.20.48] (port=55436 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy7t-003hDN-1B;
        Sat, 23 Sep 2023 03:36:33 -0500
Message-ID: <0d9a5fc1-1481-2c62-2a77-c8d46ee54f92@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:37:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hte: Annotate struct hte_device with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Dipen Patel <dipenp@nvidia.com>
Cc:     timestamp@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175344.work.987-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175344.work.987-kees@kernel.org>
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
X-Exim-ID: 1qjy7t-003hDN-1B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:55436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCDJzloPcHUPHoTKS9lKSyUIubNsdgyXybny3+OAgHGsJlWlh58j88Xj2V3yMO85mCdictiARQ9uZ6DulsuFkyTpYldIUSyjBrYG/vZR1X+gkwzx/1go
 sRFKvBNu3rkdXZmPeqLkWnsq2M3OdHLjyaJDTEw1LhUGF1UCbw94a+mHgFfPbIxDalO6+fYoI5dt+cGkYOapimX3BE//YdICbRQjDqTABgJVShnHdhkW1Rca
 QbHDQ2Q0t4FvIRTKS+IH+MKdMTQ3TYit5/7WOfUQffc=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:53, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hte_device.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dipen Patel <dipenp@nvidia.com>
> Cc: timestamp@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/hte/hte.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 598a716b7364..1fd8d2d4528b 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -88,7 +88,7 @@ struct hte_device {
>   	struct list_head list;
>   	struct hte_chip *chip;
>   	struct module *owner;
> -	struct hte_ts_info ei[];
> +	struct hte_ts_info ei[] __counted_by(nlines);
>   };
>   
>   #ifdef CONFIG_DEBUG_FS
