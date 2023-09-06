Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8166793CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjIFMjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIFMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:39:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734B173F;
        Wed,  6 Sep 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Xb9J4LP3xZ2oCJfCq0aBcb0/gSpvzJwkl3eC5fo8Ixw=; b=wCTDDvJsjAgurjMV1TTkETRul3
        bt+Rb+7CCIOZv3qLD75tcy03T6a64UzqtcVwKUMlppDnJW+WF7hG6rWHYI3jBhGDexZ3pDOb/X6vO
        nO/sNhTrZ1s466RjBDwf+p6uY8L8TW6+zhfQsYKwz2qxmrdPmNMvhSgT/ILGi0Wc/hSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qdroE-005u0C-0Y; Wed, 06 Sep 2023 14:39:02 +0200
Date:   Wed, 6 Sep 2023 14:39:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
Message-ID: <8cf5b8d1-5f03-438a-94bb-5691dee8cc86@lunn.ch>
References: <20230906095143.99806-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906095143.99806-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:51:42AM -0500, Adam Ford wrote:
> Currently there is a device tree entry called "local-mac-address"
> which can be filled by the bootloader or manually set.This is
> useful when the user does not want to use the MAC address
> programmed into the SoC.
> 
> Currently, the davinci_emac reads the MAC from the DT, copies
> it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> it by reading from registers in the SoC, and falls back to a
> random MAC if it's still not valid.  This completely ignores any
> MAC address in the device tree.
> 
> In order to use the local-mac-address, check to see if the contents
> of priv->mac_addr are valid before falling back to reading from the
> SoC when the MAC address is not valid.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

There is the potential for regressions here, since behaviour is being
changed. But i do think what you are doing make sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
