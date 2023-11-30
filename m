Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE37FFC03
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376612AbjK3UL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376564AbjK3UL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:11:26 -0500
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB710FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:11:32 -0800 (PST)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTPS
        id 8lHarBfgNgpyE8nNjrndzb; Thu, 30 Nov 2023 20:11:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 8nNirOBfFhDny8nNirrmwp; Thu, 30 Nov 2023 20:11:31 +0000
X-Authority-Analysis: v=2.4 cv=fda+dmcF c=1 sm=1 tr=0 ts=6568ec73
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=8XV0R0IcXUXM6S+KMni/4w==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=stkexhm8AAAA:8 a=COk6AnOGAAAA:8 a=cm27Pg_UAAAA:8 a=-k1GZaui-gibiiQ_YVAA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=pIW3pCRaVxJDc-hWtpF8:22 a=TjNXssC_j7lpFel5tvFf:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0H3D5HS7abL9eprgUTSy9+mJmSpcKG17VCFcw5z1EN8=; b=H4iep1VZzfwjxSuULriOoC4TdJ
        tFyxfBmO7uU21MhuVwKnwrkpr3prsiBBcLZ25Z/T+c722vSSs7XR/z1e8z6d7yevLAAynW0HiT4i2
        uJkr0y+QzS+repb9gDxJQ9UPHQs4EsdUewdTlCoceWDPoXK3aSiatfwJj53OAqhFn6W2ew/706KEs
        zmPAj0Aqvsm5PYqdtmEvdc+GJXdBCxqFx/tPA+kXl4Wl/prngTDTtyhosaX7Rt/TAzxZAbnVloLzy
        EwJahuRY+SOGGnzFbOc7ErImiKvPQ6egGmh8TxQW8XjIdrHkKQigh3teYMnHro/EQC/+QKox/3s9y
        OPzGqy0w==;
Received: from 189.215.208.186.cable.dyn.cableonline.com.mx ([189.215.208.186]:2120 helo=[192.168.0.28])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r8nNg-0021Hn-1q;
        Thu, 30 Nov 2023 14:11:28 -0600
Message-ID: <31934933-24cf-42bf-90d1-c83b44b71d4f@embeddedor.com>
Date:   Thu, 30 Nov 2023 14:11:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231130200058.work.520-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231130200058.work.520-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.215.208.186
X-Source-L: No
X-Exim-ID: 1r8nNg-0021Hn-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.215.208.186.cable.dyn.cableonline.com.mx ([192.168.0.28]) [189.215.208.186]:2120
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJE22fmy8A1FGqfACyAkJSaXWJhiHuz1NB5xpyLVtpRkE4TVQ4Qodd4JBdZKbwbVyHdrEZOn0GxbhH4mxFaWtd4AoU+81iXl1uSqxngc2ABxE26P17Tt
 JIAkjc91w23E5nw68CykC/hCxhLSh9oxD46cMD5SEXF+mMa/L/OjlpLyludxTPF19po2caIoFaGtbMEW3/F+aGe2CclQMnzmq8uX2XbtMkC267JznWzrzvCe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 14:01, Kees Cook wrote:
> The return value from nla_len() is never expected to be negative, and can
> never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> on the function, and explicitly bounds check the subtraction. This will
> let GCC's value range optimization passes know that the return can never
> be negative, and can never be larger than u16. As recently discussed[1],
> this silences the following warning in GCC 12+:
> 
> net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
> 12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 12893 |                        flex_array_size(cqm_config, rssi_thresholds,
>        |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 12894 |                                        n_thresholds));
>        |                                        ~~~~~~~~~~~~~~
> 
> This has the additional benefit of being defensive in the face of nlattr
> corruption or logic errors (i.e. nla_len being set smaller than
> NLA_HDRLEN).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Max Schulze <max.schulze@online.de>
> Cc: netdev@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/net/netlink.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 167b91348e57..c59679524705 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1214,9 +1214,9 @@ static inline void *nla_data(const struct nlattr *nla)
>    * nla_len - length of payload
>    * @nla: netlink attribute
>    */
> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>   {
> -	return nla->nla_len - NLA_HDRLEN;
> +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
>   }
>   
>   /**
