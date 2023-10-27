Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAC7D954A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjJ0KeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0KeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:34:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145C18A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:34:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40839652b97so13910285e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698402839; x=1699007639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUKyf7v2Vpql9dyi+ajoLVLsPQFQmhMH2gCSqdsIfVw=;
        b=VkdpVUEd7dVwVaAYoXanWqLvbAuPqvpwA9yaCnXE7FK7Jdo8hyn+kz/Jb6wildxt95
         1VzDoqNi4vT/31FgYfhx848HTRnnEtY/9llw9A0wK7swfrq8Yu0BnyGozuaP8/VPoiM+
         oefdvNuQ13HFPcQbcR1AgGR6TfKg5vcCeWJdAe7azcT5U5HtSp5WqaCVLFv1zVmUcW7j
         htfB7pgBjA28Vokerxlo8HcTXH/cvSfqSDw4XfQ6BG9nB9zma9nvlRCyEwZhI3XlFHR1
         XU8fBsKRDsewBRKyDhqPFsTcFJttGRxKf3wzciQ/fW8Hb+Hr+xw0p9/OaA89vmVFUizH
         Emfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698402839; x=1699007639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUKyf7v2Vpql9dyi+ajoLVLsPQFQmhMH2gCSqdsIfVw=;
        b=CPKGVs7vpcvrD6/R8aAVUSLYX6Wdb8Km2xFLRd9aFGpU+G+pAGuIFzXN9DybgI7bkF
         DllBJHTzha+D5F4KlwrDYNgKg2Lwc9VMUsZ6mK35WL7At7bjM5AR40BnsDVGz3xTlVb1
         FiVrDllZDt7U33ztjNMy93p7DTVgK+OVNkp8uEOpDEAvVzaxTf/ChwiHn/qQGwWeJbc6
         SYIs8zoik2IHqsvRLOzMTQnhuLYwlw2X4Hgz1t14sFNvYff9lQJv1Vkeix+M6cxWV8dO
         +6ZL7LC+VunlGx4BTuITmShHYUA0LTaExxg08G0B/i4haVwUNLXkaaxOCcIf3VG2WZkj
         fYfg==
X-Gm-Message-State: AOJu0Yz7/EJ2rW8ABLZdUeddU97pXj1b+KwVt7kM858QHb1BKsyc9wp5
        1+lG4OHCcyLDZKvJ2sY3PZna1w==
X-Google-Smtp-Source: AGHT+IFxwiXJ/YgK8t7ooPxrejX4aG8RM4SgcUJ2/M4NBlywqSCH/rH+Qs6MDI0pVpa3tKWWH6uTgw==
X-Received: by 2002:a05:600c:1546:b0:3fe:4cbc:c345 with SMTP id f6-20020a05600c154600b003fe4cbcc345mr1990433wmg.41.1698402839177;
        Fri, 27 Oct 2023 03:33:59 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c130f00b003fbe4cecc3bsm4701804wmf.16.2023.10.27.03.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:33:58 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus/mp2975) Move PGOOD fix
Date:   Fri, 27 Oct 2023 10:33:52 +0000
Message-ID: <20231027103352.918895-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PGOOD fix was intended for MP2973 & MP2971 & not for MP2975.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 26ba50633100..b9bb469e2d8f 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -297,6 +297,11 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 	int ret;
 
 	switch (reg) {
+	case PMBUS_STATUS_WORD:
+		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		ret ^= PB_STATUS_POWER_GOOD_N;
+		break;
 	case PMBUS_OT_FAULT_LIMIT:
 		ret = mp2975_read_word_helper(client, page, phase, reg,
 					      GENMASK(7, 0));
@@ -380,11 +385,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
 	int ret;
 
 	switch (reg) {
-	case PMBUS_STATUS_WORD:
-		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
-		ret = pmbus_read_word_data(client, page, phase, reg);
-		ret ^= PB_STATUS_POWER_GOOD_N;
-		break;
 	case PMBUS_OT_FAULT_LIMIT:
 		ret = mp2975_read_word_helper(client, page, phase, reg,
 					      GENMASK(7, 0));

base-commit: 5421af83a43bdcb646564fec238253d11009ad3f
-- 
2.41.0

