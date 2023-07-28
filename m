Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BAC766DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjG1NSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjG1NSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:18:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54368FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:18:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC5C01F8AF;
        Fri, 28 Jul 2023 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690550284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w6/qEz7nuZR61tfXugJCI1zoAyn3+vTp7j7ZdW0CUF0=;
        b=Zrb8k/4MLbqbE61aIzBIkf0QXmDe5FlHONb0N7cc2QX6LSVpiA0g6iXSnfUTiEdRpDqsgP
        qGenDFA1Y41Wstyjx+1K8HPKcBxM1k8kdUfFVcV+OM0zq5ET+4vGomwCxGWGTVV3sW8Ivo
        ZnHJUjzqzgagGgWu/w7VTSeLXbUgqmk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C29E1133F7;
        Fri, 28 Jul 2023 13:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iAEHLgzAw2RwBAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 28 Jul 2023 13:18:04 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.5-rc4
Date:   Fri, 28 Jul 2023 15:18:04 +0200
Message-Id: <20230728131804.10538-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5a-rc4-tag

xen: branch for v6.5-rc4

It contains the following patches:

- A fix for a performance problem in QubesOS, adding a way to drain
  the queue of grants experiencing delayed unmaps faster.

- A patch enabling the use of static event channels from user mode,
  which was omitted when introducing supporting static event channels.

- A fix for a problem where Xen related code didn't check properly for
  running in a Xen environment, resulting in a WARN splat.


Thanks.

Juergen

 Documentation/ABI/testing/sysfs-module | 11 ++++++++++
 drivers/xen/events/events_base.c       | 16 +++++---------
 drivers/xen/evtchn.c                   | 35 +++++++++++++++++++++--------
 drivers/xen/grant-table.c              | 40 ++++++++++++++++++++++++----------
 drivers/xen/xenbus/xenbus_probe.c      |  3 +++
 include/uapi/xen/evtchn.h              |  9 ++++++++
 include/xen/events.h                   | 11 +++++++++-
 7 files changed, 93 insertions(+), 32 deletions(-)

Demi Marie Obenour (1):
      xen: speed up grant-table reclaim

Rahul Singh (1):
      xen/evtchn: Introduce new IOCTL to bind static evtchn

Stefano Stabellini (1):
      xenbus: check xen_domain in xenbus_probe_initcall
