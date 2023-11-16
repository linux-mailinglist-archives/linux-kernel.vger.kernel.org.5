Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FE7EE80D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjKPUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKPUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:03:20 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FEE1A5;
        Thu, 16 Nov 2023 12:03:15 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r3ia0-0005T4-Vl; Thu, 16 Nov 2023 21:03:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Date:   Thu, 16 Nov 2023 21:03:12 +0100
Message-ID: <3266223.44csPzL39Z@phil>
In-Reply-To: <a338048d-bdee-4be5-bd47-c744b301913a@linaro.org>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <5727404.DvuYhMxLoT@phil> <a338048d-bdee-4be5-bd47-c744b301913a@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. November 2023, 20:51:24 CET schrieb Krzysztof Kozlowski:
> On 16/11/2023 20:26, Heiko Stuebner wrote:
> > Hi Krzysztof,
> > Am Donnerstag, 16. November 2023, 19:12:18 CET schrieb Krzysztof Kozlowski:
> >> Document preferred coding style for Devicetree sources (DTS and DTSI),
> >> to bring consistency among all (sub)architectures and ease in reviews.
> >>
> >> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Bjorn Andersson <andersson@kernel.org>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Heiko Stuebner <heiko@sntech.de>
> >> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >> Cc: Michal Simek <michal.simek@amd.com>
> >> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> >> Cc: Nishanth Menon <nm@ti.com>
> >> Cc: Olof Johansson <olof@lixom.net>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> > 
> >> +Order of Properties in Device Node
> >> +----------------------------------
> >> +
> >> +Following order of properties in device nodes is preferred:
> >> +
> >> +1. compatible
> >> +2. reg
> >> +3. ranges
> >> +4. All properties with values
> >> +5. Boolean properties
> > 
> > I guess the only thing I do have questions about is the part
> > 
> >> +4. All properties with values
> >> +5. Boolean properties
> > 
> > Is there a rationale for it? Because with it things like regulator-*
> > properties then end up in two different blocks.
> 
> Good point. It is only a matter of style that this:
> 
> foo {
> 	compatible = "foo";
> 	reg = <0x1>;
> 	clocks = <&clk>;
> 	wakeup-source;
> 	key-autorepeat;
> }
> 
> looks better to me than:
> 
> 
> foo {
> 	compatible = "foo";
> 	reg = <0x1>;
> 	key-autorepeat;
> 	wakeup-source;
> 	clocks = <&clk>;
> }
> 
> But you have good point that similar properties should be usually
> grouped together.
> 
> About which regulator properties are you thinking now? You mean the
> supplies or the provider?

I was thinking about the provider. There are 
	regulator-min-microvolt = <>;
and friends, but also
	regulator-boot-on;


I guess I would just go with

1. compatible
2. reg
3. ranges
4. All other properties
5. status (if applicable)
6. Child nodes

aka grouping the old 4+5 together. The difference is probably minimal
but doesn't create corner cases and you don't need to know if a property
has a value or is boolean when looking for it.


Heiko


