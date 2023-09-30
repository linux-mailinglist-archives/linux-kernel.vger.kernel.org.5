Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94FB7B4044
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjI3MfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjI3MfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:35:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1099DD;
        Sat, 30 Sep 2023 05:35:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c746bc3bceso3491805ad.1;
        Sat, 30 Sep 2023 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696077306; x=1696682106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKUpjN1uQlSy2hj4zzIoIWWv8YL0X6aGFPn2xpMhYcw=;
        b=eZe35MUYzWlqP5MCHgvCFeh3nyJiv30z3B1ptEfBW4/oTfX7Oobs6bS9IKXRTrsgm8
         /WpeGE8Eg9zh03/cmYb7ICTkSM9ZfHf0rGsZdA21womN46HJizDDw7V2qpMx/ckWNYMm
         FIkMr9/auzB513PqfD3RD6m4wLsitdFPPVUz7sHJCIOTikna30ohJcGvEi84nliK9o7+
         MQR5cGMr/jQToIRtW8Bw6IyD+3A8POPBrK6CsBymGuInbJxIDXTFSQyrQRT1u4HtsZKt
         EL3zTvKdrvQWEKiG8lyLT1IE/cwHMilry89g0mN9pqslEoCqdVzaMRoiu3lm65loOyDU
         DL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696077306; x=1696682106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKUpjN1uQlSy2hj4zzIoIWWv8YL0X6aGFPn2xpMhYcw=;
        b=HkLffYbGKvlv+k9ER/BV6dwI73SLDl087usVk3WkP4y21rjFRjStBxZLi6IFR4Ul89
         f1jo8DpSOVuxPDVCuPT42qMIxRTblieupGr6Hczbfc0kRTAHpXuh8d30tbpD9JhuYAt5
         ODaYQJXCCAX/WC6gJrpxZKcYKPVq990LxZX1kS5fJGJJgrIDIKHIhi4ZxIWL4ppN9r8W
         WdPw/WLWg7Fjq5D3bURHDiX306BRNqzOY8vRy+ZL4knO1mMC2Pp+R5VN+w8/rJocAgpp
         4hCVSdRGCFSU9Bi4vUAxFveIKhbAqpGC24fSwHEiFSlzKv4nxmb/TslpX574slXOPo93
         DXwg==
X-Gm-Message-State: AOJu0Yy9uSB1nv7rciPVmIAbSCvrNQZItltW71tc2No0Ol85RrGTh2Nf
        PX2JaTIMaDUTxGVT6e6yUDUrrFfFDl30Ss2/
X-Google-Smtp-Source: AGHT+IHrsx++IUK7F1nIuy4xAikzVaC9WLwiiaDNVbsalnHhvLd7pWylmBGv17IJmIsuFfLT66yASg==
X-Received: by 2002:a17:902:b618:b0:1c7:5581:f9c with SMTP id b24-20020a170902b61800b001c755810f9cmr1942864pls.0.1696077306066;
        Sat, 30 Sep 2023 05:35:06 -0700 (PDT)
Received: from abhinav-IdeaPad-Slim-5-14ABR8.. ([103.75.161.211])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001c446dea2c5sm18558920plf.143.2023.09.30.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 05:35:05 -0700 (PDT)
From:   Abhinav <singhabhinav9051571833@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        benjamin.tissoires@redhat.com, mathias.nyman@linux.intel.com,
        hdegoede@redhat.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Abhinav <singhabhinav9051571833@gmail.com>
Subject: [PATCH] fixed documentation warning about duplicate symbol
Date:   Sat, 30 Sep 2023 18:04:49 +0530
Message-Id: <20230930123449.1170359-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the documentation in html gives a warning about duplicate symbol
because same name is used for function usb_string(...) and 
also for the struct usb_string.Also having a different name can
be helpful while searching or debugging the code.

