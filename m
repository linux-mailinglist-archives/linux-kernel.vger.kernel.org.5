Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8CA7B7532
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjJCXig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjJCXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:38:34 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316FAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:38:30 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id njd0qDKK3QUgRnoyEqzWGy; Tue, 03 Oct 2023 23:38:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id noyEqKmqW7MctnoyEqZaoZ; Tue, 03 Oct 2023 23:38:30 +0000
X-Authority-Analysis: v=2.4 cv=BZjLb5h2 c=1 sm=1 tr=0 ts=651ca5f6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=jZVsG21pAAAA:8
 a=A7XncKjpAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8
 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
 a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4k6s6HPefL8zQEK7ac5EIag+vEYxjPOoY24oUSgOdLQ=; b=hIwkmocJAVHD5i9cchOxA/WmoG
        +u6ZNQD7xpdwl2CYON3DfqhkAwvur7SOoh31KWI7NngusWQ+laEuQ06UtM6Si1aa94tARb2NaCYuB
        nnHRBnYztTdqJJKMunkQcX/9rxRmOm6n6R2s5IVRUPC9XJ+Ulk8J2ahdO9xM288aPOUMaUMTA477j
        AUOQ1xp/l6g7MJdi+bKbsBoel+tvoysSPXuRjdAZH+jZssUNPB9HMrE7lrF4gYY+5IPH7s+hlS3zC
        WwNc90Oq26bz1DfmmAZ7ZSL8VPfFGfLdMjARetHakxa+6+twtrMp+lvP7YBMYbyVypDedZT2lYf4K
        qna13b5g==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:42398 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnoyC-001SqE-0Y;
        Tue, 03 Oct 2023 18:38:28 -0500
Message-ID: <839118ce-ff16-a743-d660-dd030a7e2d90@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] netem: Annotate struct disttable with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231823.work.684-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231823.work.684-kees@kernel.org>
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
X-Exim-ID: 1qnoyC-001SqE-0Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:42398
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 84
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIy4gocO9GMsKgKnSWzHYSHC8y+iMQl/rXlP1y91ENfKovQaGg94Nkfwvp1LV7b/Cd8UGgReMfBrRQw/yg+k34TmqHYjIIg7PhdhiQhoBb2zV0BQ1kRQ
 4VcrPs/TV1CrT9ASrq8CLPEWMEcUPGARzKsaR+iWqZFzua8OBug4yUr3zA+FwFlOkL4mCBv4UDjDGRBjfm7AeUBAg4SMLiAThDutRdy2OJX2XMTmIo/UvlWi
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:18, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct disttable.
> 
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   net/sched/sch_netem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 4ad39a4a3cf5..6ba2dc191ed9 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -67,7 +67,7 @@
>   
>   struct disttable {
>   	u32  size;
> -	s16 table[];
> +	s16 table[] __counted_by(size);
>   };
>   
>   struct netem_sched_data {
