Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A079B3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356928AbjIKWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbjIKQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:46:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06100E4;
        Mon, 11 Sep 2023 09:46:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8753EC433C8;
        Mon, 11 Sep 2023 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694450791;
        bh=bXMZzVKRSbTQ/tVE5TIgh9LKsYdFg9X0N5cunHPB9j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrqRAapx6rfpDgr5AfSPR8MVEVwBkQnvoEqOhbj/VqqcDUUHpXzpCz59YYlSENlkg
         iKlMdjuQ6siqk7FSEfPNa4BF3WsSjYi7qAfv4ADi5fOlSHNvm9QQQHmFLQwHGcS5UJ
         qV0xoww4MfjFOp1xTtat3YZ9FsEJG5s+qu7gUbqGYhQGNvE2ZUxFVswowCpZB+/XJZ
         J3rG73eCRzjZ/ZH4ULRiTkPPGpy2seiTnLAQjUC1VS6yE3S47F5O81nkjIZiDr/icy
         1iZh+v1Kk9bZYbHlzKr05hmnughsJ7XcwcwrSBf8pjrWvRyqEM7qrAeZnRhDGRISmR
         +6G53cx1f4Dxw==
Received: (nullmailer pid 1357324 invoked by uid 1000);
        Mon, 11 Sep 2023 16:46:28 -0000
Date:   Mon, 11 Sep 2023 11:46:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <20230911164628.GA1295856-robh@kernel.org>
References: <20230911060200.2164771-1-danishanwar@ti.com>
 <20230911060200.2164771-2-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911060200.2164771-2-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:31:59AM +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
> be added to eth node of ICSSG, MII port to support half duplex operation at
> that port.
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 311c570165f9..bba17d4d5874 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -106,6 +106,13 @@ properties:
>                phandle to system controller node and register offset
>                to ICSSG control register for RGMII transmit delay
>  
> +          ti,half-duplex-capable:
> +            type: boolean
> +            description:
> +              Enable half duplex operation on ICSSG MII port. This requires

Still have capable vs. enable confusion. Please reword the description.

> +              PHY output pin (COL) to be routed to ICSSG GPIO pin
> +              (PRGx_PRU0/1_GPIO10) as input.
> +
>          required:
>            - reg
>      anyOf:
> -- 
> 2.34.1
> 
