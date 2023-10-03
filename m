Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295787B7501
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjJCXev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjJCXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:34:50 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2C90
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:34:47 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id nkAqqWnr9NWIenoucqGsTJ; Tue, 03 Oct 2023 23:34:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id noucq67Z7mawFnoucqPpD0; Tue, 03 Oct 2023 23:34:46 +0000
X-Authority-Analysis: v=2.4 cv=LqyBd1Rc c=1 sm=1 tr=0 ts=651ca516
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=UdgJPzOXAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=KnbsgnSzWpVRoYk4pcrV:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i/hUv4+ytD1P43rCL9hPeq8agMfH6PMicmCbzbXo1wA=; b=vo1uR57egHfNwa+FvtjzdrmAsD
        3hGhojJYgGG2F7BQbv7kIzziK+L5TzTlSwxqbXw34YzKO7Fgqkb50sVYH3tHR8wc+7lyRF22+gQj2
        2wjWxlWoGsDAqZz3EwNDUALB3YzFAak0UW4EUiBLq+AsSn4yqBVrRpJwsKp3MNNTsxU4uIVQx6rXw
        ALc+MpHMuEGSo5XyCw/AiRBuS0LVp4mAL0ApXRRw2h8mKpnHEa6KwwZZCnRRKWVK+IXIEp09vlWe4
        j5T6cwOQyy3eVjXCTIOxanimiwzt4yP0EQJe0oeJ6UC45WH2GVPbDiptI5nafoTg9niCViBfFCCdl
        ALcaJx3g==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:46644 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnoua-001Pwx-0V;
        Tue, 03 Oct 2023 18:34:44 -0500
Message-ID: <44a4a0fa-0e26-f485-d3fc-54c892b2de3c@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net/packet: Annotate struct packet_fanout with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Anqi Shen <amy.saq@antgroup.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, syzbot <syzkaller@googlegroups.com>,
        Jianfeng Tan <henry.tjf@antgroup.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231003231740.work.413-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231740.work.413-kees@kernel.org>
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
X-Exim-ID: 1qnoua-001Pwx-0V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:46644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 35
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKCGB9yOFjEDK3AHV5m7zQHM0KLMNPkMlFcrp7FEEZHqCpuK4Clif7P+AH+D8F4uccxHwfHqg5/z0o0LU9BZjN9zjvW5or1i0ObpNrVVKWTZRvtdYeBL
 wnpYd/D/U3exIK2ViPC9SWpS+Ap6n+SrCqcGP96RiDTMuBiDkFhVwi13Wkujx8G+qjkeOWip8tZygz7bkunnwWeOBKjZgzduclJb+r3WAJrz0xRRJeUvOIHr
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct packet_fanout.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Anqi Shen <amy.saq@antgroup.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   net/packet/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index 63f4865202c1..d29c94c45159 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -94,7 +94,7 @@ struct packet_fanout {
>   	spinlock_t		lock;
>   	refcount_t		sk_ref;
>   	struct packet_type	prot_hook ____cacheline_aligned_in_smp;
> -	struct sock	__rcu	*arr[];
> +	struct sock	__rcu	*arr[] __counted_by(max_num_members);
>   };
>   
>   struct packet_rollover {
