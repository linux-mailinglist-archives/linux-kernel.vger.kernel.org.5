Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204717861FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbjHWVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjHWVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:12:54 -0400
Received: from genua.uuid.uk (genua.uuid.uk [78.47.120.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1022E6C;
        Wed, 23 Aug 2023 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=gPJ7fUW8ARzgzBmBbKR4BwRFESO2WZO2zZnd0h3g8pU=; t=1692825171; 
        b=f0jWnImxIeOcijAxBl7QmJVe174x2lI6v4SIdv+Ie/+EPKVCjIRalxY44E0JBxF1Z+29YPuj7X/
        /Fa+Rdm4Q/B+tIfgTP69Gm4zLwrBO9wnkSb6z9JsDeJ5+abh2NhAiyexkqpfZbQ3ri2L+JCaJFOcv
        P9WtfxkD9lZmm5NvbMEuBNjj+amEDE3wVIApf/ATxg99C275vkTJP6b79fUFQboI0u8PGwsPAqUBA
        9Rr4vRR/fm5w4L1RvANAZoqgfTINlEvdZEy+QaQUIbGxmKtOjLtz+Hm+OD0ZvJPPpQp7w7aNKcNsN
        FbPYLZxTIR1H2EKZxH8WICzLOvituuHt8dd+ZCRyIwFRkqDGb5YuxCxTIhHqZSKUhSzALUZEIYR4R
        /ZokrG/F+COi7kZEskwN4sfvsGBoUJt3WKrSKSPmJnK2IAKHIIo8lC9ZXcl/msAjbM4iH2kfHLs1q
        5xvwyas5TL9AhGDtUyElHg+YdUTRp5DeATczpCzIQm/FGlF7HwdY;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=gPJ7fUW8ARzgzBmBbKR4BwRFESO2WZO2zZnd0h3g8pU=; t=1692825171; 
        b=a8tz+a0GXGk616iX2AQmIISVUotMy7WI5VnhYAWrViWkF18bHPiHF7MpDAHXKbHW81kPnW25tgn
        J2G2MC1O3Ag==;
Received: by genua.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qYv9h-00AOsS-HN; Wed, 23 Aug 2023 22:12:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=gPJ7fUW8ARzgzBmBbKR4BwRFESO2WZO2zZnd0h3g8pU=; t=1692825165; 
        b=XOQy3dEmLzbUjtPlogEMFUjYmDofiDU1EjCz1jKjNv5ApC47zaoMpQdMTJJCr0w5l/hjhzGBN8y
        2+HeoWxxYswNvxkLrEkT5Oiuyhg6XwXxkzV3Yox2SMkc/cukypuMNJkLVgkKU7mGh/qMCQY9FO9ul
        j/oyv/i4kpTZ+5IghtpNpofPYaBVmc4Hw8RBRQeElbHxZ+TXrJPwpkO/sk5nfcW8wHNXpq5Dpf14V
        k4F0wj23DTz0BUliDSwbwK8o2aJ33Gtx8tfaY7t8i6Q8QKrYeCw1QueIf4/SjJr36XHSocyEfyFI1
        ucITgnbU4WkPGOmeGnMuXGHKkzS+9ehn2ajDssd6lW7an4vniHepwnk0z2tkX3WAXHBVOCbEUCerJ
        X3ugtkZjFCkHreIo8CKKswo7xzeCcgeURmxO7ckqVVwjWaeVVuW1onOjyJpi9ZkGGJ2MZezJbYI/u
        4s+PCkbA0CC5+Eu0ZEdFzaVuP5EigwA4GBW5s/dqQMudP0PGWAF0;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=gPJ7fUW8ARzgzBmBbKR4BwRFESO2WZO2zZnd0h3g8pU=; t=1692825165; 
        b=00zfea8O4idFXu8iUZcdX34A/kdyCU2COISZ+h1Xqa1KgeotInGHtNFiheIOt9ykDoCcXhCK693
        j1eHxmT4KBg==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qYv9f-004aRo-0T; Wed, 23 Aug 2023 22:12:43 +0100
Message-ID: <40c5c70f-46ff-c5f3-212b-2badc47e49a3@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date:   Wed, 23 Aug 2023 22:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH (v2)] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
Content-Language: en-GB
From:   Simon Arlott <simon@octiron.net>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
In-Reply-To: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the serial device never reads data written to it (because it is "output
only") then the write buffers will still be waiting for the URB to complete
on close(), which will hang for 30s until the closing_wait timeout expires.

This can happen with the ESP32-H2/ESP32-C6 USB serial interface. Instead of
changing all userspace applications to flush (discard) their output in this
specific scenario it would be easier to adjust the closing_wait timeout
with udev rules but the only available interface is the TIOCGSERIAL ioctl.

The serial_core driver (ttySx) exposes its supported ioctl values as
read-only sysfs attributes. Add read-write sysfs attributes "close_delay"
and "closing_wait" to cdc-acm (ttyACMx) devices. These are the same as the
attributes in serial_core except that the "closing_wait" sysfs values are
modified so that "-1" is used for "infinite wait" (instead of 0) and "0"
is used for "no wait" (instead of 65535).

Signed-off-by: Simon Arlott <simon@octiron.net>
---
> @@ -976,9 +973,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
> -	if (!capable(CAP_SYS_ADMIN)) {
> +	if (!admin) {
>  		if ((close_delay != acm->port.close_delay) ||
>  		    (closing_wait != acm->port.closing_wait))
>  			retval = -EPERM;

Sorry, I hadn't tested the ioctl and this return value wasn't actually
getting returned.

 Documentation/ABI/testing/sysfs-tty |  21 +++++
 drivers/usb/class/cdc-acm.c         | 139 +++++++++++++++++++++++++---
 2 files changed, 146 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 820e412d38a8..e04e322af568 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -161,3 +161,24 @@ Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:
 		 Allows user to detach or attach back the given device as
 		 kernel console. It shows and accepts a boolean variable.
+
+What:		/sys/class/tty/ttyACM0/close_delay
+Date:		August 2023
+Contact:	linux-usb@vger.kernel.org
+Description:
+		Set the closing delay time for this port in ms.
+
+		These sysfs values expose the TIOCGSERIAL interface via
+		sysfs rather than via ioctls.
+
+What:		/sys/class/tty/ttyACM0/closing_wait
+Date:		August 2023
+Contact:	linux-usb@vger.kernel.org
+Description:
+		Set the close wait time for this port in ms.
+
+		These sysfs values expose the TIOCGSERIAL interface via
+		sysfs rather than via ioctls.
+
+		Unlike the ioctl interface, waiting forever is represented as
+		-1 and zero is used to disable waiting on close.
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 00db9e1fc7ed..7e0f94e18445 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -953,42 +953,57 @@ static int acm_tty_tiocmset(struct tty_struct *tty,
 	return acm_set_control(acm, acm->ctrlout = newctrl);
 }
 
-static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
+static void acm_read_serial_info(struct acm *acm, struct serial_struct *ss)
 {
-	struct acm *acm = tty->driver_data;
-
 	ss->line = acm->minor;
 	ss->close_delay	= jiffies_to_msecs(acm->port.close_delay) / 10;
 	ss->closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				ASYNC_CLOSING_WAIT_NONE :
 				jiffies_to_msecs(acm->port.closing_wait) / 10;
-	return 0;
 }
 
-static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
+static int acm_write_serial_info(struct acm *acm, struct serial_struct *ss,
+	bool admin)
 {
-	struct acm *acm = tty->driver_data;
 	unsigned int closing_wait, close_delay;
-	int retval = 0;
+	int ret = 0;
 
 	close_delay = msecs_to_jiffies(ss->close_delay * 10);
 	closing_wait = ss->closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 			ASYNC_CLOSING_WAIT_NONE :
 			msecs_to_jiffies(ss->closing_wait * 10);
 
-	mutex_lock(&acm->port.mutex);
-
-	if (!capable(CAP_SYS_ADMIN)) {
+	if (!admin) {
 		if ((close_delay != acm->port.close_delay) ||
 		    (closing_wait != acm->port.closing_wait))
-			retval = -EPERM;
+			ret = -EPERM;
 	} else {
 		acm->port.close_delay  = close_delay;
 		acm->port.closing_wait = closing_wait;
 	}
 
+	return ret;
+}
+
+static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
+{
+	struct acm *acm = tty->driver_data;
+
+	mutex_lock(&acm->port.mutex);
+	acm_read_serial_info(acm, ss);
+	mutex_unlock(&acm->port.mutex);
+	return 0;
+}
+
+static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
+{
+	struct acm *acm = tty->driver_data;
+	int ret = 0;
+
+	mutex_lock(&acm->port.mutex);
+	ret = acm_write_serial_info(acm, ss, capable(CAP_SYS_ADMIN));
 	mutex_unlock(&acm->port.mutex);
-	return retval;
+	return ret;
 }
 
 static int wait_serial_change(struct acm *acm, unsigned long arg)
@@ -1162,6 +1177,102 @@ static int acm_write_buffers_alloc(struct acm *acm)
 	return 0;
 }
 
+static ssize_t close_delay_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct acm *acm = dev_get_drvdata(dev);
+	struct serial_struct ss;
+
+	mutex_lock(&acm->port.mutex);
+	acm_read_serial_info(acm, &ss);
+	mutex_unlock(&acm->port.mutex);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", ss.close_delay);
+}
+
+static ssize_t close_delay_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct acm *acm = dev_get_drvdata(dev);
+	struct serial_struct ss;
+	u16 close_delay;
+	int ret;
+
+	ret = kstrtou16(buf, 0, &close_delay);
+	if (ret)
+		return ret;
+
+	mutex_lock(&acm->port.mutex);
+	acm_read_serial_info(acm, &ss);
+	ss.close_delay = close_delay;
+	ret = acm_write_serial_info(acm, &ss, true);
+	mutex_unlock(&acm->port.mutex);
+
+	return ret ? ret : count;
+}
+
+static ssize_t closing_wait_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct acm *acm = dev_get_drvdata(dev);
+	struct serial_struct ss;
+	s32 value;
+
+	mutex_lock(&acm->port.mutex);
+	acm_read_serial_info(acm, &ss);
+	mutex_unlock(&acm->port.mutex);
+
+	if (ss.closing_wait == ASYNC_CLOSING_WAIT_NONE)
+		value = 0;
+	else if (ss.closing_wait == ASYNC_CLOSING_WAIT_INF)
+		value = -1;
+	else
+		value = ss.closing_wait;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+static ssize_t closing_wait_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct acm *acm = dev_get_drvdata(dev);
+	struct serial_struct ss;
+	s32 closing_wait;
+	int ret;
+
+	ret = kstrtos32(buf, 0, &closing_wait);
+	if (ret)
+		return ret;
+
+	if (closing_wait == 0) {
+		closing_wait = ASYNC_CLOSING_WAIT_NONE;
+	} else if (closing_wait == -1) {
+		closing_wait = ASYNC_CLOSING_WAIT_INF;
+	} else if (closing_wait == ASYNC_CLOSING_WAIT_NONE
+			|| closing_wait == ASYNC_CLOSING_WAIT_INF /* redundant (0) */
+			|| closing_wait < -1 || closing_wait > U16_MAX) {
+		return -ERANGE;
+	}
+
+	mutex_lock(&acm->port.mutex);
+	acm_read_serial_info(acm, &ss);
+	ss.closing_wait = closing_wait;
+	ret = acm_write_serial_info(acm, &ss, true);
+	mutex_unlock(&acm->port.mutex);
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(close_delay);
+static DEVICE_ATTR_RW(closing_wait);
+
+static struct attribute *tty_dev_attrs[] = {
+	&dev_attr_close_delay.attr,
+	&dev_attr_closing_wait.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(tty_dev);
+
 static int acm_probe(struct usb_interface *intf,
 		     const struct usb_device_id *id)
 {
@@ -1503,8 +1614,8 @@ static int acm_probe(struct usb_interface *intf,
 			goto err_remove_files;
 	}
 
-	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
-			&control_interface->dev);
+	tty_dev = tty_port_register_device_attr(&acm->port, acm_tty_driver,
+			minor, &control_interface->dev, acm, tty_dev_groups);
 	if (IS_ERR(tty_dev)) {
 		rv = PTR_ERR(tty_dev);
 		goto err_release_data_interface;
-- 
2.37.0

-- 
Simon Arlott

