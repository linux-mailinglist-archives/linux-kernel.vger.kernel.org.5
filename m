Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB727AC5C7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 01:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjIWXBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 19:01:48 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D91127;
        Sat, 23 Sep 2023 16:01:42 -0700 (PDT)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id jx8VqK4VLQFHRkBd8qxWbN; Sat, 23 Sep 2023 23:01:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id kBd7qt0jM5plfkBd7qWUc5; Sat, 23 Sep 2023 23:01:41 +0000
X-Authority-Analysis: v=2.4 cv=eZguwpIH c=1 sm=1 tr=0 ts=650f6e55
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=FP58Ms26AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3p6Oxd8lImna/tnNPn3kLAJYhLmgd2YCH8VHS7QjBc8=; b=Q6NvT0FFjrU/P/cmSBkrYbG5Gg
        i+smH9lRlSIxn9dC22X5pYBf0exEamPbuz5btM4xN4Cko5jeT7ZFiMgSzY/EDx7NOnkfaZqRrxHJj
        BVjHEplYGLOUHuv7YzAT8n1dj4jT+lo/hMj3BMYzlOWGEIFyoPWmXehdlE9bpz7SYIBJXQv4O8U5z
        PKjp3bqldB6XdvWbijbV7BPgrkmAcdHlTBNkzBguUihoqiL2LIRlDglPKeowNdHLTeNAi2zK5FpSJ
        5rfgIeN5NRxwu0F0eO6FMOIueuH0D6gfJJWpUP0Mrq6hvge5nKEk1ftsxpgfW07gNpCFcboOeP2wR
        FSS5SXSw==;
Received: from [94.239.20.48] (port=37818 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy7M-003gFe-1z;
        Sat, 23 Sep 2023 03:36:00 -0500
Message-ID: <eba660fc-4284-6793-1598-fd5bdedaca4a@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:37:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] firewire: Annotate struct fw_node with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     linux1394-devel@lists.sourceforge.net,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175334.work.335-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175334.work.335-kees@kernel.org>
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
X-Exim-ID: 1qjy7M-003gFe-1z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:37818
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEWfRWX358DrD54r6+kyeXvPOTc5+ZQkZKPjU6BGyG5Cvkm6jywbFMiyB93n6z+Y900h2F/tgZKrKhsNr3OA72Y2SVCYm7T4T9hBjKVi/fhn+w232kFs
 CVowl62I8UU68i+pJPdS+OtfXxxvuy5ob3noxS5+gMwjO7LcMmrHgCNMqjNgAuM+AHWCShn/zwWqbUXpHzHJsAJBzo9Ew1JRkVnpakp/mcM8gaw+P/UIUuRr
 b17wcxGU0JVUO5mD8S91Ic+eu2UYHxv46968DAS4yVI=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
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
> As found with Coccinelle[1], add __counted_by for struct fw_node.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: linux1394-devel@lists.sourceforge.net
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/firewire/core.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
> index 2a05f411328f..95c10f3d2282 100644
> --- a/drivers/firewire/core.h
> +++ b/drivers/firewire/core.h
> @@ -191,7 +191,7 @@ struct fw_node {
>   	/* Upper layer specific data. */
>   	void *data;
>   
> -	struct fw_node *ports[];
> +	struct fw_node *ports[] __counted_by(port_count);
>   };
>   
>   static inline struct fw_node *fw_node_get(struct fw_node *node)
