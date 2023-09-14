Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCD7A0443
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbjINMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjINMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:47:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC31FD0;
        Thu, 14 Sep 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BqdX0hV4tEYYiC/8IPMSmeBje/hkN8pxNeaKmKo60TU=; b=aYrPSq1Z0wwYWNUTdYynOkxBA6
        E+w/1eZhLHk4s58sCaIEJ1KFtUw+st8SkT7226R2SLYuikfBIlgVVOVDAFvbyp2B8O+ASrDt0TAht
        EoSM3A6tvITFl6WHoCdEfs4Yq5cRbq0jPQ9gN7wdenjmmtXKpw5ctvd+/YbeLPe5g/8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgll2-006P6o-Qu; Thu, 14 Sep 2023 14:47:44 +0200
Date:   Thu, 14 Sep 2023 14:47:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <60703503-e592-4467-a942-74400583369d@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <e7b49a60-4422-4f3f-3e77-d924f967e939@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b49a60-4422-4f3f-3e77-d924f967e939@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW when thinking about multiple PHY to a single MAC, what comes to my 
> mind is the SIS 900 board, and its driver net/ethernet/sis/sis900.c
> 
> It has a function sis900_default_phy() that loops over all phys to find 
> one with up-link then to put all but that one in ISOLATE mode. Then when 
> the link goes down it loops again to find another up-link.
> 
> I guess your series would also help in that case, wouldn't it ?

Yes, it would. However, that driver would need its PHY handling
re-written because it is using the old MII code, not phylib.

	Andrew
