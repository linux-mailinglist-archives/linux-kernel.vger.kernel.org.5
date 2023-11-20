Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A27F1864
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjKTQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjKTQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:18:24 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E2F5;
        Mon, 20 Nov 2023 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6SCBZOZz6Qup6QX990ipAzjI1yY+8rbPKPGIJ6ySC0E=; b=sqnGbTdIP9eiY5KVdCOGH68mSL
        OorK3g1mxqMHwNbBHJzmZcfhye06oLl9D7b2ucdzEubIu2uN7K/5btywoIHQon63OGbQX4+wib9Y0
        r9zZuYEbWzRCNaP121etnyiXDueFvlXYvvlkeNTypWFZwyy8op+KMUUZngzSk1XGQ4IxW3ZeMthf8
        5ixyIDuhokIU0GdZN3HQWBTnwNcHgBq2DUB4cg6QYKA60cU5qbduXITs9IXyoSTZKDlB6In1gUdX0
        f5Z1V/OzX5wWjziNXN4L1CR1jORspQPJOx6eF2drxgSc3r6HJJ4aGkG8bunfLvS9YbYcUawr3B8ZP
        5uoezByg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57710)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r56yN-0005rP-1I;
        Mon, 20 Nov 2023 16:18:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r56yN-0003JU-GV; Mon, 20 Nov 2023 16:18:07 +0000
Date:   Mon, 20 Nov 2023 16:18:07 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jie Luo <quic_luoj@quicinc.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZVuGv2005eaw+R6u@shell.armlinux.org.uk>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:34:55PM +0100, Andrew Lunn wrote:
> Are you saying there is a USXGMII-M level link change status? The link
> between the SoC and the PHY package is up/down? If it is down, all
> four MAC-PHY links are down. If it is up, it is possible to carry
> frames between the SoC and the PHY package, but maybe the PHYs
> themselves are down?

It shouldn't do. Each "channel" in the USXGMII-M link has its own
autoneg block at both ends, each conveys link status independently.

The MAC side structure is:


                            +----------+                +-----+
                    .-XGMII-> Rate     |    PCS         |     |
MAC1 <-MDI-> PHY <-+        | Adaption <--> Clause 49 <->     |
                    `-GMII-->          |                |     |
                            +-----^----+                |     |
                                  |                     |     |
                            +-----v---- +               |     |
                            | Autoneg   |               |     |
                            | Clause 37 |               |     |
                            +-----------+               |     |
                                                        | Mux <--> PMA <-->
                                                        |     |
                                                        .......     USXGMII-M

<------------------------------------------------------>
      These blocks are repeated for each channel

The spec goes on to state that there must be a USXGMII enable bit that
defaults to disabled and the PHY should assume normal XGMII/XFI
operation. When enabled, autoneg follows a slight modification of
clause 37-6.

As far as the USXGMII-M link, I believe 2.7.8 in the USXGMII-M
documentation covers this, which is "hardware autoneg programming
sequence". It states that "if 10G link is lost or regained, the
software is expected to disable autoneg and re-enable autoneg". I
think "10G link" refers to the USXGMII-M connection, which means
the loss of that link shold cause software to intervene in each
of the PCS autoneg blocks. It is, however, rather unclear.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
