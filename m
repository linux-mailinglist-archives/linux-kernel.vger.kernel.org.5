Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B019A7775F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjHJKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjHJKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:37:21 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB5E6B;
        Thu, 10 Aug 2023 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tgX9FQD+OwqVX5pp901IhBWxdrgVMGAlOYqe/oYoKZ0=; b=nk8gqcuyL2B/ZalxwkpmOKSas1
        eS09/Wkey4SP87jt+PeioeL1OoFFGJQLVhNbNwmPyIu+Xiyyennc547uby9pXECwu/eUunCL/Rhkz
        mG6XxsRHfouuGKePkF2HZeGL6XFOUqSxHwM9BCkv3/yrYH91fBzVK2/3/+B5c8zDDxc6zCX9fln/l
        tIkI61pM0M71dynkXQ95eU7olmpUJuTs5i5xplAuWn4Cm9C66+WNrx4ouHbrMnhX/iIv5w+lF+g1z
        JoOG7RszyWTyFAYEBOwrk5jq9ufeDTfIgu6PbRM2yRwTMVC4V3eia49t2DrjO35+9dSJCIRv53PUL
        /DCB7uJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57580)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qU32S-0003pQ-2U;
        Thu, 10 Aug 2023 11:37:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qU32R-0001hb-S8; Thu, 10 Aug 2023 11:37:07 +0100
Date:   Thu, 10 Aug 2023 11:37:07 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, Gabor Juhos <j4g8y7@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce PSGMII PHY interface
 mode
Message-ID: <ZNS907hoP2QANFp/@shell.armlinux.org.uk>
References: <20230810102309.223183-1-robert.marko@sartura.hr>
 <20230810102309.223183-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810102309.223183-2-robert.marko@sartura.hr>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:22:55PM +0200, Robert Marko wrote:
> From: Gabor Juhos <j4g8y7@gmail.com>
> 
> The PSGMII interface is similar to QSGMII. The main difference
> is that the PSGMII interface combines five SGMII lines into a
> single link while in QSGMII only four lines are combined.

Please also update the docs at Documentation/networking/phy.rst
section "PHY interface modes" to describe this mode. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
