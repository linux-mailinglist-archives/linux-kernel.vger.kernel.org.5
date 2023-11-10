Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D67E7F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjKJRyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjKJRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:25 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3C431E7;
        Fri, 10 Nov 2023 09:07:48 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1Uyl-0007Mv-3C;
        Fri, 10 Nov 2023 17:07:36 +0000
Date:   Fri, 10 Nov 2023 17:07:31 +0000
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
Message-ID: <ZU5jU-T0m5QW4ZeF@makrotopia.org>
References: <2678cb48-1d2b-47bc-9272-06d9aa140c58@collabora.com>
 <ZU47hV1i66WN8nZJ@makrotopia.org>
 <d7b72b3e-c8f4-4675-ae62-26f5ae576f0a@linaro.org>
 <ZU5A59KO8Y_Q97IG@makrotopia.org>
 <a56cfe76-ab03-4187-b6f1-04a5c3414e64@linaro.org>
 <ZU5DVNOmtyFwUTdC@makrotopia.org>
 <708046ae-a821-420c-959a-ab5cb712aa9e@linaro.org>
 <ZU5IcrjqQpwMopJC@makrotopia.org>
 <6576d4a6-31fa-4780-9a8a-5a1d1974836f@linaro.org>
 <bb0ed593-082b-4edd-9a1e-78cccf796677@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0ed593-082b-4edd-9a1e-78cccf796677@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 04:21:35PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 16:15, Krzysztof Kozlowski wrote:
> >>>> So adding the file to include/dt-bindings/reset/ should go into a
> >>>> seperate patch? Because including it with the driver itself gave me
> >>>> a checkpath warning telling me that dt-bindings should go seperate,
> >>>> which is why I included it with the binding docs.
> >>>
> >>> No, I said the hunk should be dropped. Removed.
> >>
> >> I guess we are somehow misunderstanding each other.
> >> Lets go with an example. I can put the header into a commit of its own,
> >> just like commit
> >> 5794dda109fc8 dt-bindings: reset: mt7986: Add reset-controller header file
> >> https://lore.kernel.org/r/20220105100456.7126-2-sam.shih@mediatek.com
> >>
> >> Would that be acceptable? And if not, why?
> > 
> > ...this question.

... which you didn't answer. Sorry, but it's not helpful to be polemic
or ironic in a code review involving non-native English speakers
trying to understand each others.

> > 
> > Again, whether this is separate patch - it is still hunk which I think
> > should be removed. I gave the reason "why" in this mail thread and in
> > multiple other discussions.
> 
> I gave you clear reasoning 7 hours ago:
> https://lore.kernel.org/all/59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org/
> to which you did not respond.

Because it doesn't match anything existing regarding MediaTek reset
drivers, and I was assuming there must be some kind of misunderstanding,
which is why I replied to your later email in the same thread.

My assumption that the problem was merely having documentation and
header combined in a single commit stems from the fact that a very
similar patch for MT7986[1] was Ack'ed by Rob Herring about a year and
a half ago; hence the rule you apply here may have always existed, but
apparently then hasn't been applied in the past.

Literally *all* existing dt-binding headers for MediaTek SoCs follow a
direct 1:1 mapping of reset bit in hardware and reset number in the
header files. The driver is simple, all it cares about is the maximum
number defined in the header (and I like that, because it makes it very
easy to add new SoCs). At this point the abstraction needed to
fulfill your request doesn't exist, not for any of the SoCs using
mtk_wdt.c. It can be implemented, surely, it's a problem computers can
solve. If that's what you (and current maintainers of that driver)
would want me to implement, please say so clearly and spell it out.

Also be clear about if all the other existing headers need to be
converted, mappings for all SoCs created in the driver, ... all before
support for MT7988 can go in?
Or should the existing headers for other MediaTek SoCs remain
untouched because they are already considered stable API or something?


Thank you for your patiente!


Daniel


[1]: https://lore.kernel.org/all/Yd4uplioThv8eJJE@robh.at.kernel.org/
