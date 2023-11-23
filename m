Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193E67F56C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjKWDKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjKWDKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:10:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80774D5E;
        Wed, 22 Nov 2023 19:10:19 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id D728020B74C0; Wed, 22 Nov 2023 19:10:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D728020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1700709018;
        bh=sP/kpPj8BkKyVMEDzS+OaFWLgeKMkV1qQHYNF/Vuc7M=;
        h=From:To:Cc:Subject:Date:From;
        b=KLkpTxfWGkaSk8aQ3/pBWPvQFay22P0DsIwccy+/HDwobwVQmW9rMRgLOd68IE3Et
         ANkXqlUTDR2J9hziRtL7Cu+eCBIiwuvIjFTfnXL94vGArdFw6RT6qiU4GSjKFA8jWG
         1vAfwrRsL85/sUPOtSCq5KslkzjSud/6eQVX+TjA=
From:   longli@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: [Patch v1 0/4] 
Date:   Wed, 22 Nov 2023 19:10:06 -0800
Message-Id: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

This patchset add support for registering a RDMA device handle with SoC
for support of upcoming RC queue pairs and CQ interrupts.

This patchset is partially based on Ajay Sharma's work:
https://lore.kernel.org/netdev/1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com

Long Li (4):
  RDMA/mana_ib: register RDMA device with GDMA
  RDMA/mana_ib: create and process EQ events
  RDMA/mana_ib: create RDMA adapter handle
  RDMA/mana_ib: query device capabilities

 drivers/infiniband/hw/mana/cq.c               |   2 +-
 drivers/infiniband/hw/mana/device.c           |  52 +++++-
 drivers/infiniband/hw/mana/main.c             | 166 ++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h          |  85 +++++++++
 drivers/infiniband/hw/mana/qp.c               |  36 +++-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++++++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  19 +-
 8 files changed, 420 insertions(+), 95 deletions(-)

-- 
2.34.1

