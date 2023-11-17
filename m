Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B77EF4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjKQOuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:50:22 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB10130;
        Fri, 17 Nov 2023 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=iAkHQGc9Edeyxcg4qVcHCYzdGc4W9iYw+dBZmqgXC2s=; b=z8
        sIuKyu0PZQo8Ea8EUYW/pA1XMaUR/Dj7Ns+M2Atb697BbHI47+Y6e1R5Kpemm41N/XJ/WRTtzwTJD
        GrXzQuwO8p2VlWiuQ6R0pPXyr6J/S8IPqkXMMFqw3sFQ2kpsmS6RToXS5Ui8+N1f15PCvBnMySOv7
        Z0C4Fa0ZDJkCBDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r40AX-000Rpd-6D; Fri, 17 Nov 2023 15:50:05 +0100
Date:   Fri, 17 Nov 2023 15:50:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <18e7e893-8473-4417-93f8-c3b4ccf4b971@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
 <8e077bbe-3b65-47ee-a3e0-fdb0611a2d3a@lunn.ch>
 <20231117122236.3138b45e@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117122236.3138b45e@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 12:22:36PM +0100, Köry Maincent wrote:
> Thanks for your review!
> 
> On Thu, 16 Nov 2023 23:41:55 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +struct pd692x0_msg {
> > > +	struct pd692x0_msg_content content;
> > > +	u16 delay_recv;
> > > +};  
> > 
> > > +	if (msg->delay_recv)
> > > +		msleep(msg->delay_recv);
> > > +	else
> > > +		msleep(30);  
> > 
> > > +	if (msg->delay_recv)
> > > +		msleep(msg->delay_recv);
> > > +	else
> > > +		msleep(30);  
> > 
> > > +	if (msg->delay_recv)
> > > +		msleep(msg->delay_recv);
> > > +	else
> > > +		msleep(30);
> > > +  
> > 
> > As far as i can see with a quick search, nothing ever sets delay_recv?
> > 
> > 	Andrew
> 
> In fact I wrote the driver taking into account that there are two commands (save
> and restore) that need a different delay response. As currently we do not
> support them I can indeed drop it for now and add it back when I will add their
> support.

When you add it back, maybe just arrange for delay_recv to be set to
30?

	Andrew
