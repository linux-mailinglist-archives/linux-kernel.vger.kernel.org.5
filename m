Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED07B771A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbjJDEZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbjJDEZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:25:51 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22869B0;
        Tue,  3 Oct 2023 21:25:48 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id npJ5qY89pNWIentSFqI6D2; Wed, 04 Oct 2023 04:25:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ntSEqzup5oD58ntSEqBvRH; Wed, 04 Oct 2023 04:25:46 +0000
X-Authority-Analysis: v=2.4 cv=Ou1cdgzt c=1 sm=1 tr=0 ts=651ce94a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=6UV5UrL1aO4bJEFlmkAA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TU8/ezpal9LOvD+9AttLo3gv3h/2NvMSc+fbzalOHb8=; b=oTmyHfiLcBC6VNqAJx6CyuQABV
        rugq7xC3fPI7m8f0YojTPDoi4XLaoq5khTHaDlNEYUBps3utjtlZuPGrLpMwbRJsnQtN1j4nClzfQ
        FieKfvyDtjWJehDN7doPbrDABltgOcY0wl+JHnSCEJFiWQffm53ovBo0e3vlPyOnnNUsfjNULT34f
        KFZjikxHuIFfBYR2bbStKXsZyNDWB14497EryYKgfrqj3KFsYzGbxI8nsxkWTgo9JIS3QPR9zb+4t
        vY7S8mwNF/tJTUeqJofT3nwz/VX+XdZYRP0w1ru3JCwE12h50dy9cUE6P54NwwsEtfe7R+uURpv80
        KX4aSuSw==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:58492 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnp0U-001VLP-16;
        Tue, 03 Oct 2023 18:40:50 -0500
Message-ID: <6a3fb58c-440a-31f7-72f8-36e07383d603@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] netlink: Annotate struct netlink_policy_dump_state with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003232102.work.430-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003232102.work.430-kees@kernel.org>
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
X-Exim-ID: 1qnp0U-001VLP-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:58492
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBz1xlqOVW54GL5Uqo56BhUhUmPmikw2AaVwCv2hLVFeONavyYiHjanBxmf07DFgOC+2tHnspu5qptIGaHSynXbxZFwkOtJEvA+Px1k8nSRTCaZL+ZiY
 vVywd7I2CHDBHI4T8Yud6f/UxXod5cAkIHYrpFyBN9RrqhXtn69iuSDs7GeQb+uetLN963KX8slCe0u7gxFECMpD2DowwN8bXSh96/P0vyK8y50AMQ5MGNAO
 9jOCQOcF5lzi/tkLeZmOwnuHSOHZwurJ2h7dbTOL3+7Oco8O9+jeU1Js+EoIHm0R
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:21, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct netlink_policy_dump_state.
> 
> Additionally update the size of the usage array length before accessing
> it. This requires remembering the old size for the memset() and later
> assignments.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   net/netlink/policy.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/net/netlink/policy.c b/net/netlink/policy.c
> index 87e3de0fde89..e2f111edf66c 100644
> --- a/net/netlink/policy.c
> +++ b/net/netlink/policy.c
> @@ -21,7 +21,7 @@ struct netlink_policy_dump_state {
>   	struct {
>   		const struct nla_policy *policy;
>   		unsigned int maxtype;
> -	} policies[];
> +	} policies[] __counted_by(n_alloc);
>   };
>   
>   static int add_policy(struct netlink_policy_dump_state **statep,
> @@ -29,7 +29,7 @@ static int add_policy(struct netlink_policy_dump_state **statep,
>   		      unsigned int maxtype)
>   {
>   	struct netlink_policy_dump_state *state = *statep;
> -	unsigned int n_alloc, i;
> +	unsigned int old_n_alloc, n_alloc, i;
>   
>   	if (!policy || !maxtype)
>   		return 0;
> @@ -52,12 +52,13 @@ static int add_policy(struct netlink_policy_dump_state **statep,
>   	if (!state)
>   		return -ENOMEM;
>   
> -	memset(&state->policies[state->n_alloc], 0,
> -	       flex_array_size(state, policies, n_alloc - state->n_alloc));
> -
> -	state->policies[state->n_alloc].policy = policy;
> -	state->policies[state->n_alloc].maxtype = maxtype;
> +	old_n_alloc = state->n_alloc;
>   	state->n_alloc = n_alloc;
> +	memset(&state->policies[old_n_alloc], 0,
> +	       flex_array_size(state, policies, n_alloc - old_n_alloc));
> +
> +	state->policies[old_n_alloc].policy = policy;
> +	state->policies[old_n_alloc].maxtype = maxtype;
>   	*statep = state;
>   
>   	return 0;
