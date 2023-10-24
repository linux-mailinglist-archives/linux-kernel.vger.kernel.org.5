Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37F7D53C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjJXOTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjJXOTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:19:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11D10A;
        Tue, 24 Oct 2023 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=AqIOY3MydOW0E4HOkt35Fwk6DE+KKlC+N1Rk35Tgk3g=; b=NsAEZaU08KEjPSnJiMF2LI23mg
        XBEBYzoNHMBCjM7E07r7O2n/niFFR17ntkiAbXgx9bqjOLdZztLH/G/8Yzm5NZPN+PVNdHvp39akk
        kQ0WtrR3Ufkmpms7q3EXrBeY3bWUfWVunLolttcmV34ip3EkAIjLWaJ0epvP8b3646zY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qvIF8-00051D-M4; Tue, 24 Oct 2023 16:18:50 +0200
Date:   Tue, 24 Oct 2023 16:18:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: cn913x: add device trees for COM Express
 boards
Message-ID: <55685b4c-843a-4430-b153-a0eef2e93265@lunn.ch>
References: <20231024131935.2567969-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024131935.2567969-1-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +&cp0_mdio {
> +	status = "okay";
> +	pinctrl-0 = <&cp0_ge_mdio_pins>;
> +	phy0: ethernet-phy@0 {
> +		marvell,reg-init = <3 16 0 0x1a4a>;

What does this do? I guess it is something to do with LEDs. Polarity?

> +&cp0_mdio {
> +	status = "okay";
> +	pinctrl-0 = <&cp0_ge_mdio_pins>;
> +	phy0: ethernet-phy@0 {
> +		marvell,reg-init = <3 16 0 0x1a4a>;

I'm temped to NACK this, and get you to work on the LED code in the
Marvell PHY driver and phylib to support what you need. This API is
horrible and should not be used any more.

	Andrew
