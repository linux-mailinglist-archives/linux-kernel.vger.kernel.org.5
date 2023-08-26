Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1557893A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHZDaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjHZD3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:29:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD772136;
        Fri, 25 Aug 2023 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=b5Np+jm/RQoPR9ubBpxyVk6ru2zF/AGaNUyjyP7PSxw=; b=j73P8FthWKjeNVcIAYLeljBRTa
        plpVZslDFdt7Rr8NbTo3HuAMvo51Vc5ddMyuaAe3klsKpKn/lMu5TcUAZ6kQiY6+5n8R4Bin0jqdq
        y/KA/o6a+iAwzYz96PMwDk6f7jA9DedlsIDKYh2JZbssJX41kJnWx8KHmCPzHHlx45x0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qZjzR-0058rJ-Vo; Sat, 26 Aug 2023 05:29:33 +0200
Date:   Sat, 26 Aug 2023 05:29:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: bcm2711: Describe Ethernet LEDs
Message-ID: <b493bce5-a8a3-4dc1-b480-537243f2785d@lunn.ch>
References: <20230821192714.3104006-1-florian.fainelli@broadcom.com>
 <70dbbc50-0672-4e0a-9d3d-f04f6ca94edc@lunn.ch>
 <91d52461-1e76-dc79-2575-f6f6848f2697@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d52461-1e76-dc79-2575-f6f6848f2697@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So in this case, the amber LED indicates the link activity, and the green
> LED indicates the link status. AFAICT we still do not have function names
> defined for those, the closest I can think is to do:
> 
> function = LED_FUNCTION_ACTIVITY for the amber LED
> 
> and for the green LED:
> 
> function = (LED_FUNCTION_RX | LED_FUNCTION_TX)
> 
> is that acceptable?

I have a WIP DT binding for exact meaning of the LED.

https://github.com/lunn/linux v6.5-rc4-net-next-led-bindings

It is too late for this merge window, so i will likely post it as an
RFC in a weeks time.

We probably need a discussion, LED_FUNCTION_LAN gives the high level
description, and contributes to the naming, and then this binding
gives the specific meaning of the LED? Or do we want to define
LED_FUNCTION_* for details?

	Andrew
