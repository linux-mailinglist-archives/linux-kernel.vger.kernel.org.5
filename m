Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73C7BB979
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjJFNoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjJFNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:44:32 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE8C6;
        Fri,  6 Oct 2023 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=j+o9YD/rH4lCweO3w6aErJlrY3wSbYk7WLC6xWXOuUE=; b=yKQkpi4TqAyIM2EQ2VF0C5etHx
        q4si8bPUVwwKmUP79r1bC5slCapWFqjQMUVMKjh+J8BlCEi1DsTk64mwpqH9SP9rd1n+U772UfCBZ
        bl4gDEKYafe3chxgUaapciz19pgqoec1Esonf9lVetPN2x1J6Exva2kAphcuRS6eCg/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qol7q-0000t2-Aq; Fri, 06 Oct 2023 15:44:18 +0200
Date:   Fri, 6 Oct 2023 15:44:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement
 net_device_ops
Message-ID: <f4bcf3e9-d059-4403-a2b7-508806da9631@lunn.ch>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-9-justinlai0215@realtek.com>
 <b28a3ea6-d75e-45e0-8b87-0b062b5c3a64@lunn.ch>
 <99dfcd7363dc412f877730fab4a9f7dd@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99dfcd7363dc412f877730fab4a9f7dd@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static void rtase_tx_timeout(struct net_device *dev, unsigned int
> > > +txqueue) {
> > > +     rtase_sw_reset(dev);
> > 
> > Do you actually see this happening? The timeout is set pretty high, i think 5
> > seconds. If it does happen, it probably means you have a hardware/firmware
> > bug. So you want to be noisy here, so you get to know about these problems,
> > rather than silently work around them.
> 
> I would like to ask if we can dump some information that will help
> us understand the cause of the problem before doing the reset? And
> should we use netdev_warn to print this information?

You might want to look at 'devlink health'. 

    Andrew
