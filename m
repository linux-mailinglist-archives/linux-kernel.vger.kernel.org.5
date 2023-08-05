Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF74771084
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHEQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHEQXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:23:24 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC1103
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:23:23 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qSK3i-0000dH-1f;
        Sat, 05 Aug 2023 16:23:18 +0000
Date:   Sat, 5 Aug 2023 17:23:11 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2 1/7] mtd: ubi: improve Kconfig formatting
Message-ID: <62240f36e4838e925e32add167a2d7d201843b0d.1691252291.git.daniel@makrotopia.org>
References: <cover.1691252291.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691252291.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig help text should be indented with one tab + 2 spaces
according to coding-style.rst. Apply this rule in
drivers/mtd/ubi/Kconfig

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/Kconfig | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 2ed77b7b3fcb5..184118f9a2969 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -61,47 +61,47 @@ config MTD_UBI_FASTMAP
 	bool "UBI Fastmap (Experimental feature)"
 	default n
 	help
-	   Important: this feature is experimental so far and the on-flash
-	   format for fastmap may change in the next kernel versions
-
-	   Fastmap is a mechanism which allows attaching an UBI device
-	   in nearly constant time. Instead of scanning the whole MTD device it
-	   only has to locate a checkpoint (called fastmap) on the device.
-	   The on-flash fastmap contains all information needed to attach
-	   the device. Using fastmap makes only sense on large devices where
-	   attaching by scanning takes long. UBI will not automatically install
-	   a fastmap on old images, but you can set the UBI module parameter
-	   fm_autoconvert to 1 if you want so. Please note that fastmap-enabled
-	   images are still usable with UBI implementations without
-	   fastmap support. On typical flash devices the whole fastmap fits
-	   into one PEB. UBI will reserve PEBs to hold two fastmaps.
-
-	   If in doubt, say "N".
+	  Important: this feature is experimental so far and the on-flash
+	  format for fastmap may change in the next kernel versions
+
+	  Fastmap is a mechanism which allows attaching an UBI device
+	  in nearly constant time. Instead of scanning the whole MTD device it
+	  only has to locate a checkpoint (called fastmap) on the device.
+	  The on-flash fastmap contains all information needed to attach
+	  the device. Using fastmap makes only sense on large devices where
+	  attaching by scanning takes long. UBI will not automatically install
+	  a fastmap on old images, but you can set the UBI module parameter
+	  fm_autoconvert to 1 if you want so. Please note that fastmap-enabled
+	  images are still usable with UBI implementations without
+	  fastmap support. On typical flash devices the whole fastmap fits
+	  into one PEB. UBI will reserve PEBs to hold two fastmaps.
+
+	  If in doubt, say "N".
 
 config MTD_UBI_GLUEBI
 	tristate "MTD devices emulation driver (gluebi)"
 	help
-	   This option enables gluebi - an additional driver which emulates MTD
-	   devices on top of UBI volumes: for each UBI volumes an MTD device is
-	   created, and all I/O to this MTD device is redirected to the UBI
-	   volume. This is handy to make MTD-oriented software (like JFFS2)
-	   work on top of UBI. Do not enable this unless you use legacy
-	   software.
+	  This option enables gluebi - an additional driver which emulates MTD
+	  devices on top of UBI volumes: for each UBI volumes an MTD device is
+	  created, and all I/O to this MTD device is redirected to the UBI
+	  volume. This is handy to make MTD-oriented software (like JFFS2)
+	  work on top of UBI. Do not enable this unless you use legacy
+	  software.
 
 config MTD_UBI_BLOCK
 	bool "Read-only block devices on top of UBI volumes"
 	default n
 	depends on BLOCK
 	help
-	   This option enables read-only UBI block devices support. UBI block
-	   devices will be layered on top of UBI volumes, which means that the
-	   UBI driver will transparently handle things like bad eraseblocks and
-	   bit-flips. You can put any block-oriented file system on top of UBI
-	   volumes in read-only mode (e.g., ext4), but it is probably most
-	   practical for read-only file systems, like squashfs.
+	  This option enables read-only UBI block devices support. UBI block
+	  devices will be layered on top of UBI volumes, which means that the
+	  UBI driver will transparently handle things like bad eraseblocks and
+	  bit-flips. You can put any block-oriented file system on top of UBI
+	  volumes in read-only mode (e.g., ext4), but it is probably most
+	  practical for read-only file systems, like squashfs.
 
-	   When selected, this feature will be built in the UBI driver.
+	  When selected, this feature will be built in the UBI driver.
 
-	   If in doubt, say "N".
+	  If in doubt, say "N".
 
 endif # MTD_UBI
-- 
2.41.0
