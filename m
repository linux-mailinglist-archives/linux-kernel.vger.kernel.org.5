Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1D7B55F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbjJBOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjJBOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:34:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC33DA;
        Mon,  2 Oct 2023 07:34:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50307acd445so25205431e87.0;
        Mon, 02 Oct 2023 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696257289; x=1696862089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUX/UAbHIqbeqOjhPaMPY2ZesCBPS6XxII45ueUUUxU=;
        b=RcuGWdgODKMiOXeKBrZ4CePp+NRdajcHrlP4geKPbz+2Sp7EaLBUSwhHShG7bQjKGd
         GXVF5hqRMEW3Kq+lC/1IOtWjXtM7GQ25oK+eth/hYzaexxMJG5J8jqq6yx0I8qNE1VE1
         wn/U6DHijfVNkVdzcbmfSLW24y27LeVQEaSa2i+k3hfChPpsw7yI5aozc7kKG7lPlWd0
         lCNRgZkca8HfgcgI+gmd0+UAH+iXsU9a7cMDJIe94iCqs6pvoS+ddiSD14POx3nwLhpj
         iURLf4Xf31SuovgjgiWFxS2qwMAtYPhjgsJtnRucYWFHrExmnwxUaiqoISJN4/FbJvqh
         wmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257289; x=1696862089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUX/UAbHIqbeqOjhPaMPY2ZesCBPS6XxII45ueUUUxU=;
        b=wG2e0zDewB3IJjdmTRSLP3hxojCLx1W3fxlWm9OxdSfXAuo9N6BeCQmvHWFm14NHWw
         lhj5v6Kg5i5VIaUegzkCg8WxPoMGtwf/T0YyDiOLp9G5BXEnLNrhBxyR02kibOfSrehs
         bVs3x2X6tCpewnpRDe3lo4N5dXKbqMuG5Ip9mOWkXI+2kbyKTQIs61Qx9PP6/VZgwD3i
         jBocIkTVyxF9n9b5dQ2/5HzXKhAbp6kYojADYvDuMzG7rHGEHlvSgUS1hXNzY7YEWEgS
         ORbd2f8QCL2pjyBXLHIkdGr4yzNMOqMml7mrwfECNgaDQntVBpNr312MeplQ2lNS9VZM
         avEQ==
X-Gm-Message-State: AOJu0Yw9ktIoxlF00Fc0irMBVlaiomcchGfrkayJwzm+Dundu9nJlYwc
        oCCueyfItjOXm4PIvlJ0jOA=
X-Google-Smtp-Source: AGHT+IFFib6n9jrm+nHoZvytjyHSN+70VADEvGNmOaCf1u5FFWF7V/F/NnfpLfgVEiBBD9N5rqibZw==
X-Received: by 2002:a05:6512:3ee:b0:502:d5b0:436e with SMTP id n14-20020a05651203ee00b00502d5b0436emr8234257lfq.62.1696257288937;
        Mon, 02 Oct 2023 07:34:48 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id e8-20020ac25468000000b004faa2de9877sm4751642lfn.286.2023.10.02.07.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:34:48 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au,
        matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 1/3] ipmi: Move KCS headers to common include folder
Date:   Mon,  2 Oct 2023 17:34:39 +0300
Message-Id: <20231002143441.545-2-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002143441.545-1-aladyshev22@gmail.com>
References: <20231002143441.545-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current KCS header files can be utilized by both IPMI drivers
(drivers/char/ipmi) and MCTP driver (drivers/net/mctp). To be able to
use them in both cases move the headers to 'include/linux' folder.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/char/ipmi/kcs_bmc.c                           | 8 +++-----
 drivers/char/ipmi/kcs_bmc_aspeed.c                    | 3 +--
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c                 | 2 +-
 drivers/char/ipmi/kcs_bmc_npcm7xx.c                   | 2 +-
 drivers/char/ipmi/kcs_bmc_serio.c                     | 2 +-
 {drivers/char/ipmi => include/linux}/kcs_bmc.h        | 0
 {drivers/char/ipmi => include/linux}/kcs_bmc_client.h | 3 +--
 {drivers/char/ipmi => include/linux}/kcs_bmc_device.h | 3 +--
 8 files changed, 9 insertions(+), 14 deletions(-)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc.h (100%)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc_client.h (97%)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc_device.h (96%)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 8b1161d5194a..d29a8505d6ed 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -5,15 +5,13 @@
  */
 
 #include <linux/device.h>
