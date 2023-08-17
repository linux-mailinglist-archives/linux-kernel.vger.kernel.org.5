Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1177FFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355287AbjHQVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355348AbjHQVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:22:41 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645C173F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:22:39 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id We1nqgRS8yYOwWkRyqtqyt; Thu, 17 Aug 2023 21:22:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WkRxqT8hg234eWkRyqFfPt; Thu, 17 Aug 2023 21:22:38 +0000
X-Authority-Analysis: v=2.4 cv=cPzzD3SN c=1 sm=1 tr=0 ts=64de8f9e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=stkexhm8AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=6UV5UrL1aO4bJEFlmkAA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wgoIFsvs5xLnCx7q6HCwBasYA5R0F0VgetzOCKQWKAY=; b=BCBP7qvIvC+L9+9rKPpZHnkX1m
        kBrpap7OckaNKzcVzUpWFO6dYAzPm14FR7eIT3p+/zfPXevDya4tOq2i39znbhx2jhhk+fkAjG04z
        XO0uZv+AaeI5bT6FaID6EGiBOf3EYLrham7Dp1V+f/VdZgSa1g0kRk2A9Tu2Bg09xaZEF29wWvJT2
        8a8B5JO5cQ4Cz29jH/aPA6xuuJtjF7RIkKQL+KSS7Jxb5o8s5DSj9HBFvYTno887Se4vUmxBmx3fF
        Jvs7S8Hxdi8v8R9xMKxU/ZgmTOuyHMG1Qng54rRQHM2j16/ZqM5nkOWqdMjBtrnBqpfRYFXRf09fF
        RIUs0Nrg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55954 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWkRv-001kOC-3D;
        Thu, 17 Aug 2023 16:22:36 -0500
Message-ID: <d720192a-6381-3122-4e7f-bcabaae8cd4b@embeddedor.com>
Date:   Thu, 17 Aug 2023 15:23:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] wifi: cfg80211: Annotate struct cfg80211_acl_data
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230817211114.never.208-kees@kernel.org>
 <20230817211531.4193219-1-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817211531.4193219-1-keescook@chromium.org>
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
X-Exim-ID: 1qWkRv-001kOC-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:55954
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 50
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJQWne59P/F9mQlG3/jZQpqwAYOUVQfPas/OBDMwlUmLf649RKJvIT48hsqgSLyt1p/XvaxcgU4bHuw1hAk5PpM7U0W/Yap7X5NJRFfMUH9TLleKxPLM
 espsk3AONMy8lcYRs29BCmK6pLf2fmWTpL5XiRUYtnjX1qm/79TLQc2RYaIl4jsUFnmUJeSoqoxkpWJCLFcHQWgzgIW0DaYILLn7UmoxMBvpJruv++C5WKFu
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 15:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cfg80211_acl_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/net/cfg80211.h | 2 +-
>   net/wireless/nl80211.c | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..eb73b5af5d04 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1282,7 +1282,7 @@ struct cfg80211_acl_data {
>   	int n_acl_entries;
>   
>   	/* Keep it last */
> -	struct mac_address mac_addrs[];
> +	struct mac_address mac_addrs[] __counted_by(n_acl_entries);
>   };
>   
>   /**
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 8bcf8e293308..80633e815311 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4889,13 +4889,12 @@ static struct cfg80211_acl_data *parse_acl_data(struct wiphy *wiphy,
>   	acl = kzalloc(struct_size(acl, mac_addrs, n_entries), GFP_KERNEL);
>   	if (!acl)
>   		return ERR_PTR(-ENOMEM);
> +	acl->n_acl_entries = n_entries;
>   
>   	nla_for_each_nested(attr, info->attrs[NL80211_ATTR_MAC_ADDRS], tmp) {
>   		memcpy(acl->mac_addrs[i].addr, nla_data(attr), ETH_ALEN);
>   		i++;
>   	}
> -
> -	acl->n_acl_entries = n_entries;
>   	acl->acl_policy = acl_policy;
>   
>   	return acl;
