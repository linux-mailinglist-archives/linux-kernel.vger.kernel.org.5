Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442B47F0787
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjKSQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:31:10 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5314194;
        Sun, 19 Nov 2023 08:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xV0QCJuId5L0XuQj1+jsWP0jiMqso/x74sTpcxg3CiA=; b=bYNPbzGOQCHEZD9EQKIYplYKt3
        Yo+JPOWXWFkRbVJf94ZlTnNAbM8TZFKwlVq0J7tupLBRj6ZRETcf58sg/Cwjx+WF/OO58zuZN8IIZ
        nRNaK0rMVeEkZYO4VNZ0Rxz3omcXomFZVGKQD7WB+C1dUd2tmLyufuvvRPcWCz4aQcAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r4khD-000Zb6-Cs; Sun, 19 Nov 2023 17:30:55 +0100
Date:   Sun, 19 Nov 2023 17:30:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Conor Dooley <conor@kernel.org>
Cc:     Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        pali@kernel.org, mrkiko.rs@gmail.com,
        chris.packham@alliedtelesis.co.nz, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cyuval@marvell.com
Subject: Re: [PATCH v5 2/3] dt-bindings: arm64: add Marvell COM Express boards
Message-ID: <1d19b6da-2d16-41d1-8c04-587890dcda52@lunn.ch>
References: <20231119102638.1041978-1-enachman@marvell.com>
 <20231119102638.1041978-3-enachman@marvell.com>
 <20231119-avatar-implicate-75cd2f12dff5@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119-avatar-implicate-75cd2f12dff5@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +      - description:
> > +            Alleycat5X (98DX35xx) Reference Design as COM Express Carrier plus
> > +            Armada CN9131 COM Express CPU module
> > +        items:
> > +          - enum:
> > +              - marvell,ac5x-car-with-cn9131
> 
> Why not just marvell,cn9131-ac5x-carrier or similar? The "with" isn't
> particularly helpful.

As the description says, this is the combination of the SOM plus the
carrier to give a complete RDK.

Elad, do the RDK as a whole have a name? You can use that here for the
compatible.

	Andrew
