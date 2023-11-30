Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2058C7FF164
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbjK3OLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbjK3OLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:11:12 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B6385;
        Thu, 30 Nov 2023 06:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xrGDxVjBiy7pGNBE5oOMMvnk6VYQFSoFjjA2DKv6muM=; b=rEX41nldmv40f0DNOVJj3H45rw
        t4zA1ylJWlvA9W/3ulRx3KKe/i8dTncKpRJppD1Ih6xVZcFWzbGVccQAffNR/ozco/EWhK5Vq04ll
        TJsSKiN4ldW1cpuBhLLop5krQxxMIGfo3qdgXAK+BChgMNA/V4EP0APjQv/QDFUX6JrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r8hku-001fii-QS; Thu, 30 Nov 2023 15:11:04 +0100
Date:   Thu, 30 Nov 2023 15:11:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Subject: Re: [PATCH net-next v2] net: phy: mdio_device: Reset device only
 when necessary
Message-ID: <760c746a-5469-4f26-8fd9-5f48affe44a4@lunn.ch>
References: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:41:10PM -0600, Andrew Halaney wrote:
> Currently the phy reset sequence is as shown below for a
> devicetree described mdio phy on boot:
> 
> 1. Assert the phy_device's reset as part of registering
> 2. Deassert the phy_device's reset as part of registering
> 3. Deassert the phy_device's reset as part of phy_probe
> 4. Deassert the phy_device's reset as part of phy_hw_init
> 
> The extra two deasserts include waiting the deassert delay afterwards,
> which is adding unnecessary delay.
> 
> This applies to both possible types of resets (reset controller
> reference and a reset gpio) that can be used.
> 
> Here's some snipped tracing output using the following command line
> params "trace_event=gpio:* trace_options=stacktrace" illustrating
> the reset handling and where its coming from:

...
 
> Reported-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

