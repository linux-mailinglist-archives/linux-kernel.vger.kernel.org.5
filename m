Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9A758B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGSCAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:00:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3053FC;
        Tue, 18 Jul 2023 19:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8416165F;
        Wed, 19 Jul 2023 02:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F57EC433C7;
        Wed, 19 Jul 2023 02:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689732047;
        bh=0Da2X8oEjmvpZcG54rKflLyO7Pl8sCdTksCZgqJcsOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syIXk2+ZWrj7aJ63qNhkQZzNKFeKeAG2cbgL1igugVG2d+v5Ph5M04dTErXOeU57W
         0Noh7hduTV9jG5UuKGaA3OyxX5WdqovKPPvcq9a/x4+/gCXljbh1P7yPwIUCLZEweo
         ff5wfpv9gpqieFgNVuXCixFpKUSgNq+gXzV35L4MQ2rQt9L2lqTYWIY3bw05CYPcmC
         fnvurc3j0FRH/QfbpBqqSgmsCuOBFA88uqmqyw9jmYc7FNTJ2gwp4JjazcUz9Am1GW
         rRxxQiNpoHsiFy57J3HRtrYjeYMLBEzAi4Z/K12XJ80IiJQXBqmLd2zKNHqwpIQlS3
         kXLQklf0s76uw==
Date:   Wed, 19 Jul 2023 10:00:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Message-ID: <20230719020035.GS9559@dragon>
References: <20230705174932.3652479-1-hugo@hugovil.com>
 <20230718063715.GL9559@dragon>
 <20230718100344.ebeae4ee79c299bcd6fee733@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718100344.ebeae4ee79c299bcd6fee733@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:03:44AM -0400, Hugo Villeneuve wrote:
> On Tue, 18 Jul 2023 14:37:15 +0800
> Shawn Guo <shawnguo@kernel.org> wrote:
> 
> > On Wed, Jul 05, 2023 at 01:49:32PM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
> > > nano SOM.
> > > 
> > > The PTN5150 circuitry on newer versions of the Symphony EVK board has
> > > a non-standard configuration in which the PTN5150 IRQ pin is left
> > > unconnected, and the PTN5150 ID pin is connected to GPIO1_IO11. This
> > > requires changes to the ptn5150 driver to support this new mode.
> > > Variscite have indicated their intention to submit those changes
> > > upstream.
> > > 
> > > In the meantime, import device tree changes from linux-5.15 branch of
> > > varigit repos to at least make the USB OTG port operate correctly in
> > > host mode.
> > > 
> > > Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")
> > 
> > Has USB OTG been ever worked at all?  If the answer is no, it's not
> > a fix but a new feature, and I would suggest you rework the patch
> > subject and drop the Fixes tag.
> 
> Hi Shawn,
> it never worked for me since commit 7358e05bddca, but it may have
> something to do with the new hardware board version (>=1.4a) that I
> have. It probably worked for older boards (< 1.4a) altough I cannot
> confirm it without old hardware.
> 
> Let me know if you want me to remove the Fixes tag.

The change doesn't look like a bug fix as it stands.  Please rework the
patch subject and remove the Fixes tag.

Shawn
