Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E87A5D02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjISIwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjISIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D518D;
        Tue, 19 Sep 2023 01:52:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB71C433CC;
        Tue, 19 Sep 2023 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113533;
        bh=HwGEKdiyV/VIwXG51/5quMq97DbDp7dqdnUhrgn3UpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0wCqTQMRaotoCVvUT+lI7QbMcheeX375KMBnNiFEqJs8XfM3M8qiElu2G/v/b+is
         srykVE+g0QFcTjUKraW9k8yx9xFJNrryXCWNLzDrI9MAdToZwp/Cc9AQ9Xt9Ig5G64
         8UMDj1cRvu8/iq4ofU+tjgk5m+kNqSVWPCJc4eiZgaL3A7HzfVAJp9pmF5ag+qQl4T
         S7y+ek6km5tTgFSJB1241xmw+W0NoDHiOy681JTZbG8o3a9uZlYUO8nGQilTvQ2xh3
         ar+XKlxRL09z/6o1FsZv69diz3SRl8zgAher4O/jc8SxLxoPQilTP18jvQiW0WMdO6
         twBuq0psUf1xA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/15] tty: fix kernel-doc for functions in tty.h
Date:   Tue, 19 Sep 2023 10:51:50 +0200
Message-ID: <20230919085156.1578-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_kref_get() is already included in Documentation, but is not properly
formatted. Fix this.

tty_get_baud_rate() is neither properly formatted, nor is included. Fix
both.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/tty_ioctl.rst |  3 +++
 include/linux/tty.h                        | 21 +++++++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_ioctl.rst b/Documentation/driver-api/tty/tty_ioctl.rst
index 9b0be79fc15e..3ff1ac5e07f1 100644
--- a/Documentation/driver-api/tty/tty_ioctl.rst
+++ b/Documentation/driver-api/tty/tty_ioctl.rst
@@ -5,3 +5,6 @@ TTY IOCTL Helpers
 =================
 
 .. kernel-doc:: drivers/tty/tty_ioctl.c
+
+.. kernel-doc:: include/linux/tty.h
+   :identifiers: tty_get_baud_rate
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 59d675f345e9..4b6340ac2af2 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -390,14 +390,12 @@ int vcs_init(void);
 extern const struct class tty_class;
 
 /**
- *	tty_kref_get		-	get a tty reference
- *	@tty: tty device
+ * tty_kref_get - get a tty reference
+ * @tty: tty device
  *
- *	Return a new reference to a tty object. The caller must hold
- *	sufficient locks/counts to ensure that their existing reference cannot
- *	go away
+ * Returns: a new reference to a tty object. The caller must hold sufficient
+ * locks/counts to ensure that their existing reference cannot go away
  */
-
 static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 {
 	if (tty)
@@ -435,14 +433,13 @@ void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
 		speed_t obaud);
 
 /**
- *	tty_get_baud_rate	-	get tty bit rates
- *	@tty: tty to query
+ * tty_get_baud_rate - get tty bit rates
+ * @tty: tty to query
  *
- *	Returns the baud rate as an integer for this terminal. The
- *	termios lock must be held by the caller and the terminal bit
- *	flags may be updated.
+ * Returns: the baud rate as an integer for this terminal. The termios lock
+ * must be held by the caller and the terminal bit flags may be updated.
  *
- *	Locking: none
+ * Locking: none
  */
 static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 {
-- 
2.42.0

