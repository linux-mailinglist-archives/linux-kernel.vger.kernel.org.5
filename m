Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A37BC7F1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbjJGNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJGNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:10:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D444FB6;
        Sat,  7 Oct 2023 06:10:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40535597f01so28024495e9.3;
        Sat, 07 Oct 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696684255; x=1697289055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JckiUdume8/244qoGkEzxCY5dVAABsvgSL01kRwzTpg=;
        b=QwxvqicZggpuwNM75/jGjk3fHA3Hx7R5gUo5KUdfuWY7oP3oIdiZ6hSZShIlZe/i+L
         lK0L+HRxQQjlsCfRhmh1hR6uKbisxRrdLkOBYF4f1gqtD8EUOvqn2IVj5oAsPQe99zGY
         W+ldEt4nlA9NB9Y58mUfbUPMhtc8uv7HY0EZBVPR+Wv5cdvhAeKeafGzwgnK5BVe8zGD
         bsZZG4jbNVWhJzX7B3qhzmGNTgQRmnrhbG/BMCBx4hYQnUzcyE0SxvNPJL3oTQAWBeyL
         KCB8u8jvFmy0Us929j+ka/nha0Ii6a24XY2mu8Furelpjg6f1/5gxXYbjqIB6FEsyQb9
         gJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696684255; x=1697289055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JckiUdume8/244qoGkEzxCY5dVAABsvgSL01kRwzTpg=;
        b=Hgt6GRVcb576J5JnjKvAH9S4CcZ/ywxhfvQQB3SMLeji7OYFhCHlyHug/9z29ry+Ab
         lh6iBEJUTdizr4j3zQiltCKhBctLGKB4qsoR7U0yeAHvZXp9NFhkYZdn7szQgz96FtwG
         Q/KL5D0LFvlWKxePJHuTiXeY+t9G4Q0FKZY8E2fAp5MRZ+OPRJiHqSuZtZvDugZhhDIk
         JrfdrxErZ6N699i71Xd0dyaf6Q7PfE95CcT6SchYpVZN62YYaEQjM8X/ld1K3SvGNVjn
         amRThEqcDr7HQqmIEaJqLxid4ohW7Tlwa5gCzpDTGe42oeU9uBnxYctDDO4CapsGF2Xx
         uplA==
X-Gm-Message-State: AOJu0Yxyb6npuhisaSSB1OR60V89l1esz4W0FWdMg7KK+2g+IFHlkuyG
        fxJexrhkQg3NXb7af4PAib0=
X-Google-Smtp-Source: AGHT+IHLkfk9ITx4gK1tDu0r7cmJuMEf4/dyDkcAuowsCwxPpMICDJ8fKG+kvks9164B/5egGGr3dA==
X-Received: by 2002:a1c:7407:0:b0:401:c338:ab94 with SMTP id p7-20020a1c7407000000b00401c338ab94mr9969808wmc.29.1696684254888;
        Sat, 07 Oct 2023 06:10:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v10-20020a05600c470a00b00407460234f9sm513922wmo.21.2023.10.07.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 06:10:54 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [net PATCH] leds: trigger: netdev: move size check in set_device_name
Date:   Sat,  7 Oct 2023 15:10:42 +0200
Message-Id: <20231007131042.15032-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 13.2 complains about array subscript 17 is above array bounds of
'char[16]' with IFNAMSIZ set to 16.

The warning is correct but this scenario is impossible.
set_device_name is called by device_name_store (store sysfs entry) and
netdev_trig_activate.

device_name_store already check if size is >= of IFNAMSIZ and return
-EINVAL. (making the warning scenario impossible)

netdev_trig_activate works on already defined interface, where the name
has already been checked and should already follow the condition of
strlen() < IFNAMSIZ.

Aside from the scenario being impossible, set_device_name can be
improved to both mute the warning and make the function safer.
To make it safer, move size check from device_name_store directly to
set_device_name and prevent any out of bounds scenario.

Cc: stable@vger.kernel.org
Fixes: 28a6a2ef18ad ("leds: trigger: netdev: refactor code setting device name")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309192035.GTJEEbem-lkp@intel.com/
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 58f3352539e8..e358e77e4b38 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -221,6 +221,9 @@ static ssize_t device_name_show(struct device *dev,
 static int set_device_name(struct led_netdev_data *trigger_data,
 			   const char *name, size_t size)
 {
+	if (size >= IFNAMSIZ)
+		return -EINVAL;
+
 	cancel_delayed_work_sync(&trigger_data->work);
 
 	mutex_lock(&trigger_data->lock);
@@ -263,9 +266,6 @@ static ssize_t device_name_store(struct device *dev,
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	int ret;
 
-	if (size >= IFNAMSIZ)
-		return -EINVAL;
-
 	ret = set_device_name(trigger_data, buf, size);
 
 	if (ret < 0)
-- 
2.40.1

