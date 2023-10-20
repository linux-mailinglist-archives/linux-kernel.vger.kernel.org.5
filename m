Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24E7D17C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjJTVIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjJTVIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF210C0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1123752b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836105; x=1698440905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXnBfDlArT8QQ+dhtd2r5fMDGlrQTZfL2E4sRwVy3fU=;
        b=Iu/XNEEYGxohnwSTLvfv4m9v02bvuXPrDS4a+kAt8x9UsUqVZTeSwHLL4YKPeXVQs4
         3ynwaL2GtPp5f5wRpdTyi/ogfvgaiB5o7cREBGrdgsDJcmxQbV4wH4ioCzOl3Arp7xZD
         fqZwyiF8+rmfK6DfjM1CJf8+NV+JqobTm4mZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836105; x=1698440905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXnBfDlArT8QQ+dhtd2r5fMDGlrQTZfL2E4sRwVy3fU=;
        b=DMlIEF3RPu81+/tw/sSLGl/mb9CdEgiCk8Vv7NhM+B0Tty6aL3TrNODaftcyrsljvN
         az+NxrBjzczvkeG3/IHpNU0vV4dNiASH/2wA44BcFsyaqyaBgc+iB200ThgBGohTsgBQ
         bwDqb6GDPmlvfUNNDg525mQuRkm3U3HHhjZIqqFZWQK5mJzm0V3j2c0PTnJpIu38PQKM
         zdrihDt5PPsdUM/nhJmAVbjBOIkQCB06rmm3YZDQVoXnRN8ctrNOpko+PBGzJPvxElH5
         u6d5BXwbeQ7pJv/V1uP4CdS6X/8D+HVHQKgffOwXfDtLCR23N/+3UiMh3GAVx5Q4XsOM
         Bhbg==
X-Gm-Message-State: AOJu0YwFzrz5wBx6wHEuFoy2mV+RO8RKCG+FcIJLNctPRzDmFQFt/oy8
        rqzWKbScVxGlhx51gdXHosFTXA==
X-Google-Smtp-Source: AGHT+IEb1MKkvrdCiTUUHUx2844H+lZouwvUUGZUYdWYX+sKgbuQD171isy8pFxgtyU5nlBqGpwG0Q==
X-Received: by 2002:a05:6a21:7748:b0:15d:8409:8804 with SMTP id bc8-20020a056a21774800b0015d84098804mr3161452pzc.57.1697836104815;
        Fri, 20 Oct 2023 14:08:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v5 8/8] r8152: Block future register access if register access fails
Date:   Fri, 20 Oct 2023 14:06:59 -0700
Message-ID: <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231020210751.3415723-1-dianders@chromium.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the functions to read/write registers can fail, most of
the places in the r8152 driver that read/write register values don't
check error codes. The lack of error code checking is problematic in
at least two ways.

The first problem is that the r8152 driver often uses code patterns
similar to this:
  x = read_register()
  x = x | SOME_BIT;
  write_register(x);

