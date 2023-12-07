Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9001780954B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444116AbjLGW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjLGW04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:26:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1F170C;
        Thu,  7 Dec 2023 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701988008; x=1702592808; i=w_armin@gmx.de;
        bh=y2EiVsoHmyaZo5EWEuzoKsphmINyUOYwfn7EMnwuLU0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Yj+srHueQQUZbBmN77rZ2/c3CPtuEnYClCHxzkl6trWoSymWU5Mr03g3aIoUcxLB
         uiIqDD7+mtS36KH1x0S6Cxj3wbzLQF6kMaUJA9ZkIyAhc8QyqPKR0qHYSELS0OriS
         5CScQo/lLKODJGpASISe+fiYliDcw2l1hCwB75znrZLELEZVcwiAKYMrO10njtBsx
         KSnGh2+cUK75JPaz4OkEQAEjhdWzQUWRicg1ftgHqccmxEIGvkFp9hpuSGMIGtWs+
         plFPh7wLpdtjiM9ouRKQ4c45ducIP6ZsYo/+5anyMJLQOWTtx+O4miCn/UwlGPyFB
         HQih1FcinZYC1HaYAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mg6Zw-1rj4UQ2FIM-00hgNB; Thu, 07 Dec 2023 23:26:48 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] platform/x86: wmi: Remove chardev interface
Date:   Thu,  7 Dec 2023 23:26:22 +0100
Message-Id: <20231207222623.232074-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207222623.232074-1-W_Armin@gmx.de>
References: <20231207222623.232074-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQ9UYDFhnYuYZY2U6JeHfGozqpr2BYf08f6ZRM2dq5zgwIBVrgS
 94JDOsPJlXyD22SApQEwMw/NsHWUg7hN0eJLtjUp+p599yImgw1BzNpHclSoZivB2yBFE9K
 RH5XA3Zx02xwZMNn+Il7u9/382ze1mD/5y5b0/T7QZE7TGxUGgFKRMCUhdZFyeXH/3ypyOx
 3zTkxB1/FqmvK81nQYw+g==
UI-OutboundReport: notjunk:1;M01:P0:oCtkFgIGYMc=;IWDCxZdV9V6XU83HaYvD7N4J9MV
 5WUIVL1zHlmo0ofZP0/uXUhKhl5P3joTMmbKoraEttlb8DC4LFFj+r19xxejyKqWa9OQcT8Sj
 u+Wyyhml8y68KrNrKjMMnjjruCiMJCAT9QFwZfSBaeEGW3XZ92jhDvcXfSt1POT/ZgUr3OvBt
 eqzpaPbLcHkqDm1MdXfhR6j5Acd/pnpXuZE+nFnXOrDh36sMuDA/HyLgLtDf3Qde99mh2vwjv
 2rAMpEvbkWwY6NarHX0kkHZlIRmViKOpL4Z0NgaFrBx/caDRd+rjrZ8L2CoTNj3Qmc7k4EGrL
 W2UoqvwUOUCMqkXv8It9rbkNTfDrVKJB/q3LyYnti+2+7IGUJWLjpRf/fDXTMe1btblAVoXAG
 fA5ZLCc2tuK1U08lBHsE6PjhmCrEGPJMDPCKkDmUiaq7DljlSYNj9y0Bw8WNuhCRiedtlffjY
 Al9oo4YOw/1jxJ2sCybN/PVQ+EAMZ6bgo1cqGozLrxKSCkvjXTONDILZ5xbMdejJmbLZfRh0Y
 qK/zLwYKB0uxLQMvHfOR9pq0hq0I4DXHxBrSbWYdthFlzL3KvbFKzW9u0sqRtqMeQKn4vdDJ+
 YIw9zxoqi64+smcx1ii+UnuoRZl3diAoelA/ggP8Quk1hcE/7qWVxvuEy4zXukDWvs8IT5aRy
 2RRurZ4A1dOTa3FrudayEz7jo3YbmsOhDanFx2vYcBrfTIBjyl+SCZzMy1KEQqSmf+aHxZyXg
 JPn5yvB3a7QRlwuKrZ5Ru9oPv451kSIhyjmRkhoEPTtrAwzbLYJzT4znB4/tO9LOpqn311z4A
 iGrRrbzUSRvi+m2LrQwyxlAGWxAZaSaNHPyNdM402ApcZ6SZLbdRdcfQUX0gBdtsTQ9/UdBnV
 vFH+oKLZ9ynf8w1CjC3NBgQxnHb433do7Te55kJETsm68ZRPT4wGD3v3LB8HiWNiKsM4+c4mD
 7d2sDUbOdWLyvGx1gPNtbZCmRB8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The design of the WMI chardev interface is broken:
- it assumes that WMI drivers are not instantiated twice
- it offers next to no abstractions, the WMI driver gets
a raw byte buffer
- it is only used by a single driver, something which is
unlikely to change

