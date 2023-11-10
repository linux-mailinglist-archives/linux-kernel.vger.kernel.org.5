Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540A07E816F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbjKJS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjKJSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:34 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A996FAC;
        Thu,  9 Nov 2023 22:26:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw3PLXK_1699595621;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vw3PLXK_1699595621)
          by smtp.aliyun-inc.com;
          Fri, 10 Nov 2023 13:53:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] hwmon: Fix some kernel-doc comments
Date:   Fri, 10 Nov 2023 13:53:41 +0800
Message-Id: <20231110055341.39939-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc comments to silence the warnings:
drivers/hwmon/sht4x.c:65: warning: Function parameter or member 'valid' not described in 'sht4x_data'
drivers/hwmon/sht4x.c:73: warning: Function parameter or member 'data' not described in 'sht4x_read_values'
drivers/hwmon/sht4x.c:73: warning: Excess function parameter 'sht4x_data' description in 'sht4x_read_values'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7220
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hwmon/sht4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index 7ee797410458..4883755d4b1e 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -49,6 +49,7 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
  * struct sht4x_data - All the data required to operate an SHT4X chip
  * @client: the i2c client associated with the SHT4X
  * @lock: a mutex that is used to prevent parallel access to the i2c client
+ * @valid: validity of fields below
  * @update_interval: the minimum poll interval
  * @last_updated: the previous time that the SHT4X was polled
  * @temperature: the latest temperature value received from the SHT4X
@@ -66,7 +67,7 @@ struct sht4x_data {
 
 /**
  * sht4x_read_values() - read and parse the raw data from the SHT4X
- * @sht4x_data: the struct sht4x_data to use for the lock
+ * @data: the struct sht4x_data to use for the lock
  * Return: 0 if successful, -ERRNO if not
  */
 static int sht4x_read_values(struct sht4x_data *data)
-- 
2.20.1.7.g153144c

