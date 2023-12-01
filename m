Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D72800DD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379276AbjLAPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379257AbjLAPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:01:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D41D6C;
        Fri,  1 Dec 2023 07:01:51 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r951S-0000eX-Mm; Fri, 01 Dec 2023 16:01:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     andrew@lunn.ch, hkallweit1@gmail.com
Cc:     linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        heiko@sntech.de
Subject: [PATCH 0/2] net: phy: micrel: additional clock handling
Date:   Fri,  1 Dec 2023 16:01:29 +0100
Message-Id: <20231201150131.326766-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Micrel phys define a specific rmii-ref clock (added in 2014) while
the generic phy binding specifies an unnamed clock for ethernet phys.

This allows Micrel phys to use both, so as to keep the phys not using
the named rmii-ref clock to conform to the generic binding while allowing
them to enable a supplying clock, when the phy is not supplied by a
dedicated oscillator.


Heiko Stuebner (2):
  net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref
    clock
  net: phy: micrel: allow usage of generic ethernet-phy clock

 drivers/net/phy/micrel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.39.2

