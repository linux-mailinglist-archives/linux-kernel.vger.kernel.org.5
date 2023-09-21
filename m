Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639CF7A9B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjIUS4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjIUSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:55:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A572402;
        Thu, 21 Sep 2023 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QISaqh9G4DzFpv5qasHYVcLuNJPZgvVZsAh/znxO66M=; b=VTNXQ5zmMk1xgow0SjFQvHt7VN
        0OlTTyoPg7ZIpxBxeIU5typ9qHlfn0/xSso3I2iftYkpqJ634DTbhiaQtB5l3Wd87OYBZJNU2Bb6d
        eML8VrqhPP2DcRnLyCt8/fybhGJnmThXov9Re3ZPC+3fbPOkMd7IlkHUHiwD67n4Wd5Bgc6TD0sKM
        0kAhDgWRq0aHFtC2k/M7p2kExzhACC/czUICFb7UJiHO+JpDzMVRg6nM/tqBqvNi2q0RTpXoNfn4n
        Hfy3Vn4bcwu0knjJwimf2lmh9X5OEEvxP2vZbojvJhogNjHL5KmgfH28RdQWEFu9Rhk/sdAtzXaRK
        Nl880l+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54114)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qjKMe-0004lU-0u;
        Thu, 21 Sep 2023 15:09:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qjKMb-0003aw-Q8; Thu, 21 Sep 2023 15:09:05 +0100
Date:   Thu, 21 Sep 2023 15:09:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Choong Yong Liang <yong.liang.choong@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wong Vee Khee <veekhee@apple.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        David E Box <david.e.box@intel.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v3 0/5] TSN auto negotiation between 1G and 2.5G
Message-ID: <ZQxOgfw3LD5Bu2iD@shell.armlinux.org.uk>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <4caade36-d4be-4670-ac79-d9d00488293d@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4caade36-d4be-4670-ac79-d9d00488293d@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:14:59PM +0200, Andrew Lunn wrote:
> > Auto-negotiation between 10, 100, 1000Mbps will use
> > in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
> > 2.5Gbps will work as the following proposed flow, the stmmac driver reads
> > the PHY link status registers then identifies the negotiated speed.
> 
> I don't think you replied to my comment.
> 
> in-band is just an optimisation. It in theory allows you to avoid a
> software path, the PHY driver talking to the MAC driver about the PHY
> status. As an optimisation, it is optional. Linux has the software
> path and the MAC driver you are using basically has it implemented.

Sorry Andrew, I have to disagree. It isn't always optional - there are
PHYs out there where they won't pass data until the in-band exchange
has completed. If you try to operate out-of-band without the PHY being
told that is the case, and program the MAC/PCS end not to respond to
the in-band frames from the PHY, the PHY will report link up as normal
(since it reports the media side), but no data will flow because the
MAC facing side of the PHY hasn't completed.

The only exception are PHYs that default to in-band but have an inband
bypass mode also enabled to cover the case where the MAC/PCS doesn't
respond to the inband messages.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
