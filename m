Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C7788904
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbjHYNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbjHYNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:50:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2E213D;
        Fri, 25 Aug 2023 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=a3FiZjh9L5KNDqjT1PJkkiHZWi2wdLHxr5sQceKIIH4=; b=4HjOt6YFmWXQk9uuj1BNfB4+hV
        8KxPDX2VPjSx23zqk30XyuJ7oN/X+NzQ3a9XvyxNxYJAuO5EY4Q3w700J1zdApbPTWYGQI9w8/yZj
        YPXcWRs8xwdB3ra9HVBaHICzU2fNqmVz9a8QeR9M4wUj48Y3bIU1l9BWD7xle0rvEO0w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qZXCQ-0055wu-Dn; Fri, 25 Aug 2023 15:50:06 +0200
Date:   Fri, 25 Aug 2023 15:50:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     Sabrina Dubroca <sd@queasysnail.net>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <e2e26d30-86fb-4005-9a0e-ac9b793df86a@lunn.ch>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog>
 <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
 <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
> > > > +				struct macsec_rx_sc *rx_sc)
> > > > +{
> > > > +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
> > > 
> > > u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
> > 
> > why is the __force needed? What happens with a normal cast?
> > 
> 
> Sparse will print warnings if __force is missing.

What is the warning? I just want to make sure __force is the correct
solution, not that something has the wrong type and we should be
fixing a design issue.

       Andrew
 
