Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10B480F673
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377187AbjLLTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjLLTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:19:03 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E16CE;
        Tue, 12 Dec 2023 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IjbNLBnXJMkEPuo14QetPgRXWjPIn+/9Sx2GduCHfXA=; b=BT6S/XMZL/rzU9HjAnFEu7NGGR
        upEveRnxQ+NPn39oOLaeAuRuDC03OcuH9sGUuCIInrTiiMfZyptebSEHaOlCb+d3e1ltrga1Uu7fn
        vpZYcKUgJHlIuJFptgzg+Iwm51DET8VPWvjf+mk9KfOtqLZoAvTOYinmyXYnIWx+lfQheXc9lYM2i
        fx5tD2aAZ9C5C459TvYc5CYrrASTXZeTN7uJ7aKSCUeWKwMSn4IjEVoT/oxIN8RPqoZs+sXVTUaEg
        rJCkeJ1P/Yf0aj18LnYqWK5teotB7rfvz/8Yq5deB1+erDYaendz6E2Y4S/ltezUTgJcwj2wRVHFS
        Yj1wiGvw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49216)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rD8HV-0007JO-2r;
        Tue, 12 Dec 2023 19:19:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rD8HX-0000hW-T4; Tue, 12 Dec 2023 19:19:03 +0000
Date:   Tue, 12 Dec 2023 19:19:03 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     maxime.chevallier@bootlin.com, mw@semihalf.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
Message-ID: <ZXiyJ0s++j1ib6Pw@shell.armlinux.org.uk>
References: <20231212141200.62579-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212141200.62579-1-eichest@gmail.com>
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

On Tue, Dec 12, 2023 at 03:12:00PM +0100, Stefan Eichenberger wrote:
> Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> The description in Marvell's functional specification seems to be wrong.
> To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
> we need to clear it. This is also how U-Boot handles it.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

LGTM.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
