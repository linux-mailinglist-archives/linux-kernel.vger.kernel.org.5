Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFCB7D3E73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjJWSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:02:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40145A1;
        Mon, 23 Oct 2023 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MQawxn832yz1X6QjBTcyMN3/+LzdSzv7N+CX88b/x6o=; b=WN2vBimorueRpS/2O4+IyWMAm+
        DSpv6k8QxUL7fURmYnu+eUDWVVO/bHVMFqnyOin8LKMRlCz3QR84p8oj9mJWdnkON6RPvH6+tMEOh
        IQhOHCpzT/dOmMCnPuWluK60/KmfdiuanWCXVrCR+v7BM+zGtQpbzyrT+7IoorpmBnYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1quzFU-0033ZG-BQ; Mon, 23 Oct 2023 20:01:56 +0200
Date:   Mon, 23 Oct 2023 20:01:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: ipqess: add a PSGMII calibration
 procedure to the IPQESS driver
Message-ID: <df71bbe5-fec0-45cc-adb4-acfbcc356ba3@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-5-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023155013.512999-5-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:50:11PM +0200, Romain Gantois wrote:
> The IPQ4019 Ethernet Switch Subsystem uses a PSGMII link to communicate
> with a QCA8075 5-port PHY. This 1G link requires calibration before it can
> be used reliably.
> 
> This commit introduces a calibration procedure followed by thourough
> testing of the link between each switch port and its corresponding PHY
> port.

Could you explain the architecture in a bit more detail.

When i see MAC code messing with a PHY, i normally say move it into
the PHY driver. But its not clear to me if you are talking about the
real PHYs here, or this is the switch end of the link, and it has some
sort of a PHY to talk to the quint PHY?

     Andrew