Renaming the function usb_string(...) to utf16le_to_utf8(...) fixes 
this warning.Reason for choosing this name because 
this is what the function description says it is doing.

Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>
---
 drivers/usb/atm/cxacru.c         |  2 +-
 drivers/usb/atm/speedtch.c       |  2 +-
 drivers/usb/atm/ueagle-atm.c     |  2 +-
 drivers/usb/atm/usbatm.c         |  2 +-
 drivers/usb/core/hub.c           |  2 +-
 drivers/usb/core/message.c       | 12 ++++++------
 drivers/usb/misc/adutux.c        |  2 +-
 drivers/usb/misc/iowarrior.c     |  2 +-
 drivers/usb/misc/ldusb.c         |  2 +-
 drivers/usb/serial/io_edgeport.c |  4 ++--
 include/linux/usb.h              |  2 +-
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 4ce7cba2b48a..c27d13f9de74 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1352,7 +1352,7 @@ static int cxacru_usb_probe(struct usb_interface *intf,
 	 * Abort if bDeviceClass is 0xff and iProduct is "USB NET CARD".
 	 */
 	if (usb_dev->descriptor.bDeviceClass == USB_CLASS_VENDOR_SPEC
-			&& usb_string(usb_dev, usb_dev->descriptor.iProduct,
+			&& utf16le_to_utf8(usb_dev, usb_dev->descriptor.iProduct,
 				buf, sizeof(buf)) > 0) {
 		if (!strcmp(buf, "USB NET CARD")) {
 			dev_info(&intf->dev, "ignoring cx82310_eth device\n");
diff --git a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
index 973548b5c15c..4e13f740e2ae 100644
--- a/drivers/usb/atm/speedtch.c
+++ b/drivers/usb/atm/speedtch.c
@@ -655,7 +655,7 @@ static int speedtch_atm_start(struct usbatm_data *usbatm, struct atm_dev *atm_de
 
 	/* Set MAC address, it is stored in the serial number */
 	memset(atm_dev->esi, 0, sizeof(atm_dev->esi));
-	if (usb_string(usb_dev, usb_dev->descriptor.iSerialNumber, mac_str, sizeof(mac_str)) == 12) {
+	if (utf16le_to_utf8(usb_dev, usb_dev->descriptor.iSerialNumber, mac_str, sizeof(mac_str)) == 12) {
 		for (i = 0; i < 6; i++)
 			atm_dev->esi[i] = (hex_to_bin(mac_str[i * 2]) << 4) +
 				hex_to_bin(mac_str[i * 2 + 1]);
diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 5812f7ea7f90..2998c9b90a11 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2416,7 +2416,7 @@ static int uea_getesi(struct uea_softc *sc, u_char *esi)
 {
 	unsigned char mac_str[2 * ETH_ALEN + 1];
 	int i;
-	if (usb_string
+	if (utf16le_to_utf8
 	    (sc->usb_dev, sc->usb_dev->descriptor.iSerialNumber, mac_str,
 	     sizeof(mac_str)) != 2 * ETH_ALEN)
 		return 1;
diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 1cdb8758ae01..88ff90454572 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1035,7 +1035,7 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
 	buf = instance->description;
 	length = sizeof(instance->description);
 
-	if ((i = usb_string(usb_dev, usb_dev->descriptor.iProduct, buf, length)) < 0)
+	if ((i = utf16le_to_utf8(usb_dev, usb_dev->descriptor.iProduct, buf, length)) < 0)
 		goto bind;
 
 	buf += i;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3c54b218301c..0cdf81b07852 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5244,7 +5244,7 @@ static int descriptors_changed(struct usb_device *udev,
 	}
 
 	if (!changed && serial_len) {
-		length = usb_string(udev, udev->descriptor.iSerialNumber,
+		length = utf16le_to_utf8(udev, udev->descriptor.iSerialNumber,
 				buf, serial_len);
 		if (length + 1 != serial_len) {
 			dev_dbg(&udev->dev, "serial string error %d\n",
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 077dfe48d01c..5f4c178d83f7 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -767,7 +767,7 @@ EXPORT_SYMBOL_GPL(usb_sg_cancel);
  *
  * Gets a USB descriptor.  Convenience functions exist to simplify
  * getting some types of descriptors.  Use
- * usb_get_string() or usb_string() for USB_DT_STRING.
+ * usb_get_string() or utf16le_to_utf8() for USB_DT_STRING.
  * Device (USB_DT_DEVICE) and configuration descriptors (USB_DT_CONFIG)
  * are part of the device structure.
  * In addition to a number of USB-standard descriptors, some
@@ -819,7 +819,7 @@ EXPORT_SYMBOL_GPL(usb_get_descriptor);
  *
  * Retrieves a string, encoded using UTF-16LE (Unicode, 16 bits per character,
  * in little-endian byte order).
- * The usb_string() function will often be a convenient way to turn
+ * The utf16le_to_utf8() function will often be a convenient way to turn
  * these strings into kernel-printable form.
  *
  * Strings may be referenced in device, configuration, interface, or other
@@ -948,7 +948,7 @@ static int usb_get_langid(struct usb_device *dev, unsigned char *tbuf)
 }
 
 /**
- * usb_string - returns UTF-8 version of a string descriptor
+ * utf16le_to_utf8 - returns UTF-8 version of a string descriptor
  * @dev: the device whose string descriptor is being retrieved
  * @index: the number of the descriptor
  * @buf: where to put the string
@@ -965,7 +965,7 @@ static int usb_get_langid(struct usb_device *dev, unsigned char *tbuf)
  *
  * Return: length of the string (>= 0) or usb_control_msg status (< 0).
  */
-int usb_string(struct usb_device *dev, int index, char *buf, size_t size)
+int utf16le_to_utf8(struct usb_device *dev, int index, char *buf, size_t size)
 {
 	unsigned char *tbuf;
 	int err;
@@ -1003,7 +1003,7 @@ int usb_string(struct usb_device *dev, int index, char *buf, size_t size)
 	kfree(tbuf);
 	return err;
 }
-EXPORT_SYMBOL_GPL(usb_string);
+EXPORT_SYMBOL_GPL(utf16le_to_utf8);
 
 /* one UTF-8-encoded 16-bit character has at most three bytes */
 #define MAX_USB_STRING_SIZE (127 * 3 + 1)
@@ -1027,7 +1027,7 @@ char *usb_cache_string(struct usb_device *udev, int index)
 
 	buf = kmalloc(MAX_USB_STRING_SIZE, GFP_NOIO);
 	if (buf) {
-		len = usb_string(udev, index, buf, MAX_USB_STRING_SIZE);
+		len = utf16le_to_utf8(udev, index, buf, MAX_USB_STRING_SIZE);
 		if (len > 0) {
 			smallbuf = kmalloc(++len, GFP_NOIO);
 			if (!smallbuf)
diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index ed6a19254d2f..9c8e482d9dd9 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -717,7 +717,7 @@ static int adu_probe(struct usb_interface *interface,
 	if (!dev->interrupt_out_urb)
 		goto error;
 
-	if (!usb_string(udev, udev->descriptor.iSerialNumber, dev->serial_number,
+	if (!utf16le_to_utf8(udev, udev->descriptor.iSerialNumber, dev->serial_number,
 			sizeof(dev->serial_number))) {
 		dev_err(&interface->dev, "Could not retrieve serial number\n");
 		retval = -EIO;
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 1e3df27bab58..8b39662e3ae2 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -840,7 +840,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 		goto error;
 	/* Get the serial-number of the chip */
 	memset(dev->chip_serial, 0x00, sizeof(dev->chip_serial));
-	usb_string(udev, udev->descriptor.iSerialNumber, dev->chip_serial,
+	utf16le_to_utf8(udev, udev->descriptor.iSerialNumber, dev->chip_serial,
 		   sizeof(dev->chip_serial));
 	if (strlen(dev->chip_serial) != 8)
 		memset(dev->chip_serial, 0x00, sizeof(dev->chip_serial));
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 7cbef74dfc9a..4c13f7f0d5e4 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -675,7 +675,7 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 		if (!buffer)
 			goto error;
 		/* usb_string makes SETUP+STALL to leave always ControlReadLoop */
-		usb_string(udev, 255, buffer, 256);
+		utf16le_to_utf8(udev, 255, buffer, 256);
 		kfree(buffer);
 	}
 
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index abe4bbb0ac65..70d487e95117 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2723,12 +2723,12 @@ static int edge_startup(struct usb_serial *serial)
 	usb_set_serial_data(serial, edge_serial);
 
 	/* get the name for the device from the device */
-	i = usb_string(dev, dev->descriptor.iManufacturer,
+	i = utf16le_to_utf8(dev, dev->descriptor.iManufacturer,
 	    &edge_serial->name[0], MAX_NAME_LEN+1);
 	if (i < 0)
 		i = 0;
 	edge_serial->name[i++] = ' ';
-	usb_string(dev, dev->descriptor.iProduct,
+	utf16le_to_utf8(dev, dev->descriptor.iProduct,
 	    &edge_serial->name[i], MAX_NAME_LEN+2 - i);
 
 	dev_info(&serial->dev->dev, "%s detected\n", edge_serial->name);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index a21074861f91..870430a1fa52 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1879,7 +1879,7 @@ static inline int usb_get_ptm_status(struct usb_device *dev, void *data)
 		0, data);
 }
 
-extern int usb_string(struct usb_device *dev, int index,
+extern int utf16le_to_utf8(struct usb_device *dev, int index,
 	char *buf, size_t size);
 extern char *usb_cache_string(struct usb_device *udev, int index);
 
-- 
2.34.1

