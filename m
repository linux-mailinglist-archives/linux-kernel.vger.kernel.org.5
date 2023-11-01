Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9557DE199
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjKANVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjKANVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:21:45 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB94FD;
        Wed,  1 Nov 2023 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fTZGkY03HE3O8L5UizGWjCWSFnz27c8Zq89DTc21l7Q=; b=KLptjDmueC7lG8F5Qj23yozjFU
        Mg93eV2M0Lo9dMPjed/qt0VczCYZJYbFIrPVCx+EzVsY6WI9Up1Nqmf04t3R/YFDtBu0qL7WYod3y
        ALg2pDOXXEblD/S1pTUi4ssd3uANusNuIWNz+BmJdvbNFV8PkFILAGXPRgV0H4Wr9uwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyBA1-000gi8-KI; Wed, 01 Nov 2023 14:21:29 +0100
Date:   Wed, 1 Nov 2023 14:21:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Message-ID: <fe8d7176-6f37-47cb-950f-257f54965339@lunn.ch>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <20231101123608.11157-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101123608.11157-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actually
> +  work.
> +
> +  This can be done and is implemented by OEM in 3 different way:
> +    - Attached SPI directly to the PHY with the firmware. The PHY will
> +      self load the firmware in the presence of this configuration.
> +    - Dedicated partition on system NAND with firmware in it. NVMEM
> +      subsystem will be used and the declared NVMEM cell will load
> +      the firmware to the PHY using the PHY mailbox interface.
> +    - Manually provided firmware using the sysfs interface. Firmware is
> +      loaded using the PHY mailbox.

sysfs is a linux concept. DT bindings should be OS agnostic. It would
be better to say its loaded from a file in the file system.

I'm not sure mailbox is relevant here. All you really are trying to
say is that if there is an SPI flash, the PHY will load the firmware
itself. If not the driver will load the firmware.

	Andrew
