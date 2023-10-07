Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8447BC52A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjJGGvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJGGvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:51:09 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE05BB9;
        Fri,  6 Oct 2023 23:51:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 27A7E809E;
        Sat,  7 Oct 2023 06:51:08 +0000 (UTC)
Date:   Sat, 7 Oct 2023 09:51:06 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Davis <afd@ti.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
Message-ID: <20231007065106.GO34982@atomide.com>
References: <20230911214609.2201040-1-robh@kernel.org>
 <20230912065946.GC5285@atomide.com>
 <28c862d9-ca39-2dda-86dd-9ccc206c3a1d@ti.com>
 <CAL_Jsq+8jisrwEqzz7tZnsV9g2+LmThwpO7sHRFA-zh+6q8XuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+8jisrwEqzz7tZnsV9g2+LmThwpO7sHRFA-zh+6q8XuA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [230922 16:23]:
> On Fri, Sep 22, 2023 at 9:38 AM Andrew Davis <afd@ti.com> wrote:
> >
> > On 9/12/23 1:59 AM, Tony Lindgren wrote:
> > > * Rob Herring <robh@kernel.org> [230911 21:46]:
> > >> DT overlays in tree need to be applied to a base DTB to validate they
> > >> apply, to run schema checks on them, and to catch any errors at compile
> > >> time.
> > >>
> > >> Signed-off-by: Rob Herring <robh@kernel.org>
> > >> ---
> > >> Note that I have no idea if this combination of overlays makes sense.
> > >
> >
> > It does make sense, but it is only one of many valid combinations. I'm
> > guessing the goal here is just to make sure they all get applied in
> > at least one way so the scheme check runs. In that case this is fine
> > other than it might give the impression this is the only valid combinations.
> 
> I only care that an overlay is applied to one base. You should care
> about any combination a user might do in a bootloader because who
> wants to debug a failure a) on a board and b) in the bootloader.
> 
> > Also now we end up with these odd `am57{1,2}x-idk-overlays.dtb` files
> > which also might confuse folks, I wonder if there is some way to
> > apply and check, but not ship/install these..
> 
> There's already a config option, CONFIG_OF_ALL_DTBS, which adds
> $(dtb-) entries to the build. So if you have "dtb- +=
> foo-overlays.dtb" it will only be built in that case. Note that they'd
> probably get installed too, but who installs allyesconfig builds.

So what's the conclusion here? Is this safe to apply yes or no?

Regards,

Tony


