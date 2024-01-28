Return-Path: <linux-kernel+bounces-41867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F175983F8FF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B17D1F217AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73092E62B;
	Sun, 28 Jan 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="l5YE3eTz"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A722E62A;
	Sun, 28 Jan 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465178; cv=none; b=r/YyvXC37SGGoenAN+U5cHPmLn+xTcw5mxI52WajVx/m2luwGmxcIbhqs/td1OxAHxBUp3xvr02X6z8lKwvPfduHsbtTc6ey78El1k4DwHWeEgAZwD3gxjBhXe1ZSxcXJf0tIBAmyiNZOU/Xtzl2ExDrQti82pfvnvklmAtgS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465178; c=relaxed/simple;
	bh=sS1ZWEmQKtZR7kwdEZ+vuqXJLlJ/VTALKyjf/CpHz2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFPFBzm6b9jC9bScAjKUKF4Q76vCij9cJvgeI19j8sIGMDzrVANt2+QQAxk83Uz5+42+WF6fv6Ag1S7ZLQroFpVbCSKzAqJiWwyf4sKt8Ey+h80NTSyEoHPsJZvqX3UBLg8ze2aCGchTfyDm+HvDL7EltgPx/l75t6D4vxKpqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=l5YE3eTz; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wqej4+vmTV/rU8AtrwDFmSZQizv8btuEV2EtfTfvd/8=; b=l5YE3eTzYsQYcO7x3N661sRzKX
	+7qFZ8/zRZBqVG4a41b+F0JEGCvLlrboPFIxoolUf5AAkY4UymjGAJyxygTJxBrT74t3L27hUr1TN
	k4LflZytG+bZQ9bh+KkaIKPM97N61dzLkkxPiy3XOO5TVrna70FgzB4+rFvkFWc6BmjhxHUdqOITo
	kzIha6oJuWiT6OD/qy49BqNW1lu/zIADbS1qwAiXmxEe22mcUwY1FYuEmubYic0WCSSl60dUQR2IY
	h3kQmewRVuflREZuokofcnhidqsW5JxIxl+hz2n7DBohwsSrI0nC0nrNd2OWb4VAsaG0Whrr4m3R6
	Yzmq/Frw==;
Received: from p200300c2070939001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:709:3900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rU92c-008qDd-CQ; Sun, 28 Jan 2024 18:33:58 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rU92b-00BO9l-2W;
	Sun, 28 Jan 2024 18:33:57 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [RFC PATCH v2 2/3] bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips
Date: Sun, 28 Jan 2024 18:33:51 +0100
Message-Id: <20240128173352.2714442-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128173352.2714442-1-andreas@kemnade.info>
References: <20240128173352.2714442-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of these chips have GNSS support. GNSS support
is available through channel 9 whilst FM is through channel 8.
Add a platform subdevice for GNSS so that a driver for that
functionality can be build. To avoid having useless GNSS
devices, do it only when the devicetree node namecontains gnss.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/bluetooth/hci_ll.c   | 81 ++++++++++++++++++++++++++++++++++++
 include/linux/ti_wilink_st.h |  8 ++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 4a0b5c3160c2b..09e5a4dbd2f8c 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -32,6 +32,7 @@
 #include <linux/signal.h>
 #include <linux/ioctl.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 #include <linux/ti_wilink_st.h>
