Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630579418F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbjIFQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:37:12 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C923C1738;
        Wed,  6 Sep 2023 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kC/adOmPdO89VH7yR1A+ieJSp6e/4jhkrzrqxAYoq4Q=; b=ZY0B0RFpQ9y8GWbA9R1g80J8/y
        hq2amJhTIfAWWLb6RhZOQ5JA0WTlW/XesbFOKLHVntcVrs0tNjeOdAEWFTx5/fmLKbMQsi8CwIgPr
        K6R/e0qNrDNLyPh/E8TdRgvBikMlyhvgty0NVpQ/Rang/PEgjJM1/co4cnipew1rHxi80ZKnLM/vY
        dZ7/fxDY02anS2XW9XTymJELpm7I+xMMWDCYvlbW/X16N9ZNctFKNuZ1zoYVpfuajY6J0FJgsYDAl
        JOUb1EQYzNnpe49NJQRoVa2m+6rSuJ86VuqVp5mRnmmqxnv4kBCfO+ESkwxUJNkF3kcFMRI4JWnGr
        tnuPALbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54168)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qdvWL-0000pm-0k;
        Wed, 06 Sep 2023 17:36:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qdvWJ-0004vb-TO; Wed, 06 Sep 2023 17:36:47 +0100
Date:   Wed, 6 Sep 2023 17:36:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org
Subject: Re: [RFC net-next v2 2/2] net: dsa: microchip: Add drive strength
 configuration
Message-ID: <ZPiqn94YbJXCqpT8@shell.armlinux.org.uk>
References: <20230906105904.1477021-1-o.rempel@pengutronix.de>
 <20230906105904.1477021-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906105904.1477021-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:59:04PM +0200, Oleksij Rempel wrote:
> +static void ksz9477_drive_strength_error(struct ksz_device *dev, int milliamp)
> +{
> +	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
> +	char supported_values[100];
> +	int i;
> +
> +	for (i = 0; i < array_size; i++) {
> +		if (i == 0)
> +			snprintf(supported_values, sizeof(supported_values),
> +				 "%d", ksz9477_drive_strengths[i].milliamp);
> +		else
> +			snprintf(supported_values, sizeof(supported_values),
> +				 "%s, %d", supported_values,
> +				 ksz9477_drive_strengths[i].milliamp);

That's an interesting way to append... I note that snprintf(3) has a
note about this, suggesting that (a) the standards make this undefined
and (b) that depending on the gcc version used, this may not produce
the expected results. Taking both together seems sufficient
justification to stay away from attempting this method of appending
a string.

> +static int ksz9477_drive_strength_write(struct ksz_device *dev,
> +					struct ksz_driver_strength_prop *props,
> +					int num_props)
> +{
> +	int i, ret, reg;
> +	u8 val;
	u8 val, mask;

> +
> +	if (props[KSZ_DRIVER_STRENGTH_IO].value != -1)
> +		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
> +			 props[KSZ_DRIVER_STRENGTH_IO].name);
> +
> +	if (dev->chip_id == KSZ8795_CHIP_ID ||
> +	    dev->chip_id == KSZ8794_CHIP_ID ||
> +	    dev->chip_id == KSZ8765_CHIP_ID)
> +		reg = KSZ8795_REG_SW_CTRL_20;
> +	else
> +		reg = KSZ9477_REG_SW_IO_STRENGTH;
> +

> +	ret = ksz_read8(dev, reg, &val);
> +	if (ret)
> +		return ret;
> +
Remote this.

	val = mask = 0;

> +	for (i = 0; i < num_props; i++) {
> +		if (props[i].value == -1)
> +			continue;
> +
> +		ret = ksz9477_drive_strength_to_reg(props[i].value);
> +		if (ret < 0) {
> +			ksz9477_drive_strength_error(dev, props[i].value);
> +			return ret;
> +		}
> +
> +		val &= ~(SW_DRIVE_STRENGTH_M << props[i].offset);

		mask |= SW_DRIVE_STRENGTH_M << props[i].offset;

> +		val |= ret << props[i].offset;

		val |= ret << props[i].offset;

> +	}
> +
> +	return ksz_write8(dev, reg, val);

	return ksz_rmw8(dev, reg, mask, val);

maybe safer?


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
