Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F347A763D36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGZRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C010EC;
        Wed, 26 Jul 2023 10:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD1D61BF3;
        Wed, 26 Jul 2023 17:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C5C433C8;
        Wed, 26 Jul 2023 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690391139;
        bh=1T+xS9yXDltmwI7i44gQg/MaNV4L9JrE8kjtjqY+lhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPdAkVzqpd4c6bpl0eY79hMpcvW13A9RkqhO2Ims2UIQioPwOiEP3xTDm674VskRR
         lPVabjecOi0tz3+sETm9gJJjshM4cERN96QeQlzFy0qbqYolR5NwSWiBklOWdKeBXF
         MnPtGu3RPjrkbTY9bIPnSwnJ0Y+yNp0P3KqWlsGm8B4smkMsPSFpacNv4bf2xYQQlI
         +sRIq1V9t8srj0E6FqHP3PMJmsP4MNgFXKXoWvPJb14PMakSt8SW6apgQJu3L05DyP
         iLotFZ8y3C7Wj5SWhykIejcX+1N3cPnmnwsZGNUaQuyXMQcde36hhaq+xkn38ip0R9
         GxZdHitdPL8lg==
Received: (nullmailer pid 1591499 invoked by uid 1000);
        Wed, 26 Jul 2023 17:05:37 -0000
Date:   Wed, 26 Jul 2023 11:05:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, rogerq@kernel.org,
        s-vadapalli@ti.com
Subject: Re: [PATCH 1/5] dt-bindings: phy: cadence-torrent: Add second
 optional input reference clock
Message-ID: <20230726170537.GA1587239-robh@kernel.org>
References: <20230724150002.5645-1-sjakhade@cadence.com>
 <20230724150002.5645-2-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724150002.5645-2-sjakhade@cadence.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:59:58PM +0200, Swapnil Jakhade wrote:
> Torrent(SD0801) PHY supports two input reference clocks. Update bindings
> to support dual reference clock multilink configurations.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 23 +++++++++++++------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index dfb31314face..ddb86ee0cebf 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -33,16 +33,25 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
>      description:
> -      PHY reference clock for 1 item. Must contain an entry in clock-names.
> -      Optional Parent to enable output reference clock.
> +      PHY input reference clocks (refclk & refclk1).
> +      Optional Parent to enable output reference clock (phy_en_refclk).
>  
>    clock-names:
> -    minItems: 1
> -    items:
> -      - const: refclk
> -      - const: phy_en_refclk
> +    oneOf:
> +      - items:
> +          - const: refclk
> +      - items:
> +          - const: refclk
> +          - const: phy_en_refclk
> +      - items:
> +          - const: refclk
> +          - const: refclk1
> +      - items:
> +          - const: refclk
> +          - const: refclk1
> +          - const: phy_en_refclk

Can be simplified to:

minItems: 1
items:
  - const: refclk
  - enum: [ refclk1, phy_en_refclk ]
  - const: phy_en_refclk

*-names already requires each entry to be unique, so you don't have to 
worry about that case.

Rob
