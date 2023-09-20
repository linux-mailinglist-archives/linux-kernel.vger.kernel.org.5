Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E527A7E25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjITMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjITMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:15:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D183
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:15:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D44C433C7;
        Wed, 20 Sep 2023 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695212136;
        bh=H575bRTPoElpINF9yF6RhdCCUTc3Ej/a2wKGdnvU8T8=;
        h=From:To:Cc:Subject:Date:From;
        b=sPyy5wUduBlldhulEJTDY75t6fdiJXSP3KwK2MHv8c17A6s+ZbzGWsePv1aAnApw0
         NJg6vsazYYm4RbyyYf8pjmt04mn2afoSaDqQ6mDo+wakwADTP7bndm5Cpu42jx1iql
         DFEplbEoV3r6ZCxZ8rGkE4YUUzLciQO4zuFw740yX1s6qAPpR8KOUKJkgnIXbBYgEm
         3CcMbvZ8yeZHMH4Jkg3P5HsQ5w2/xNqfyTHDN86AGT1Z8nnedhfVC50LvyDkaI32mg
         XJofybMv8ky2cFUH9AISL29f85LNRkg0vj+H4W1SqtWufMS1q2yF7Dne0HjAzxTGax
         RgFVctd1frv1w==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
Subject: [PATCH net-next v4 0/3] net: ethernet: ti: am65-cpsw: Add mqprio and frame pre-emption
Date:   Wed, 20 Sep 2023 15:15:27 +0300
Message-Id: <20230920121530.4710-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds mqprio qdisc offload in channel mode and
Frame Pre-emption MAC merge support for AM65 CPSW driver.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (1):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode

Roger Quadros (2):
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 550 +++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 112 ++++
 5 files changed, 745 insertions(+), 74 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