...with the above pattern, if the read_register() fails and returns
garbage then we'll end up trying to write modified garbage back to the
Realtek adapter. If the write_register() succeeds that's bad. Note
that as of commit f53a7ad18959 ("r8152: Set memory to all 0xFFs on
failed reg reads") the "garbage" returned by read_register() will at
least be consistent garbage, but it is still garbage.

It turns out that this problem is very serious. Writing garbage to
some of the hardware registers on the Ethernet adapter can put the
adapter in such a bad state that it needs to be power cycled (fully
unplugged and plugged in again) before it can enumerate again.

The second problem is that the r8152 driver generally has functions
that are long sequences of register writes. Assuming everything will
be OK if a random register write fails in the middle isn't a great
assumption.

One might wonder if the above two problems are real. You could ask if
we would really have a successful write after a failed read. It turns
out that the answer appears to be "yes, this can happen". In fact,
we've seen at least two distinct failure modes where this happens.

On a sc7180-trogdor Chromebook if you drop into kdb for a while and
then resume, you can see:
1. We get a "Tx timeout"
2. The "Tx timeout" queues up a USB reset.
3. In rtl8152_pre_reset() we try to reinit the hardware.
4. The first several (2-9) register accesses fail with a timeout, then
   things recover.

The above test case was actually fixed by the patch ("r8152: Increase
USB control msg timeout to 5000ms as per spec") but at least shows
that we really can see successful calls after failed ones.

On a different (AMD) based Chromebook with a particular adapter, we
found that during reboot tests we'd also sometimes get a transitory
failure. In this case we saw -EPIPE being returned sometimes. Retrying
worked, but retrying is not always safe for all register accesses
since reading/writing some registers might have side effects (like
registers that clear on read).

Let's fully lock out all register access if a register access fails.
When we do this, we'll try to queue up a USB reset and try to unlock
register access after the reset. This is slightly tricker than it
sounds since the r8152 driver has an optimized reset sequence that
only works reliably after probe happens. In order to handle this, we
avoid the optimized reset if probe didn't finish. Instead, we simply
retry the probe routine in this case.

When locking out access, we'll use the existing infrastructure that
the driver was using when it detected we were unplugged. This keeps us
from getting stuck in delay loops in some parts of the driver.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Originally when looking at this problem I thought that the obvious
solution was to "just" add better error handling to the driver. This
_sounds_ appealing, but it's a massive change and touches a
significant portion of the lines in this driver. It's also not always
obvious what the driver should be doing to handle errors.

If you feel like you need to be convinced and to see what it looked
like to add better error handling, I put up my "work in progress"
patch when I was investigating this at: https://crrev.com/c/4937290

There is still some active debate between the two approaches, though,
so it would be interesting to hear if anyone had any opinions.

NOTE: Grant's review tag was removed in v5 since v5 changed somewhat
significantly.

Changes in v5:
- Removed extra mutex_unlock() left over in v4.
- Fixed minor typos.
- Don't do queue an unbind/bind reset if probe fails; just retry probe.

Changes in v4:
- Took out some unnecessary locks/unlocks of the control mutex.
- Added comment about reading version causing probe fail if 3 fails.
- Added text to commit msg about the potential unbind/bind loop.

Changes in v3:
- Fixed v2 changelog ending up in the commit message.
- farmework -> framework in comments.

Changes in v2:
- Reset patch no longer based on retry patch, since that was dropped.
- Reset patch should be robust even if failures happen in probe.
- Switched booleans to bits in the "flags" variable.
- Check for -ENODEV instead of "udev->state == USB_STATE_NOTATTACHED"

 drivers/net/usb/r8152.c | 207 ++++++++++++++++++++++++++++++++++------
 1 file changed, 176 insertions(+), 31 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 65232848b31d..afb20c0ed688 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -773,6 +773,9 @@ enum rtl8152_flags {
 	SCHEDULE_TASKLET,
 	GREEN_ETHERNET,
 	RX_EPROTO,
+	IN_PRE_RESET,
+	PROBED_WITH_NO_ERRORS,
+	PROBE_SHOULD_RETRY,
 };
 
 #define DEVICE_ID_LENOVO_USB_C_TRAVEL_HUB		0x721e
@@ -953,6 +956,8 @@ struct r8152 {
 	u8 version;
 	u8 duplex;
 	u8 autoneg;
+
+	unsigned int reg_access_reset_count;
 };
 
 /**
@@ -1200,6 +1205,96 @@ static unsigned int agg_buf_sz = 16384;
 
 #define RTL_LIMITED_TSO_SIZE	(size_to_mtu(agg_buf_sz) - sizeof(struct tx_desc))
 
+/* If register access fails then we block access and issue a reset. If this
+ * happens too many times in a row without a successful access then we stop
+ * trying to reset and just leave access blocked.
+ */
+#define REGISTER_ACCESS_MAX_RESETS	3
+
+static void rtl_set_inaccessible(struct r8152 *tp)
+{
+	set_bit(RTL8152_INACCESSIBLE, &tp->flags);
+	smp_mb__after_atomic();
+}
+
+static void rtl_set_accessible(struct r8152 *tp)
+{
+	clear_bit(RTL8152_INACCESSIBLE, &tp->flags);
+	smp_mb__after_atomic();
+}
+
+static
+int r8152_control_msg(struct r8152 *tp, unsigned int pipe, __u8 request,
+		      __u8 requesttype, __u16 value, __u16 index, void *data,
+		      __u16 size, const char *msg_tag)
+{
+	struct usb_device *udev = tp->udev;
+	int ret;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return -ENODEV;
+
+	ret = usb_control_msg(udev, pipe, request, requesttype,
+			      value, index, data, size,
+			      USB_CTRL_GET_TIMEOUT);
+
+	/* No need to issue a reset to report an error if the USB device got
+	 * unplugged; just return immediately.
+	 */
+	if (ret == -ENODEV)
+		return ret;
+
+	/* If the write was successful then we're done */
+	if (ret >= 0) {
+		tp->reg_access_reset_count = 0;
+		return ret;
+	}
+
+	dev_err(&udev->dev,
+		"Failed to %s %d bytes at %#06x/%#06x (%d)\n",
+		msg_tag, size, value, index, ret);
+
+	/* Block all future register access until we reset. Much of the code
+	 * in the driver doesn't check for errors. Notably, many parts of the
+	 * driver do a read/modify/write of a register value without
+	 * confirming that the read succeeded. Writing back modified garbage
+	 * like this can fully wedge the adapter, requiring a power cycle.
+	 */
+	rtl_set_inaccessible(tp);
+
+	/* If probe hasn't yet finished, then we'll request a retry of the
+	 * whole probe routine if we get any control transfer errors. We
+	 * never have to clear this bit since we free/reallocate the whole "tp"
+	 * structure if we retry probe.
+	 */
+	if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
+		set_bit(PROBE_SHOULD_RETRY, &tp->flags);
+		return ret;
+	}
+
+	/* Failing to access registers in pre-reset is not surprising since we
+	 * wouldn't be resetting if things were behaving normally. The register
+	 * access we do in pre-reset isn't truly mandatory--we're just reusing
+	 * the disable() function and trying to be nice by powering the
+	 * adapter down before resetting it. Thus, if we're in pre-reset,
+	 * we'll return right away and not try to queue up yet another reset.
+	 * We know the post-reset is already coming.
+	 */
+	if (test_bit(IN_PRE_RESET, &tp->flags))
+		return ret;
+
+	if (tp->reg_access_reset_count < REGISTER_ACCESS_MAX_RESETS) {
+		usb_queue_reset_device(tp->intf);
+		tp->reg_access_reset_count++;
+	} else if (tp->reg_access_reset_count == REGISTER_ACCESS_MAX_RESETS) {
+		dev_err(&udev->dev,
+			"Tried to reset %d times; giving up.\n",
+			REGISTER_ACCESS_MAX_RESETS);
+	}
+
+	return ret;
+}
+
 static
 int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 {
@@ -1210,9 +1305,10 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
-			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
+	ret = r8152_control_msg(tp, tp->pipe_ctrl_in,
+				RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				value, index, tmp, size, "read");
+
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1233,9 +1329,9 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
-			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
+	ret = r8152_control_msg(tp, tp->pipe_ctrl_out,
+				RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
+				value, index, tmp, size, "write");
 
 	kfree(tmp);
 
@@ -1244,10 +1340,8 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 static void rtl_set_unplug(struct r8152 *tp)
 {
-	if (tp->udev->state == USB_STATE_NOTATTACHED) {
-		set_bit(RTL8152_INACCESSIBLE, &tp->flags);
-		smp_mb__after_atomic();
-	}
+	if (tp->udev->state == USB_STATE_NOTATTACHED)
+		rtl_set_inaccessible(tp);
 }
 
 static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
@@ -8262,7 +8356,7 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 	struct r8152 *tp = usb_get_intfdata(intf);
 	struct net_device *netdev;
 
-	if (!tp)
+	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
 		return 0;
 
 	netdev = tp->netdev;
@@ -8277,7 +8371,9 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 	napi_disable(&tp->napi);
 	if (netif_carrier_ok(netdev)) {
 		mutex_lock(&tp->control);
+		set_bit(IN_PRE_RESET, &tp->flags);
 		tp->rtl_ops.disable(tp);
+		clear_bit(IN_PRE_RESET, &tp->flags);
 		mutex_unlock(&tp->control);
 	}
 
@@ -8290,9 +8386,11 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	struct net_device *netdev;
 	struct sockaddr sa;
 
-	if (!tp)
+	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
 		return 0;
 
+	rtl_set_accessible(tp);
+
 	/* reset the MAC address in case of policy change */
 	if (determine_ethernet_addr(tp, &sa) >= 0) {
 		rtnl_lock();
@@ -9494,17 +9592,29 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 	__le32 *tmp;
 	u8 version;
 	int ret;
+	int i;
 
 	tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 	if (!tmp)
 		return 0;
 
-	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
-			      USB_CTRL_GET_TIMEOUT);
-	if (ret > 0)
-		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
+	/* Retry up to 3 times in case there is a transitory error. We do this
+	 * since retrying a read of the version is always safe and this
+	 * function doesn't take advantage of r8152_control_msg().
+	 */
+	for (i = 0; i < 3; i++) {
+		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+				      USB_CTRL_GET_TIMEOUT);
+		if (ret > 0) {
+			ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
+			break;
+		}
+	}
+
+	if (i != 0 && ret > 0)
+		dev_warn(&udev->dev, "Needed %d retries to read version\n", i);
 
 	kfree(tmp);
 
@@ -9603,25 +9713,14 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
 	return 0;
 }
 
