Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C879DE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbjIMCRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMCRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:17:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F584170A;
        Tue, 12 Sep 2023 19:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=+YFoAOG8GFMEn6GoFZD7onXG3aT2RSiOvfB1zEXG+i0=; b=fCKR71FJGDOOOwicFE6wHPjzqQ
        nnfLUmVeWl1FPSUSQjLL8UQg/hIMNOMFoc7bKb5IdjeQBtltBacujlGbyCkRx1ULj96/xjnDd+5OR
        WQkiK7FCvkKQqm89kU3muC7gPfqURpzwY+9kXrKgrFE1+ftkIpixXvJTPhBFU9BdhQ2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgFR0-006GyV-0O; Wed, 13 Sep 2023 04:16:54 +0200
Date:   Wed, 13 Sep 2023 04:16:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct oa_tc6 {
> +	struct spi_device *spi;
> +	bool ctrl_prot;
> +};

Should this be considered an opaque structure which the MAC driver
should not access the members?

I don't see anything setting ctrl_prot here. Does it need a setter and
a getter?

	Andrew
