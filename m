Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A397A6568
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjISNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:40:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7039CF1;
        Tue, 19 Sep 2023 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bF2zlnUUaHnn/ghDIFe4kmsq06/HOWxQot3UX+2BOfU=; b=oJH8a0F9WSWQW57hGDZZCj9cqa
        7qVSgu2OJN8qLZUZ6wr57FhEyngEzGrtJ5NkEQyWgyIMLzsdSeK2QOWoGgG3eUO63RlwJ3Jjqwvvo
        lkP5UEqAc5UBf89o2sN1vd6TqejxMnXNJaEw49yRCArqF+gGqLlpQeN5pFpTCXRk/r9lQgNUpbPXE
        hZszHk5bfw7FgYhK6CigMhbQ1gDuk2+nRprgv8hP5iK9sk+vy3WEEPOwlZsR/eSiHffpMU3Ehyrs8
        zRT0y47a1mEhkNO4bZr64hsm79/98+isKx52AuSFtnSE2za87D9+KMS6TwhJV0t19h7BfKNpV93nl
        eONMPpEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41456)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qiaxb-0001yE-1s;
        Tue, 19 Sep 2023 14:40:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qiaxb-0001YI-4q; Tue, 19 Sep 2023 14:40:15 +0100
Date:   Tue, 19 Sep 2023 14:40:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone
 GPON-ONU-34-20BI
Message-ID: <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919124720.8210-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:47:20PM +0200, Christian Marangi wrote:
> Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> NRZ in their EEPROM.
> 
> The module also require the ignore tx fault fixup similar to Huawei MA5671A
> as it gets disabled on error messages with serial redirection enabled.

I'll send you shortly a different approach for the "ignore tx fault"
thing that I'd like you to test please.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
