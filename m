Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93E77BC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjHNPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjHNPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:05:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F118F;
        Mon, 14 Aug 2023 08:05:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso596802466b.1;
        Mon, 14 Aug 2023 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025538; x=1692630338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EyTsS0N9nnty1CNb27CMYPQxvCHWi9OMqi5a0wP9j2s=;
        b=DhKCmnLAU3vKa+c63Ab3ZbNzOJF5Rd10Kc9ygOR9MdCgf33F1W2wJ+KLxDqvTOj7dP
         aeXZloIZpC8EASxfeo9AlS7585pYQfHzUDG5pufF80JqMDNlmxATLlRG6qpb5ITT60r8
         iJ7x+MfBG4vTJwiHfyTck1hNlMJDzBizDfuDpsYZGfNXpxPNEergJNzwhjE4vUcNDeTU
         EA61BjvUsLsffFjkerEvIUu1NLQzQwalozaMllc64X7vEK6czeGc9u5xkytnctpv1TlJ
         ntGAeQ3MXadQ0u32dgS0VjOBxadiFZ3j5KRRG7f8wz0kLXaUA5OifhNc1mpriCMxTLmC
         Zt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025538; x=1692630338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyTsS0N9nnty1CNb27CMYPQxvCHWi9OMqi5a0wP9j2s=;
        b=QTOCv9q+22MpIM+stpODnlj/d+A4gxOhPkXhqmfjfEkc5Cj+1XLYhvQt9b3l23/fIX
         Tup8thhiv02OXNlKH2f3tr9uAo6yMtUO+kMQtZVqXUp2o59ZCoZjBjPRCz4q06RFDwuk
         H0xIZ/yEx+30TfgdY/5DerQZNAJkJ+O4kewmkIOPbd5jijPh+vP97VDmvnhiAHfH1Wzz
         7tMi1JC1fp+gqv/rGGiLnZSkNdsPoryPvfNC6HsWrKAdtGeL+3W6mlGepQsY6jkXuX0G
         mFHB31NUbKo2mXe11edtLpwdbag0jXB5hNsDvlgWqjnDqLQuM3I78P/egzt6sEDayQGJ
         3OlQ==
X-Gm-Message-State: AOJu0YxSqyF+3Q4X0snvVHF0+yWgP7wSyTmXqVsqOJXkQ2rmiQ/qnlfe
        p99x6WXEdX4V/9WsIsDZViQ=
X-Google-Smtp-Source: AGHT+IFyqU7M7LIUAcZuycerhP4j/Ml64BlmKcgq9L+T+xxUcVhsh2dcGYhtmXx1QEU034EO5nJGPA==
X-Received: by 2002:a17:906:cc52:b0:98d:e605:2bce with SMTP id mm18-20020a170906cc5200b0098de6052bcemr7187517ejb.46.1692025537888;
        Mon, 14 Aug 2023 08:05:37 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090613cb00b00992d0de8762sm5744792ejc.216.2023.08.14.08.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:05:37 -0700 (PDT)
Date:   Mon, 14 Aug 2023 18:05:34 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: dsa: mt7530: fix handling of 802.1X PAE frames
Message-ID: <20230814150534.epuluw2gfldrtgnl@skbuf>
References: <20230813105917.32102-1-arinc.unal@arinc9.com>
 <20230813105917.32102-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813105917.32102-1-arinc.unal@arinc9.com>
 <20230813105917.32102-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 01:59:17PM +0300, Arınç ÜNAL wrote:
> 802.1X PAE frames are link-local frames, therefore they must be trapped to
> the CPU port. Currently, the MT753X switches treat 802.1X PAE frames as
> regular multicast frames, therefore flooding them to user ports. To fix
> this, set 802.1X PAE frames to be trapped to the CPU port(s).
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/net/dsa/mt7530.c | 4 ++++
>  drivers/net/dsa/mt7530.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 38b3c6dda386..b8bb9f3b3609 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1006,6 +1006,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
>  	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
>  		   MT753X_BPDU_CPU_ONLY);
>  
> +	/* Trap 802.1X PAE frames to the CPU port(s) */
> +	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_PORT_FW_MASK,
> +		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY));
> +

In the interest of efficiency, this could have been merged with the
previous write to MT753X_BPC, which would save some MDIO transactions:

	mt7530_rmw(priv, MT753X_BPC,
		   MT753X_BPDU_PORT_FW_MASK | MT753X_PAE_PORT_FW_MASK,
		   MT753X_BPDU_CPU_ONLY |
		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY));

In the interest of readability, this is probably fine too.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
>  	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
>  		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 08045b035e6a..17e42d30fff4 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -66,6 +66,8 @@ enum mt753x_id {
>  /* Registers for BPDU and PAE frame control*/
>  #define MT753X_BPC			0x24
>  #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
> +#define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
> +#define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
>  
>  /* Register for :03 and :0E MAC DA frame control */
>  #define MT753X_RGAC2			0x2c
> -- 
> 2.39.2
> 

