Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A07DA5DC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjJ1Iiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1Iit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:38:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F15F4;
        Sat, 28 Oct 2023 01:38:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c41e95efcbso393613466b.3;
        Sat, 28 Oct 2023 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698482324; x=1699087124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpMeyzioqsroJUo35H7XsKCzwknPxdneK87kcKtXySo=;
        b=MtDJsB0KLvuPH357Nq1sjmw+/N3cqcPL7zwljBGwCsSsZMSGPBLUrW4G9KraOgsDOX
         C1fbGP/Lr8ZMAQSAyed1Zcj8QWQaBUQj3RQbqoPVqwKgtbldv2hicwpc5JQYH7DXlxqK
         4UJ2WIJFo5EEJ9I0Sl3joj0OmWzL6dyYQH3k8b5dV9p1DCnbrhJWgrq4loWUpJMrrCEH
         LPXTt1D1dZmZvUTR8juo20t9CodNDAwU26SvMGCGA/2CAAMPRqqX51u8nX+9/OJbw7Xd
         VZLpWolc8Lx0wAOPRJ8IS+XH1xpP76wcILSYuubGbSC8Rio+4TSp5ScRuZs2bVNaxemu
         dy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698482324; x=1699087124;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpMeyzioqsroJUo35H7XsKCzwknPxdneK87kcKtXySo=;
        b=NoLAwRWQBiPkm2S6ZdQ0n269l5FWW9iU4UqTJwQdrLyCbNKvrYtrNgjvYJ9OyqYo9h
         tJmSFSTfbU6xAOSOIMAIcQsrAfdIdTmxdMAfhqoJCMop/mSV/zPcPZlgs1Q8dLukmeOj
         PAEth4YNmVriQQYleVgDQSVZTNm6GkXlxWI+0NdDNAFr/drUbtomYRc7P+kVhNNVShKC
         ohD0t3Jkv6vJcpCggm8hDZ8s14B4sniqpT2rMWdAZKBfqD7fv/b78vvbo7SKZpd/UT+Z
         SyEC/DxCbxuyXYEAXhjP68S4kl3JjTPZUFnPkxhUEpo2UmD5ZXCVESwL2L6KHmUD5NfB
         Y8/A==
X-Gm-Message-State: AOJu0Yx5AQ4URVavzwx8mW994BxP6Tznija6fccAqIR0I3nuTfV/c/XG
        xu0FvD45CZDy6R224EYpPmg=
X-Google-Smtp-Source: AGHT+IHY4dyT9zpaKF77TkYL68omyNiRhrDZFl0X1WhyeyMCdYoKj+A9ZcCQ9HLjmJ5xcRPhxkx5vQ==
X-Received: by 2002:a17:907:2da7:b0:9bd:d1e8:57f1 with SMTP id gt39-20020a1709072da700b009bdd1e857f1mr4833016ejc.50.1698482323620;
        Sat, 28 Oct 2023 01:38:43 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c119:9c00:b47c:4f5f:820f:2966? (dynamic-2a01-0c23-c119-9c00-b47c-4f5f-820f-2966.c23.pool.telefonica.de. [2a01:c23:c119:9c00:b47c:4f5f:820f:2966])
        by smtp.googlemail.com with ESMTPSA id e17-20020a170906375100b0099e12a49c8fsm2457712ejc.173.2023.10.28.01.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 01:38:43 -0700 (PDT)
Message-ID: <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
Date:   Sat, 28 Oct 2023 10:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for
 RTL_GIGA_MAC_VER_46
Content-Language: en-US
To:     Patrick Thompson <ptf@google.com>, netdev@vger.kernel.org
Cc:     Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231027213059.3550747-1-ptf@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231027213059.3550747-1-ptf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2023 23:30, Patrick Thompson wrote:
> MAC_VER_46 ethernet adapters fail to detect eapol packets unless
> allmulti is enabled. Add exception for VER_46 in the same way VER_35
> has an exception.
> 
MAC_VER_48 (RTL8107E) has the same MAC, just a different PHY.
So I would expect that the same quirk is needed for MAC_VER_48.

MAC_VER_xx is a little misleading, actually it should be NIC_VER_xx

> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> ---
> 
> Changes in v2:
> - add Fixes tag
> - add net annotation
> - update description
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 361b90007148b..a775090650e3a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
>  		rx_mode |= AcceptAllPhys;
>  	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
>  		   dev->flags & IFF_ALLMULTI ||
> -		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
> +		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
> +		   tp->mac_version == RTL_GIGA_MAC_VER_46) {
>  		/* accept all multicasts */
>  	} else if (netdev_mc_empty(dev)) {
>  		rx_mode &= ~AcceptMulticast;

