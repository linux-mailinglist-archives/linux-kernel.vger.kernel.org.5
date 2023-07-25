Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA4761BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjGYObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjGYOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:30:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D226A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:30:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b734aea34aso81203451fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1690295433; x=1690900233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeJ+8u8ZaYUwpLiyi+CCaKydAPqb727pDz7pLVQc0Og=;
        b=phE16iwCP31NqrlalixrwUIhuGyz7U0E5Y0skNncWEjB2mPNscOndY0shE0gYzdtAU
         jj7Mqm1ohFxtjGGh6OVLBA6AjHcIsWRo+/pUpkh1pRhIiVynC5g15qj/kmFdslgdEPjP
         ZoJEdEli/309kprYOVGjdq8EJ+Y7b7i2/QOr2PwEdLWyYf1+ypNr66Db1NmP2ih/v/lZ
         pzFhUaBMVR0I3HxTNy2xbYptBHK8IHpHGKce1buo3UHXtWBGvjmAjBQ871KZcW5WAVXf
         1O91WaEfDO96SSHQ6QXBMKW14FCNPqkK+/BqE1aFg/Qo32mBCh1APXwgs/RcGzT/2cNp
         xjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295433; x=1690900233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeJ+8u8ZaYUwpLiyi+CCaKydAPqb727pDz7pLVQc0Og=;
        b=SttvG49K5IUzjUwbDm1jKABdvdsd7cLqlruZsAWj0x05Yx+6qXCM16cqW91dv2YfGP
         9yNOrDjOpeIu/qPnzdNwGwIQiUJs18s+TZ5gOw2o+nO/jSkd6OfBWp5mGh+nNQfyKqHS
         fjWbKU1n6sa/sbQmDPTXy4NAWAryhc3Tac0b47BxtyrI8VybDLjBdhfQzz7RCHDHbmmN
         ipEKLaureGiF7ccDH2fQcIsZubVUlBEpUswXvmgfW0D2HXDOyCLxPV8cmioFIjfTG0it
         420zmcy7Rd2SvBUBpbjqfAZ17bc5ePyfhCMEabm5LCRahKlK8hvSuVBKDin1aNFZP18S
         lTQg==
X-Gm-Message-State: ABy/qLaU22061WTdu0F6e1L0c3MW1XF+bwSlaYleD23vrVPCwBUtnoCE
        brmFujerFG8f89SJYSKXFR/GSA==
X-Google-Smtp-Source: APBJJlGvML6v1TzuUhl0DWjxHNstRMRJ09utxtc+X2zC5yRiM128sQmgAqyZXsoCJCW3ExK9L8DIKQ==
X-Received: by 2002:a2e:9650:0:b0:2b6:fa54:cec1 with SMTP id z16-20020a2e9650000000b002b6fa54cec1mr9474682ljh.48.1690295433490;
        Tue, 25 Jul 2023 07:30:33 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906378d00b0099b4ec39a19sm8348718ejc.6.2023.07.25.07.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:30:33 -0700 (PDT)
Message-ID: <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
Date:   Tue, 25 Jul 2023 17:30:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
To:     Lin Ma <linma@zju.edu.cn>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        idosch@nvidia.com, lucien.xin@gmail.com, liuhangbin@gmail.com,
        edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725055706.498774-1-linma@zju.edu.cn>
Content-Language: en-US
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230725055706.498774-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 08:57, Lin Ma wrote:
> There are totally 9 ndo_bridge_setlink handlers in the current kernel,
> which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
> i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
> ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
> nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.
> 
> By investigating the code, we find that 1-7 parse and use nlattr
> IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
> lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
> length 0) to be viewed as a 2 byte integer.
> 
> To avoid such issues, also for other ndo_bridge_setlink handlers in the
> future. This patch adds the nla_len check in rtnl_bridge_setlink and
> does an early error return if length mismatches. To make it works, the
> break is removed from the parsing for IFLA_BRIDGE_FLAGS to make sure
> this nla_for_each_nested iterates every attribute.
> 
> Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: removes the break in parsing for IFLA_BRIDGE_FLAGS suggested
>            by Hangbin Liu <liuhangbin@gmail.com>
> 
>   net/core/rtnetlink.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 3ad4e030846d..aef25aa5cf1d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5140,13 +5140,17 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>   	if (br_spec) {
>   		nla_for_each_nested(attr, br_spec, rem) {
> -			if (nla_type(attr) == IFLA_BRIDGE_FLAGS) {
> +			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
>   				if (nla_len(attr) < sizeof(flags))
>   					return -EINVAL;
>   
>   				have_flags = true;
>   				flags = nla_get_u16(attr);
> -				break;
> +			}
> +
> +			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
> +				if (nla_len(attr) < sizeof(u16))
> +					return -EINVAL;
>   			}
>   		}
>   	}

Patch looks good now, you should probably remove the extra checks done
by each driver that are now unnecessary (net-next material). As Hangbin
commented you should target this fix at -net, with that:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

