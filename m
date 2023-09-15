Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCA7A28B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjIOUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbjIOUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:51:41 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9742709
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:50:46 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTP
        id hFjPqAF4oOzKlhFm1qIIR8; Fri, 15 Sep 2023 20:50:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFm1qkRWUxtb5hFm1qfZSD; Fri, 15 Sep 2023 20:50:45 +0000
X-Authority-Analysis: v=2.4 cv=IOERtyjG c=1 sm=1 tr=0 ts=6504c3a5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=x_RLF880AAAA:8 a=IXr_WNlcAAAA:8 a=SRrdq9N9AAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=G5nsRgLVucSo8_3d1RoA:9 a=QEXdDO2ut3YA:10
 a=jCPSC2jcP07J4OBJNHyf:22 a=K24ECnMRWNUKRqF_MnsZ:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nxvRp4DGgI/6MixR2WlqcSPhzQJquVqoPBvbY8UncWM=; b=nXds5WHz6Ptbe2/HB9I9kDCSE9
        Lq4v3BlLXWKNpglWH8WUCFTaLFxUEvQTDIZ3Eu2EGfcCwxqhOh1rIKXB2uGfM96xUhyDGSTrWacb1
        g27LYfvYcH/4en27z4xPrxykTLgF4Oqg+Yqy6Vqkr0ULxChC9vn7I9zzj4kbSDAN1Hlq3Z+O6Ws7i
        C43pWD3m5jpbWgcLIQHLdjnDNkhMQHWxGJmdvd6t7fcUhqIbkxYch72CIMi9ovmzD53wlA6jKMHY5
        dJpyYCIBHkPyVzJtyAHHhfrbsmsFqJ0le+cK81Jx/TUktXiZekpMflwTbs71bACupN1FMo7MBQKDB
        P4bScZ+w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:35644 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFm0-002g5A-0y;
        Fri, 15 Sep 2023 15:50:44 -0500
Message-ID: <ae45f6a6-8870-d2c8-8c98-a9e7d9d1ba2f@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:51:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ocfs2: Annotate struct ocfs2_slot_info with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201522.never.979-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201522.never.979-kees@kernel.org>
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
X-Exim-ID: 1qhFm0-002g5A-0y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:35644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 493
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLRqqf/AzjveY13hJcaVp2CRk6U7uFuqySMUTseHY+U/SXsmNimEPSDT8g+PexqaYiB4bCmYKCn3cgaBisypzTK7x7sUpJjtpVR5SEvHhbT5TXjNbjay
 6Xlfh5eaGTWxKg0JrpYZCK2qMzQ3ok8UxwTihyQO5/0csu+utgZzdU/Ul3nhO0p4DDPPK8K9Od9dS5f/LilpPjp3b7VPJhOkBQBQxheTttfn/q/8gGZjxzNZ
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ocfs2_slot_info.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/ocfs2/slot_map.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
> index da7718cef735..e544c704b583 100644
> --- a/fs/ocfs2/slot_map.c
> +++ b/fs/ocfs2/slot_map.c
> @@ -37,7 +37,7 @@ struct ocfs2_slot_info {
>   	unsigned int si_blocks;
>   	struct buffer_head **si_bh;
>   	unsigned int si_num_slots;
> -	struct ocfs2_slot si_slots[];
> +	struct ocfs2_slot si_slots[] __counted_by(si_num_slots);
>   };
>   
>   