Since the only user (dell-smbios-wmi) has been migrated
to his own ioctl interface, remove it.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 180 ++-----------------------------------
 include/linux/wmi.h        |   8 --
 2 files changed, 5 insertions(+), 183 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7df5b5ee7983..7303702290e5 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -23,17 +23,14 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/uuid.h>
 #include <linux/wmi.h>
 #include <linux/fs.h>
-#include <uapi/linux/wmi.h>

 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
@@ -66,12 +63,9 @@ struct wmi_block {
 	struct wmi_device dev;
 	struct list_head list;
 	struct guid_block gblock;
-	struct miscdevice char_dev;
-	struct mutex char_mutex;
 	struct acpi_device *acpi_device;
 	wmi_notify_handler handler;
 	void *handler_data;
-	u64 req_buf_size;
 	unsigned long flags;
 };

@@ -256,26 +250,6 @@ static void wmi_device_put(struct wmi_device *wdev)
  * Exported WMI functions
  */

-/**
- * set_required_buffer_size - Sets the buffer size needed for performing =
IOCTL
- * @wdev: A wmi bus device from a driver
- * @length: Required buffer size
- *
- * Allocates memory needed for buffer, stores the buffer size in that mem=
ory.
- *
- * Return: 0 on success or a negative error code for failure.
- */
-int set_required_buffer_size(struct wmi_device *wdev, u64 length)
-{
-	struct wmi_block *wblock;
-
-	wblock =3D container_of(wdev, struct wmi_block, dev);
-	wblock->req_buf_size =3D length;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(set_required_buffer_size);
-
 /**
  * wmi_instance_count - Get number of WMI object instances
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
@@ -884,111 +858,12 @@ static int wmi_dev_match(struct device *dev, struct=
 device_driver *driver)

 	return 0;
 }
-static int wmi_char_open(struct inode *inode, struct file *filp)
-{
-	/*
-	 * The miscdevice already stores a pointer to itself
-	 * inside filp->private_data
-	 */
-	struct wmi_block *wblock =3D container_of(filp->private_data, struct wmi=
_block, char_dev);
-
-	filp->private_data =3D wblock;
-
-	return nonseekable_open(inode, filp);
-}
-
-static ssize_t wmi_char_read(struct file *filp, char __user *buffer,
-			     size_t length, loff_t *offset)
-{
-	struct wmi_block *wblock =3D filp->private_data;
-
-	return simple_read_from_buffer(buffer, length, offset,
-				       &wblock->req_buf_size,
-				       sizeof(wblock->req_buf_size));
-}
-
-static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long =
arg)
-{
-	struct wmi_ioctl_buffer __user *input =3D
-		(struct wmi_ioctl_buffer __user *) arg;
-	struct wmi_block *wblock =3D filp->private_data;
-	struct wmi_ioctl_buffer *buf;
-	struct wmi_driver *wdriver;
-	int ret;
-
-	if (_IOC_TYPE(cmd) !=3D WMI_IOC)
-		return -ENOTTY;
-
-	/* make sure we're not calling a higher instance than exists*/
-	if (_IOC_NR(cmd) >=3D wblock->gblock.instance_count)
-		return -EINVAL;
-
-	mutex_lock(&wblock->char_mutex);
-	buf =3D wblock->handler_data;
-	if (get_user(buf->length, &input->length)) {
-		dev_dbg(&wblock->dev.dev, "Read length from user failed\n");
-		ret =3D -EFAULT;
-		goto out_ioctl;
-	}
-	/* if it's too small, abort */
-	if (buf->length < wblock->req_buf_size) {
-		dev_err(&wblock->dev.dev,
-			"Buffer %lld too small, need at least %lld\n",
-			buf->length, wblock->req_buf_size);
-		ret =3D -EINVAL;
-		goto out_ioctl;
-	}
-	/* if it's too big, warn, driver will only use what is needed */
-	if (buf->length > wblock->req_buf_size)
-		dev_warn(&wblock->dev.dev,
-			"Buffer %lld is bigger than required %lld\n",
-			buf->length, wblock->req_buf_size);
-
-	/* copy the structure from userspace */
-	if (copy_from_user(buf, input, wblock->req_buf_size)) {
-		dev_dbg(&wblock->dev.dev, "Copy %llu from user failed\n",
-			wblock->req_buf_size);
-		ret =3D -EFAULT;
-		goto out_ioctl;
-	}
-
-	/* let the driver do any filtering and do the call */
-	wdriver =3D drv_to_wdrv(wblock->dev.dev.driver);
-	if (!try_module_get(wdriver->driver.owner)) {
-		ret =3D -EBUSY;
-		goto out_ioctl;
-	}
-	ret =3D wdriver->filter_callback(&wblock->dev, cmd, buf);
-	module_put(wdriver->driver.owner);
-	if (ret)
-		goto out_ioctl;
-
-	/* return the result (only up to our internal buffer size) */
-	if (copy_to_user(input, buf, wblock->req_buf_size)) {
-		dev_dbg(&wblock->dev.dev, "Copy %llu to user failed\n",
-			wblock->req_buf_size);
-		ret =3D -EFAULT;
-	}
-
-out_ioctl:
-	mutex_unlock(&wblock->char_mutex);
-	return ret;
-}
-
-static const struct file_operations wmi_fops =3D {
-	.owner		=3D THIS_MODULE,
-	.read		=3D wmi_char_read,
-	.open		=3D wmi_char_open,
-	.unlocked_ioctl	=3D wmi_ioctl,
-	.compat_ioctl	=3D compat_ptr_ioctl,
-};

 static int wmi_dev_probe(struct device *dev)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);
 	int ret =3D 0;
