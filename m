Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717D27C6308
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376833AbjJLCtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjJLCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF2C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oWmEAALGtzray4g5L/dvD0KU1ECIZ68qt/wD69rhLLk=; b=YmdNrae678FNL0fp2me8DmbG8D
        atkGeY1TuzTciLC/M6riWdU7KxM64V0DjCe2SnesyF3hny4x6f2x93PP8p7LJbuOFtLfnrQUsWfPA
        rcCjtA9MXFZ3UMJ1pPcHsPNtgN7ZaRX7cLqPcqmvDoLgx0dE11CyM+sW6gu8Icm1cyv+HPYc3vyvs
        QsdJsWw3WSR/bhCItS2H1WnXGJ0fBQNXtJLPBt3WH+ujc5gEkXILVX44MRa2gjJ7VFVZ0l6Xl9Nc/
        meCaC0tmx9ocILeRLvM+5SHrlFRKY7cjecQ35uA19N85NXshBaLq9nCokEBMKWStIm8oxgAzHVMu4
        p+vcL2/Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkn-00HDiv-0n;
        Thu, 12 Oct 2023 02:48:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/7] misc: mei: main.c: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:45 -0700
Message-ID: <20231012024845.29169-8-rdunlap@infradead.org>
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

Fix kernel-doc warnings in main.c:

main.c:465: warning: contents before sections
main.c:590: warning: missing initial short description on line:
 * mei_ioctl_client_notify_request -

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -460,11 +460,11 @@ end:
 /**
  * mei_vt_support_check - check if client support vtags
  *
- * Locking: called under "dev->device_lock" lock
- *
  * @dev: mei_device
  * @uuid: client UUID
  *
+ * Locking: called under "dev->device_lock" lock
+ *
  * Return:
  *	0 - supported
  *	-ENOTTY - no such client
@@ -587,8 +587,8 @@ static int mei_ioctl_connect_vtag(struct
 }
 
 /**
- * mei_ioctl_client_notify_request -
- *     propagate event notification request to client
+ * mei_ioctl_client_notify_request - propagate event notification
+ *                                   request to client
  *
  * @file: pointer to file structure
  * @request: 0 - disable, 1 - enable
