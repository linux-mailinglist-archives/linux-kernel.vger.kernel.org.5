Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1877575A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGRHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGRHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:47:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9585DD;
        Tue, 18 Jul 2023 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NboEGMEtSSINFTYAhTdPSs3mcHrjmxWKlp9QfP49pKE=; b=OTHhWJt2wqwUZeixwym/3j9XpL
        CyIDaE4LQaT1h9FuBQc+SvxAFI0z0708oeRaJAIgI986GFFU1lgHPBjX478+uZ4xiLTB6nZGAM9Y4
        wXB2WChuWcdeCJagCjgUwLLJiSs9MdNE7xDWioK97MFn7uh4Zo51fkdIxkqVKNm5WL66Sp6HWTczW
        zSgqQnmAUrW6MABHdrKXLq7NzRMVveYE/tvUVg8FOdiqgeGCuPJDioZaoQ8zBY1tPVUiFWNFka9Ax
        DZ15TDsFiuEG33VqAFY8FuitMeQ2vnuoM+Brbtk2DSY/nVvB7wAJsd6ytJ9bAc78BRHMuGaMItzZe
        WDSZ+3GA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47624)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qLfQb-0005XY-2e;
        Tue, 18 Jul 2023 08:47:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qLfQZ-0002rl-KX; Tue, 18 Jul 2023 08:47:23 +0100
Date:   Tue, 18 Jul 2023 08:47:23 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "M. Haener" <michael.haener@siemens.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Message-ID: <ZLZDi22lqZfHKFUZ@shell.armlinux.org.uk>
References: <20230718065937.10713-1-michael.haener@siemens.com>
 <20230718065937.10713-4-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718065937.10713-4-michael.haener@siemens.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 08:59:31AM +0200, M. Haener wrote:
> From: Michael Haener <michael.haener@siemens.com>
> 
> The 88e632x family has several SERDES 100/1000 blocks. By adding these
> operations, these functionalities can be used.
> 
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
> Changelog:
> v3: rebased onto main branch
> v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

I think you're missing something - you seem to be adding support to read
the statistics from these blocks, but you're not actually driving them
at all in terms of reading their status or configuring them.

You need to modify drivers/net/dsa/mv88e6xxx/pcs-6352.c for that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
