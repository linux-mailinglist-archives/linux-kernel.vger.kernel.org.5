Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B080113B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378341AbjLAQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLAQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:17:46 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908F1BDD;
        Fri,  1 Dec 2023 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MIlmoJpSr6Vcy4UC9StocEZWKTbyTCPOWvNn2xIAcU8=; b=ghfi8mtKvcjM95EjlN11GFmSKQ
        yMe7CJI0QjdMUayeTCJIoHoFq/M7WxtmhLQv58Gv1Wn/4g75F+ean2ydL3I0rjsyaRE7ISA0hu8xa
        M64kwhzqkjD3FsdpgvqEIqZ6AuROMB44ABCqDZr4h/IoYM/S/TKoIFvJkDWMmsOHwjZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r96Cm-001mF3-BS; Fri, 01 Dec 2023 17:17:28 +0100
Date:   Fri, 1 Dec 2023 17:17:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: move MMP boards to common marvell
 directory
Message-ID: <9c50d09e-98a0-416f-b779-9cf39d1a94b5@lunn.ch>
References: <20231201132306.60753-1-krzysztof.kozlowski@linaro.org>
 <1e25e2f4-e4b9-4219-a9c2-cb6230a62549@lunn.ch>
 <a44b7bb2-34ac-45ab-84c6-630d604f1bcf@linaro.org>
 <5d511e31-8ff5-4c23-a65e-8660833a9799@lunn.ch>
 <944c02f5-d0e6-4367-bb4d-b366054b3e4e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944c02f5-d0e6-4367-bb4d-b366054b3e4e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:38:36PM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2023 15:34, Andrew Lunn wrote:
> > On Fri, Dec 01, 2023 at 03:21:05PM +0100, Krzysztof Kozlowski wrote:
> >> On 01/12/2023 14:51, Andrew Lunn wrote:
> >>> On Fri, Dec 01, 2023 at 02:23:06PM +0100, Krzysztof Kozlowski wrote:
> >>>> Marvell board bindings are spread over arm/marvell/ and arm/mrvl/
> >>>> directories.  Move MMP board bindings from the latter to the former, to
> >>>> keep all of them together.
> >>>
> >>> Hi Krzysztof
> >>>
> >>> Did you test get_maintainers.pl? MMP has a different maintainer to
> >>> many of the other Marvell SoCs. We want emails going to the correct
> >>> Maintainers, and ideally not spamming the others.
> >>
> >> The old binding was not referenced in MAINTAINERS, at least I could not
> >> find it.
> >> My change does not affect status quo - orphaned files.
> >>
> >> OTOH, some entries like Orion list specific files. Others like Marvell
> >> list entire directory, which is their mistake in the first place.
> >>
> >> There is a mess in this approach, but the mess exists before my patch.
> > 
> > I think these moved files will now match:
> > 
> > ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
> > M:      Andrew Lunn <andrew@lunn.ch>
> > M:      Gregory Clement <gregory.clement@bootlin.com>
> > M:      Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > S:      Maintained
> > T:      git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
> > F:      Documentation/devicetree/bindings/arm/marvell/
> > 
> > But these files are not Gregory or my problem.
> 
> Yeah, that's what I meant by listing entire directory.
> 
> > 
> > If they were orphaned before, i would prefer they are either orphaned
> > after the move, or associated to the correct maintainer. Being
> > associated to the wrong maintainers is worse than having no
> > maintainers at all.
> 
> I can add this to existing maintainers entry. Which one? I see only two
> ARM/Marvell.

MMP SUPPORT
R:      Lubomir Rintel <lkundrak@v3.sk>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:      Odd Fixes
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
F:      arch/arm/boot/dts/marvell/mmp*
F:      arch/arm/mach-mmp/
F:      include/linux/soc/mmp/

But you also need to modify the ARM/Marvell Kirkwood and ... so that
it excludes these MMP files.

   Andrew
