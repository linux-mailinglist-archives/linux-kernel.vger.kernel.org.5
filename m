Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC57A80D016
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjLKPv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:51:57 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D94BD;
        Mon, 11 Dec 2023 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P9gG83qx8aR9uLdUcuIWFCkioCtRZaO43g3YwL30w+E=; b=ZrDV1J6Bl/sRJwDj17If6GhPTE
        +sJqL2xe0aqq2qDLjWdejUOg6VokCSQ8KDOk410SvVABH9PdZhqVxt/ydXNn3FdVoJWKZeTD7liI1
        fsK3IeCLrgK97YzbFys1oSh/S7FW1xMaT8M4taa+4Cb+1hRNFHY/6nXSr37umRTn5mMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rCiZY-002dTF-R2; Mon, 11 Dec 2023 16:51:56 +0100
Date:   Mon, 11 Dec 2023 16:51:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
Message-ID: <6fce1c46-f7ae-4729-b9d4-763af45f6146@lunn.ch>
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
 <65772f6f.050a0220.8a2bb.80c7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65772f6f.050a0220.8a2bb.80c7@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:49:00PM +0100, Christian Marangi wrote:
> On Mon, Dec 11, 2023 at 04:44:06PM +0100, Andrew Lunn wrote:
> > > +properties:
> > > +  qca,led-active-high:
> > > +    description: Set all the LEDs to active high to be turned on.
> > > +    type: boolean
> > 
> > I would of expected active high is the default. An active low property
> > would make more sense. It should also be a generic property, not a
> > vendor property. As such, we either want the phylib core to parse it,
> > or the LED core.
> >
> 
> Also sorry for the double email... Any help for the problem of the
> missing link_2500 define in net-next? (merged in Lee tree?)

You need to email Lee and Jakub, ask for a stable branch which can be
pulled into net-next.

       Andrew
