Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E527DE688
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347177AbjKATrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbjKATrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:47:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954209F;
        Wed,  1 Nov 2023 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wYk75WWjhfRsVSIrzNnwPLbfZGcI7ZKnOifzPb2PiLY=; b=tvLD5QyPRht3WABrSXs9QsyqgP
        AbCUa6QUcXE+QcecXR0Ri9H5FmW4mJfpQqR85pOJ+v3J80KphGVmNeE2GwZIaE5vMmKyf2ncclPqx
        EIOnskEg7gE6oqw6PRMGXqHrQFKsvBRmVUzdPoaQ5KZZjL7v2hgka38ahFjbgtqmq/Og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyHAs-000hdr-5r; Wed, 01 Nov 2023 20:46:46 +0100
Date:   Wed, 1 Nov 2023 20:46:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
Message-ID: <6dca432f-2a25-4e34-b44e-7cca0b045566@lunn.ch>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
 <65427400.5d0a0220.41c58.0ded@mx.google.com>
 <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
 <65427fd4.df0a0220.28d26.1955@mx.google.com>
 <c9dad91a-1de1-4c30-ab7f-414552702009@lunn.ch>
 <65428629.050a0220.b2431.1edc@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65428629.050a0220.b2431.1edc@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do we have API to check this? Or I think I should just check the iram
> and dram size and see if iram_size % sizeof(u32) is zero and return
> error otherwise.

Yes, that sounds correct.

     Andrew
