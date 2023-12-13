Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B50811756
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442138AbjLMPh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442034AbjLMPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:37:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B5B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:38:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C816BC433C7;
        Wed, 13 Dec 2023 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481882;
        bh=gScubWv7+ZzEnPJcCeVKQ22MVXXXNr97yRWbtv+NF0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T2sHLqfXvg9T3II4rQGTdcTvXulOsp7sNYJ54yV3gHU0Jgfaq31E4smT+XznySFO3
         LgGM+9Z6QLRZwxj5Bu7Y/2vsNVQp9NczPM2L0nCEW1tJdKkUBJmgyUTnP+y7W0zvbE
         1IwoIqbhmABGes3iWB8/e2KVEHasTZbFOlhlnJ0oaI6gg0b+EWqGc6z+kFs2KsBx92
         57NvpXzl11/wqIraHM4jZFUd/aZn9rXSXXQGvAUbO2YG/hDQwH5V3SIdDraUFkrU8w
         mr5BQSeQUa4hFxTk2pEHhoQ/yU9RAaJHHDEUOJ2VLbhp8Bwnpk2xldeEs98fD3tfA9
         Hnsrbi+hC8Zcg==
Date:   Wed, 13 Dec 2023 16:37:57 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Daniel Golle <daniel@makrotopia.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <20231213163757.1d576bb7@dellmb>
In-Reply-To: <20231213150033.17057-1-ansuelsmth@gmail.com>
References: <20231213150033.17057-1-ansuelsmth@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Display only supported entry */
> +	if (attr == &dev_attr_link_10.attr &&
> +	    (test_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported_link_speed) ||
> +	     test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported_link_speed)))
> +		return attr->mode;
> +
> +	if (attr == &dev_attr_link_100.attr &&
> +	    (test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported_link_speed) ||
> +	     test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported_link_speed)))
> +		return attr->mode;
> +
> +	if (attr == &dev_attr_link_1000.attr &&
> +	    (test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported_link_speed) ||
> +	     test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported_link_speed)))
> +		return attr->mode;
> +
> +	if (attr == &dev_attr_link_2500.attr &&
> +	    test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported_link_speed))
> +		return attr->mode;
> +
> +	if (attr == &dev_attr_link_5000.attr &&
> +	    test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported_link_speed))
> +		return attr->mode;
> +
> +	if (attr == &dev_attr_link_10000.attr &&
> +	    test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported_link_speed))
> +		return attr->mode;

Why only the T modes? There are much more ethtool modes for these
speeds, for example at least 5 modes for 1000 mbps speed:
  1000baseT_Half
  1000baseT_Full
  1000baseKX_Full
  1000baseX_Full
  1000baseT1_Full

There are also 2 possible modes for 2500 mbps
  2500baseT
  2500baseX

Ditto for 10 mbps and 100 mbps.

So if you're doing this, why not do it properly?

There is an aarray
  static const struct phy_setting settings[]
in
  drivers/net/phy/phy-core.c
and a function phy_speeds() which will tell you which speeds are
supported for a given ethtool mode bitmap.

Or you can add another function there,
  bool phy_speed_supported(unsigned long mask, unsigned int speed)
and use that one.

Marek
