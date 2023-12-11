Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083080C567
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjLKJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjLKJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:59:51 -0500
X-Greylist: delayed 173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 01:59:57 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC952B8;
        Mon, 11 Dec 2023 01:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702288796;
        bh=UGHfDCSkfnLHonKPO4l5G0OCvPlVDDc5beUYsxuWpdw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=gucwGgz7TgqspKXw8/jw6fsDjuyW7bOQ2FbacFsTr24NEuGIhLC2oyg1+u/oVYdWA
         L+2ddLjGETBvw7qJvkiCdEaa5Ciml6W+oRx7aA8Kx7ffI5VHdk+/NO6fOfGYykZ5/m
         m+7/qv4X8rnLnK2/H2TUHmJbyfj0wrwM5yeOlLiiFNAS1im8eM/xk6yGpqQI82inRH
         5RkenM45KKpl/q+dVmrQ8dUIjw1vCR4J8WTY851adHRHZ9Jq/0N6RlAAnUfRBt4OD1
         LkrnPSrpyRUNpU34mru/XQwfcAWK/KoqIsB+kkZbbyxP2op1fDDr2X1WTo4YkzjPmI
         aR6ZWFl96AAhw==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id B076C378140E;
        Mon, 11 Dec 2023 09:59:54 +0000 (UTC)
Message-ID: <874b8a8b-7fe1-4547-828e-948ed25b7be3@collabora.com>
Date:   Mon, 11 Dec 2023 10:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: clock: mediatek: add clock
 controllers of MT7988
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
 <93025cdb7c31bf413fb2be5a071340073a0679d1.1702158423.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <93025cdb7c31bf413fb2be5a071340073a0679d1.1702158423.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/23 22:55, Daniel Golle ha scritto:
> Add various clock controllers found in the MT7988 SoC to existing
> bindings (if applicable) and add files for the new ethwarp, mcusys
> and xfi-pll clock controllers not previously present in any SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4:
>   * add subnodes for controllers acting as MFD
> 
> v3:
>   * move clock bindings to clock folder
>   * drop ti,syscon-reset from bindings and example
>   * merge mcusys with topckgen bindings
> 
> v2:
>   * dropped unused labels
>   * add 'type: object' declaration for reset-controller found in new
>     ethwarp controller and represented as ti,syscon-reset
>   * rebase on top of
>     "dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema"
> 
>   .../arm/mediatek/mediatek,infracfg.yaml       |  1 +
>   .../bindings/clock/mediatek,apmixedsys.yaml   |  1 +
>   .../bindings/clock/mediatek,ethsys.yaml       |  1 +
>   .../clock/mediatek,mt7988-ethwarp.yaml        | 66 +++++++++++++++++++
>   .../clock/mediatek,mt7988-xfi-pll.yaml        | 48 ++++++++++++++
>   .../bindings/clock/mediatek,topckgen.yaml     |  2 +
>   .../bindings/net/pcs/mediatek,sgmiisys.yaml   | 61 ++++++++++++++---
>   7 files changed, 171 insertions(+), 9 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
> 

..snip..

> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
> new file mode 100644
> index 0000000000000..e126f3fe0856c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt7988-ethwarp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7988 ethwarp Controller
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description:
> +  The Mediatek MT7988 ethwarp controller provides clocks and resets for the
> +  Ethernet related subsystems found the MT7988 SoC.
> +  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt7988-ethwarp
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reset-controller:
> +    type: object
> +    properties:
> +      compatible:
> +        const: ti,syscon-reset
> +
> +    # TODO: Convert to DT schema
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/ti-syscon.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@15031000 {
> +            compatible = "mediatek,mt7988-ethwarp", "syscon", "simple-mfd";
> +            reg = <0 0x15031000 0 0x1000>;
> +            #clock-cells = <1>;
> +
> +            reset-controller {
> +                compatible = "ti,syscon-reset";

NACK! This is not the right way to do it. Please do *not* use ti,syscon-reset.

Declare your resets in the relevant clock controller driver, like was done with
all (or the vast majority of) the other MediaTek clock drivers.

This means that you don't need simple-mfd here (and probably syscon as well).

Regards,
Angelo


