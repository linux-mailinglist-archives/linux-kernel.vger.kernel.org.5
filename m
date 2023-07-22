Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8875DC15
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGVLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGVLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:53:08 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D93AB8;
        Sat, 22 Jul 2023 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gpMai+RGZVHO11XO50XWI3/EZ38TmKbr58h9zhvA2Ng=; b=wLJ2lxgjKeS0A5E5folJrJ1QmX
        ENdR+hijE1xMd2fkD0roQAMmMydabk+nSI7LKbibanWBfivtAqYdo2MPw2uXJS7Xi1zL+bi3nQCvr
        SfZt/5QFdOl4ZT+uNXsALE4jOzaFpKUEcrtH3xBCKQJMn5RoLiGx4IWeF28Li2DxgUaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qNBA9-001vyL-VK; Sat, 22 Jul 2023 13:52:41 +0200
Date:   Sat, 22 Jul 2023 13:52:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tristram.Ha@microchip.com
Cc:     o.rempel@pengutronix.de, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
        Arun.Ramadoss@microchip.com, edumazet@google.com,
        f.fainelli@gmail.com, conor+dt@kernel.org, olteanv@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make
 switch MAC address configurable
Message-ID: <95007aa6-a09b-4a05-93cb-65db405a2549@lunn.ch>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-7-o.rempel@pengutronix.de>
 <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The DSA driver used to have an API to set the MAC address to the switch,
> but it was removed because nobody used it.

That is a long time ago, when Marvell was about the only supported
vendor. As far as i understood, it was used to set the MAC source
address used when sending pause frames. But since pause frames are
link local by definition, and the switches had a reasonable default,
it was removed.

    Andrew
