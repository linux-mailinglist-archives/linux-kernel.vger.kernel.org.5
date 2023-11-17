Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3957B7EF81F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKQUEM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 15:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:04:11 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF6D6A;
        Fri, 17 Nov 2023 12:04:05 -0800 (PST)
Received: from i5e861935.versanet.de ([94.134.25.53] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r454N-0000e0-3u; Fri, 17 Nov 2023 21:04:03 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Date:   Fri, 17 Nov 2023 21:04:01 +0100
Message-ID: <4071780.8hb0ThOEGa@diego>
In-Reply-To: <50eadab2-0f0a-480c-a77c-ca731c5d75cf@ti.com>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <4289147.1BCLMh4Saa@diego> <50eadab2-0f0a-480c-a77c-ca731c5d75cf@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 17. November 2023, 20:54:05 CET schrieb Andrew Davis:
> On 11/17/23 1:38 PM, Heiko Stübner wrote:
> > Am Freitag, 17. November 2023, 15:03:38 CET schrieb Andrew Davis:
> >> On 11/16/23 2:33 PM, Heiko Stuebner wrote:
> >>> Am Donnerstag, 16. November 2023, 21:23:20 CET schrieb Krzysztof Kozlowski:
> >>>> On 16/11/2023 21:03, Heiko Stuebner wrote:
> >>> going with the vcc5v0_host regulator of the rk3588-quartzpro64 and
> >>>
> >>> +1. compatible
> >>> +2. reg
> >>> +3. ranges
> >>> +4. All properties with values
> >>> +5. Boolean properties
> >>> +6. status (if applicable)
> >>> +7. Child nodes
> >>>
> >>> we'd end up with
> >>>
> >>>           vcc5v0_host: vcc5v0-host-regulator {
> >>> /* 1. */        compatible = "regulator-fixed";
> >>> /* 4. */        gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> >>>                   pinctrl-names = "default";
> >>>                   pinctrl-0 = <&vcc5v0_host_en>;
> >>>                   regulator-min-microvolt = <5000000>;
> >>>                   regulator-max-microvolt = <5000000>;
> >>>                   regulator-name = "vcc5v0_host";
> >>>                   vin-supply = <&vcc5v0_usb>;
> >>> /* 5. */        enable-active-high;
> >>>                   regulator-always-on;
> >>>                   regulator-boot-on;
> >>>           };
> >>>
> >>
> >> How about grouping like properties (defined in the same schema),
> >> then sorting within that group. Would also allow for defining
> >> where to add spacing.
> >>
> >> 1. compatible
> >> 2. reg
> >> 3. ranges
> >> 4. All property groups
> >>     4.1 Properties with values
> >>     4.2 Boolean properties
> >>     4.3 Separating space
> >> 6. status (if applicable)
> >> 7. Child nodes
> >>
> >> Your node then would look like we expect:
> >>
> >> vcc5v0_host: vcc5v0-host-regulator {
> >> /* 1   */   compatible = "regulator-fixed";
> >>
> >> /* 4.1 */   pinctrl-names = "default";
> >> /* 4.1 */   pinctrl-0 = <&vcc5v0_host_en>;
> >> /* 4.3 */
> >> /* 4.1 */   regulator-min-microvolt = <5000000>;
> >> /* 4.1 */   regulator-max-microvolt = <5000000>;
> >> /* 4.1 */   regulator-name = "vcc5v0_host";
> >> /* 4.2 */   regulator-always-on;
> >> /* 4.2 */   regulator-boot-on;
> >> /* 4.2 */   enable-active-high;
> >> /* 4.3 */
> >> /* 4.1 */   gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> >> ...
> >> };
> > 
> > I'm really not sure about adding big sets of rules.
> > In the above example you'd also need to define which schema has a higher
> > priority? ;-)
> > 
> > 
> > When I started with Rockchip stuff, I also had some fancy way of sorting
> > elements in mind that was really intuitive to myself :-) .
> > Over time I realized that it was quite complex - especially when I had to
> > explain it to people.
> > 
> > There are definite advantages for having compatible + reg + status in
> > fixed positions, as it helps going over a whole dt to spot the huge
> > mistakes (accidentially disabled, wrong address), but for the rest a
> > simple alphabetical sorting is easiest to explain to people :-) .
> > 
> > And alphabetic elements are also easier on my eyes.
> > 
> 
> +1 for starting with compatible/reg/status that we would like to see
> in the same spot in each node.
> 
> Not so sure on plain alphabetical. That has the same issue you pointed out
> with splitting value vs boolean properties, related properties would end up
> not grouped. Some like regulator- with the same prefix will, but think -gpios
> that is a postfix, they would be scattered about.
> 
> How about just enforcing ordering on the couple common property we care about
> seeing and everything else left free-hand as it today?

Sounds like a very sensible idea :-) .

Especially as the sorting of individual properties is just a tiny part of
Krzysztof's document, and all the other parts in it are way more
important anyway.


Heiko


