Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06337EB93C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjKNWSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjKNWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:18:49 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE534D5;
        Tue, 14 Nov 2023 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kYFMgAp+5BoxtlQI58FobE//112Vfycj7qgkhJNRtpw=; b=BfaKGznOtChcnGUIxWwWLYcJx5
        W2tCtpsHx21rGU/QW4t9sCNZ8B1kQ2ekcDHOGxxrnY9eCfP5GOClQV/WfNnWznn7vkUv1OeKViAmm
        VR/BVwv6QgVg/4UTM8IuCORrG++y/cI6TXzPH4kOGCe6jH7GGwq1N3Zq6TWKdfxJ83WY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r31jn-000CM0-QJ; Tue, 14 Nov 2023 23:18:27 +0100
Date:   Tue, 14 Nov 2023 23:18:27 +0100
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
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v8 3/4] net: phy: aquantia: add firmware load
 support
Message-ID: <94a68354-1956-49dd-9fb6-edb3fefaf5d7@lunn.ch>
References: <20231114140844.9596-1-ansuelsmth@gmail.com>
 <20231114140844.9596-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114140844.9596-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 03:08:43PM +0100, Christian Marangi wrote:
> From: Robert Marko <robimarko@gmail.com>
> 
> Aquantia PHY-s require firmware to be loaded before they start operating.
> It can be automatically loaded in case when there is a SPI-NOR connected
> to Aquantia PHY-s or can be loaded from the host via MDIO.
> 
> This patch adds support for loading the firmware via MDIO as in most cases
> there is no SPI-NOR being used to save on cost.
> Firmware loading code itself is ported from mainline U-boot with cleanups.
> 
> The firmware has mixed values both in big and little endian.
> PHY core itself is big-endian but it expects values to be in little-endian.
> The firmware is little-endian but CRC-16 value for it is stored at the end
> of firmware in big-endian.
> 
> It seems the PHY does the conversion internally from firmware that is
> little-endian to the PHY that is big-endian on using the mailbox
> but mailbox returns a big-endian CRC-16 to verify the written data
> integrity.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
