Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3F8066CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376754AbjLFFyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376643AbjLFFyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:54:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A288018F;
        Tue,  5 Dec 2023 21:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BAXtbSw9W5xw6W6eD0JYuFWJgJP0GI7JxlqByr7InSw=; b=sZDfgOyKcv2BfxqKTOQXpWJnTB
        7buDvIU661JK49ilVMJe5FE694qfTCliNAUbznjJQdWGCNiGVLAirxbl2P9bF6Zj1Zg878isXW1cQ
        fuM4/ZAb5DFr6nrISqAIOWTpbTfJgjoOv+h9hVwxZSL14Qh09oGT9B7qJFyZLa4NOP4UBx+g3y69B
        B3uSOV0+1JvYWcCnm/XPvaIzo62UNv/nVJnx3mjiibOGLm8PtUKqOg2Z6Jw2deijbvNneqKYAuRJY
        5SkYgsNOmuVWvCCzmpuwNZbNfyAO2ZvJCdY0GhiRFb5Ux+4kqFc4zmCH1lqUUhyzxT0wAeSw/THP5
        ZgY2mNdg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAkro-0098PV-1M;
        Wed, 06 Dec 2023 05:54:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH] hwspinlock/core: fix kernel-doc warnings
Date:   Tue,  5 Dec 2023 21:54:39 -0800
Message-ID: <20231206055439.671-1-rdunlap@infradead.org>
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

Correct function comments to prevent kernel-doc warnings
found when using "W=1".

hwspinlock_core.c:208: warning: Excess function parameter 'timeout' description in '__hwspin_lock_timeout'
hwspinlock_core.c:318: warning: Excess function parameter 'bank' description in 'of_hwspin_lock_simple_xlate'
hwspinlock_core.c:647: warning: Function parameter or member 'hwlock' not described in '__hwspin_lock_request'

and 17 warnings like:
hwspinlock_core.c:487: warning: No description found for return value of 'hwspin_lock_register'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: linux-remoteproc@vger.kernel.org
---
 drivers/hwspinlock/hwspinlock_core.c |   53 +++++++++++++------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff -- a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -84,8 +84,9 @@ static DEFINE_MUTEX(hwspinlock_tree_lock
  * should decide between spin_trylock, spin_trylock_irq and
  * spin_trylock_irqsave.
  *
- * Returns 0 if we successfully locked the hwspinlock or -EBUSY if
+ * Returns: %0 if we successfully locked the hwspinlock or -EBUSY if
  * the hwspinlock was already taken.
+ *
  * This function will never sleep.
  */
 int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
@@ -171,7 +172,7 @@ EXPORT_SYMBOL_GPL(__hwspin_trylock);
 /**
  * __hwspin_lock_timeout() - lock an hwspinlock with timeout limit
  * @hwlock: the hwspinlock to be locked
- * @timeout: timeout value in msecs
+ * @to: timeout value in msecs
  * @mode: mode which controls whether local interrupts are disabled or not
  * @flags: a pointer to where the caller's interrupt state will be saved at (if
  *         requested)
@@ -199,9 +200,11 @@ EXPORT_SYMBOL_GPL(__hwspin_trylock);
  * to choose the appropriate @mode of operation, exactly the same way users
  * should decide between spin_lock, spin_lock_irq and spin_lock_irqsave.
  *
- * Returns 0 when the @hwlock was successfully taken, and an appropriate
+ * Returns: %0 when the @hwlock was successfully taken, and an appropriate
  * error code otherwise (most notably -ETIMEDOUT if the @hwlock is still
- * busy after @timeout msecs). The function will never sleep.
+ * busy after @timeout msecs).
+ *
+ * The function will never sleep.
  */
 int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int to,
 					int mode, unsigned long *flags)
@@ -304,13 +307,12 @@ EXPORT_SYMBOL_GPL(__hwspin_unlock);
 
 /**
  * of_hwspin_lock_simple_xlate - translate hwlock_spec to return a lock id
- * @bank: the hwspinlock device bank
  * @hwlock_spec: hwlock specifier as found in the device tree
  *
  * This is a simple translation function, suitable for hwspinlock platform
  * drivers that only has a lock specifier length of 1.
  *
- * Returns a relative index of the lock within a specified bank on success,
+ * Returns: a relative index of the lock within a specified bank on success,
  * or -EINVAL on invalid specifier cell count.
  */
 static inline int
