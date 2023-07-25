Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A37609A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGYFpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGYFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:45:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793B21BE9;
        Mon, 24 Jul 2023 22:45:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b1238cab4so2643765a12.2;
        Mon, 24 Jul 2023 22:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690263903; x=1690868703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLWTxt1GdJIDBYksY3L3E4ELJttcMZnjYHwQwgR/rmQ=;
        b=Daexl/YkS56lVItdQAH6OE7o74Sdt4kAPd6P48d9MI9sGOdEfwVuf/g25ESuHp991Z
         rpiU4heuEfZQiDyE6jsTbSFnUiUZ2qHLDZZPTquiTjl7ywvbi7bvh4dAbKJsgeT3SK6Z
         LSFa+kkU2l4lH6G/q6ANFDnbzc2xrjcQthbjfNVP9sxxnptREz0rXXz8MrdbIhpvUjmM
         N/lEQpDxXkdaCX6MzUDJBj13C/FBVNC+rC/Rx+yNIP/Qu0mzBAlTOafZbrfUeiZ9x8Iw
         ggEeGpaCNWJK+hvmQlKLYSTnKAIerNyF7G9QO8CKE+exW2fuGaZt1Cv68sbVEnaJ5G5a
         4aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263903; x=1690868703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLWTxt1GdJIDBYksY3L3E4ELJttcMZnjYHwQwgR/rmQ=;
        b=jWpzZDWJAYpCeYc8/lld5kehnY5husRYINkct6/ADxANr1lYnNOjf6Gve+gzraBoVL
         a1JcNGLMbQ9ke1BU5D8yvK/gvZJTe8J8iqNkvbm43nNC0e7rF3+IcNqoP4e776TbBIXk
         PpaT35P6Mb1ogqU1eOLCuXu+6d6fCS+sYCBiuV9hdtITpM69WxsjNYYn+oPXX8O6TjfW
         dr0AfoGa319/ID5AV1cessO8X2o+oQy3wbfWDrlBWSd0f9xVlOSUmRiP4aMY1iLppIhX
         sDFbg/F7I8/pHxTTAWTdCnCrKwnvBEfrG72QCibR58vnZ00LHtzr5vFrPwIhHuSrHzo2
         RWyw==
X-Gm-Message-State: ABy/qLar71iQAFePw22g7tW2eF8pA+woMIpGTaXx+P7/walGyly0q8+1
        An3hZAjMarxatL/dDMTthKQ=
X-Google-Smtp-Source: APBJJlGRnzVbxjcm7XFoZ4nSawGz6+t7H93r+2OA1H1izbI9aqlVj+HqoS7yX2+iKxJT+kaGX8Cbzg==
X-Received: by 2002:a17:903:489:b0:1bb:893e:5df5 with SMTP id jj9-20020a170903048900b001bb893e5df5mr7249808plb.34.1690263903016;
        Mon, 24 Jul 2023 22:45:03 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b801044466sm10032671plb.114.2023.07.24.22.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:45:02 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:44:56 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
        lucien.xin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <ZL9hWEs4GNhm8xVY@Laptop-X1>
References: <20230725022151.417450-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725022151.417450-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:21:51AM +0800, Lin Ma wrote:
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
> does an early error return if length mismatches.
> 
> Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  net/core/rtnetlink.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 3ad4e030846d..1e51291007ea 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5148,6 +5148,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  				flags = nla_get_u16(attr);
>  				break;
>  			}

If we got attr tIFLA_BRIDGE_FLAGS first, it will break here and not check
the later IFLA_BRIDGE_MODE.

> +
> +			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
> +				if (nla_len(attr) < sizeof(u16))
> +					return -EINVAL;
> +			}
>  		}
>  	}

Thanks
Hangbin
