Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B01C7AFC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjI0H1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjI0H1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:27:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75D126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:27:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC65EC433C7;
        Wed, 27 Sep 2023 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695799667;
        bh=uXmzZw+CSsAvM8Urfx0gAJMtEEVDIe/sd4WOWNPVU0M=;
        h=From:To:Cc:Subject:Date:From;
        b=o5+/4tc91kAuxHqAiFvEgJvVSI9YZ8YNSeL7FNa7zwURbHQTfqqhJYCyDGUSZcF5a
         9M/6EfeW+3OgDcu4qpYgq3+w37NS23f67lecD8NOhHK89nlX7F6zDQG74mlZ/IBIAp
         UShWAJs44HJ1BBURBtegStLXQBZc6Wlo2vDt7MHUO6IBfWfoAsjMXYtZ2BVnOGrWVn
         ajXirFPtN2riEwzDOKn3G2j2CE/m07z2QbteJjat4c53wM/4A1KZDZMGBBtBWs9Kci
         uAoiubAVNrkHeEpfkiV9qasEVkVtgrFWzeaORVexcRaDSrnkY8LNCROmUkUYuFYaQO
         6Ldn9+wbwPQLQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
Subject: [PATCH v5 net-next 0/4] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date:   Wed, 27 Sep 2023 10:27:37 +0300
Message-Id: <20230927072741.21221-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds mqprio qdisc offload in channel mode,
Frame Pre-emption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

Comparted to v4, this series picks up the coalesing patch.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (2):
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 229 ++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  61 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 550 +++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 112 ++++
 5 files changed, 879 insertions(+), 82 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

