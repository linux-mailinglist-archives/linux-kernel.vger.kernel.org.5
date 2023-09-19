Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7097A5D06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjISIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjISIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA219D;
        Tue, 19 Sep 2023 01:52:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89883C433C9;
        Tue, 19 Sep 2023 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113534;
        bh=G3gCJiOmLc01U11IngixSrlAJ5T2BkqMKoCNN6Iej6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QW8o2Lz3xSjnzRoX09EFwxqRFNjUFiMHvmjM8JgV1LR653FHwBZcrAu/Ywsk2gakV
         dtEWoCxZ9MNRQefme0/H/Geohv6YA6lvKa6q/rO6fJLaCYhNO58FexMIt/vEWX+2fK
         G/g/SgX2OrsMQvgKclrU5p4PcHWfiCb4SFTUyBliO8cF2KQ2HOSTAS1njT/4leAdcX
         nuZIwe/8faxNCAIGM9gNfTvWoCNoCMTnzpTLmgr7R6+yOYCK2C9J7AFo+0rIR710tH
         kAfoirEYVvpyc+lFcv3hCVbmeTMrETPNtpVgdyAbH8H6dpZloySd9fs2DorqKQ+Y53
         6dz+zn5d5kXjw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/15] tty: stop using ndash in kernel-doc
Date:   Tue, 19 Sep 2023 10:51:51 +0200
Message-ID: <20230919085156.1578-11-jirislaby@kernel.org>
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

An ndash used instead of a single dash renders a bullet to the result.
So use only single dashes in kernel-doc.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c        | 8 ++++----
 drivers/tty/tty_port.c      | 6 +++---
 drivers/tty/vt/consolemap.c | 2 +-
 drivers/tty/vt/vc_screen.c  | 4 ++--
 drivers/tty/vt/vt.c         | 4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..2ed12ca7c832 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3300,7 +3300,7 @@ void tty_unregister_device(struct tty_driver *driver, unsigned index)
 EXPORT_SYMBOL(tty_unregister_device);
 
 /**
- * __tty_alloc_driver -- allocate tty driver
+ * __tty_alloc_driver - allocate tty driver
  * @lines: count of lines this driver can handle at most
  * @owner: module which is responsible for this driver
  * @flags: some of %TTY_DRIVER_ flags, will be set in driver->flags
@@ -3393,7 +3393,7 @@ static void destruct_tty_driver(struct kref *kref)
 }
 
 /**
- * tty_driver_kref_put -- drop a reference to a tty driver
+ * tty_driver_kref_put - drop a reference to a tty driver
  * @driver: driver of which to drop the reference
  *
  * The final put will destroy and free up the driver.
@@ -3405,7 +3405,7 @@ void tty_driver_kref_put(struct tty_driver *driver)
 EXPORT_SYMBOL(tty_driver_kref_put);
 
 /**
- * tty_register_driver -- register a tty driver
+ * tty_register_driver - register a tty driver
  * @driver: driver to register
  *
  * Called by a tty driver to register itself.
@@ -3470,7 +3470,7 @@ int tty_register_driver(struct tty_driver *driver)
 EXPORT_SYMBOL(tty_register_driver);
 
 /**
- * tty_unregister_driver -- unregister a tty driver
+ * tty_unregister_driver - unregister a tty driver
  * @driver: driver to unregister
  *
  * Called by a tty driver to unregister itself.
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 624d104bd145..63c125250961 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -79,7 +79,7 @@ const struct tty_port_client_operations tty_port_default_client_ops = {
 EXPORT_SYMBOL_GPL(tty_port_default_client_ops);
 
 /**
- * tty_port_init -- initialize tty_port
+ * tty_port_init - initialize tty_port
  * @port: tty_port to initialize
  *
  * Initializes the state of struct tty_port. When a port was initialized using
@@ -267,7 +267,7 @@ void tty_port_free_xmit_buf(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
 
 /**
- * tty_port_destroy -- destroy inited port
+ * tty_port_destroy - destroy inited port
  * @port: tty port to be destroyed
  *
  * When a port was initialized using tty_port_init(), one has to destroy the
@@ -297,7 +297,7 @@ static void tty_port_destructor(struct kref *kref)
 }
 
 /**
- * tty_port_put -- drop a reference to tty_port
+ * tty_port_put - drop a reference to tty_port
  * @port: port to drop a reference of (can be NULL)
  *
  * The final put will destroy and free up the @port using
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index f02d21e2a96e..5e39a4f430ee 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -205,7 +205,7 @@ static enum translation_map inv_translate[MAX_NR_CONSOLES];
 				 FIELD_PREP(UNI_GLYPH_BITS, (glyph)))
 
 /**
- * struct uni_pagedict -- unicode directory
+ * struct uni_pagedict - unicode directory
  *
  * @uni_pgdir: 32*32*64 table with glyphs
  * @refcount: reference count of this structure
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 829c4be66f3b..99c8e39d91b4 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -174,7 +174,7 @@ vcs_poll_data_get(struct file *file)
 }
 
 /**
- * vcs_vc -- return VC for @inode
+ * vcs_vc - return VC for @inode
  * @inode: inode for which to return a VC
  * @viewed: returns whether this console is currently foreground (viewed)
  *
@@ -199,7 +199,7 @@ static struct vc_data *vcs_vc(struct inode *inode, bool *viewed)
 }
 
 /**
- * vcs_size -- return size for a VC in @vc
+ * vcs_size - return size for a VC in @vc
  * @vc: which VC
  * @attr: does it use attributes?
  * @unicode: is it unicode?
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c47f77804f0..f5004231cb6a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2588,7 +2588,7 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 
 
 /**
- * vc_sanitize_unicode -- Replace invalid Unicode code points with U+FFFD
+ * vc_sanitize_unicode - Replace invalid Unicode code points with U+FFFD
  * @c: the received character, or U+FFFD for invalid sequences.
  */
 static inline int vc_sanitize_unicode(const int c)
@@ -2600,7 +2600,7 @@ static inline int vc_sanitize_unicode(const int c)
 }
 
 /**
- * vc_translate_unicode -- Combine UTF-8 into Unicode in @vc_utf_char
+ * vc_translate_unicode - Combine UTF-8 into Unicode in @vc_utf_char
  * @vc: virtual console
  * @c: character to translate
  * @rescan: we return true if we need more (continuation) data
-- 
2.42.0

