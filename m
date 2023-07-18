Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06C75890F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGRXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:31:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208D134;
        Tue, 18 Jul 2023 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cENNk0DUwEVttvnmoBqq817jhXxYEJLMGNEsGNnVoM8=; b=UoB2zwRdDo3OKW92kxcnnaC0mo
        U+mFSc8P5miVWXac4Do2m4iPei5L0AKUEjhS1IYapjv79+zZjcWeIuWPK1yZRhYCkLSJysaIiXOBj
        9wHFcVz9/rL3UAtrE8k63aEsYf2NeWoE1d9g9iA+/d67sPTmI9w8RBfCyakxNBHXDTfc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLu9B-001fie-Cs; Wed, 19 Jul 2023 01:30:25 +0200
Date:   Wed, 19 Jul 2023 01:30:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Michael Walle <mwalle@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
Message-ID: <26d16266-83e2-4494-8c29-ca4879be28d4@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
 <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
 <ZLbRTLRbHW/Xt2hL@shell.armlinux.org.uk>
 <6afc205e-b525-44df-b81b-ef7cfdfb6680@lunn.ch>
 <ZLcIRYb4Ak+nW557@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLcIRYb4Ak+nW557@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why would it be two drivers?

I'm assuming there is no C22 over C45. So phy_read() is not going to
work. I'm also assuming the current driver is using the C22 register
space.

So either the driver needs re-writing to use only the C45 register
space, maybe using C45 over C22, or it needs a second parallel driver
using just the C45 register space when only C45 bus transfers are
available.

	Andrew
