Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324C80F786
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377175AbjLLUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:09:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B6AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:09:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E340AC433C7;
        Tue, 12 Dec 2023 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702411770;
        bh=0eVTZkHlIsk4aS6bhAk3MNH78cknRO/FG2cL4SHw4nI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DD6xBI3fMi8m8hMqyxAqM36NRBTMjYg931z25Qts7t2uYQAK00GDdDBiyoi/FZU58
         T9SoUwMxKnA0cz46BjKba5m4VqYqOTygLmVIs3sEdYuPg2P2ASocvDEPXR3wC/uJE9
         qEe24c7y5ScQsZx/2ONaVEeGAFcO9ftV+ckdevj9JrD3fis2cq6fShopa8V0O95wZM
         aKFwUfAe3+3iMj5KxNCUAELeS6V6diijN3EkX7+vLAMkWsBKXOBP6/RP7mcSg+1E8/
         VE8WRBkUH64YHcc3gYeYdaT8WvphmfQCBlKozwafOyXWENgvyoVL1JmNRxKlQWJxPt
         PjGzwsL/bIOtg==
Date:   Tue, 12 Dec 2023 12:09:28 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231212120928.4b558d68@kernel.org>
In-Reply-To: <20231212123743.29829-3-ansuelsmth@gmail.com>
References: <20231212123743.29829-1-ansuelsmth@gmail.com>
        <20231212123743.29829-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 13:37:43 +0100 Christian Marangi wrote:
> + * __phy_package_write_mmd - write MMD reg relative to PHY package base addr

kdoc test says phy_package_write_mmd

> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to write to
> + * @regnum: The register on the MMD to write
> + * @val: value to write to @regnum
> + *
> + * Convenience helper for writing a register of an MMD on a given PHY
> + * using the PHY package base address. The base address is added to
> + * the addr_offset value.
> + *
> + * Same calling rules as for phy_write();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> + */
> +int phy_package_write_mmd(struct phy_device *phydev,
-- 
pw-bot: cr
