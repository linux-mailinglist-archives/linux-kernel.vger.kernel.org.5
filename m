Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE87D7F53A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjKVWrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjKVWra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:47:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E701A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:47:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1099C433C9;
        Wed, 22 Nov 2023 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700693246;
        bh=SHbQMMey11hjBP8yxns0NPFvAu9Nr0TqmQigEjIJlYM=;
        h=From:To:Cc:Subject:Date:From;
        b=U4rkAg4i2SQA52TT1dNYTVXHK/TLxnH9GwQW7J98OUhJQxyRkAsdV5WDO/jSphGJ2
         QS3mj5Vg7rHPwsMFNggbk+eqZ3+T+s0QHnYLOQ1mPBJkzBZ9Dic8RCRqRcSS8jaGdJ
         grEY/6irykIEN0RaEdTasyRkrWZhAT/eRRtq+lIwXlhLEFbZ95RWp5o9hmHtiGpHVy
         +tpUVcppJHU9TOnOZVTb0gBTQYZLG1wm0on5IgrN46LefIOdKrg0D/WsEbM4HzW/gD
         yHdfI6l/FUaRPzMLUxUilHHxPMBAgb/7CLHPXpu7GwHpllrhCtMJOAPYAJmsBDYUG4
         X/JFSvJIRQLYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-nvme@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] nvme link failure fixes
Date:   Wed, 22 Nov 2023 23:47:16 +0100
Message-Id: <20231122224719.4042108-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are still a couple of link failures that I tried to address
with a previous patch. I've split up the missing bits into smaller
patches and tried to explain the bugs in more detail.

With these applied, randconfig builds work again. Please either
merge them or treat them as bug reports and find a different fix,
I won't do another version.

Arnd Bergmann (3):
  nvme: target: fix nvme_keyring_id() references
  nvme: target: fix Kconfig select statements
  nvme: tcp: fix compile-time checks for TLS mode

 drivers/nvme/host/tcp.c        | 31 ++++++++++++++-----------------
 drivers/nvme/target/Kconfig    |  4 ++--
 drivers/nvme/target/configfs.c |  2 +-
 3 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.39.2

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

