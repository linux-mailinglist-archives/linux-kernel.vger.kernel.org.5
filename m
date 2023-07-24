Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83375ED66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGXIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjGXIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:25:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F029134;
        Mon, 24 Jul 2023 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690187107; x=1721723107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eo4QhChgz1OMrGIR/dw/gfJ7BnsxpgOAO4aD+hGA1Pg=;
  b=lQQUhOI0OlbMHzXjpQMT1g9X49qmVQENtsoNrrWz8VJPMgHfTyFmDCY+
   YDiAfKWt0O7RECwVIFLuzsWbow9K8lxA0WlOb2Kp3chnpOJ3rViEc36QK
   nsczfy+nanXJqJU7Q2DJ2199+ZT8h5Usw4vyg2tWIfKnFgElK7phTwCG6
   faJ1JXKDPyjBGEvIKgSJ3Qssj0mlG6iGfjk7Bm0/zDVRbN+WHWwCjpWxj
   cl0sp8gW7IYY0JzZpVlkJz0tsQWbAnw3Sg6wG+zHgJ8eEjyV0hk80MQkj
   JDHUxwk65MgqeT9WJDU9mmY1hljjMlq2kJdlW2rBS8d+frYKGa/MFkJ6z
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="225495427"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 01:25:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 01:25:04 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 01:25:04 -0700
Date:   Mon, 24 Jul 2023 13:54:49 +0530
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Message-ID: <20230724082449.GA17358@raju-project-pc>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
 <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
 <ZLpyjNJsQjOw2hfj@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZLpyjNJsQjOw2hfj@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell King,

Thank you for review comments.

The 07/21/2023 12:57, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Jul 21, 2023 at 09:49:06AM +0100, Russell King (Oracle) wrote:
> > On Fri, Jul 21, 2023 at 11:30:17AM +0530, Raju Lakkaraju wrote:
> > > +static void lan743x_phylink_mac_config(struct phylink_config *config,
> > > +                                  unsigned int link_an_mode,
> > > +                                  const struct phylink_link_state *state)
> > > +{
> > > +   struct net_device *netdev = to_net_dev(config->dev);
> > > +   struct lan743x_adapter *adapter = netdev_priv(netdev);
> > > +   bool status;
> > > +   int ret;
> > > +
> > > +   lan743x_mac_cfg_update(adapter, state->link, state->speed,
> > > +                          state->advertising);
> >
> > Please, no new state->speed users in mac_config().
> 
> I have just submitted a patch series that results in state->speed always
> being set to SPEED_UNKNOWN when this function is called to prevent
> future uses of this struct member.

Still, these changes are not available in "net-next" branch.
I will check and fix.

> 
> > > +   adapter->phylink_config.dev = &netdev->dev;
> > > +   adapter->phylink_config.type = PHYLINK_NETDEV;
> > > +   adapter->phylink_config.mac_managed_pm = true;
> > > +   /* This driver makes use of state->speed in mac_config */
> > > +   adapter->phylink_config.legacy_pre_march2020 = true;
> >
> > Sorry, but no new users of legacy features.
> 
> ... and which totally strips out the legacy phylink code, which I've
> been wanting to remove for the last three years.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,
Raju
