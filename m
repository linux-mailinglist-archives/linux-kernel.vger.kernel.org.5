Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2707F5261
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjKVVPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKVVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:15:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB0D42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:15:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748A8C433C7;
        Wed, 22 Nov 2023 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700687708;
        bh=tX29cwq4HW2ZTQzwFFB4rNa+GB41wrnSmjmIQn6Gg9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E959KgU9SkJXN31p4CoiSoFMbt1/4mixRnb3ii4nBu8A1WjJfgKADIlw/4ob1B2OO
         C2YiEz9grSlGSdayOaPCOmxT2duYcfB+4pdNVCGKJW3PEmzFt9LF/OPpmBoLkZEIyZ
         DdSOuor0RqsN0PXu688gw3z8uc0RMaTG/hvbfr4h+jscQUVSNipFZ3C9MZlcpXlh1L
         utkd7IFab0TsuoYQRgymLQiq4fx4G5OuLAUah8wAUR7PpwxAv0CvvCDPngDFwfS8DL
         gKgUKN0gBkIcOfj2b+AuL6cYIdEKKmfUyQjOPIcdXSa8vT1rR8KS4H+4Z3zAzFGBxy
         9PWmU8fF6JOpw==
Date:   Wed, 22 Nov 2023 21:14:59 +0000
From:   Simon Horman <horms@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 04/14] net: phy: add initial support for PHY
 package in DT
Message-ID: <20231122211459.GA46439@kernel.org>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-5-ansuelsmth@gmail.com>
 <20231122105243.GB28959@kernel.org>
 <655e452d.5d0a0220.61c31.01ae@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655e452d.5d0a0220.61c31.01ae@mx.google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:15:06PM +0100, Christian Marangi wrote:

...

> > Hi Christian,
> > 
> > I was a little hasty in hitting send on my previous message.
> > Please find some more minor feedback from my side below.
> >
> 
> Thanks a lot for the initial review and sorry for the various warning
> you had to write about it. I know this was a new concept and that I had
> to discuss a lot about the DT structure so I was a bit relaxed in
> releasing OF node. Will handle all of them in v2. Again thanks! 

No problem. I'm never sure if this kind of feedback is appropriate for and
RFC or not. And perhaps in this case it would have been better to wait for
at least one more revision. So sorry for the noise at this stage of the
patch-set's development.

...
