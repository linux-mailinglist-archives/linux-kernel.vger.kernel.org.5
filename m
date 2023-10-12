Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D937C630D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbjJLCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347029AbjJLCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91416B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qmlUn/f3e8UXJAuEhnJXHHHbWqPpc8bMN+0dzccnErM=; b=zm2Mwrc3+RHACLCl5aF1CcKVuy
        zxSSPNlWJsGir9wRV11lZIJ+qZNSa3YbrXZFZKohDTgYLDaAF9XPeSqeDIAfUqShsY2aYsXAayxJZ
        QHDGxRVve4iQIhvgGy3O+NMVS4TgPAwKHGRnhaN/sg88VAM70/ZExBlcTIA70jQJphYXpxhohVfDE
        3S8JrrfMycCxA2+Zrg0Z996KFxwyowlrLc1pRiBA2rD+WWFzj8G+smrOeMxGR9rJIvA382DPaAykk
        d7fGeC/A+oS5tTmr64UJs081pBY9WQ6H/BeJ0CWbZsY9WumEHmbQKbdcwQrvqzSVATcjJj60gPUnK
        IS3Ouqsg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkm-00HDiv-1K;
        Thu, 12 Oct 2023 02:48:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/7] misc: mei: dma-ring.c: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:41 -0700
Message-ID: <20231012024845.29169-4-rdunlap@infradead.org>
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

Fix kernel-doc warnings in dma-ring.c:

dma-ring.c:130: warning: No description found for return value of 'mei_dma_copy_from'
dma-ring.c:150: warning: No description found for return value of 'mei_dma_copy_to'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/dma-ring.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -- a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -124,6 +124,8 @@ void mei_dma_ring_reset(struct mei_devic
  * @buf: data buffer
  * @offset: offset in slots.
  * @n: number of slots to copy.
+ *
+ * Return: number of bytes copied
  */
 static size_t mei_dma_copy_from(struct mei_device *dev, unsigned char *buf,
 				u32 offset, u32 n)
@@ -144,6 +146,8 @@ static size_t mei_dma_copy_from(struct m
  * @buf: data buffer
  * @offset: offset in slots.
  * @n: number of slots to copy.
+ *
+ * Return: number of bytes copied
  */
 static size_t mei_dma_copy_to(struct mei_device *dev, unsigned char *buf,
 			      u32 offset, u32 n)
