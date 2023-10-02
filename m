Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C384E7B5C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjJBVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBVHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:07:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88948E;
        Mon,  2 Oct 2023 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cHdxPJkUffAe71uXd4ceymr9QjRVP6992Y6TUUtw5Jk=; b=VOLjccYRB8DDrJeZxkRDhrd9M6
        BAI10X6BkVMCgCay8Q3Q/aMez4oITD685DE1zeK8PUNHxCZEcL94F657Z7+jH/bdNSKjik+R56PUe
        5XF6DFiRwvZykTNg+UQ+yL8B5S3k960aDSS0N0+z9O4BnqwpL6Gn2Dcu66A3071gKz0k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qnQ8T-0083OV-Ly; Mon, 02 Oct 2023 23:07:25 +0200
Date:   Mon, 2 Oct 2023 23:07:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <9a84642e-b4fe-4e36-bcdc-d02c84bb1dc9@lunn.ch>
References: <20230930104008.234831-1-robimarko@gmail.com>
 <df89a28e-0886-4db0-9e68-5f9af5bec888@lunn.ch>
 <651b26a5.050a0220.213bf.e11b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651b26a5.050a0220.213bf.e11b@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is problematic... Since this is a plain standard PHY and we don't
> have a compatible (as it's matched with the PHY id) we don't have DT to
> add this... Sooo how to add this? Should we update the generic-phy dt?
> 
> Should we create a dummy dt and add a compatible adding
> ethernet-phy.ID... just for this properties?
> 
> This is why we were a bit confused about adding a DT commit to this.

Just do what other PHYs do. ti,dp83869.yaml, motorcomm,yt8xxx.yaml,
nxp,tja11xx.yaml, etc.

	Andrew
