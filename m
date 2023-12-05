Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A8805C56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbjLEOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbjLEOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:54:12 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008CC9;
        Tue,  5 Dec 2023 06:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZZpeAgyRW+DpHk4FdCZKuI0czxGCRAJrnjC4XQgIC+A=; b=HUPGps74HulDcqW2Zakxrbrz5R
        FIzbuwAHeKJ7DH47Ge7tpPRKFgD8hH17Dnn00tDhLN1vxRQliEYrQcwy8fclW0/WUDwANTIFVCOBU
        7A0Ea7T5qfZh/sddlqRmkskN5d6JFR3Efv4rSJeSCEZ3UeO/wogsSPU6g6s5j7aVZXVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rAWoG-0026Z6-L1; Tue, 05 Dec 2023 15:54:04 +0100
Date:   Tue, 5 Dec 2023 15:54:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656f37a6.5d0a0220.96144.356f@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I tend to agree. These functions should be documented once in kdoc,
> > and only once. I don't really care if its in the header, or the C
> > code, but not both.
> >
> 
> Ok just to make sure, I should keep the kdoc in the .c and drop them in
> .h ? (or should I move the more complete kdoc in .c to .h and remove
> kdoc in .c?)

Please put the kdoc in the header file and remove if from the .c file.

Thanks
	Andrew
