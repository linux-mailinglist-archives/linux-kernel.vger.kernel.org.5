Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A77EC568
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjKOOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:36:11 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F0189;
        Wed, 15 Nov 2023 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=lcLWf7D+wf01gcNMKgiSbyjZczgsXRY/v9yIaHKLvho=; b=WdWXj6oUBxealGRHVCiBGSXmeZ
        1Gy1aHJsLiGG6NrXFreRrLkGb9MDiz1rDdSsEpT/pnvS6Kzy86FkWW8trRZaQ1TQl4vCUO9JM1RPF
        /VXzee4g/WPjDT8hqEpaLIv0B+Jl0eGJV0kOrewGn8WR0bTaXS4WMBR0FcushjcPtXiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3Gzi-000FRQ-5l; Wed, 15 Nov 2023 15:35:54 +0100
Date:   Wed, 15 Nov 2023 15:35:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 9/9] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <bff45329-ee11-4507-b853-0a2f2cbbe742@lunn.ch>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-10-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115032515.4249-10-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  phy-reset-gpio:
> +    minItems: 1
> +    maxItems: 3
> +    description:
> +      GPIO used to reset the PHY, each GPIO is for resetting the connected
> +      ethernet PHY device.

This is a PHY property, so should be in the PHY node. phylib should
then take care of fit.

> +
> +  phyaddr-fixup:
> +    description: Register address for programing MDIO address of PHY devices

Please give a better description of this and the next two properties.

> +
> +  pcsaddr-fixup:
> +    description: Register address for programing MDIO address of PCS devices
> +
> +  mdio-clk-fixup:
> +    description: The initialization clocks to be configured
> +
> +  fixup:
> +    description: The MDIO address of PHY/PCS device to be programed
> +        clocks:
> +          items:
> +            - description: MDIO clock source frequency fixed to 100MHZ
> +            - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
> +            - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
> +            - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
> +            - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ

The clock frequencies is not relevent here, the driver sets that up.

    Andrew
