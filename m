Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD07945F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbjIFWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjIFWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:07:16 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16A199B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:07:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2AA7C0002;
        Wed,  6 Sep 2023 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694038031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mCCueHqxrK4depNZb+Y64oZRKRhws2c6uxnRIrlmxnA=;
        b=hcM/cWkI9+oFzPF0aVuI3YBpfMF2d0yD2QRnZ222uzLSs+M5FBhUw21M4m52PVEyExf5LO
        Kex1zpkrQ/rLaGQhh5ldEM8hzywvjipxcnKWiLuizlrHbW/ZeNSb9SHUOA3a05epS6DPhZ
        +6MNr1FKVpuRsCOMR9nAmUZDuapkNamLplwdlJ7ULsjyiYMhfWfa6u17nzIMhnusM/36S3
        HErsJVmNrLy04R45UNRJnJy80Fp6ha8E6YpSbJliO7E3b3zJxAz4k1fXp77sd8hS1XAo3Y
        07BLth/CUaXfkkrVFDLvx5FA3di9ICOqEGz0FfzqxBMaSORpzmAeZuOWSVfuOw==
Date:   Thu, 7 Sep 2023 00:07:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.6
Message-ID: <20230906220710e64b2b71@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the i3c subsytem pull request for 6.6. There are mostly small
fixes as people ar finally starting to have access to actual hardware.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.6

for you to fetch changes up to 6e13d6528be2f7e801af63c8153b87293f25d736:

  i3c: master: svc: fix probe failure when no i3c device exist (2023-09-06 01:21:47 +0200)

----------------------------------------------------------------
I3C for 6.6

Core:
 - Fix SETDASA when static and dynamic adress are equal
 - Fix cmd_v1 DAA exit criteria

Drivers:
 - svc: allow probing without any device

----------------------------------------------------------------
Aniket (2):
      dt-bindings: i3c: Fix description for assigned-address
      i3c: master: Fix SETDASA process

Billy Tsai (1):
      i3c/master: cmd_v1: Fix the exit criteria for the daa procedure

Frank Li (1):
      i3c: master: svc: fix probe failure when no i3c device exist

Miquel Raynal (1):
      i3c: master: svc: Describe member 'saved_regs'

Rob Herring (1):
      i3c: Explicitly include correct DT includes

Ruan Jinjie (1):
      i3c: master: svc: Do not check for 0 return after calling platform_get_irq()

 Documentation/devicetree/bindings/i3c/i3c.yaml | 15 +++++++++++----
 drivers/i3c/master.c                           |  6 +++++-
 drivers/i3c/master/ast2600-i3c-master.c        |  1 -
 drivers/i3c/master/i3c-master-cdns.c           |  1 -
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c       |  2 +-
 drivers/i3c/master/svc-i3c-master.c            | 19 +++++++++++++++----
 6 files changed, 32 insertions(+), 12 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
