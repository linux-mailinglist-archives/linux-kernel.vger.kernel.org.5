Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A85752781
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjGMPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjGMPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:42:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F15A2686;
        Thu, 13 Jul 2023 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lxBEygaiq1yvneOQNiYJ4HmAjugX4hVDNt255vDNtYU=; b=a5Bb5HuGOvtvYz10jaqYXn2B9c
        03sshjquaJ1kpHmmNOQzFVJstSllubRWkVybucPXYmnUuPfuMU8Cn162S3DcaKBzSzjPIelPtvPgY
        l8hYndEspd4NsahsEdMsxPXe1nfSoe0V8qSNzU3lzS4q7Dw+Zn9ajHfbpzo2oeWlMtCr9pb2Zq6Xn
        93DWocfkPkqy1XgziGUgWFcusTIJVJUobuduXAo1bm3wXv+8ArFNJ/Bk/BzDPmRGbBWsX3IRccdMC
        DK6sdNdL0FZ91Srybdh/OES41vNYb2U9M6QDA4W3jNbpS+if/Ziaftv5FE/pXFZsLuJF8xQkBncT1
        /acEEIcQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50256)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qJySK-0007iP-1t;
        Thu, 13 Jul 2023 16:42:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qJySJ-0006HW-2H; Thu, 13 Jul 2023 16:42:11 +0100
Date:   Thu, 13 Jul 2023 16:42:11 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "Haener, Michael" <michael.haener@siemens.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <ZLAbUxCLg1gP2gle@shell.armlinux.org.uk>
References: <20230704065916.132486-1-michael.haener@siemens.com>
 <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
 <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
 <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
 <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
 <d154d59edd2883b30de8f80fa9c08ec7700504d6.camel@siemens.com>
 <d7466827-7f39-495b-a129-91188e3d150f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7466827-7f39-495b-a129-91188e3d150f@lunn.ch>
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

On Thu, Jul 13, 2023 at 05:34:25PM +0200, Andrew Lunn wrote:
> > we did understand Andrew's request indeed, however we were not able to
> > backport your series quickly to the version we are able to test on the
> > HW.
> 
> But your own patchset has been tested on net-next by yourself? So it
> should be trivial to use "b4 am <threadid>" to get Russells patchset,
> apply them on top of net-next, and then add your patches as well.

And it's even easier as today I submitted a patch set on top of current
net-next - not that there were any conflicts.

https://lore.kernel.org/netdev/ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk/T/#t

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
