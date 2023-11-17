Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224307EF3FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjKQOGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:06:51 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F7C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MS+xmKtqjDZ/M5t29RFVVypGVB4vFBAUGa6e5AlAOCQ=; b=Q/xnXEcNd608d6/bAxOEWOb6Ts
        apPho17iQjkY8qLuX5F5LWJI5eWVIQ79yYccBBSdw1W0YHJ+dF29mop7mZAMPlRyJXgD2NX9Xhys1
        9QkMY/0uKE3fZN0DAkgxo+7P3GxLn5JGk67DARDI4RT1j84v0KbwyW1v+Tm7KEJCzmSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3zUa-000Rbp-3x; Fri, 17 Nov 2023 15:06:44 +0100
Date:   Fri, 17 Nov 2023 15:06:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] firmware_loader: Expand Firmware upload error codes with
 firmware invalid error
Message-ID: <548c3b60-60ce-4166-9943-224e03152cc5@lunn.ch>
References: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
 <2023111720-slicer-exes-7d9f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023111720-slicer-exes-7d9f@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 08:45:59AM -0500, Greg Kroah-Hartman wrote:
> On Fri, Nov 17, 2023 at 11:27:53AM +0100, Kory Maincent wrote:
> > No error code are available to signal an invalid firmware content.
> > Drivers that can check the firmware content validity can not return this
> > specific failure to the user-space
> > 
> > Expand the firmware error code with an additional code:
> > - "firmware invalid" code which can be used when the provided firmware
> >   is invalid
> > 
> > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > 
> > This patch was initially submitted as part of a net patch series.
> > Conor expressed interest in using it in a different subsystem.
> > Consequently, I extracted it from the series and submitted it separately
> > to the main tree, driver-core.
> > https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf249@bootlin.com/
> 
> So you want me to take it through my tree?  Sure, but if you are relying
> on this for any other code, it will be a while before it gets into
> Linus's tree, not until 6.8-rc1, is that ok?

My idea was that you could create a stable branch, which can then be
pulled into netdev and arm-soc.

If you don't want to do that, we can ask Arnd to take it, and he can
create a stable branch which we pull into netdev.

       Andrew
