Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6F7C630B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbjJLCtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347034AbjJLCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F76BA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Dn9zCcvrcxqpmwWd8vgmyiOH+lNjJ7UYM9Um5cJkFUc=; b=Dmc1dCSAj9y4yj18SrmRTBq5DX
        QyQgL9ZcjrfABJ2mJhXR55d7MjfpBZLI0Z9IYQ1EdineFmwnZrfJEgbqZ1JcUwnwTTNZdxG5zKzIp
        NC02PoJBvDRgnHl7cvLD6MBdFqh/KevDaw7n56YS/gKJhDHceEANfRdhwQICGmP+rbWqA7QW/zMdk
        jlOCXF6JBqXseT7ocQR2CphbizutlWw4aOU6hEqtkgm2LfKzY+EuuNp4LSONnzhQ85otJ31w1q7ci
        OZj/mXKC3HGP2K1RbdyaxJjfojrgX4f6dy9bcXwq8dMvH9EvI3d1bxQnJrHfHqILjf11WlQYdNV0V
        bqvmA6fw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqlkm-00HDiv-2e;
        Thu, 12 Oct 2023 02:48:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/7] misc: mei: hw-me.c: fix kernel-doc warnings
Date:   Wed, 11 Oct 2023 19:48:43 -0700
Message-ID: <20231012024845.29169-6-rdunlap@infradead.org>
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

Fix kernel-doc warnings in hw-me.c:

hw-me.c:1391: warning: contents before sections
hw-me.c:1475: warning: contents before sections
hw-me.c:1501: warning: contents before sections
hw-me.c:1525: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/hw-me.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1379,6 +1379,8 @@ EXPORT_SYMBOL_GPL(mei_me_irq_thread_hand
 /**
  * mei_me_polling_thread - interrupt register polling thread
  *
+ * @_dev: mei device
+ *
  * The thread monitors the interrupt source register and calls
  * mei_me_irq_thread_handler() to handle the firmware
  * input.
@@ -1388,8 +1390,6 @@ EXPORT_SYMBOL_GPL(mei_me_irq_thread_hand
  * time increases yet again by MEI_POLLING_TIMEOUT_ACTIVE
  * up to MEI_POLLING_TIMEOUT_IDLE.
  *
- * @_dev: mei device
- *
  * Return: always 0
  */
 int mei_me_polling_thread(void *_dev)
@@ -1468,12 +1468,12 @@ static const struct mei_hw_ops mei_me_hw
 /**
  * mei_me_fw_type_nm() - check for nm sku
  *
+ * @pdev: pci device
+ *
  * Read ME FW Status register to check for the Node Manager (NM) Firmware.
  * The NM FW is only signaled in PCI function 0.
  * __Note__: Deprecated by PCH8 and newer.
  *
- * @pdev: pci device
- *
  * Return: true in case of NM firmware
  */
 static bool mei_me_fw_type_nm(const struct pci_dev *pdev)
@@ -1494,12 +1494,12 @@ static bool mei_me_fw_type_nm(const stru
 /**
  * mei_me_fw_type_sps_4() - check for sps 4.0 sku
  *
+ * @pdev: pci device
+ *
  * Read ME FW Status register to check for SPS Firmware.
  * The SPS FW is only signaled in the PCI function 0.
  * __Note__: Deprecated by SPS 5.0 and newer.
  *
- * @pdev: pci device
- *
  * Return: true in case of SPS firmware
  */
 static bool mei_me_fw_type_sps_4(const struct pci_dev *pdev)
@@ -1519,11 +1519,11 @@ static bool mei_me_fw_type_sps_4(const s
 /**
  * mei_me_fw_type_sps_ign() - check for sps or ign sku
  *
+ * @pdev: pci device
+ *
  * Read ME FW Status register to check for SPS or IGN Firmware.
  * The SPS/IGN FW is only signaled in pci function 0
  *
- * @pdev: pci device
- *
  * Return: true in case of SPS/IGN firmware
  */
 static bool mei_me_fw_type_sps_ign(const struct pci_dev *pdev)
