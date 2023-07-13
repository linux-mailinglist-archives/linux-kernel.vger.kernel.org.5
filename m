Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A4752102
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjGMMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjGMMQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:16:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326191FEA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:15:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFFFD1FDAE;
        Thu, 13 Jul 2023 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689250542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69I9n2IK3naLFPJAhL5ZT4b7LKGGJ1CwIXBa7kBCt5U=;
        b=MQCCxB2Vlfl4wRDyy7mk8NCrZoyHLEB6I2HxpmeQgn8e4ut2z2KDRmd4VZrd1H+0jImkaw
        1tBCvT0JpY8S+P0Iq3SbfO/w1TDlYUW5z6u3B67RF/wabIAeEnecE48LwiMhZefI5M+agi
        v8mX3H8rOGhC4aQOvyK6jSLksu4fSRc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA2C0133D6;
        Thu, 13 Jul 2023 12:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MjDtK+7qr2TLJQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 13 Jul 2023 12:15:42 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.5-rc2
Date:   Thu, 13 Jul 2023 14:15:42 +0200
Message-Id: <20230713121542.4854-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5-rc2-tag

xen: branch for v6.5-rc2

It contains the following patches:

- a cleanup of the Xe related ELF-notes

- a fix for virtio handling in Xen dom0 when running Xen in a VM


Thanks.

Juergen

 arch/x86/xen/xen-head.S     | 37 +++++++++++++++++++++----------------
 drivers/xen/grant-dma-ops.c |  2 ++
 2 files changed, 23 insertions(+), 16 deletions(-)

Jan Beulich (1):
      x86/Xen: tidy xen-head.S

Petr Pavlu (1):
      xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent
