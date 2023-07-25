Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B46760BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGYHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGYHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:33:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C23A9E;
        Tue, 25 Jul 2023 00:30:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbc06f830aso1312755ad.0;
        Tue, 25 Jul 2023 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690270214; x=1690875014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h52mdhH7AN/s//mAEPa1uGifOdnK72pNrGrnuOGcMy8=;
        b=koPV6gHU8enmCrWa1N+TlbeRDD/5LJ+xW8Qz538P1HQqoLBVhBjLYGmiuaNYSuTrhl
         BSu+7VlFyggxLG6T7oeE57nZJ4CuVr/qWxlnrhhrVTc0w/3H66dbqaqES1YZ3FP3NtnX
         jd/bVKJ3C5pyz8AVKgxCSIWunx09JqW2zUeTREXAefamc/FWUy6qBqz2RjLIP9hEZ/gt
         Xb1GNWb6bnXjIlkdgcB7njxalXW//PPO309dGTET7BWZ1biXDrGzh5c6mn0iSdexq0+t
         aCfZYpio4HELVZ5FPZpYIeRCzxPr5JMKJAwylMvP4SF2RYd8w05uIs43jMoOPQSKDcqw
         Y92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270214; x=1690875014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h52mdhH7AN/s//mAEPa1uGifOdnK72pNrGrnuOGcMy8=;
        b=bETz8d9frPzKg2liS5IHuf247X8/YQ1DAgsDS804cg9ivuiGX/GHoacVzQ0YA0c9V2
         E2XPfs9sq2c7zT7fLTZV2ekfJdrzB+P0STY5NNqDnZHfVTqegte716eGHrr7/KWFymAm
         MaLSqP6kcuMrkA6ar7kjX0VwCYVcco0sYIVeEHXH53sVD//k3SPiYlsFhPyZhxCJPOZu
         1vqT4f45gJFXsngGhoHyne3fU02zcbg8jbg5aqN10k+iv61ukWtYWayOML5EB0ohhPFY
         vp0a1hM0N5lFodiaeaEfW0vb2l8m1IdBS0LQ/zinq7j121CPgNfqP8rb9jUAehnWNwaC
         IMuw==
X-Gm-Message-State: ABy/qLYBQZvOUw4cu/j4H2lV6g/yyKfSCXhTsggWr2/yi5e9KnPBAfGy
        nVfN0C0RrizURr2cnFfm8JU=
X-Google-Smtp-Source: APBJJlFRd7kE2MMljHX9EPq/8meOMGyUQiqFmtR9ZtniKbCY/xVIugncO3/gT0vCe8tggvb5r5k+0Q==
X-Received: by 2002:a17:902:e5cd:b0:1b9:e9ed:c721 with SMTP id u13-20020a170902e5cd00b001b9e9edc721mr2110877plf.19.1690270213797;
        Tue, 25 Jul 2023 00:30:13 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r15-20020a638f4f000000b005633fd3518dsm9911192pgn.40.2023.07.25.00.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:30:13 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:30:07 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
        lucien.xin@gmail.com, jiri@resnulli.us,
        anirudh.venkataramanan@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <ZL95/wR8EeO2yUku@Laptop-X1>
References: <20230725055706.498774-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725055706.498774-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma Lin,

Please add the target branch in your subject. e.g. [PATCHv2 net]

On Tue, Jul 25, 2023 at 01:57:06PM +0800, Lin Ma wrote:
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

Since you have checked the length in rtnl_bridge_setlink(). Can we remove
the check in the driver handlers to avoid duplicate code? You can hold on
this update and see if others have different opinion.

Thanks
Hangbin

> 
> Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: removes the break in parsing for IFLA_BRIDGE_FLAGS suggested
>           by Hangbin Liu <liuhangbin@gmail.com>
> 
>  net/core/rtnetlink.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 3ad4e030846d..aef25aa5cf1d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5140,13 +5140,17 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>  	if (br_spec) {
>  		nla_for_each_nested(attr, br_spec, rem) {
> -			if (nla_type(attr) == IFLA_BRIDGE_FLAGS) {
> +			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
>  				if (nla_len(attr) < sizeof(flags))
>  					return -EINVAL;
>  
>  				have_flags = true;
>  				flags = nla_get_u16(attr);
> -				break;
> +			}
> +
> +			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
> +				if (nla_len(attr) < sizeof(u16))
> +					return -EINVAL;
>  			}
>  		}
>  	}
> -- 
> 2.17.1
> 
