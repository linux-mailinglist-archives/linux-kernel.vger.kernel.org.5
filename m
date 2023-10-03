Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84F7B62DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjJCHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:54:08 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03646B3;
        Tue,  3 Oct 2023 00:54:01 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
        id 0876120239; Tue,  3 Oct 2023 15:54:00 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1696319640;
        bh=vsBp77p7CDhHRULJIIRilyCY9D7df8p0W5nYzOmlxYk=;
        h=From:To:Cc:Subject:Date;
        b=dIb2/5uzvw6ksgomcS/2UUZ3ci7UKGcfHjSx3urC/mT6neS33iN3PVpajlxoKLVFT
         zO9xv1n/2YhMYfUfiBTcFnksIBcaLJAbkrVqRt22hffdjm6LpUZUgw5OPMCOCJNY1+
         WGcyb14aDdOeLKI0sX9WaK0xRQFbCxjUVgleH1BFSTxf5at4PPY7yO6sFAeMdzTiRW
         /YRElUnBycEep4xzDzivLjYlRJ4aHqIPlLvC1csGgDUFU2fakHLWjWSI5vRzIYaRm1
         P7jbrKRDbINMGIwCoN5oCAI0wzU6w/ZTKVZ/W+qgtCGZRKjZJoZUaeiFlKFwScsNzI
         pKKJlIbVPSS6g==
From:   Matt Johnston <matt@codeconstruct.com.au>
To:     linux-i3c@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH] i3c: Fix typo "Provisional ID" to "Provisioned ID"
Date:   Tue,  3 Oct 2023 15:53:39 +0800
Message-Id: <20231003075339.197099-1-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI I3C spec refers to a Provisioned ID, since it is (sometimes)
provisioned at device manufacturing.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 Documentation/ABI/testing/sysfs-bus-i3c        | 4 ++--
 Documentation/devicetree/bindings/i3c/i3c.yaml | 4 ++--
 Documentation/driver-api/i3c/protocol.rst      | 4 ++--
 drivers/i3c/master/svc-i3c-master.c            | 2 +-
 include/linux/i3c/device.h                     | 2 +-
 include/linux/i3c/master.h                     | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
index 1f4a2662335b..e5248fd67a56 100644
--- a/Documentation/ABI/testing/sysfs-bus-i3c
+++ b/Documentation/ABI/testing/sysfs-bus-i3c
@@ -67,7 +67,7 @@ What:		/sys/bus/i3c/devices/i3c-<bus-id>/pid
 KernelVersion:  5.0
 Contact:	linux-i3c@vger.kernel.org
 Description:
-		PID stands for Provisional ID and is used to uniquely identify
+		PID stands for Provisioned ID and is used to uniquely identify
 		a device on a bus. This PID contains information about the
 		vendor, the part and an instance ID so that several devices of
 		the same type can be connected on the same bus.
@@ -123,7 +123,7 @@ What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/pid
 KernelVersion:  5.0
 Contact:	linux-i3c@vger.kernel.org
 Description:
-		PID stands for Provisional ID and is used to uniquely identify
+		PID stands for Provisioned ID and is used to uniquely identify
 		a device on a bus. This PID contains information about the
 		vendor, the part and an instance ID so that several devices of
 		the same type can be connected on the same bus.
diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index ab69f4115de4..f8ac7a3e3123 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -119,12 +119,12 @@ patternProperties:
                 minimum: 0
                 maximum: 0x7f
               - description: |
-                  First half of the Provisional ID (following the PID
+                  First half of the Provisioned ID (following the PID
                   definition provided by the I3C specification).
 
                   Contains the manufacturer ID left-shifted by 1.
               - description: |
-                  Second half of the Provisional ID (following the PID
+                  Second half of the Provisioned ID (following the PID
                   definition provided by the I3C specification).
 
                   Contains the ORing of the part ID left-shifted by 16,
diff --git a/Documentation/driver-api/i3c/protocol.rst b/Documentation/driver-api/i3c/protocol.rst
index 02653defa011..23a0b93c62b1 100644
--- a/Documentation/driver-api/i3c/protocol.rst
+++ b/Documentation/driver-api/i3c/protocol.rst
@@ -71,8 +71,8 @@ During DAA, each I3C device reports 3 important things:
   related capabilities
 * DCR: Device Characteristic Register. This 8-bit register describes the
   functionalities provided by the device
-* Provisional ID: A 48-bit unique identifier. On a given bus there should be no
-  Provisional ID collision, otherwise the discovery mechanism may fail.
+* Provisioned ID: A 48-bit unique identifier. On a given bus there should be no
+  Provisioned ID collision, otherwise the discovery mechanism may fail.
 
 I3C slave events
 ================
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 32eca2d6caf0..e23d7900c5a1 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -765,7 +765,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			u8 data[6];
 
 			/*
-			 * We only care about the 48-bit provisional ID yet to
+			 * We only care about the 48-bit provisioned ID yet to
 			 * be sure a device does not nack an address twice.
 			 * Otherwise, we would just need to flush the RX FIFO.
 			 */
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 90fa83464f00..84ed77c04940 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -96,7 +96,7 @@ enum i3c_dcr {
 
 /**
  * struct i3c_device_info - I3C device information
- * @pid: Provisional ID
+ * @pid: Provisioned ID
  * @bcr: Bus Characteristic Register
  * @dcr: Device Characteristic Register
  * @static_addr: static/I2C address
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 0b52da4f2346..4fd6a777150f 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -166,7 +166,7 @@ struct i3c_device_ibi_info {
  *		 assigned a dynamic address by the master. Will be used during
  *		 bus initialization to assign it a specific dynamic address
  *		 before starting DAA (Dynamic Address Assignment)
- * @pid: I3C Provisional ID exposed by the device. This is a unique identifier
+ * @pid: I3C Provisioned ID exposed by the device. This is a unique identifier
  *	 that may be used to attach boardinfo to i3c_dev_desc when the device
  *	 does not have a static address
  * @of_node: optional DT node in case the device has been described in the DT
-- 
2.39.2

