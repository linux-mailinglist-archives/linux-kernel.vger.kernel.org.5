Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7E798240
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjIHGSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjIHGSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:18:42 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 23:18:37 PDT
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3491990;
        Thu,  7 Sep 2023 23:18:36 -0700 (PDT)
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id DFZ00129;
        Fri, 08 Sep 2023 14:17:29 +0800
Received: from localhost.localdomain (10.94.3.99) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:17:28 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] tty: hvc: remove set but unused variable
Date:   Fri, 8 Sep 2023 02:17:26 -0400
Message-ID: <20230908061726.2641-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.3.99]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid:   202390814172939ff660740f7c538239454b4c8871133
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable vdev in hvcs_destruct_port() is set
but not used. Remove the variable and related code.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/tty/hvc/hvcs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index d29fdfe9d93d..b537d1fb67d4 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -664,7 +664,6 @@ static void hvcs_return_index(int index)
 static void hvcs_destruct_port(struct tty_port *p)
 {
 	struct hvcs_struct *hvcsd = container_of(p, struct hvcs_struct, port);
-	struct vio_dev *vdev;
 	struct completion *comp;
 	unsigned long flags;
 
@@ -686,7 +685,6 @@ static void hvcs_destruct_port(struct tty_port *p)
 	printk(KERN_INFO "HVCS: Destroyed hvcs_struct for vty-server@%X.\n",
 			hvcsd->vdev->unit_address);
 
-	vdev = hvcsd->vdev;
 	hvcsd->vdev = NULL;
 
 	hvcsd->p_unit_address = 0;
-- 
2.27.0

