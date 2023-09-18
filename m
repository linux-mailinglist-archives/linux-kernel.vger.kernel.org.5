Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51467A54E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjIRVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:12:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B248E;
        Mon, 18 Sep 2023 14:12:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AAEC433C8;
        Mon, 18 Sep 2023 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695071525;
        bh=m/n53GAvddAGYEj8KIWHPEfGhiEY0hHq/daTN/xqmFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lT6zdRyXLl3hGuDf4Nmys6NDjz2efBIL530DSrN/5R5/MRcQKduO3iwEIe/7x/+w2
         Z8CCwA50YfY9NmcTYlhnpktZTivUUex6T+i5eEfh0sP7g4927U7pMO84D07R5uQK5M
         vBIlzWxcu1TwjS/d4EVqTPKVPrLn4+69kUMEIoDy7RwpksLVaFf/wg9sZXzQ8NEJ79
         p1VOE/dv37lACSur8VEm86e4EzSZJsXMvfFNl5tCpidcZat1b2us9VdssDOB+m1zRj
         NLYItvKkINSQ6o1g6ynePQDp+4HuEpK3ybeCVliZ7KCbTkdDnCDOXVbkuvfwSJT7cG
         XDOt1yurB5n0A==
Received: (nullmailer pid 1768524 invoked by uid 1000);
        Mon, 18 Sep 2023 21:12:02 -0000
Date:   Mon, 18 Sep 2023 16:12:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: mtmips: document pins of groups
Message-ID: <20230918211202.GA1743810-robh@kernel.org>
References: <20230917162837.277405-1-arinc.unal@arinc9.com>
 <20230917162837.277405-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917162837.277405-2-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 07:28:37PM +0300, Arınç ÜNAL wrote:
> Document the pins of each group on the MediaTek MTMIPS SoC pin controllers.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 22 ++++++++++++-
>  .../pinctrl/mediatek,mt7621-pinctrl.yaml      | 18 +++++++++-
>  .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 33 ++++++++++++++++++-
>  .../pinctrl/ralink,rt2880-pinctrl.yaml        | 17 +++++++++-
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        | 16 ++++++++-
>  .../pinctrl/ralink,rt3352-pinctrl.yaml        | 17 +++++++++-
>  .../pinctrl/ralink,rt3883-pinctrl.yaml        | 16 ++++++++-
>  .../pinctrl/ralink,rt5350-pinctrl.yaml        | 13 +++++++-
>  8 files changed, 144 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> index 221adcef6e14..eb9d9d2bd90f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> @@ -44,8 +44,28 @@ patternProperties:
>                     wdt refclk, wdt rst, wled]
>  
>            groups:
> -            description:
> +            description: |
>                An array of strings. Each string contains the name of a group.
> +
> +              group             pins
> +              ------------------------------------------------------------------
> +              "i2c"             1, 2
> +              "spi"             3, 4, 5, 6
> +              "uartf"           7, 8, 9, 10, 11, 12, 13, 14
> +              "uartlite"        15, 16
> +              "wdt"             17
> +              "pa"              18, 19, 20, 21
> +              "mdio"            22, 23
> +              "rgmii1"          24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35
> +              "pcie"            36
> +              "spi refclk"      37, 38, 39
> +              "ephy"            40, 41, 42, 43, 44
> +              "nd_sd"           45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56,
> +                                57, 58, 59
> +
> +              "rgmii2"          60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71
> +              "wled"            72

This list of strings should be an enum like 'function' above.

> +
>              maxItems: 1

This is wrong if more than 1 string is allowed...

Same goes for the rest of the changes.

Rob
