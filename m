Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C97AE316
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjIZAwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIZAwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:52:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124DB3;
        Mon, 25 Sep 2023 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=u1nU5JLGvirz2IB1v8ZoAM3OrG2Ec5+6zeDs75GvXlo=; b=n+uSFqIe00KUc/NH7EKJ6RAJCB
        trpwtKivX/CEPUqw7AcIJ2FtwgHP1JE9hD5nKie9TWqiPD1gofUOxumZ3VWerVrbj3gJHK/iMzb5N
        UTYHDXSVWN5tj7D1CRfPtHV+2c7VF3MLiuQ33XwbR6ELgLb17BN6jvng6jD28Sumf+7JnzPrTFyQp
        cTqFFiuKheQDyVB40ARB2afa8fD2nVqos13HRJZAdv/3ukBEq33mIQIMp5rrSZOKFOJjru8DwYfYw
        2cznmEf1yJv6wpqJqH9sL6kHkkhQvLbgghHp3Swa7erE0prMcOIwnGPxGA3d4JMt+6ZeT95RkwjZh
        F0B99HoA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkwJV-00FJe6-0U;
        Tue, 26 Sep 2023 00:52:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: fix kernel-doc for disk_force_media_change()
Date:   Mon, 25 Sep 2023 17:52:32 -0700
Message-ID: <20230926005232.23666-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

Drop one function parameter's kernel-doc comment since the parameter
was removed. This prevents a kernel-doc warning:

block/disk-events.c:300: warning: Excess function parameter 'events' description in 'disk_force_media_change'

Fixes: ab6860f62bfe ("block: simplify the disk_force_media_change interface")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309060957.vfl0mUur-lkp@intel.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/disk-events.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/block/disk-events.c b/block/disk-events.c
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -290,7 +290,6 @@ EXPORT_SYMBOL(disk_check_media_change);
 /**
  * disk_force_media_change - force a media change event
  * @disk: the disk which will raise the event
- * @events: the events to raise
  *
  * Should be called when the media changes for @disk.  Generates a uevent
  * and attempts to free all dentries and inodes and invalidates all block
