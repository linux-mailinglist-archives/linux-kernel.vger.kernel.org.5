Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA77DA7E1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJ1Pzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:55:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9ABBF
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:55:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE86921D6F;
        Sat, 28 Oct 2023 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698508525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dGrk1kgDIUUWjtfSnQ+C6LXr6l7ET+4+pAVQ44VHhtE=;
        b=ViN190DzdFdCqnn/9/LXvKVD9+pLQ/qwts27v0yZ1th3p5cYApaXylS+yaUvJfJIefggDM
        JDN2CZA0l9cODgsnaMQgIQkg4O+Y2bbceSse3uKqWfnA7I03FBTNhoDtInOSDSaPov+lgk
        CLVJWgD/TM4vZNwDctXmDJ+D28wt3DM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81222138F8;
        Sat, 28 Oct 2023 15:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id krgQHu0uPWXCJwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 28 Oct 2023 15:55:25 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.7-rc1
Date:   Sat, 28 Oct 2023 17:55:24 +0200
Message-Id: <20231028155524.19315-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.68
X-Spamd-Result: default: False [-1.68 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(1.42)[85.23%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7-rc1-tag

xen: branch for v6.7-rc1

It contains the following patches:

- 2 small cleanup patches

- a fix for PCI passthrough under Xen

- a 4 patch series speeding up virtio under Xen with user space backends


Thanks.

Juergen

 drivers/xen/Kconfig                             |   8 +-
 drivers/xen/events/events_base.c                |   3 +-
 drivers/xen/evtchn.c                            |   2 +-
 drivers/xen/privcmd.c                           | 407 +++++++++++++++++++++++-
 drivers/xen/xen-pciback/conf_space.c            |  19 +-
 drivers/xen/xen-pciback/conf_space_capability.c |   8 +-
 drivers/xen/xen-pciback/conf_space_header.c     |  21 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c        |   4 +-
 drivers/xen/xenbus/xenbus_probe.c               |   2 +-
 include/uapi/xen/privcmd.h                      |  22 +-
 include/xen/interface/hvm/ioreq.h               |  51 +++
 11 files changed, 508 insertions(+), 39 deletions(-)

Gustavo A. R. Silva (1):
      xen/xenbus: Add __counted_by for struct read_buffer and use struct_size()

Juergen Gross (1):
      xenbus: fix error exit in xenbus_init()

Marek Marczykowski-Górecki (1):
      xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled

Viresh Kumar (4):
      xen: Make struct privcmd_irqfd's layout architecture independent
      xen: irqfd: Use _IOW instead of the internal _IOC() macro
      xen: evtchn: Allow shared registration of IRQ handers
      xen: privcmd: Add support for ioeventfd
