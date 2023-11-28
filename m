Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E57FB656
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjK1Jxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1Jx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:53:27 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471FDD;
        Tue, 28 Nov 2023 01:53:34 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id BE6B660871;
        Tue, 28 Nov 2023 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701165213;
        bh=3mWAVOOVekZqdc5czMgJaT2BDdCCOnbTDi9BP290nz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPLyJoUey47nfn3opllr5FHKXO5SF5s0e/1URBEKp41ElaqvUCFs1sXb34DBng744
         apL4d320h8AS/+/9UynWo/KXzEzGLpAxKa0CIsufYx6LVRnQbDYFhfOk7IV36Zh2Bz
         Sz5lSCxUJhcX43n1VmzUgZlSdI/p0GrHWh1ISl1t0MvxifhDrcvdr0YvcXqUaj6Hy3
         kdga5ISlA1II769s9sLJoxE4eBgwemAgjJCyh6nE3UlGCqXhaOTn/KQX0nI+X6ZvhF
         IczQ01j3AjPRGTYD1xX8ZmLZUkKYt4ApkcbrTXyUluQDQlyvnkF/tqi/fJ9HixUp+M
         oDqK2oqdSfDOA==
Date:   Tue, 28 Nov 2023 11:53:14 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
Message-ID: <20231128095314.GP5169@atomide.com>
References: <20231010211925.1629653-1-robh@kernel.org>
 <20231018052059.GJ34982@atomide.com>
 <edb9361c-e100-450f-a4f6-10bc9eff2fe1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb9361c-e100-450f-a4f6-10bc9eff2fe1@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Davis <afd@ti.com> [231018 14:05]:
> On 10/18/23 12:20 AM, Tony Lindgren wrote:
> > * Rob Herring <robh@kernel.org> [231011 00:19]:
> > > DT overlays in tree need to be applied to a base DTB to validate they
> > > apply, to run schema checks on them, and to catch any errors at compile
> > > time.
> > > 
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > >   - Only test applying overlays when building all DTBs
> > 
> > Andrew, any comments or care to ack?
> 
> As before, this is a valid combination, but it is only one of
> many more. For now this is a reasonable start though,
> 
> Acked-by: Andrew Davis <afd@ti.com>

OK thanks applying into omap-for-v6.8/dt.

Tony
