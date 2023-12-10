Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2995680C075
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjLKEiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:38:10 -0500
X-Greylist: delayed 23613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Dec 2023 20:38:13 PST
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8713B3;
        Sun, 10 Dec 2023 20:38:13 -0800 (PST)
Received: from [2.211.185.227] (helo=marius.fritz.box)
        by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <mail@mariuszachmann.de>)
        id 1rCRug-003d73-0b;
        Sun, 10 Dec 2023 23:04:38 +0100
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     linux@roeck-us.net, mail@mariuszachmann.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] hwmon: corsair-cpro: use NULL instead of 0
Date:   Sun, 10 Dec 2023 23:03:57 +0100
Message-ID: <20231210220357.77036-1-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 2.211.185.227
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces the integer 0 with NULL.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100455.k6m2eO4N-lkp@intel.com/
Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
 drivers/hwmon/corsair-cpro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 463ab4296ede..a284a02839fb 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -524,7 +524,7 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret)
 		goto out_hw_close;
 	ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
-							 ccp, &ccp_chip_info, 0);
+							 ccp, &ccp_chip_info, NULL);
 	if (IS_ERR(ccp->hwmon_dev)) {
 		ret = PTR_ERR(ccp->hwmon_dev);
 		goto out_hw_close;
-- 
2.43.0

