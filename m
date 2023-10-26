Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6217D8073
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJZKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:15:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEE195;
        Thu, 26 Oct 2023 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698315353; x=1729851353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFivSlyyCN0/u7lSbSw417gmoKe6JNs1oDbyCj3MVR4=;
  b=kaCMsmaYekSE08V0cbsbKN4O6O1G4U19FHs/zynjndJufwtvI+ZZs6UO
   54G1g1+AB5XSuFc8Y7XQW3588li782VIrRVGjRDQaQgXU7B/MW4+oZup3
   U0c/7DrWXO/rxC18u0LuuD/NCbuutJ8UupJPzlVYamEKBkkZsGJwZvXd+
   uGihGVtzMJI0b7TlwJG5U/QZNDGJblnirPRMUGbgJRRNmR9XhbW5QPPAB
   iceEoCG1a4mggEObgShgLScM3Xpq6sLZlfJSpVfSg9aVfv4i9Lve2tXQA
   LEA3k55gLndQXU2XOdsIlfbkslzWCHTV/i+exI+DHSMfI1XW+UPQoZgmG
   A==;
X-CSE-ConnectionGUID: uV9XzKt9TfK6K5PKhz3XAg==
X-CSE-MsgGUID: tkN/U9bESHWBxLYxXil25A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="177802887"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 03:15:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 03:15:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 26 Oct 2023 03:15:46 -0700
Date:   Thu, 26 Oct 2023 15:44:40 +0530
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
        <Jose.Abreu@synopsys.com>, <fancer.lancer@gmail.com>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V1] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZTo8EL7JhmqY56J0@HYD-DK-UNGSW21>
References: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
 <ZToq3n26jDqiueTB@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZToq3n26jDqiueTB@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell King,

Thank you for review the patch.

The 10/26/2023 10:01, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Oct 26, 2023 at 11:13:05AM +0530, Raju Lakkaraju wrote:
> > +     sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > +
> > +     state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);
> > +     if (!state->link) {
> > +             state->speed = SPEED_UNKNOWN;
> > +             state->pause = MLO_PAUSE_NONE;
> > +             state->duplex = DUPLEX_UNKNOWN;
> > +             return 0;
> > +     }
> 
> You don't need this. If autoneg is enabled then these are initialised
> prior to calling this by phylink using:
> 
>                 state->speed = SPEED_UNKNOWN;
>                 state->duplex = DUPLEX_UNKNOWN;
>                 state->pause = MLO_PAUSE_NONE;
> 

Ok. I will remove the change.

Thanks,
Raju

> or if not using autoneg:
> 
>                 state->speed =  pl->link_config.speed;
>                 state->duplex = pl->link_config.duplex;
>                 state->pause = pl->link_config.pause;
> 
> so you don't need to touch them if the link is down.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
--------                                                                        
Thanks,                                                                         
Raju
