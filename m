Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6077BD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHNPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHNPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:50:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4ACA3;
        Mon, 14 Aug 2023 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=v5JgryXQYnsxijbmMHcJuW7R0tp/PKPWCaTYNByJedo=; b=tpXUZJbxcqhkYgC4Cogo19XedQ
        N5O/9gLVI1T6mQk7NmQWDR13dZ3Xz5wPNFd6YqEqPVI0Ktx0WJRkwijOnZewGBufIGHZvhhSmxEcy
        ueKZuwMOXqOSfoWlPBh6HGVGy7FvKFU1enIcc3CRZYxLSFcbTtR18EUOXaevgkEF2tKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVZpo-0044Iy-Uz; Mon, 14 Aug 2023 17:50:24 +0200
Date:   Mon, 14 Aug 2023 17:50:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 2/5] net: phy: remove MACSEC guard
Message-ID: <2d367db9-94cf-433b-a129-59ed6ac54229@lunn.ch>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-3-radu-nicolae.pirea@oss.nxp.com>
 <056a153c-19d7-41bb-ac26-04410a2d0dc4@lunn.ch>
 <ZNpJxca6SE4Mii2L@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpJxca6SE4Mii2L@hog>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:35:33PM +0200, Sabrina Dubroca wrote:
> 2023-08-11, 18:59:57 +0200, Andrew Lunn wrote:
> > On Fri, Aug 11, 2023 at 06:32:46PM +0300, Radu Pirea (NXP OSS) wrote:
> > > Allow the phy driver to build the MACSEC support even if
> > > CONFIG_MACSEC=N.
> > 
> > What is missing from this commit message is an answer to the question
> > 'Why?'
> 
> The same question applies to patch #1. Why would we need a dummy
> implementation of macsec_pn_wrapped when !CONFIG_MACSEC?
> 
> I guess it's to avoid conditional compilation of
> drivers/net/phy/nxp-c45-tja11xx-macsec.c and a few ifdefs in the main
> driver.

Which is that the mscc driver does.

Implementing MACSEC is a lot of code, and makes the resulting binary a
lot bigger. So it does seem reasonable to leave it out if MACSEC is
not needed.

So i suggest you follow what mscc does.

    Andrew
