Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D57ABED9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjIWIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjIWIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:24:52 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F071A7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:24:46 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id jq43qI3XcbK1VjxwUqkGPn; Sat, 23 Sep 2023 08:24:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jxwTqOs8xsKmijxwUqJP5P; Sat, 23 Sep 2023 08:24:46 +0000
X-Authority-Analysis: v=2.4 cv=JOMoDuGb c=1 sm=1 tr=0 ts=650ea0ce
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V4hgD8fBP7rEpu7MlCUDU9+Gx39Q2x8L1p65AqC2Klo=; b=uQsEvM39b4jCPo23Qc7OhA/dAp
        aAToyxmeDFmkUtNe66pViGAs4uxP6yxJ8DksPljs/Ju7DX9t29+30cQNsmgqukn8R+JiIvD2gqDEW
        uRSViFTJGJM9Z+97MOyCfk9mNyi6pMY4Oke7tIXT4+8pamSNdij6Ffve7VkRc1YKCd+3QWm0ALL3v
        x0pBdFi3swOMFJgwF/tP/6VJNknc29iQkHSfRri9gnBv4m+KvJlG7LTUfGomaW5KV5GgvNDvZ/mOC
        fUSIBSU18mlafB9gxhryAt+w7+KfkFcwhSR9axyqOyr8hMwVrvrvBjEuzS9EdZINnKtffVA5YUt+W
        NmDjUzLg==;
Received: from [94.239.20.48] (port=46472 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjxwT-003UKS-0D;
        Sat, 23 Sep 2023 03:24:45 -0500
Message-ID: <3527897d-6fb1-7fa0-ac8d-7a53f4d00fe4@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:25:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] media: allegro: Annotate struct
 mcu_msg_push_buffers_internal with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922174935.work.699-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922174935.work.699-kees@kernel.org>
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
X-Exim-ID: 1qjxwT-003UKS-0D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:46472
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMR0GbgrVA8JL+JMQQ3zNeUSKOFHLlify/wTXZV4N0k+67znnsicCifSLrF+nH5PRLb3M1iRxv7NmU+51GO9ujGEI3NRwFw2SMHC8s+MVDf0ZaMGy/f4
 6bivx0h12fr2+ZEAbZrDFz0EChZf8e/Y2Bie+MwPYkRc9ruzyc23O+rrWwf1BbhAC8mgMBw94fOrwrmx4CMqGQsNUy9ntJIpNdposkyxrt1fY4RX9dSCfJ+N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:49, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mcu_msg_push_buffers_internal.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Michael Tretter <m.tretter@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/media/platform/allegro-dvt/allegro-mail.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/allegro-dvt/allegro-mail.h b/drivers/media/platform/allegro-dvt/allegro-mail.h
> index a5686058d754..c0c9013f1aab 100644
> --- a/drivers/media/platform/allegro-dvt/allegro-mail.h
> +++ b/drivers/media/platform/allegro-dvt/allegro-mail.h
> @@ -184,7 +184,7 @@ struct mcu_msg_push_buffers_internal {
>   	struct mcu_msg_header header;
>   	u32 channel_id;
>   	size_t num_buffers;
> -	struct mcu_msg_push_buffers_internal_buffer buffer[];
> +	struct mcu_msg_push_buffers_internal_buffer buffer[] __counted_by(num_buffers);
>   };
>   
>   struct mcu_msg_put_stream_buffer {
