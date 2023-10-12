Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A417C6306
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJLCtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbjJLCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85EB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9IY1frtEC2rYJqSMRCt/naGt/cJcR9rRktWt5Wfg+dM=; b=Kr5uISvkejibDfd4bv+oLqUKK6
        uvWVOYjPFk/OGSGX5Me5KH+Lrk92yFZyirFVQwEw7Ee68oseHr4TveGT+5jrze0QLMlWusR/2ZU5g
        6DeMHECOMbANJG/P5stZJ/zR4rTxJfeakkaU8GsWHlq7Eas0CBgrgCbgpuiIIXjV1RPi2uQC21MrX
        FdEcHwc5MAiuiwtVFY9Jq1f1B8I9+6Eq3cc23yMY3NgsCtF2D8jp7tDSUpohkgi9XUC/b42vRrzCh
        a18NDi3AvqaxmQUFsW7VmXIMi7bnmVS/r1h9raC8IH1PeIlb1xyjbuwY0Gval91TQlK3Flua3ZWzl
        rG38OASA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkm-00HDiv-0f;
        Thu, 12 Oct 2023 02:48:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/7] misc: mei: client.c: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:40 -0700
Message-ID: <20231012024845.29169-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012024845.29169-1-rdunlap@infradead.org>
References: <20231012024845.29169-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in client.c:

client.c:53: warning: contents before sections
client.c:68: warning: contents before sections
client.c:334: warning: contents before sections
client.c:349: warning: contents before sections
client.c:364: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/client.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff -- a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -48,9 +48,9 @@ struct mei_me_client *mei_me_cl_get(stru
 /**
  * mei_me_cl_release - free me client
  *
- * Locking: called under "dev->device_lock" lock
- *
  * @ref: me_client refcount
+ *
+ * Locking: called under "dev->device_lock" lock
  */
 static void mei_me_cl_release(struct kref *ref)
 {
@@ -63,9 +63,9 @@ static void mei_me_cl_release(struct kre
 /**
  * mei_me_cl_put - decrease me client refcount and free client if necessary
  *
- * Locking: called under "dev->device_lock" lock
- *
  * @me_cl: me client
+ *
+ * Locking: called under "dev->device_lock" lock
  */
 void mei_me_cl_put(struct mei_me_client *me_cl)
 {
@@ -329,10 +329,10 @@ void mei_io_cb_free(struct mei_cl_cb *cb
 /**
  * mei_tx_cb_enqueue - queue tx callback
  *
- * Locking: called under "dev->device_lock" lock
- *
  * @cb: mei callback struct
  * @head: an instance of list to queue on
+ *
+ * Locking: called under "dev->device_lock" lock
  */
 static inline void mei_tx_cb_enqueue(struct mei_cl_cb *cb,
 				     struct list_head *head)
@@ -344,9 +344,9 @@ static inline void mei_tx_cb_enqueue(str
 /**
  * mei_tx_cb_dequeue - dequeue tx callback
  *
- * Locking: called under "dev->device_lock" lock
- *
  * @cb: mei callback struct to dequeue and free
+ *
+ * Locking: called under "dev->device_lock" lock
  */
 static inline void mei_tx_cb_dequeue(struct mei_cl_cb *cb)
 {
@@ -359,10 +359,10 @@ static inline void mei_tx_cb_dequeue(str
 /**
  * mei_cl_set_read_by_fp - set pending_read flag to vtag struct for given fp
  *
- * Locking: called under "dev->device_lock" lock
- *
  * @cl: mei client
  * @fp: pointer to file structure
+ *
+ * Locking: called under "dev->device_lock" lock
  */
 static void mei_cl_set_read_by_fp(const struct mei_cl *cl,
 				  const struct file *fp)
