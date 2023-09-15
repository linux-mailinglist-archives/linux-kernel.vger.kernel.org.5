Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342E7A28AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjIOUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbjIOUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:50:39 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CC1BD3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:49:56 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id hEvdqM999EoVshFlEqHyoB; Fri, 15 Sep 2023 20:49:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFlEqDLyT1SF3hFlEqcwYq; Fri, 15 Sep 2023 20:49:56 +0000
X-Authority-Analysis: v=2.4 cv=Avr9YcxP c=1 sm=1 tr=0 ts=6504c374
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=BS-Bl4eDAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=Mz5RY1mrK68yK6INR7tS:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WDzRH02xtZOdn1w3Mh08Uj0Kg1XXQkWl85TLPHbY12g=; b=EIxwvVaorObxr7NqbMU1wJcDoE
        NPFsz2Y1DWsxWX4SI8bAsAyT9DCET++1EuNu5mqDWnMJ7pIDZrkAwb/yS81cne5/NBuGkEfQMrWga
        FaPrjRUQd+Psnv9VfUNeIPFB7v759CWpg0L2YbbYC4eSEnaCwW4cqCynSultSXp20WF7qADhncX21
        kY9uSy88hkjjqIQLHgjtbS7DGcUsj5ZtVdmCmwV4zsknKcZy4t7xhwSfCHvq4La5dL8oLsmaMWw1U
        pponp75jC/r/M+4yWR1lqX0O8FpnavopKJz9JmX/e03HlUSs74m7OWpRHTRDGxqaMlSoxfiyrsx63
        1JZjQ+ww==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39494 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFlD-002fGS-1V;
        Fri, 15 Sep 2023 15:49:55 -0500
Message-ID: <e558c8be-985b-014a-a0ff-34e84a2cb24c@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:50:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] afs: Annotate struct afs_addr_list with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201449.never.649-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201449.never.649-kees@kernel.org>
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
X-Exim-ID: 1qhFlD-002fGS-1V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39494
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 446
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP5qr+x1c7oJZOnmkJwZD3NbGLdNZA3coFdJnz149lsZWrCECUEwqYhSBJrxW9GISTAHjj+hxDZvMg2/TQTemTUdza4QXCao2Ady6qlr4oSMA8xyTUak
 p7oRlgq5aREZ0xz5z3AI5zBOnera/zqKCUSIG8fC4FgIwu/f6BErkCoJJ7C8/VfLKWYgKsASosczu/xkNZWbhEhokhvyzohtcBdet0ORE3naM/yKPmbSvHoL
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:14, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct afs_addr_list.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Marc Dionne <marc.dionne@auristor.com>
> Cc: linux-afs@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/afs/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index da73b97e19a9..07433a5349ca 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -87,7 +87,7 @@ struct afs_addr_list {
>   	enum dns_lookup_status	status:8;
>   	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
>   	unsigned long		responded;	/* Mask of addrs that responded */
> -	struct sockaddr_rxrpc	addrs[];
> +	struct sockaddr_rxrpc	addrs[] __counted_by(max_addrs);
>   #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
>   };
>   
