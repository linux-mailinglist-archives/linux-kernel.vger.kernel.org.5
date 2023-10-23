Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53C7D2B78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJWHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B8D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698046546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxWUPtTWgFMNVman7iCUnbOshHnj9rT5MN0BdheUlsI=;
        b=gk0cc+m4pa+V4IM+SbCt7D4KpY2h/TGwTaRgb91fztviruSY6GOj+Oy3und//re5BaF7Y6
        WGnuTumvEZZuA5mfr1R7Ti3P30cZlRoI9jnpQZhM9tCMnGgJptyX8W1AIIhHJKnFVkXA7g
        1ZcMdc4pqZMwdYEa5bXOG7J2GZxAcGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-CvHIrsnCNW-X1TCjAD6nIg-1; Mon, 23 Oct 2023 03:35:43 -0400
X-MC-Unique: CvHIrsnCNW-X1TCjAD6nIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC5768564E5;
        Mon, 23 Oct 2023 07:35:42 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 582D125C0;
        Mon, 23 Oct 2023 07:35:41 +0000 (UTC)
From:   Prasad Pandit <ppandit@redhat.com>
To:     Bernhard Walle <bernhard@bwalle.de>
Cc:     linux-kernel@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] firmware: fix indentation of config attributes
Date:   Mon, 23 Oct 2023 13:08:30 +0530
Message-ID: <20231023073830.209881-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasad Pandit <pjp@fedoraproject.org>

Fix indentation of config attributes. They are generally
indented with a leading tab(\t) character, so use the same instead
of spaces.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/firmware/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..82ae68b13381 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -55,8 +55,8 @@ config EDD
 	  BIOS tries boot from.  This information is then exported via sysfs.
 
 	  This option is experimental and is known to fail to boot on some
-          obscure configurations. Most disk controller BIOS vendors do
-          not yet implement this feature.
+	  obscure configurations. Most disk controller BIOS vendors do
+	  not yet implement this feature.
 
 config EDD_OFF
 	bool "Sets default behavior for EDD detection to off"
@@ -68,14 +68,14 @@ config EDD_OFF
 	  using the kernel parameter 'edd={on|skipmbr|off}'.
 
 config FIRMWARE_MEMMAP
-    bool "Add firmware-provided memory map to sysfs" if EXPERT
-    default X86
-    help
-      Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
-      That memory map is used for example by kexec to set up parameter area
-      for the next kernel, but can also be used for debugging purposes.
+	bool "Add firmware-provided memory map to sysfs" if EXPERT
+	default X86
+	help
+	  Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
+	  That memory map is used for example by kexec to set up parameter area
+	  for the next kernel, but can also be used for debugging purposes.
 
-      See also Documentation/ABI/testing/sysfs-firmware-memmap.
+	  See also Documentation/ABI/testing/sysfs-firmware-memmap.
 
 config EFI_PCDP
 	bool "Console device selection via EFI PCDP or HCDP table"
@@ -99,12 +99,12 @@ config EFI_PCDP
 	  You must also enable the appropriate drivers (serial, VGA, etc.)
 
 	  See DIG64_HCDPv20_042804.pdf available from
-	  <http://www.dig64.org/specifications/> 
+	  <http://www.dig64.org/specifications/>
 
 config DMIID
-    bool "Export DMI identification via sysfs to userspace"
-    depends on DMI
-    default y
+	bool "Export DMI identification via sysfs to userspace"
+	depends on DMI
+	default y
 	help
 	  Say Y here if you want to query SMBIOS/DMI system identification
 	  information from userspace through /sys/class/dmi/id/ or if you want
-- 
2.41.0

