Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35CB7542E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjGNSy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjGNSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:54:28 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BDA30FC;
        Fri, 14 Jul 2023 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=iJvvs9dOIGayOcerhrBaLhd0TaO38lkSU2S3p/bJwE8=; b=BJInmMfmI+72o4t0/qKzcQD2zi
        8VH4rFNHZmk5NRtlCUqYHzlzRFrQLrNhnYi0ym5fM28T+ItwzIDA34QcOw5cTgfdFoDrM4EaI9Is7
        G2ckWv6hyIO2QVmNEVCb7B11QeLghcNUOk4p7hCQLvzcvM+qb2gedx42ctNs41OGgiGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qKNvr-001Nlf-TA; Fri, 14 Jul 2023 20:54:23 +0200
Date:   Fri, 14 Jul 2023 20:54:23 +0200
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
Subject: Re: [PATCH v4 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Message-ID: <4efd8643-455e-4f7f-b031-a0a02dd65210@lunn.ch>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-2-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714101406.17686-2-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  motorcomm,rx-clk-driver-strength:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      drive strength of rx_clk rgmii pad.
> +      |----------------------------------|
> +      |        rx_clk ds map table       |
> +      |----------------------------------|
> +      | DS(3b) |  wol@1.8v  |  wol@3.3v  |
> +      |________|_________________________|
> +      |        | current(uA)| current(uA)|
> +      |   000  |     1200   |    3070    |
> +      |   001  |     2100   |    4080    |
> +      |   010  |     2700   |    4370    |
> +      |   011  |     2910   |    4680    |
> +      |   100  |     3110   |    5020    |
> +      |   101  |     3600   |    5450    |
> +      |   110  |     3970   |    5740    |
> +      |   111  |     4350   |    6140    |
> +      |--------|------------|------------|
> +    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
> +            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
> +    default: 2910

The DS(3b) value is not relevant to the binding. It is a driver
detail. So i would not bother listing it.

Please add a comment explaining what wol is. 

       Andrew
