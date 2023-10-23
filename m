Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E37D42FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjJWXA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJWXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:00:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF02ED6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aJiESMjjEjNQPs1ZAJsVANKwy/33mcSwku5Li2utrDk=; b=Xb/V7kPsrwNQrH9FYK0R940atT
        AhC8GjfBt6EfQ5/AMPdVcm9AwgVFT8cFLZOoIq6Wh/enXTUkuZHZMZ3iUDJAhF3vr0E+tMSpJ2bMg
        RvcvhcLCuCoH0QwXBP4upF9R54G8IsBXu8i0tGNpkGj1r3RgF1HwuV4aOa/wJJrdoM7n+j0KX1Nq0
        dCRab9ZDfKy7KNt28zTT3K/Wsq8bH2SDZ6gWbY17kSKIfglNHr0gpV+ZW/t4AcSZ5tWirmX6NFALJ
        xMUXIezjCn8no4R8NOpbV3e3jKs9tmxx+RPJFrae+EZrOsehlWs0nqBFFVNEXwc4Vav4zuEq6vdbB
        DAWhLyPQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qv3um-008Pw5-2t;
        Mon, 23 Oct 2023 23:00:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-keyring: add MODULE_LICENSE()
Date:   Mon, 23 Oct 2023 16:00:52 -0700
Message-ID: <20231023230052.31161-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NVME_KEYRING=y (NVME_AUTH is not set), there is a modpost build
error:

ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o

so add a MODULE_LICENSE() to keyring.c (copied from auth.c).

Fixes: 9d77eb527784 ("nvme-keyring: register '.nvme' keyring")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
---
 drivers/nvme/common/keyring.c |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -180,3 +180,5 @@ void nvme_keyring_exit(void)
 	key_put(nvme_keyring);
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_exit);
+
+MODULE_LICENSE("GPL v2");
