Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E497B707C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbjJCSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjJCSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:03:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081FAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:03:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F592C433C7;
        Tue,  3 Oct 2023 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696356235;
        bh=dQZBCs6cBypy1tjvCGgVW866wi7y6vz/hhDVoMug0fU=;
        h=From:To:Cc:Subject:Date:From;
        b=Qyqg0anDjtiXkUcYjR7yuceeC1pBvPXIbtLz79owwM/GGHoe2Y/0MBwGgjSQyrhEs
         Eqc8dVDbZEGVXZNr/o/xS/uNSSk4HiBDkXv3NJ5BmyMHrbijlEUIt00Pvk4X3xFFUn
         Plc7aPM5Bu9i27oolq9QB4SNTXp2FRDc4MmEszrI6coxyhU6a6isR7sd5ug2scZO1R
         dP6+w0YxuvSSZM/dz7nU2YZdWNzJeYCCb0PknixV6Z8oaBMbL/h13sr36fx8KVnOEV
         iQYdKUM3mlDHB0wixS2EZDTNCCOIoFTuIbAkbQ/UskR/PHrEAZfMi9BxWZIpuX+DX9
         UBWj8FqnOU8hg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.6-rc4
Date:   Tue, 03 Oct 2023 19:03:47 +0100
Message-Id: <20231003180355.3F592C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.6-rc4

for you to fetch changes up to 7a795ac8d49e2433e1b97caf5e99129daf8e1b08:

  regmap: rbtree: Fix wrong register marked as in-cache when creating new node (2023-09-22 16:54:00 +0100)

----------------------------------------------------------------
regmap: Fix for v6.4

A fix for a long standing issue where when we create a new node in an
rbtree register cache we were failing to convert the register address
of the new register into a bitmask correctly and marking the wrong
register as being present in the newly created node.  This would only
have affected devices with a register stride other than 1 but would
corrupt data on those devices.

----------------------------------------------------------------
Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when creating new node

 drivers/base/regmap/regcache-rbtree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
