Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94977EE003
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbjKPLmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbjKPLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:42:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DDD50
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:42:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB1A7204FF;
        Thu, 16 Nov 2023 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700134961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rZdIlzuDKB53L1F0Dn2qgygX+xkvd8594ERD+Hc8H2I=;
        b=DZfjQu0HN/giOA/qM0wgjjXAyUA8FGLsAeKsoVCE9gyqdXHBmT1wF7VL0ygz4YTxPXR81y
        DnbGEnREq7JOlbAsCIngz+ufr5uttHbmlFqt18Qnb1tPhL94wReTn1ip8HbjEfAArIgALU
        OH5kZ4gC3q21uNA83rowcvqk3471Lms=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AB13139C4;
        Thu, 16 Nov 2023 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2tqWIDEAVmU6UgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Nov 2023 11:42:41 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.7-rc2
Date:   Thu, 16 Nov 2023 12:42:41 +0100
Message-Id: <20231116114241.26403-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc2-tag

xen: branch for v6.7-rc2

It contains the following patches:

- A fix in the Xen events driver avoiding to use RCU after the call of
  rcu_report_dead() when taking a cpu down.

- A fix for running as Xen dom0 to line up ACPI's idea of power
  management capabilities with the one of Xen.

- A cleasnup eliminating several kernel-doc warnings in Xen related
  code.

- A cleanup series of the Xen events driver.


Thanks.

Juergen

 arch/x86/include/asm/acpi.h           |  14 +
 arch/x86/include/asm/xen/hypervisor.h |   9 +
 drivers/xen/events/events_2l.c        |   8 +-
 drivers/xen/events/events_base.c      | 576 ++++++++++++++++------------------
 drivers/xen/events/events_internal.h  |   1 -
 drivers/xen/pcpu.c                    |  22 ++
 drivers/xen/xen-front-pgdir-shbuf.c   |  34 +-
 include/xen/events.h                  |   8 +-
 8 files changed, 347 insertions(+), 325 deletions(-)

Juergen Gross (8):
      xen/events: avoid using info_for_irq() in xen_send_IPI_one()
      xen/events: fix delayed eoi list handling
      xen/events: remove unused functions
      xen/events: reduce externally visible helper functions
      xen/events: remove some simple helpers from events_base.c
      xen/events: drop xen_allocate_irqs_dynamic()
      xen/events: modify internal [un]bind interfaces
      xen/events: remove some info_for_irq() calls in pirq handling

Randy Dunlap (1):
      xen/shbuf: eliminate 17 kernel-doc warnings

Roger Pau Monne (1):
      acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0
