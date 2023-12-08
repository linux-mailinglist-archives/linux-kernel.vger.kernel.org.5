Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE14880A6FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574391AbjLHPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574350AbjLHPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:12:21 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543D1BF8;
        Fri,  8 Dec 2023 07:11:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6A04C0009;
        Fri,  8 Dec 2023 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702048265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3cHWqyfL1MHTo5ECWhjRzGg7w8aJh0rDRGtJaQgvZ0=;
        b=JQyoWEytpa4qN/zu+0MfA7JSnKfaCPtsNS7PUOnWZIEJgGo+Id2gCDvbl3yJtuOm4LPOU+
        i2Hq6lhbN07COf4Jev5Y1vpd8ChtkA5Z3TqAqzssXC/b6WlVCsJv+EV78dOIXW3OOV4JE0
        bUEexEurXPzNAzrdfYdcOAKxMoIgGgLiO4rOtxY2QOnL1Z77L7LXyrGf0BaodQU+f6ABMY
        qqrgeRtuexHYU3yG6oOwYtsgx5pYdXqROpaw1F750ZfWRPWtT6PJmAYLtYpnvXy4ZRRAbc
        kg6KHMZPBMttPTruWZ1juXzla+3EFKYyluV9frs63/aEL0rYKNnzIugPO881aQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v9 2/3] ARM64: dts: marvell: Fix some common switch
 mistakes
In-Reply-To: <20231127-mv88e6xxx-mvebu-fixes-v9-2-d19b963e81fb@linaro.org>
References: <20231127-mv88e6xxx-mvebu-fixes-v9-0-d19b963e81fb@linaro.org>
 <20231127-mv88e6xxx-mvebu-fixes-v9-2-d19b963e81fb@linaro.org>
Date:   Fri, 08 Dec 2023 16:11:04 +0100
Message-ID: <877cloenlj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be ethernet-switch@0.
> - ports should be ethernet-ports
> - port@0 should be ethernet-port@0
> - PHYs should be named ethernet-phy@
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  .../dts/marvell/armada-3720-espressobin-ultra.dts  | 14 ++--
>  .../boot/dts/marvell/armada-3720-espressobin.dtsi  | 20 +++--
>  .../boot/dts/marvell/armada-3720-gl-mv1000.dts     | 20 +++--
>  .../boot/dts/marvell/armada-3720-turris-mox.dts    | 85 ++++++++++++----------
>  .../boot/dts/marvell/armada-7040-mochabin.dts      | 24 +++---
>  .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 22 +++---
>  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        | 42 +++++------
>  7 files changed, 115 insertions(+), 112 deletions(-)

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