@@ -68,6 +69,9 @@ struct ll_device {
 	struct gpio_desc *enable_gpio;
 	struct clk *ext_clk;
 	bdaddr_t bdaddr;
+
+	void (*gnss_recv_func)(struct device *dev, struct sk_buff *skb);
+	struct platform_device *gnssdev;
 };
 
 struct ll_struct {
@@ -78,6 +82,8 @@ struct ll_struct {
 	struct sk_buff_head tx_wait_q;	/* HCILL wait queue	*/
 };
 
+static int ll_gnss_register(struct ll_device *lldev);
+static int ll_gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
 /*
  * Builds and sends an HCILL command packet.
  * These are very simple packets with only 1 cmd byte
@@ -411,6 +417,13 @@ static int ll_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	.lsize = 0, \
 	.maxlen = 0
 
+#define LL_RECV_GNSS \
+	.type = 9, \
+	.hlen = 3, \
+	.loff = 1, \
+	.lsize = 2
+
+
 static const struct h4_recv_pkt ll_recv_pkts[] = {
 	{ H4_RECV_ACL,       .recv = hci_recv_frame },
 	{ H4_RECV_SCO,       .recv = hci_recv_frame },
@@ -419,6 +432,7 @@ static const struct h4_recv_pkt ll_recv_pkts[] = {
 	{ LL_RECV_SLEEP_ACK, .recv = ll_recv_frame  },
 	{ LL_RECV_WAKE_IND,  .recv = ll_recv_frame  },
 	{ LL_RECV_WAKE_ACK,  .recv = ll_recv_frame  },
+	{ LL_RECV_GNSS,      .recv = ll_gnss_recv_frame },
 };
 
 /* Recv data */
@@ -677,9 +691,69 @@ static int ll_setup(struct hci_uart *hu)
 		}
 	}
 
+	if (strstr(of_node_full_name(serdev->dev.of_node), "gnss"))
+		ll_gnss_register(lldev);
+
+	return 0;
+}
+
+struct hci_dev *st_get_hci(struct device *dev)
+{
+	struct ll_device *lldev = dev_get_drvdata(dev);
+
+	return lldev->hu.hdev;
+}
+EXPORT_SYMBOL(st_get_hci);
+
+void st_set_gnss_recv_func(struct device *dev,
+			   void (*recv_frame)(struct device *, struct sk_buff *))
+{
+	struct ll_device *lldev = dev_get_drvdata(dev);
+
+	lldev->gnss_recv_func = recv_frame;
+}
+EXPORT_SYMBOL(st_set_gnss_recv_func);
+
+static int ll_gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct ll_device *lldev = container_of(hu, struct ll_device, hu);
+
+	if (!lldev->gnssdev)
+		return 0;
+
+	if (lldev->gnss_recv_func) {
+		lldev->gnss_recv_func(&lldev->gnssdev->dev, skb);
+		return 0;
+	}
+	kfree_skb(skb);
+
 	return 0;
 }
 
+static int ll_gnss_register(struct ll_device *lldev)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc("ti-ai2-gnss", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = &lldev->serdev->dev;
+	lldev->gnssdev = pdev;
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	lldev->gnssdev = NULL;
+	platform_device_put(pdev);
+	return ret;
+}
+
 static const struct hci_uart_proto llp;
 
 static int hci_ti_probe(struct serdev_device *serdev)
@@ -757,12 +831,19 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	}
 
 	return hci_uart_register_device(hu, &llp);
+
+
+	return 0;
 }
 
+
 static void hci_ti_remove(struct serdev_device *serdev)
 {
 	struct ll_device *lldev = serdev_device_get_drvdata(serdev);
 
+	if (lldev->gnssdev)
+		platform_device_unregister(lldev->gnssdev);
+
 	hci_uart_unregister_device(&lldev->hu);
 }
 
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 10642d4844f0c..eccc2db004069 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -381,6 +381,14 @@ unsigned long st_ll_getstate(struct st_data_s *);
 unsigned long st_ll_sleep_state(struct st_data_s *, unsigned char);
 void st_ll_wakeup(struct st_data_s *);
 
+/**
+ * various funcs used to interact between FM, GPS and BT
+ */
+struct hci_dev *st_get_hci(struct device *dev);
+void st_set_gnss_recv_func(struct device *dev,
+			   void (*recv_frame)(struct device *, struct sk_buff *));
+
+
 /*
  * header information used by st_core.c for FM and GPS
  * packet parsing, the bluetooth headers are already available
-- 
2.39.2