-	char *buf;

 	if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
 		dev_warn(dev, "failed to enable device -- probing anyway\n");
@@ -996,55 +871,17 @@ static int wmi_dev_probe(struct device *dev)
 	if (wdriver->probe) {
 		ret =3D wdriver->probe(dev_to_wdev(dev),
 				find_guid_context(wblock, wdriver));
-		if (ret !=3D 0)
-			goto probe_failure;
-	}
-
-	/* driver wants a character device made */
-	if (wdriver->filter_callback) {
-		/* check that required buffer size declared by driver or MOF */
-		if (!wblock->req_buf_size) {
-			dev_err(&wblock->dev.dev,
-				"Required buffer size not set\n");
-			ret =3D -EINVAL;
-			goto probe_failure;
-		}
+		if (!ret) {
+			if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
+				dev_warn(dev, "Failed to disable device\n");

-		wblock->handler_data =3D kmalloc(wblock->req_buf_size,
-					       GFP_KERNEL);
-		if (!wblock->handler_data) {
-			ret =3D -ENOMEM;
-			goto probe_failure;
-		}
-
-		buf =3D kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
-		if (!buf) {
-			ret =3D -ENOMEM;
-			goto probe_string_failure;
-		}
-		wblock->char_dev.minor =3D MISC_DYNAMIC_MINOR;
-		wblock->char_dev.name =3D buf;
-		wblock->char_dev.fops =3D &wmi_fops;
-		wblock->char_dev.mode =3D 0444;
-		ret =3D misc_register(&wblock->char_dev);
-		if (ret) {
-			dev_warn(dev, "failed to register char dev: %d\n", ret);
-			ret =3D -ENOMEM;
-			goto probe_misc_failure;
+			return ret;
 		}
 	}

 	set_bit(WMI_PROBED, &wblock->flags);
-	return 0;

-probe_misc_failure:
-	kfree(buf);
-probe_string_failure:
-	kfree(wblock->handler_data);
-probe_failure:
-	if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
-		dev_warn(dev, "failed to disable device\n");
-	return ret;
+	return 0;
 }

 static void wmi_dev_remove(struct device *dev)
@@ -1054,12 +891,6 @@ static void wmi_dev_remove(struct device *dev)

 	clear_bit(WMI_PROBED, &wblock->flags);

-	if (wdriver->filter_callback) {
-		misc_deregister(&wblock->char_dev);
-		kfree(wblock->char_dev.name);
-		kfree(wblock->handler_data);
-	}
-
 	if (wdriver->remove)
 		wdriver->remove(dev_to_wdev(dev));

@@ -1131,7 +962,6 @@ static int wmi_create_device(struct device *wmi_bus_d=
ev,

 	if (wblock->gblock.flags & ACPI_WMI_METHOD) {
 		wblock->dev.dev.type =3D &wmi_type_method;
-		mutex_init(&wblock->char_mutex);
 		goto out_init;
 	}

diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 8a643c39fcce..50f7f1e4fd4f 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/acpi.h>
 #include <linux/mod_devicetable.h>
-#include <uapi/linux/wmi.h>

 /**
  * struct wmi_device - WMI device structure
@@ -47,8 +46,6 @@ acpi_status wmidev_block_set(struct wmi_device *wdev, u8=
 instance, const struct

 u8 wmidev_instance_count(struct wmi_device *wdev);

-extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
-
 /**
  * struct wmi_driver - WMI driver structure
  * @driver: Driver model structure
@@ -57,11 +54,8 @@ extern int set_required_buffer_size(struct wmi_device *=
wdev, u64 length);
  * @probe: Callback for device binding
  * @remove: Callback for device unbinding
  * @notify: Callback for receiving WMI events
- * @filter_callback: Callback for filtering device IOCTLs
  *
  * This represents WMI drivers which handle WMI devices.
- * @filter_callback is only necessary for drivers which
- * want to set up a WMI IOCTL interface.
  */
 struct wmi_driver {
 	struct device_driver driver;
@@ -71,8 +65,6 @@ struct wmi_driver {
 	int (*probe)(struct wmi_device *wdev, const void *context);
 	void (*remove)(struct wmi_device *wdev);
 	void (*notify)(struct wmi_device *device, union acpi_object *data);
-	long (*filter_callback)(struct wmi_device *wdev, unsigned int cmd,
-				struct wmi_ioctl_buffer *arg);
 };

 extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
=2D-
2.39.2

