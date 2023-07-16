Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B2754F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGPPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGPPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB890;
        Sun, 16 Jul 2023 08:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF5160BEC;
        Sun, 16 Jul 2023 15:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6527C433C8;
        Sun, 16 Jul 2023 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689520789;
        bh=xUYM4Nhp9KPij8FlcmEB4gdWJ4rwhwoNmU5S+LEUqic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KXRnKRraGnfpqDaKDrzqbLcrSxfU1i+vW9xDqToECaMFPE4b8YnDuTqkhFSuAW0U2
         GohufeHg2f7G1lPgRPChqU4wfPab88i/uij8la4fAbkQEKBBrtUNwqDDl+3zLjjBVD
         J8d9dBQkYjA0t1Oe1AYRrgtdDQxiL3HFXUk1uMqOcyyJIk8+G3cqvW7DvVS4r4QpaP
         59WBXp8+FPjpna1fHg8y2jwd1LmJA0Zg22+uU4uOV08YWoLKXqhWTh4+46qPhjLtjc
         J2FvWwti9nk19IB/wHJQGxabODriMmS6JoU9oPWJAq7MG5Mf6EXfo7RABLt0zKQhIG
         ZxOWVGP6zyU/g==
Date:   Sun, 16 Jul 2023 16:19:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230716161941.6ab3ecae@jic23-huawei>
In-Reply-To: <20230715-violate-suburb-ba9ae0a46674@spud>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
        <20230714150051.637952-2-marius.cristea@microchip.com>
        <20230715-violate-suburb-ba9ae0a46674@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 11:28:03 +0100
Conor Dooley <conor@kernel.org> wrote:

> Hey,
> 
> On Fri, Jul 14, 2023 at 06:00:50PM +0300, marius.cristea@microchip.com wrote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> > 
> > This is the device tree schema for iio driver for
> > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > Delta-Sigma ADCs with an SPI interface (Microchip's
> > MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> > MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> > MCP3562R and MCP3564R analog to digital converters).
> > 
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>  
> 
> This looks good to me, other than the custom property, for which I can't
> tell if a consensus was reached on last time around.
> 
> > +  microchip,hw-device-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 3
> > +    description:
> > +      The address is set on a per-device basis by fuses in the factory,
> > +      configured on request. If not requested, the fuses are set for 0x1.
> > +      The device address is part of the device markings to avoid
> > +      potential confusion. This address is coded on two bits, so four possible
> > +      addresses are available when multiple devices are present on the same
> > +      SPI bus with only one Chip Select line for all devices.
> > +      Each device communication starts by a CS falling edge, followed by the
> > +      clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> > +      which is first one on the wire).  
> 
> On the last version, the last comment I could find on lore was
> https://lore.kernel.org/all/20230609184149.00002766@Huawei.com/
> where Jonathan and Rob were discussing whether or not a spi-mux type of
> thing could work, but it does not seem to have ended conclusively.
> 
> Rob or Jonathan, would you mind commenting on that?

Sure - as far as I'm concerned - it looks like it should be possible to do something
generic, but without a prototype it's hard to be sure how fiddly that will be.

+CC Mark Brown who might be able to give a more informed answer to whether such a
thing would work / be easy to implement.

I've no idea how common this trick is.  If it's a one off, may not be worth the bother
of a more generic mux like binding whether that is the more elegant solution or
not.

> 
> There was also a comment from Jonathan:
> > > +  vref-supply:
> > > +    description:
> > > +      Some devices have a specific reference voltage supplied on a different
> > > +      pin to the other supplies. Needed to be able to establish channel scaling
> > > +      unless there is also an internal reference available (e.g. mcp3564r)
> > > +  
> > 
> > From a quick glance at a random datasheet, looks like there additional power supplies
> > that should be required.
> > 
> > If this is required for some devices, I'd expect to see the binding enforce
> > that with some required entries conditioned on the compatibles rather than as
> > documentation. If there are devices where it isn't even optional then the binding
> > should enforce that as well.  
> 
> The binding does now enforce the vref supply where relevant, but it
> sounds like you were looking more supplies to be documented Jonathan?
> (AVdd, DVdd etc)

Exactly.

> 
> Thanks,
> Conor.

