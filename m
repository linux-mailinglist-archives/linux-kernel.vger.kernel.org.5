Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C877E81A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjKJSaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346091AbjKJS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:28:07 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B539CEB;
        Fri, 10 Nov 2023 06:51:13 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1Sqf-0006vh-2c;
        Fri, 10 Nov 2023 14:51:05 +0000
Date:   Fri, 10 Nov 2023 14:51:00 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
Message-ID: <ZU5DVNOmtyFwUTdC@makrotopia.org>
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <2678cb48-1d2b-47bc-9272-06d9aa140c58@collabora.com>
 <ZU47hV1i66WN8nZJ@makrotopia.org>
 <d7b72b3e-c8f4-4675-ae62-26f5ae576f0a@linaro.org>
 <ZU5A59KO8Y_Q97IG@makrotopia.org>
 <a56cfe76-ab03-4187-b6f1-04a5c3414e64@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56cfe76-ab03-4187-b6f1-04a5c3414e64@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 03:46:14PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 15:40, Daniel Golle wrote:
> > On Fri, Nov 10, 2023 at 03:20:53PM +0100, Krzysztof Kozlowski wrote:
> >> On 10/11/2023 15:17, Daniel Golle wrote:
> >>> On Fri, Nov 10, 2023 at 12:56:18PM +0100, AngeloGioacchino Del Regno wrote:
> >>>> Il 10/11/23 01:30, Daniel Golle ha scritto:
> >>>>> Add binding description for mediatek,mt7988-wdt.
> >>>>>
> >>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >>>>> ---
> >>>>>   .../bindings/watchdog/mediatek,mtk-wdt.yaml          |  1 +
> >>>>>   include/dt-bindings/reset/mediatek,mt7988-resets.h   | 12 ++++++++++++
> >>>>>   2 files changed, 13 insertions(+)
> >>>>>   create mode 100644 include/dt-bindings/reset/mediatek,mt7988-resets.h
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> >>>>> index cc502838bc398..8d2520241e37f 100644
> >>>>> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> >>>>> @@ -25,6 +25,7 @@ properties:
> >>>>>             - mediatek,mt6735-wdt
> >>>>>             - mediatek,mt6795-wdt
> >>>>>             - mediatek,mt7986-wdt
> >>>>> +          - mediatek,mt7988-wdt
> >>>>>             - mediatek,mt8183-wdt
> >>>>>             - mediatek,mt8186-wdt
> >>>>>             - mediatek,mt8188-wdt
> >>>>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> >>>>> new file mode 100644
> >>>>> index 0000000000000..fa7c937505e08
> >>>>> --- /dev/null
> >>>>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> >>>>> @@ -0,0 +1,12 @@
> >>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>>>> +
> >>>>> +/* TOPRGU resets */
> >>>>
> >>>> The first reset is zero, the second reset is one.
> >>>>
> >>>> Where's the zero'th reset? :-)
> >>>
> >>> Currently the reset numbers represent the corresponding bit positions in
> >>> the toprgu register, as this is how the mtk-wdt driver is organized.
> >>>
> >>> So there is probably something at bit 0, and also at bit 3~11 and
> >>> maybe also 17~23, but it's unknown and may be added later once known
> >>> and/or needed.
> >>
> >> There is no need to put register bits, which are not used by the driver,
> >> in the bindings.
> > 
> > There aren't. That's why there isn't a zero'th reset (and also not 3~11, 17~24).
> > 
> > Or should the driver be reorganized to provide a mapping of logical to
> > physical resets, and then have only the needed once present and start
> > counting logical resets from 0? This is doable, of course, but it's a
> > bit of effort just for the aesthetical goal of starting to count from
> > zero and continous in header file.
> > 
> > And, of course, chances are that other currently still unused bits
> > will be needed at a later point which then would mean having to add
> > them in at least 2 places (header file and mapping logical<->physical)
> > where as currently it would just mean adding a line defining it in the
> > header file.
> 
> You can do it, but it's not what I wrote here. So bear with me:
> 
> "There is no need to put register bits in the bindings."
> 
> You replied "There aren't", which I don't understand in this context. I
> can be clearer:
> Drop this hunk.

So adding the file to include/dt-bindings/reset/ should go into a
seperate patch? Because including it with the driver itself gave me
a checkpath warning telling me that dt-bindings should go seperate,
which is why I included it with the binding docs.

> 
> > 
> > A quick looks at all the other headers in
> > include/dt-binding/reset/mt*-resets.h also shows that currently all of
> > them have unused bits and e.g. infracfg on MT7986 starts counting from
> > 6.
> 
> Best regards,
> Krzysztof
> 
> 