+#include <linux/kcs_bmc.h>
+#include <linux/kcs_bmc_client.h>
+#include <linux/kcs_bmc_device.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 
-#include "kcs_bmc.h"
-
-/* Implement both the device and client interfaces here */
-#include "kcs_bmc_device.h"
-#include "kcs_bmc_client.h"
 
 /* Record registered devices and drivers */
 static DEFINE_MUTEX(kcs_bmc_lock);
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 72640da55380..3dc0dfb448f5 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/kcs_bmc_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,8 +22,6 @@
 #include <linux/slab.h>
 #include <linux/timer.h>
 
-#include "kcs_bmc_device.h"
-
 
 #define DEVICE_NAME     "ast-kcs-bmc"
 
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index cf670e891966..bf1001130a6c 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/ipmi_bmc.h>
+#include <linux/kcs_bmc_client.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -17,7 +18,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-#include "kcs_bmc_client.h"
 
 /* Different phases of the KCS BMC module.
  *  KCS_PHASE_IDLE:
diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
index 7961fec56476..160553248a93 100644
--- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
+++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kcs_bmc_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -17,7 +18,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include "kcs_bmc_device.h"
 
 #define DEVICE_NAME	"npcm-kcs-bmc"
 #define KCS_CHANNEL_MAX	3
diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
index 1793358be782..24df7144a189 100644
--- a/drivers/char/ipmi/kcs_bmc_serio.c
+++ b/drivers/char/ipmi/kcs_bmc_serio.c
@@ -5,12 +5,12 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/list.h>
+#include <linux/kcs_bmc_client.h>
 #include <linux/module.h>
 #include <linux/sched/signal.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
 
-#include "kcs_bmc_client.h"
 
 struct kcs_bmc_serio {
 	struct list_head entry;
diff --git a/drivers/char/ipmi/kcs_bmc.h b/include/linux/kcs_bmc.h
similarity index 100%
rename from drivers/char/ipmi/kcs_bmc.h
rename to include/linux/kcs_bmc.h
diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/include/linux/kcs_bmc_client.h
similarity index 97%
rename from drivers/char/ipmi/kcs_bmc_client.h
rename to include/linux/kcs_bmc_client.h
index 6fdcde0a7169..f6350c9366dd 100644
--- a/drivers/char/ipmi/kcs_bmc_client.h
+++ b/include/linux/kcs_bmc_client.h
@@ -5,8 +5,7 @@
 #define __KCS_BMC_CONSUMER_H__
 
 #include <linux/irqreturn.h>
-
-#include "kcs_bmc.h"
+#include <linux/kcs_bmc.h>
 
 struct kcs_bmc_driver_ops {
 	int (*add_device)(struct kcs_bmc_device *kcs_bmc);
diff --git a/drivers/char/ipmi/kcs_bmc_device.h b/include/linux/kcs_bmc_device.h
similarity index 96%
rename from drivers/char/ipmi/kcs_bmc_device.h
rename to include/linux/kcs_bmc_device.h
index 17c572f25c54..65333b68c0af 100644
--- a/drivers/char/ipmi/kcs_bmc_device.h
+++ b/include/linux/kcs_bmc_device.h
@@ -5,8 +5,7 @@
 #define __KCS_BMC_DEVICE_H__
 
 #include <linux/irqreturn.h>
-
-#include "kcs_bmc.h"
+#include <linux/kcs_bmc.h>
 
 struct kcs_bmc_device_ops {
 	void (*irq_mask_update)(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 enable);
-- 
2.25.1

