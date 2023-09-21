Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FB7A9ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjIUUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjIUUMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:12:08 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C55100A41;
        Thu, 21 Sep 2023 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9qTM0K/yk5JdWUeLoP3oQpoZOY/3tRKxEVyXZngPDNQ=; b=CNkrTxxxCnxfM62tCw6pnjsbMW
        DA9LLSCZIGZkABwGThi4P6y7G6dE4/OnpWKo7rut/nS3TbWdMmIN22oDDsh+9CNRKoIuoLehCIPMZ
        TwDNnmnAKppB4qVcA6ZplqS1+JhjucYUMLDMJAUsmOCa9rQsA2FDofTxnxMvb+6ppMwU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjPAT-0077hs-Ck; Thu, 21 Sep 2023 21:16:53 +0200
Date:   Thu, 21 Sep 2023 21:16:53 +0200
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <42031ac6-7f3d-4bc9-8cfa-d7eb61ed10d5@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
 <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
 <2021acc6-bcf6-4dba-b7ce-ca1b3ca86088@lunn.ch>
 <94e4a08b-005d-adc0-5852-85568ba5db72@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e4a08b-005d-adc0-5852-85568ba5db72@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So drivers/net/ethernet/Kconfig file should contain the below,
> 
> config OA_TC6
>           tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support"
>           depends on SPI
>           select PHYLIB 
> 
>           help
>             This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
>             Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
> 
> The drivers/net/ethernet/Makefile file should contain the below,
> 
> obj-$(CONFIG_OA_TC6) += oa_tc6.o

That looks about right, but i'm not a kconfig expert.

I would expect drivers using this to then have a

	depends on OA_TC6

	Andrew
