Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0121679F69D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjINBz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjINBzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:55:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D41BD0;
        Wed, 13 Sep 2023 18:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=AWjszMGAWwAmKRftVpe0hRnvM8CrBy/Ah5EmpYh7ovU=; b=weob5U3WI1KVyn80QQzY4IVrs3
        Nu306fsr4NyATTTU73asLYk0ASWuNiui/fHYecrXRng8P4gemkx5OKzRiSEHeYtAkLJdb9ecLALXA
        vmDY/cl+pk5uWrdFXRhJvFuizdBcO2baumL2Qwv6PLff/BrMMV92n+IQSMnnAUtJYwpE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgbZP-006M7W-W0; Thu, 14 Sep 2023 03:55:03 +0200
Date:   Thu, 14 Sep 2023 03:55:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <8d5078b0-1a45-43ac-89bd-c71c514336f5@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define REG_STDR_RESET		0x00000003

This appears to be a standard register, so you should not need to
define it here.

> +#define REG_MAC_ADDR_BO		0x00010022
> +#define REG_MAC_ADDR_L		0x00010024
> +#define REG_MAC_ADDR_H		0x00010025
> +#define REG_MAC_NW_CTRL         0x00010000
> +#define REG_MAC_NW_CONFIG	0x00010001
> +#define REG_MAC_HASHL		0x00010020
> +#define REG_MAC_HASHH		0x00010021
> +#define REG_MAC_ADDR_BO		0x00010022
> +#define REG_MAC_ADDR_L		0x00010024
> +#define REG_MAC_ADDR_H		0x00010025
> +
> +#define CCS_Q0_TX_CFG		0x000A0081
> +#define CCS_Q0_RX_CFG		0x000A0082

These are proprietary vendor registers, so please add a prefix to make
this clear.

     Andrew
