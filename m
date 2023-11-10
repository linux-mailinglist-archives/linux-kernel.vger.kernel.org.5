Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA07E84A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbjKJUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbjKJUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:45:56 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C4D64;
        Fri, 10 Nov 2023 12:45:53 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1YNy-0008Ty-3B;
        Fri, 10 Nov 2023 20:45:51 +0000
Date:   Fri, 10 Nov 2023 20:45:48 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
Message-ID: <ZU6WfOUF7owz7ZLN@makrotopia.org>
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org>
 <fc52c1df-e414-49a9-a3a7-7a4ce45c403e@linaro.org>
 <49cd75fd-962f-417c-9196-3c9edd42e4d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cd75fd-962f-417c-9196-3c9edd42e4d5@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 09:00:26PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 16:20, Krzysztof Kozlowski wrote:
> > On 10/11/2023 09:09, Krzysztof Kozlowski wrote:
> >> On 10/11/2023 01:30, Daniel Golle wrote:
> >>> Add binding description for mediatek,mt7988-wdt.
> >>>
> >>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >>> ---
> >>
> >> ...
> >>
> >>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> >>> new file mode 100644
> >>> index 0000000000000..fa7c937505e08
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> >>> @@ -0,0 +1,12 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>> +
> >>> +/* TOPRGU resets */
> >>> +#define MT7988_TOPRGU_SGMII0_GRST		1
> >>> +#define MT7988_TOPRGU_SGMII1_GRST		2
> >>> +#define MT7988_TOPRGU_XFI0_GRST			12
> >>> +#define MT7988_TOPRGU_XFI1_GRST			13
> >>> +#define MT7988_TOPRGU_XFI_PEXTP0_GRST		14
> >>> +#define MT7988_TOPRGU_XFI_PEXTP1_GRST		15
> >>> +#define MT7988_TOPRGU_XFI_PLL_GRST		16
> >>
> >> IDs should start from 0 or 1 and increment by 1. If these are not IDs,
> >> then you do not need them in the bindings.
> >>
> >> Where is the driver change using these IDs?

It isn't needed as the driver doesn't list the IDs. If that would
be true, it would be sufficient to put them into a header next to the
driver or defined inside the driver C file.

The defined IDs here are intended to be used in device tree files.

> > 
> > You nicely skipped my email and keep pushing the idea of putting this
> > into separate patch.
> > 
> > No. Respond to received comments.
> > 
> >>
> >>> +
> >>> +#define MT7988_TOPRGU_SW_RST_NUM		24
> >>
> >> Why 24? I see 7. 

Because the wdt on MT7988 has a total of 24 resets. Most of them are
(currently, as there are no GPL drops, no publicly available devices,
...) undocumented and are not used in Linux **at this point**. Having
to change the driver every time a new reset is discovered or needed to
be used is tideous, so I thought the best would be -- as we know the
total number of resets -- to already define that, as it's safe to do
and won't need to change.

> >> Why having it in the bindings in the first place.

This line can indeed go into the driver, it's not used anywhere else.
I was merely immitating the style of all the existing binding headers
for similar SoCs and didn't want to stick-out style-wise, also in terms
of the added code to the driver which relies on that number being
defined in the header for all other SoCs.

> >>
> >> It's quite likely I asked the same question about other bindings for
> >> Mediatek. I will be asking every time till this is fixed.
> > 
> > No response to this, either.
> 
> You still did not respond here. To none of the points here. It's my
> third ping because I want this to be resolved. But ignoring my emails,
> and skipping paragraphs of my replies will not lead anywhere.

I have answered to this before:
The driver does NOT have any internal list of names of individual
resets, it relies on the reset number from device tree matching the bit
in the controller, just like for any other MediaTek toprgu already
supported by mtk-wdt.c.
