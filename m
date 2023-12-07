Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BF808ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjLGRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjLGRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:17:54 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669661716;
        Thu,  7 Dec 2023 09:18:00 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rBI0L-00045r-2T;
        Thu, 07 Dec 2023 17:17:42 +0000
Date:   Thu, 7 Dec 2023 17:17:38 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: mediatek: add clock
 controllers of MT7988
Message-ID: <ZXH-Mq_DlW5Oodwt@makrotopia.org>
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <def05aac79ddff872d3e56698b736cb445f14116.1701823757.git.daniel@makrotopia.org>
 <3e72bff6-9f4d-4cd4-845e-b065f1233ec6@collabora.com>
 <ZXBs9GOOOlZrMuSW@makrotopia.org>
 <64ee48fc-4f77-48cc-b235-c9fb2b10afc4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ee48fc-4f77-48cc-b235-c9fb2b10afc4@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:03:44PM +0100, Krzysztof Kozlowski wrote:
> On 06/12/2023 13:45, Daniel Golle wrote:
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - const: mediatek,mt7988-ethwarp
> >>> +      - const: syscon
> >>> +      - const: simple-mfd
> >>
> >> No, this is not a mfd, I say.
> >>
> >> Prove me wrong! :-)
> > 
> > https://github.com/dangowrt/linux/blob/mt7988-for-next/arch/arm64/boot/dts/mediatek/mt7988a.dtsi#L564
> > 
> > The 'simple-mfd' compatible is required to have the Linux
> > kernel probe drivers for sub-nodes -- several drivers will act on
> > the different aspects of the circuit exposed at this memory range.
> > From what I understand, this is the definition of a MFD.
> 
> We know what is MFD, so no need to teach us. We expect you to look at
> this. You do not have subnodes, so MFD is pointless. Showing DTSI means
> nothing except that you did not test your bindings.

Sorry, I simply wasn't aware that this is what I'm being asked for.
Is the device a MFD? - Yes it is.

In this case the child node would be a 'ti,syscon-reset' which doesn't
have YAML bindings. Should I include it as object without $ref or do I
need to convert ti,syscon-reset.txt to yaml first, and then reference
it as child node in the MFD?
