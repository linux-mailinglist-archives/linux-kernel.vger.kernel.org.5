Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9880B934
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjLJGGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:06:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE55B7;
        Sat,  9 Dec 2023 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wqSeEPanlXlOG/9n9u5KnVzekwZYv7zZQyTmk5eD/Ks=; b=HeK3txOiVsoFp2/rXM+EwnnWS+
        EB+/qc5gdMOAAT6nF+KS7y7zB1iLp5+R538d9O1aOLSeWDO2IyzCBQgpVmkGn/DpMmELroTbK6Xlz
        gaUZB/DSVZ5HJ0mc7eOuQph5nVnqUvT9wsI1O4V8bhPckEp1/O3TgE1jDQBkU2fkjzajfni2R9fAp
        0xht4IP9v2/j40pH13qifSaUoZrTpk4wTa3pnECaoYYTlou7q5U/rokdVcsPDYqbLAwdmAXrDHQ5H
        m3HS1GvJC7eBE1ueQhGPJKS9mRC3/mRPgydN9IS3L8hx4BRabL/VJVuYs99m7SD8KwU84PhROoIkf
        GaS5JJKw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rCCxh-00119d-0K;
        Sun, 10 Dec 2023 06:06:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Subject: [PATCH] bcachefs: six lock: fix typos
Date:   Sat,  9 Dec 2023 22:06:44 -0800
Message-ID: <20231210060644.26978-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few typos in the six.h header file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
---
 fs/bcachefs/six.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/fs/bcachefs/six.h b/fs/bcachefs/six.h
--- a/fs/bcachefs/six.h
+++ b/fs/bcachefs/six.h
@@ -15,7 +15,7 @@
  * will have to take write locks for the full duration of the operation.
  *
  * But by adding an intent state, which is exclusive with other intent locks but
- * not with readers, we can take intent locks at thte start of the operation,
+ * not with readers, we can take intent locks at the start of the operation,
  * and then take write locks only for the actual update to each individual
  * nodes, without deadlocking.
  *
@@ -65,8 +65,8 @@
  *
  * Reentrancy:
  *
- *   Six locks are not by themselves reentrent, but have counters for both the
- *   read and intent states that can be used to provide reentrency by an upper
+ *   Six locks are not by themselves reentrant, but have counters for both the
+ *   read and intent states that can be used to provide reentrancy by an upper
  *   layer that tracks held locks. If a lock is known to already be held in the
  *   read or intent state, six_lock_increment() can be used to bump the "lock
  *   held in this state" counter, increasing the number of unlock calls that
