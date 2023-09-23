Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291777ABF71
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjIWJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjIWJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:42:14 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A7197;
        Sat, 23 Sep 2023 02:41:50 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id jkvlqyk2aWU1cjz93qSqCk; Sat, 23 Sep 2023 09:41:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jz92qVlwT8SgTjz93qMfdg; Sat, 23 Sep 2023 09:41:49 +0000
X-Authority-Analysis: v=2.4 cv=VLTOIvDX c=1 sm=1 tr=0 ts=650eb2dd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W59l0qYTaJCJR+DSooa3iIlRJqVuefAJWm70dNU33tM=; b=n1skR6Z83tyH06zw6HanzSoLGt
        GmhipnH13DzlSeNZWRxSiW7YIFRd3NrKekMLH4Kg7ZUL7NsFYIE/3n3zFsjOjoOFMmQKIC2JuXXK9
        fw8cU1BOREgyvDJ+0wSez5l7na5w8P3Wgbd4iQFS9jhEs6r4ruxBLq+jYjkFIu2/J2HghwY6iDvjo
        szoowIGTHJsxPOspnqZKBRKRkwItA26Yqhc0oYSmbitMGqlIaNNDJTGEogDMFdHtcXI8+FDJxfXfi
        1hgA6rVoD8EUioBRui2te4qVhCmcxPOvKJy3cs2s7jodGv/J4GZ9X/MWTn/miRPwfxRfNIOqt2N0i
        DwjpFcCA==;
Received: from [94.239.20.48] (port=47800 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy6p-003fLi-34;
        Sat, 23 Sep 2023 03:35:28 -0500
Message-ID: <f0a4bd2c-c099-b8e1-2a0e-7c505b4f7e6f@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:36:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scsi: target: tcmu: Annotate struct tcmu_tmr with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Bodo Stroesser <bostroesser@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175300.work.148-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175300.work.148-kees@kernel.org>
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
X-Exim-ID: 1qjy6p-003fLi-34
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:47800
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKyYb1xFu1OukEAObDyaG7s7XWZNB3Wmzc2/lsKXNsOdroZzgB4tgeKdbhugSOFYFv6sDTcZa9SBM+Jce2W9hBQWGb+SMOFIjJIRkWZK53wCYiq4z+WX
 +P9byGWJYxmNarq3MF4tCy4q8DFBDKVirvWn98Xq6QsrfZ5zF1ELQHSycq1+81SzoDnxXeeP94FKbXfgZO0GehEXL5EwaFPUvUhAINuYn0D33qspTqGZhgb7
 0+HU24jREvPeexj+gRe3b7VGCrzBJVFtXh14o0QazP1B+q/eW62TT8/1oFH+rhcaRPxGW2GWYwsF8/dQpkksBZ9qMy+B9cjUppTbkfZFNBqFoN7uLDHDe9SD
 QujXsqH5
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct tcmu_tmr.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Bodo Stroesser <bostroesser@gmail.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: target-devel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/target/target_core_user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 22cc6cac0ba2..7eb94894bd68 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -201,7 +201,7 @@ struct tcmu_tmr {
>   
>   	uint8_t tmr_type;
>   	uint32_t tmr_cmd_cnt;
> -	int16_t tmr_cmd_ids[];
> +	int16_t tmr_cmd_ids[] __counted_by(tmr_cmd_cnt);
>   };
>   
>   /*
