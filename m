Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A297CCC84
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjJQTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjJQTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:45:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B698193
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D31C433C8;
        Tue, 17 Oct 2023 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697571929;
        bh=Qf4xkuN06EFX0//n+z87j9jXE5pKm2Yh2AAgUDg38vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMZHGMBInPRKKQMhDr7BadORk21RApp8NtvidBo7RL7fyKCJjqFoGcRcq0eBTijev
         0nEUF19DiyamGjEx9lQ8W9B9fQuoNJ4vfvXV0CsHPnUbn+cCIL/0Vvc1Z58iKuEkXW
         8z/7t8BcaiaZpQ7VMvvYt2tfujgr0F+Y2Zb+pjm8vxY55cr/6T+WNkGVAUKweLM9iz
         oIaEdOLa3f7HQrheNJlCx40V7RiRs/99kLsMnQW89h+4HiiSO3NuLsqcXzJA/96JNv
         N4DbC1waK12BcBV5RDYTpyUI4hV27UwS+TKO2ZGr/S57jCf22G4F4WNTqXnSC3rdQ7
         HD0NNc4FxBvlg==
Date:   Tue, 17 Oct 2023 21:45:24 +0200
From:   Simon Horman <horms@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernek.org, Justin Chen <justin.chen@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:BROADCOM ETHERNET PHY DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
Message-ID: <20231017194524.GA1940501@kernel.org>
References: <20231016184428.311983-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016184428.311983-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:44:28AM -0700, Florian Fainelli wrote:
> The .probe() function would allocate the necessary space and ensure that
> the library call sizes the nunber of statistics but the callbacks
> necessary to fetch the name and values were not wired up.
> 
> Reported-by: Justin Chen <justin.chen@broadcom.com>
> Fixes: 1b89b3dce34c ("net: phy: bcm7xxx: Add EPHY entry for 72165")

Should the fixes tag be as follows?

Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")

> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

...

