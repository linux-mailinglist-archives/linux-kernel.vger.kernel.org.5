Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C772E8066CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376760AbjLFFzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376643AbjLFFzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:55:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F151BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cve8B6slllsHbzs7scFf7ow6SwDdgTLgILnKqEnvrds=; b=YnMQR4dL0al69+lHcV1w4uAIQw
        omEm+YIyLr9Y8Shy9Kvh6v4Df0ETFWZqk2Y81V380dgm/bSbKYIe6CurIcJU1+xJ84KAb8lkCFHO7
        75MGdLRwcoVFpqUQsLB/gTB56J4uzUyTm7/psmDxgGwC36WFvVLiXJsZshr/wfcaFa4xA661fi03E
        J0g6RqpYn9vNOfF39hpG1tA6CwHOyMhWSZ0WdPhFyhM7+VD7K5HdnlJDvxe3EgjZQ/1spk1vshOp5
        /aMo1p4w1Y+Akb1uzMjzS0jYbT+WSoxmYt3v8V11gHxEbOcdlkYhATX1P3eXvDtSWOjB//XLvC89d
        a3+I0vwg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAksb-0098YF-1T;
        Wed, 06 Dec 2023 05:55:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] intel_th: msu: fix kernel-doc warnings
Date:   Tue,  5 Dec 2023 21:55:28 -0800
Message-ID: <20231206055528.10176-1-rdunlap@infradead.org>
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

msu.c:77: warning: Function parameter or member 'msc' not described in 'msc_window'
msu.c:122: warning: bad line: 
msu.c:760: warning: No description found for return value of 'msc_configure'
msu.c:1309: warning: Function parameter or member 'nr_pages' not described in 'msc_buffer_alloc'
msu.c:1309: warning: Function parameter or member 'nr_wins' not described in 'msc_buffer_alloc'
msu.c:1309: warning: Excess function parameter 'size' description in 'msc_buffer_alloc'
msu.c:1376: warning: No description found for return value of 'msc_buffer_free_unless_used'
msu.c:1444: warning: No description found for return value of 'msc_win_to_user'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -- a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -61,6 +61,7 @@ enum lockout_state {
  * @lo_lock:	lockout state serialization
  * @nr_blocks:	number of blocks (pages) in this window
  * @nr_segs:	number of segments in this window (<= @nr_blocks)
+ * @msc:	pointer to the MSC device
  * @_sgt:	array of block descriptors
  * @sgt:	array of block descriptors
  */
@@ -119,7 +120,6 @@ struct msc_iter {
  * @user_count:		number of users of the buffer
  * @mmap_count:		number of mappings
  * @buf_mutex:		mutex to serialize access to buffer-related bits
-
  * @enabled:		MSC is enabled
  * @wrap:		wrapping is enabled
  * @mode:		MSC operating mode
@@ -755,6 +755,8 @@ unlock:
  * Program storage mode, wrapping, burst length and trace buffer address
  * into a given MSC. Then, enable tracing and set msc::enabled.
  * The latter is serialized on msc::buf_mutex, so make sure to hold it.
+ *
+ * Returns: %0 for success or a negative error code otherwise.
  */
 static int msc_configure(struct msc *msc)
 {
@@ -1291,7 +1293,8 @@ static void msc_buffer_free(struct msc *
 /**
  * msc_buffer_alloc() - allocate a buffer for MSC
  * @msc:	MSC device
- * @size:	allocation size in bytes
+ * @nr_pages:	number of pages for each window
+ * @nr_wins:	number of windows
  *
  * Allocate a storage buffer for MSC, depending on the msc::mode, it will be
  * either done via msc_buffer_contig_alloc() for SINGLE operation mode or
@@ -1370,6 +1373,9 @@ static int msc_buffer_unlocked_free_unle
  * @msc:	MSC device
  *
  * This is a locked version of msc_buffer_unlocked_free_unless_used().
+ *
+ * Return:	0 on successful deallocation or if there was no buffer to
+ *		deallocate, -EBUSY if there are active users.
  */
 static int msc_buffer_free_unless_used(struct msc *msc)
 {
@@ -1438,6 +1444,8 @@ struct msc_win_to_user_struct {
  * @data:	callback's private data
  * @src:	source buffer
  * @len:	amount of data to copy from the source buffer
+ *
+ * Returns: >= %0 for success or -errno for error.
  */
 static unsigned long msc_win_to_user(void *data, void *src, size_t len)
 {