@@ -332,9 +334,10 @@ of_hwspin_lock_simple_xlate(const struct
  * hwspinlock device, so that it can be requested using the normal
  * hwspin_lock_request_specific() API.
  *
- * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
- * device is not yet registered, -EINVAL on invalid args specifier value or an
- * appropriate error as returned from the OF parsing of the DT client node.
+ * Returns: the global lock id number on success, -EPROBE_DEFER if the
+ * hwspinlock device is not yet registered, -EINVAL on invalid args
+ * specifier value or an appropriate error as returned from the OF parsing
+ * of the DT client node.
  */
 int of_hwspin_lock_get_id(struct device_node *np, int index)
 {
@@ -399,9 +402,10 @@ EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id)
  * the hwspinlock device, so that it can be requested using the normal
  * hwspin_lock_request_specific() API.
  *
- * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
- * device is not yet registered, -EINVAL on invalid args specifier value or an
- * appropriate error as returned from the OF parsing of the DT client node.
+ * Returns: the global lock id number on success, -EPROBE_DEFER if the
+ * hwspinlock device is not yet registered, -EINVAL on invalid args
+ * specifier value or an appropriate error as returned from the OF parsing
+ * of the DT client node.
  */
 int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
 {
@@ -481,7 +485,7 @@ out:
  *
  * Should be called from a process context (might sleep)
  *
- * Returns 0 on success, or an appropriate error code on failure
+ * Returns: %0 on success, or an appropriate error code on failure
  */
 int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 		const struct hwspinlock_ops *ops, int base_id, int num_locks)
@@ -529,7 +533,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_register);
  *
  * Should be called from a process context (might sleep)
  *
- * Returns 0 on success, or an appropriate error code on failure
+ * Returns: %0 on success, or an appropriate error code on failure
  */
 int hwspin_lock_unregister(struct hwspinlock_device *bank)
 {
@@ -578,7 +582,7 @@ static int devm_hwspin_lock_device_match
  *
  * Should be called from a process context (might sleep)
  *
- * Returns 0 on success, or an appropriate error code on failure
+ * Returns: %0 on success, or an appropriate error code on failure
  */
 int devm_hwspin_lock_unregister(struct device *dev,
 				struct hwspinlock_device *bank)
@@ -607,7 +611,7 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_unreg
  *
  * Should be called from a process context (might sleep)
  *
- * Returns 0 on success, or an appropriate error code on failure
+ * Returns: %0 on success, or an appropriate error code on failure
  */
 int devm_hwspin_lock_register(struct device *dev,
 			      struct hwspinlock_device *bank,
@@ -635,12 +639,13 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_regis
 
 /**
  * __hwspin_lock_request() - tag an hwspinlock as used and power it up
+ * @hwlock: the target hwspinlock
  *
  * This is an internal function that prepares an hwspinlock instance
  * before it is given to the user. The function assumes that
  * hwspinlock_tree_lock is taken.
  *
- * Returns 0 or positive to indicate success, and a negative value to
+ * Returns: %0 or positive to indicate success, and a negative value to
  * indicate an error (with the appropriate error code)
  */
 static int __hwspin_lock_request(struct hwspinlock *hwlock)
@@ -680,7 +685,7 @@ static int __hwspin_lock_request(struct
  * hwspin_lock_get_id() - retrieve id number of a given hwspinlock
  * @hwlock: a valid hwspinlock instance
  *
- * Returns the id number of a given @hwlock, or -EINVAL if @hwlock is invalid.
+ * Returns: the id number of a given @hwlock, or -EINVAL if @hwlock is invalid.
  */
 int hwspin_lock_get_id(struct hwspinlock *hwlock)
 {
@@ -704,7 +709,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_get_id);
  *
  * Should be called from a process context (might sleep)
  *
- * Returns the address of the assigned hwspinlock, or NULL on error
+ * Returns: the address of the assigned hwspinlock, or %NULL on error
  */
 struct hwspinlock *hwspin_lock_request(void)
 {
@@ -747,7 +752,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_request);
  *
  * Should be called from a process context (might sleep)
  *
- * Returns the address of the assigned hwspinlock, or NULL on error
+ * Returns: the address of the assigned hwspinlock, or %NULL on error
  */
 struct hwspinlock *hwspin_lock_request_specific(unsigned int id)
 {
@@ -795,7 +800,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_request_sp
  *
  * Should be called from a process context (might sleep)
  *
- * Returns 0 on success, or an appropriate error code on failure
+ * Returns: %0 on success, or an appropriate error code on failure
  */
 int hwspin_lock_free(struct hwspinlock *hwlock)
 {
@@ -865,7 +870,7 @@ static void devm_hwspin_lock_release(str
  *
  * Should be called from a process context (might sleep)
  *
- * Returns 0 on success, or an appropriate error code on failure
+ * Returns: %0 on success, or an appropriate error code on failure
  */
 int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock)
 {
@@ -891,7 +896,7 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_free)
  *
  * Should be called from a process context (might sleep)
  *
- * Returns the address of the assigned hwspinlock, or NULL on error
+ * Returns: the address of the assigned hwspinlock, or %NULL on error
  */
 struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
 {
@@ -926,7 +931,7 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_reque
  *
  * Should be called from a process context (might sleep)
  *
- * Returns the address of the assigned hwspinlock, or NULL on error
+ * Returns: the address of the assigned hwspinlock, or %NULL on error
  */
 struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
 						     unsigned int id)
