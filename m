Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA280264B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjLCSiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:38:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029ADA;
        Sun,  3 Dec 2023 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=HLV8YOVDigNgWOz0plPakVj5s9mqkHpb2at7e7OE9i8=; b=maVOiZenfrED7JgoNTkfQoYl6E
        xnjzKhI7F2GN6XDMO1Dy2rjMf3sVIlFb1qsKR6FYxdxRR46ZRliG+7ekpTyC40QnvmRBMUT7Ze6Md
        aFoKgrKfZGMWlHEHSndFe/iVqCgjt1O4OpTznUqPS0iA7cYAt0plIPyUSxW1MEjsAtb0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9rLw-001uPa-IS; Sun, 03 Dec 2023 19:38:04 +0100
Date:   Sun, 3 Dec 2023 19:38:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kory Maincent <kory.maincent@bootlin.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 3/8] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <69292ed5-63d3-4316-9bab-630bd00ce807@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * enum - Types of PSE controller.
> + *
> + * @PSE_UNKNOWN: Type of PSE controller is unknown
> + * @PSE_PODL: PSE controller which support PoDL
> + * @PSE_C33: PSE controller which support Clause 33 (PoE)
> + */
> +enum {
> +	PSE_UNKNOWN = BIT(0),
> +	PSE_PODL = BIT(1),
> +	PSE_C33 = BIT(2),
> +};

Maybe this should be in the netlink API?

I think you can imply it by looking at what properties are in the
netlink reply, but having it explicitly is probably better.
ethtool(1) can default to PSE_PODL if the property is missing for an
older kernel.

      Andrew
