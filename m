Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4A7A507F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjIRRHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjIRRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9595497;
        Mon, 18 Sep 2023 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=lgfas7avhgiihQebG1lQQFSWTYzTTBigEkTfGM3EQc8=; b=z1Ky3EA52riPjKNeUy0vxsCo0I
        6XNHu4PbKQibr6MGroYyZolishlYuzN+/5cUazf175D1Z3Zt2Ty2bQ3pY4Gq1VN9532VBlyd7akGG
        wE8a9SaDZOmwdTweuzMC1ygjpC4SPmSwlSnQ1k+dF6qFJBZmattZLfEVYwt6CD+1aBoM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiGft-006oAL-TH; Mon, 18 Sep 2023 18:00:37 +0200
Date:   Mon, 18 Sep 2023 18:00:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jay Monkman <jtm@lopingdog.com>
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>,
        Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH 4/4] net/onsemi: Add NCN26010 driver
Message-ID: <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
References: <ZQf1QwNzK5jjOWk9@lopingdog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQf1QwNzK5jjOWk9@lopingdog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:59:15AM -0500, Jay Monkman wrote:
> 
> This adds a driver for the onsemi NCN26010 ethernet controller. The
> NCN26010 is combined MAC/PHY that uses SPI to interface to a
> microcontroller.

Is this an OA TC6 device?  At a quick look it does appear to
be. Please make use of the framework Microchip is developing:

https://lore.kernel.org/netdev/20230908142919.14849-4-Parthiban.Veerasooran@microchip.com/T/

	Andrew