-static int rtl8152_probe(struct usb_interface *intf,
-			 const struct usb_device_id *id)
+static int rtl8152_probe_once(struct usb_interface *intf,
+			      const struct usb_device_id *id, u8 version)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct r8152 *tp;
 	struct net_device *netdev;
-	u8 version;
 	int ret;
 
-	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
-		return -ENODEV;
-
-	if (!rtl_check_vendor_ok(intf))
-		return -ENODEV;
-
-	version = rtl8152_get_version(intf);
-	if (version == RTL_VER_UNKNOWN)
-		return -ENODEV;
-
 	usb_reset_device(udev);
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {
@@ -9784,10 +9883,20 @@ static int rtl8152_probe(struct usb_interface *intf,
 	else
 		device_set_wakeup_enable(&udev->dev, false);
 
+	/* If we saw a control transfer error while probing then we may
+	 * want to try probe() again. Consider this an error.
+	 */
+	if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
+		goto out2;
+
+	set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
 	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
 
 	return 0;
 
+out2:
+	unregister_netdev(netdev);
+
 out1:
 	tasklet_kill(&tp->tx_tl);
 	cancel_delayed_work_sync(&tp->hw_phy_work);
@@ -9796,10 +9905,46 @@ static int rtl8152_probe(struct usb_interface *intf,
 	rtl8152_release_firmware(tp);
 	usb_set_intfdata(intf, NULL);
 out:
+	if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
+		ret = -EAGAIN;
+
 	free_netdev(netdev);
 	return ret;
 }
 
+#define RTL8152_PROBE_TRIES	3
+
+static int rtl8152_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
+{
+	u8 version;
+	int ret;
+	int i;
+
+	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
+		return -ENODEV;
+
+	if (!rtl_check_vendor_ok(intf))
+		return -ENODEV;
+
+	version = rtl8152_get_version(intf);
+	if (version == RTL_VER_UNKNOWN)
+		return -ENODEV;
+
+	for (i = 0; i < RTL8152_PROBE_TRIES; i++) {
+		ret = rtl8152_probe_once(intf, id, version);
+		if (ret != -EAGAIN)
+			break;
+	}
+	if (ret == -EAGAIN) {
+		dev_err(&intf->dev,
+			"r8152 failed probe after %d tries; giving up\n", i);
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
 static void rtl8152_disconnect(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
-- 
2.42.0.758.gaed0368e0e-goog

