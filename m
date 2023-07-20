Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E3975B3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjGTQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGTQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:00:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49BCE;
        Thu, 20 Jul 2023 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=V11+xyj3JzOnQEprdsM1XI5W3c+hh54wJgw0Bk25suE=; b=QG63nbQFGlzHgtHwh3WrtbNx7F
        MUwBNdm4r22BBGbRq52zsyKJHPvd+oyrFmC4T6TcbhpTywuPxTC+ixkFjFGNuuKgL3VTPUMeUYHJr
        CO5O+Xm4fSlwQ+mEfwwfzHI1bUzv7RllQz+qjEPrzMuzUcHBYoZxhx+nYtmnJCmsJqx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qMW4d-001ozN-AV; Thu, 20 Jul 2023 18:00:15 +0200
Date:   Thu, 20 Jul 2023 18:00:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Samin Guo <samin.guo@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Message-ID: <0cd8b154-d255-4c16-b76d-9d3b036f3093@lunn.ch>
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
 <20230720111509.21843-2-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720111509.21843-2-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  motorcomm,rx-clk-drv-microamp:
> +    description: |
> +      drive strength of rx_clk rgmii pad.
> +      The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the LDO voltage can
> +      be configured with hardware pull-up resistors to match the SOC voltage
> +      (usually 1.8V).
> +      The software can read the registers to obtain the LDO voltage and configure
> +      the legal drive strength(curren).
> +      =====================================================
> +      | voltage |        curren Available (uA)            |

current has a t.

> +      =====================================================
> +      | voltage |        curren Available (uA)            |

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
