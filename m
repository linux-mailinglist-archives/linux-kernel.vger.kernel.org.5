Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00A97C95B6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjJNRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJNRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 13:25:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F5B7;
        Sat, 14 Oct 2023 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5ZME0K/dUDkM/nKqY8eSFCRWyXSzcZpmLHsxSY+6UqM=; b=ewd2lzFJ8Do+OaFuiRpDDEmqhh
        EIvgrbc4xgCxnGRXUwa15z+cuyUB74YI5mGgLR+UCuCmbQPmcrK51aCt8J2KLgzAIg2UgsqZAgPKz
        9sD1NfRI8ymEcZWhqZuCnyc+i3CO5SCYAmaPd8Y0OFKxXU5KD226opke1ZKogfyy3NxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qriNw-002C31-DI; Sat, 14 Oct 2023 19:25:08 +0200
Date:   Sat, 14 Oct 2023 19:25:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/7] net: dsa: microchip: use wakeup-source
 DT property to enable PME output
Message-ID: <bec13846-afbf-428a-979b-7369b369ecd4@lunn.ch>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-7-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013122405.3745475-7-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:24:04PM +0200, Oleksij Rempel wrote:
> KSZ switches with WoL support signals wake event over PME pin. If this
> pin is attached to some external PMIC or System Controller can't be
> described as GPIO, the only way to describe it in the devicetree is to
> use wakeup-source property. So, add support for this property and enable
> PME switch output if this property is present.

So i get the feeling these patches are in the wrong order. The binding
and this patch being first would answer my question about why the pin
would not be active. Or a better explanation in patch 0/X about the
whole series.

      Andrew
