Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663307871C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjHXOg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbjHXOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:36:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28941BD4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:36:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A703122A72;
        Thu, 24 Aug 2023 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692887786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=I4kf96Gd/Pc254PdRlSC5VEW2Pw9dnY7qf5r6K/JaRQ=;
        b=TPdQCUtmEWOeKIGIrTK68yO+0VLWEAtX3ijOW8TUxZpV2rQ/9UfqcWU9aCQtcVb8HvKX6l
        WGusHhRDvLrVbpJc1k5Vi9yC/GPIplIzx0pE1YhgEH90zgxFOzXENT2/8aEJPyvHGKHTIE
        XMkdk9yPlREkeFZvS34Pjar+XbQiePM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F5251336F;
        Thu, 24 Aug 2023 14:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K4RqHepq52SdKQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Aug 2023 14:36:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.6-rc1
Date:   Thu, 24 Aug 2023 16:36:26 +0200
Message-Id: <20230824143626.10100-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.6-rc1-tag

xen: branch for v6.6-rc1

It contains the following patches:

- a bunch of minor cleanups

- a patch adding irqfd support for virtio backends running as user
  daemon supporting Xen guests


Thanks.

Juergen

 arch/x86/include/asm/xen/page.h             |   5 +-
 arch/x86/xen/enlighten_pv.c                 |   2 +-
 arch/x86/xen/mmu_pv.c                       |  18 +-
 arch/x86/xen/setup.c                        |   4 +-
 drivers/xen/Kconfig                         |   7 +
 drivers/xen/grant-table.c                   |   2 +-
 drivers/xen/privcmd.c                       | 282 +++++++++++++++++++++++++++-
 drivers/xen/xen-acpi-processor.c            |   7 +-
 drivers/xen/xen-pciback/conf_space_quirks.h |   2 -
 drivers/xen/xen-pciback/pciback.h           |   3 -
 drivers/xen/xenbus/xenbus_probe_frontend.c  |   2 +-
 drivers/xen/xenbus/xenbus_xs.c              |   4 +-
 include/uapi/xen/privcmd.h                  |  14 ++
 include/xen/events.h                        |   1 -
 14 files changed, 320 insertions(+), 33 deletions(-)

Li Zetao (1):
      xen: xenbus: Use helper function IS_ERR_OR_NULL()

Linus Walleij (1):
      x86/xen: Make virt_to_pfn() a static inline

Petr Pavlu (1):
      xen/xenbus: Avoid a lockdep warning when adding a watch

Petr Tesarik (1):
      xen: remove a confusing comment on auto-translated guest I/O

Ruan Jinjie (1):
      xen: Switch to use kmemdup() helper

Viresh Kumar (1):
      xen: privcmd: Add support for irqfd

Yang Li (1):
      xen: Fix one kernel-doc comment

Yue Haibing (2):
      xen/evtchn: Remove unused function declaration xen_set_affinity_evtchn()
      xen-pciback: Remove unused function declarations
