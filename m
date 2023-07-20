Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8F75A884
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGTIBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGTIA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6902128;
        Thu, 20 Jul 2023 01:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4BE6190E;
        Thu, 20 Jul 2023 08:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1618CC433C8;
        Thu, 20 Jul 2023 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689840056;
        bh=46vJp8e7GtUguZcfgzEColtOeIPGAL93DRmb53QG2ME=;
        h=From:To:Cc:Subject:Date:From;
        b=VAaTPEpUomH/cV/hMAkRcCr01ZxUBKc8w4FXczGi8X+Y5AT3ZAS3/H7R5i/OyOoMo
         mqS/j79NicOnq9CDB0Z4RcL9EumKMqXvajclTNriAxU0k5/FwNHv6/+l2GOp10trEO
         sCfY7saFGuWerQ7+KLtRFZbI3dFUpPcVCMHsEwwDCQnPplye6A1FvtBoTOSxTuBq0o
         psP12qGpoeqFo21qGCDFjDUJ6mfn+SuTXqlnllDh7CL7MXpUVQxvsnPjNtawOqkrcM
         KL7M2eQ4s4lp1B9FqYgRe8pnPt6+A2Erg+TRAzSIc328xtVwlFMz+klKhfR/5fPMuL
         OJ70xu8KO/vJg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMOat-0003ea-28;
        Thu, 20 Jul 2023 10:01:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] USB: serial: simple: sort entries
Date:   Thu, 20 Jul 2023 10:00:49 +0200
Message-ID: <20230720080049.14032-1-johan@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the defines and device-id entries alphabetically in order to make
it more obvious where new entries should be added.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial-simple.c | 66 +++++++++++++-------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 3c552e4b87ce..24b8772a345e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -38,16 +38,6 @@ static struct usb_serial_driver vendor##_device = {		\
 	{ USB_DEVICE(0x0a21, 0x8001) }	/* MMT-7305WW */
 DEVICE(carelink, CARELINK_IDS);
 
-/* ZIO Motherboard USB driver */
-#define ZIO_IDS()			\
-	{ USB_DEVICE(0x1CBE, 0x0103) }
-DEVICE(zio, ZIO_IDS);
-
-/* Funsoft Serial USB driver */
-#define FUNSOFT_IDS()			\
-	{ USB_DEVICE(0x1404, 0xcddc) }
-DEVICE(funsoft, FUNSOFT_IDS);
-
 /* Infineon Flashloader driver */
 #define FLASHLOADER_IDS()		\
 	{ USB_DEVICE_INTERFACE_CLASS(0x058b, 0x0041, USB_CLASS_CDC_DATA) }, \
@@ -55,6 +45,11 @@ DEVICE(funsoft, FUNSOFT_IDS);
 	{ USB_DEVICE(0x8087, 0x0801) }
 DEVICE(flashloader, FLASHLOADER_IDS);
 
+/* Funsoft Serial USB driver */
+#define FUNSOFT_IDS()			\
+	{ USB_DEVICE(0x1404, 0xcddc) }
+DEVICE(funsoft, FUNSOFT_IDS);
+
 /* Google Serial USB SubClass */
 #define GOOGLE_IDS()						\
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
@@ -63,6 +58,11 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* HP4x (48/49) Generic Serial driver */
+#define HP4X_IDS()			\
+	{ USB_DEVICE(0x03f0, 0x0121) }
+DEVICE(hp4x, HP4X_IDS);
+
 /* KAUFMANN RKS+CAN VCP */
 #define KAUFMANN_IDS()			\
 	{ USB_DEVICE(0x16d0, 0x0870) }
@@ -73,11 +73,6 @@ DEVICE(kaufmann, KAUFMANN_IDS);
 	{ USB_DEVICE(0x1209, 0x8b00) }
 DEVICE(libtransistor, LIBTRANSISTOR_IDS);
 
-/* ViVOpay USB Serial Driver */
-#define VIVOPAY_IDS()			\
-	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
-DEVICE(vivopay, VIVOPAY_IDS);
-
 /* Motorola USB Phone driver */
 #define MOTO_IDS()			\
 	{ USB_DEVICE(0x05c6, 0x3197) },	/* unknown Motorola phone */	\
@@ -106,10 +101,10 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
-/* HP4x (48/49) Generic Serial driver */
-#define HP4X_IDS()			\
-	{ USB_DEVICE(0x03f0, 0x0121) }
-DEVICE(hp4x, HP4X_IDS);
+/* Siemens USB/MPI adapter */
+#define SIEMENS_IDS()			\
+	{ USB_DEVICE(0x908, 0x0004) }
+DEVICE(siemens_mpi, SIEMENS_IDS);
 
 /* Suunto ANT+ USB Driver */
 #define SUUNTO_IDS()			\
@@ -117,47 +112,52 @@ DEVICE(hp4x, HP4X_IDS);
 	{ USB_DEVICE(0x0fcf, 0x1009) } /* Dynastream ANT USB-m Stick */
 DEVICE(suunto, SUUNTO_IDS);
 
-/* Siemens USB/MPI adapter */
-#define SIEMENS_IDS()			\
-	{ USB_DEVICE(0x908, 0x0004) }
-DEVICE(siemens_mpi, SIEMENS_IDS);
+/* ViVOpay USB Serial Driver */
+#define VIVOPAY_IDS()			\
+	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
+DEVICE(vivopay, VIVOPAY_IDS);
+
+/* ZIO Motherboard USB driver */
+#define ZIO_IDS()			\
+	{ USB_DEVICE(0x1CBE, 0x0103) }
+DEVICE(zio, ZIO_IDS);
 
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
-	&zio_device,
-	&funsoft_device,
 	&flashloader_device,
+	&funsoft_device,
 	&google_device,
+	&hp4x_device,
 	&kaufmann_device,
 	&libtransistor_device,
-	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
-	&hp4x_device,
-	&suunto_device,
 	&siemens_mpi_device,
+	&suunto_device,
+	&vivopay_device,
+	&zio_device,
 	NULL
 };
 
 static const struct usb_device_id id_table[] = {
 	CARELINK_IDS(),
-	ZIO_IDS(),
-	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
+	FUNSOFT_IDS(),
 	GOOGLE_IDS(),
+	HP4X_IDS(),
 	KAUFMANN_IDS(),
 	LIBTRANSISTOR_IDS(),
-	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
-	HP4X_IDS(),
-	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	SUUNTO_IDS(),
+	VIVOPAY_IDS(),
+	ZIO_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.41.0

