Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16D179DE39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjIMCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbjIMCTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:19:15 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD601717;
        Tue, 12 Sep 2023 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Ns6UnpiLdI2yDe5ElqFkyvCqmhJVj9T5E+dHT+rOskI=; b=KNpZUYN9eD1KrH4e5o1C5msqt2
        PKooCLoCoZRoBl8sbPDc7M0HGWjwDPyva6Gs/YBiw4id7IoRee7mmss6sFYKIIGZSBVGKsxe8K0EV
        GfD8TXWVKgu46iV+PthhYogYeOwZFi4ejdcJwComkGBs93V7kJ04dggruu6sRP0i6H1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgFT5-006Gzf-7w; Wed, 13 Sep 2023 04:19:03 +0200
Date:   Wed, 13 Sep 2023 04:19:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <489f7f63-a542-45cf-80ec-f8d3cb7aa686@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <28dce908-3a87-48c8-b181-d859697c0152@lunn.ch>
 <2db21ee1-17ba-b7ca-bcfb-110c0f66ef93@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db21ee1-17ba-b7ca-bcfb-110c0f66ef93@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. If I understand correctly, I have to use devm_request_threaded_irq() 
> instead of devm_request_irq() and let the thread handler registered with 
> the devm_request_threaded_irq() function to perform interrupt activity 
> directly?

Yes. I've not looked at all the patches yet, but if the work queue is
not used for anything else, you should be able to remove it, and let
the IRQ core handle all the threading for you.

    Andrew
