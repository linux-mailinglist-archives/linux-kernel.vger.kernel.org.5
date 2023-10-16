Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E907CA522
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJPKSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjJPKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:17:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258D10D5;
        Mon, 16 Oct 2023 03:17:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ba081173a3so710235766b.1;
        Mon, 16 Oct 2023 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697451444; x=1698056244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ABIBqRVTS2T0tRVHTT9KAXeuy4mMkl/npHfHsfl4HI=;
        b=hUB11ebL+3GCTJSUc67A2heti7QL91wl/LyG0r0P33/Yk2wiMgHuzTFZYHZo17eLnE
         RQvNFp3dRt6Q9AqOBHO3vS+y/uZQuPkJfTG/slkYW8R2Qi+a3NNLppCCeShezOI2JKAW
         uAKytM8TgDpTIbU41qaATcMX4Cmn7bw9paImOCZhbJGt8kbEOhBGvvJPbdcgqVrGSEmu
         3oIhC7gL0xq8q/v9S4GirX2Zu/TrULz1ulNZtqTcuXyKwhsUcV9By5JXOsxygaX5os2X
         o0pdbhGJwk19IGnziH6SPt/PShaW3NgKxifS+NOeaA0uUbkps9NHP5wk0tGkksNIE6Xo
         KyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451444; x=1698056244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ABIBqRVTS2T0tRVHTT9KAXeuy4mMkl/npHfHsfl4HI=;
        b=GE6VHggmq1CCeSTG4OCJWlm4JaQ6QS5/q5NzeP9hyHtHLW9znIwRPbwzSaFoizIjPD
         9398lBi/71LB5VG86tOTUmomwjIfJ6C92LY2jM4s+USWRN6Ges2bTBTnycjruFWMgSU+
         Pke3dzfgn83o2NBNfxgzzUA3klleiYyCtUbR/wxVQvkD78V5RBXs1RgQRV52NDGLaFGa
         hri/lQrRbQAhpL64e4rPVgJPbDn+RnhLSVRl48YrnpGGCbWLHs5eNf46zC8oo6eqomYT
         qFXTZTwR/O7peXYOvluOfuw+lMGNI63kd/tG0qUMENlj5mhFSurD21+WMskqAZzY28NZ
         eSWA==
X-Gm-Message-State: AOJu0YygtfBjNsryXXYnk806/gPjBVX9eQiIbWZf1zlpAzr3X15oZ8xG
        RZ7fQaPEL5dv/gI6AuFQuRc=
X-Google-Smtp-Source: AGHT+IHLskuU7E2U4B8DFF/3AUSD5n4mYeQu/HFu/etDgo35vkLCIanfxkLH0t5qDGRjitf6y+d4PA==
X-Received: by 2002:a17:907:d02:b0:9be:1dbd:552e with SMTP id gn2-20020a1709070d0200b009be1dbd552emr7772284ejc.68.1697451444267;
        Mon, 16 Oct 2023 03:17:24 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n25-20020a17090673d900b0099297782aa9sm3683857ejl.49.2023.10.16.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:17:24 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:17:21 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <20231016101721.ktc6mrpewrxsh7nv@skbuf>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-4-o.rempel@pengutronix.de>
 <20231013122405.3745475-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013122405.3745475-4-o.rempel@pengutronix.de>
 <20231013122405.3745475-4-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:24:01PM +0200, Oleksij Rempel wrote:
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index db0ef4ad181e..bef1951fe6f2 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -319,6 +319,8 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
>  	.mdb_del = ksz9477_mdb_del,
>  	.change_mtu = ksz9477_change_mtu,
>  	.phylink_mac_link_up = ksz9477_phylink_mac_link_up,
> +	.wol_get = ksz9477_get_wol,
> +	.wol_set = ksz9477_set_wol,

Can the dev_ops function pointers also be named get_wol() and set_wol()
for consistency with everything else?

>  	.config_cpu_port = ksz9477_config_cpu_port,
>  	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
>  	.enable_stp_addr = ksz9477_enable_stp_addr,
> @@ -2935,6 +2937,28 @@ static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
>  	return 0;
>  }
