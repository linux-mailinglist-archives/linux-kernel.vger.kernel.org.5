Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3AD7995F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 04:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjIIC1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjIIC1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 22:27:44 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534451FEF;
        Fri,  8 Sep 2023 19:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=OE+AIxlFdRyZcA4Gag1i4gJe884pcRWVjakLn4CplzA=; b=30rG5BMChfpid4nfM6SSkqxXpT
        y5HHdpI0Wt3J6p7gbZ0V8RZfdC8/HYmsehA1xtW1ZO0PFPQUUnQer13DL7VhZXkItWMWDciP+svtf
        pVuMuCZhIpxTxxuHNINTHGw71C5igSptNHdmRLCifjKf8XCr8zhViUMRMrOrJ90xjP6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qenh5-00636R-Gx; Sat, 09 Sep 2023 04:27:31 +0200
Date:   Sat, 9 Sep 2023 04:27:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     netdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking LEDs
Message-ID: <6c8f5cc5-0b8b-42e0-ac86-91ddcb35389f@lunn.ch>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
 <2239338.iZASKD2KPV@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2239338.iZASKD2KPV@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This works as intended so far. Unfortunately this driver and the PHY LED 
> framework do not support active-low LEDs (yet).

Polarity is something which i've seen a few PHY devices have. It also
seems like a core LED concept, not something specific to PHY LEDs. So
i think this needs to be partially addressed in the LED core.

  Andrew
