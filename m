Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E77A5082
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjIRRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIRRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06AE94;
        Mon, 18 Sep 2023 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=A4yzGLXsCoMt636aHEn/2wTD7iTwqIEeCCVkVl5NG28=; b=0OWcHQZMNQM1VZvs8cNLfozLdU
        ibUf0Cv45//VYlJJO/82/PsrH3JVtfWBxWQo6escaBPOqKSAFF94nd8jyjswqUdXBVQWZLsR15b5y
        B4KR9udrykfuaycCrQ+s2YhmecYeIL//a7LZ/YUgovJ6UwueeGZmEmt/iDXQ9L1H58N0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiGy0-006oHE-Hg; Mon, 18 Sep 2023 18:19:20 +0200
Date:   Mon, 18 Sep 2023 18:19:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc:     Jay Monkman <jtm@lopingdog.com>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH 3/4] net: phy: Add GPIO and DT support to NCN26000
Message-ID: <ba9e7fb4-e19f-454c-9542-cb53b45f6b99@lunn.ch>
References: <ZQf1Nx+2amtUZulX@lopingdog.com>
 <b279bee8-1613-23ea-a339-9d3fdde9d0eb@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b279bee8-1613-23ea-a339-9d3fdde9d0eb@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:40:36AM +0100, Vadim Fedorenko wrote:
> > +static int ncn26000_gpio_request(struct gpio_chip *gc, unsigned int offset)
> > +{
> > +	struct ncn26000_priv *priv = gpiochip_get_data(gc);
> > +
> > +	if (offset > 2)
> > +		return -ENODEV;
> > +
> > +	if (priv->gpiomask & (1 << offset))
> 
> it's better to use BIT(offset) here

Hi Vadim

When replying, please trim the email to just the relevant text.

     Thanks
	Andrew
