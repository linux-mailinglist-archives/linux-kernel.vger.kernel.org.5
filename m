Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A867A96B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjIURCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjIURCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CAF1728
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:00:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80AE51FF34;
        Thu, 21 Sep 2023 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695285671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xLSmJHDOAeyr0SNBhUaYyjXJCesrWfX5ksP2B3zrsxU=;
        b=B2CSIf4qD3ZjJ0wqPhaMGHT0itCWrwZjCQgE+TIXmStBYXtryLkbOTz9SFudLoT7xdPCXm
        HSJv/8Nh/O8EgTibNN19rNjR6Eck1TYHt/fOxHYUUuo4x4XH0vZfPWPkgero80M0VLA0ct
        Vzmq6PNT1w3cMYecKGkvhcS2lm9130E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AC46134B0;
        Thu, 21 Sep 2023 08:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id akXPFKcBDGUAHwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 21 Sep 2023 08:41:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.6-rc3
Date:   Thu, 21 Sep 2023 10:41:10 +0200
Message-Id: <20230921084110.31633-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.6a-rc3-tag

xen: branch for v6.6-rc3

It contains:

- a cleanup patch removing some unused functions in the Xen event
  channel handling

- a 3 patch series fixing a regression (introduced in 6.6 merge window)
  when booting as Xen PV guest

- a small cleanup patch removing another strncpy() instance


Thanks.

Juergen

 arch/arm/xen/enlighten.c              |  2 +-
 arch/x86/entry/common.c               |  2 +-
 arch/x86/include/asm/paravirt_types.h | 15 --------
 arch/x86/include/asm/xen/hypervisor.h | 37 +++++++++++++++++++
 arch/x86/kernel/paravirt.c            | 67 -----------------------------------
 arch/x86/xen/efi.c                    |  2 +-
 arch/x86/xen/enlighten.c              |  2 +-
 arch/x86/xen/enlighten_hvm.c          |  2 +-
 arch/x86/xen/enlighten_pv.c           | 40 +++++++++++++++++----
 arch/x86/xen/mmu_pv.c                 | 55 ++++++++++++++++++----------
 arch/x86/xen/multicalls.h             |  4 +--
 drivers/xen/events/events_base.c      | 21 ++---------
 drivers/xen/platform-pci.c            |  2 +-
 include/trace/events/xen.h            | 12 +++----
 include/xen/arm/hypervisor.h          | 12 -------
 include/xen/events.h                  |  3 +-
 16 files changed, 123 insertions(+), 155 deletions(-)

Juergen Gross (4):
      xen: simplify evtchn_do_upcall() call maze
      arm/xen: remove lazy mode related definitions
      x86/xen: move paravirt lazy code
      x86/xen: allow nesting of same lazy mode

Justin Stitt (1):
      xen/efi: refactor deprecated strncpy
