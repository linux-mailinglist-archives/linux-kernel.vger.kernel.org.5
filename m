Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AA7ABF6A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjIWJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjIWJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:41:50 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E71AC;
        Sat, 23 Sep 2023 02:41:44 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id jx8dqJ7iMbK1Vjz8yqkWMF; Sat, 23 Sep 2023 09:41:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jz8xqyR9OZb7Mjz8xq1r4V; Sat, 23 Sep 2023 09:41:43 +0000
X-Authority-Analysis: v=2.4 cv=Z57/oVdA c=1 sm=1 tr=0 ts=650eb2d7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f0xMfpFbXrJ1GVDfUSIPxZ3rtagU/wUURpese8OucSQ=; b=fY2KKhHpvEo85qEso9g3x0ZfpC
        xDsF3dI4fI+ilSx+ve765boHnB8HnUgO59pvmSW2kSClMuYcaEZppXxkmNwXJDcw64xBfcXuI5Nz0
        TEk/BErlY2za6dvk+rNv8gllZItAuoeC5dzlilx8Odpt0aWWXAHET9E7w78s100npVTlYwF+Pijau
        ZylFyM6X7pGWQtDNLrXT1kz47k+YcqW6oO7dAjdbeqt+zWJCmLb1basDnVDKEy2dFqJns8a5O+j06
        WIyFdHL1lDC4AxpaKO4M/9TjE8LNnremX/aNXgbxhiWc0CXarUbZa1cwtdx7mqmsGWfghSPMe8Jqh
        w7mEGsKQ==;
Received: from [94.239.20.48] (port=43746 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy4m-003ciH-36;
        Sat, 23 Sep 2023 03:33:21 -0500
Message-ID: <f0ed26fb-c462-72f9-2f7e-834bab505ce4@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:34:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] sparc: Annotate struct cpuinfo_tree with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175159.work.357-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175159.work.357-kees@kernel.org>
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
X-Exim-ID: 1qjy4m-003ciH-36
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:43746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBCMpQ24JdfeIfKb+SfBD75VpoTYD77+OkegjNj6czvjqrNjzPfb6BXQ6f/HWeGHwVZIBmOsH0v0n4ztlwAtkORTeGnaCp89lCszQ9RmEpRlfCAaS7Zb
 kcsTwGLJH8Nk0IVgIKBrc9Idtk9gHjdUpWyDpqDjgiuFEDnKkyE7IZLkpCJc63nbsTKFKTy4AyR16huJajwJakqJIF+b57YD2ZSFWQCc5FrkkhEm8J5a9Asg
 rHWWujpua8VepHzeWFGpZpWJuPyqLrodArvo9MA71Wv+1GHmgX6n7xoK3XoRvQkcYap2KYOY8rk+sm+kXqaCIg==
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
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
> As found with Coccinelle[1], add __counted_by for struct cpuinfo_tree.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   arch/sparc/kernel/cpumap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
> index f07ea88a83af..8fcf2d8c6bd2 100644
> --- a/arch/sparc/kernel/cpumap.c
> +++ b/arch/sparc/kernel/cpumap.c
> @@ -50,7 +50,7 @@ struct cpuinfo_tree {
>   
>   	/* Offsets into nodes[] for each level of the tree */
>   	struct cpuinfo_level level[CPUINFO_LVL_MAX];
> -	struct cpuinfo_node  nodes[];
> +	struct cpuinfo_node  nodes[] __counted_by(total_nodes);
>   };
>   
>   
