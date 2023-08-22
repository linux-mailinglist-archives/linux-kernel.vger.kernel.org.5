Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664B8783A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjHVHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjHVHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46307E42;
        Tue, 22 Aug 2023 00:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9F060C53;
        Tue, 22 Aug 2023 07:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ACAC433C7;
        Tue, 22 Aug 2023 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692688274;
        bh=5abBsOROkeket/n7uPinBiqxWhdIx3NpC4zEAOxIpxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxLL2jmPdNfZmpr/pZgBbY4ebnfkLiqxLltvx4pgd8VIBLhzCsqNCXCdbl5WwM7i0
         LmAiVPNrkDlX6AGpYnVGGykVbbevC7t4KMQoQr/LhORPt12Kegs5Je+RAkshwXxIDO
         Krky6Q/HZHA5nGeRXupUSLJoFmNHVU2MPngpmjgY=
Date:   Tue, 22 Aug 2023 09:10:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     stable@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:BROADCOM ETHERNET PHY DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 4.14] net: phy: broadcom: stub c45 read/write for
 54810
Message-ID: <2023082252-motor-grower-5621@gregkh>
References: <2023082134-chain-tubular-c681@gregkh>
 <20230821215410.3123513-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821215410.3123513-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:54:10PM -0700, Florian Fainelli wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> commit 096516d092d54604d590827d05b1022c8f326639 upstream
> 
> The 54810 does not support c45. The mmd_phy_indirect accesses return
> arbirtary values leading to odd behavior like saying it supports EEE
> when it doesn't. We also see that reading/writing these non-existent
> MMD registers leads to phy instability in some cases.
> 
> Fixes: b14995ac2527 ("net: phy: broadcom: Add BCM54810 PHY entry")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Link: https://lore.kernel.org/r/1691901708-28650-1-git-send-email-justin.chen@broadcom.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [florian: resolved conflicts in 4.14]
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for these, all now queued up.

greg k-h
