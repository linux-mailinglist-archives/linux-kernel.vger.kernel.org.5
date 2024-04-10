Return-Path: <linux-kernel+bounces-139206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131489FFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1099C1C251D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22311802B7;
	Wed, 10 Apr 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b="nrvZCq6v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJ61S3u+"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36E1802A1;
	Wed, 10 Apr 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773795; cv=none; b=UVKZZH7a2ZuN7SKEGdH4Q4+3xyWGg8DJc3L0d01QehF+PEQVzB99ZnpB4Ccug1qMtzY1ssWAAGo/tw+0Mopxm+GSYAr1zON0+g9Rt0MEMD72tDxld5bYPqYewgii9iwirr8rx9qFgYrSfwivb0SLVz5sX7mY353/4hRDh4TEAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773795; c=relaxed/simple;
	bh=SQCDWCsQ5RNLOnzg0m93ZoSRZmhabER90bEkvWudsp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NG1jurEktWddgHtjaqtJxqZJZFjxy0tTHTjIEqARdExr/am19JrOkAkkokk5kXk3YY5JWcUTdYwqsA/YQrlKDKy+GFO+cvv47QAwkirD6kHdzIASMZobABWwEEMNrjsVu7M/6PKogpbKhegvEIs3dlBh3ZzzxrCSotB7IGbIkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com; spf=pass smtp.mailfrom=noahloomans.com; dkim=pass (2048-bit key) header.d=noahloomans.com header.i=@noahloomans.com header.b=nrvZCq6v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJ61S3u+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noahloomans.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noahloomans.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 092251140153;
	Wed, 10 Apr 2024 14:29:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 10 Apr 2024 14:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noahloomans.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1712773791; x=1712860191; bh=LbUIMEaLar
	j+aDrxCGb4vfWzJ9bAenM4+MVOHeGEsfE=; b=nrvZCq6voGlzTaAYlA7+V89VmA
	i6rDnIWF0oWMi+3YUNi1MpAXl0dGmRNkU+zQE5vLm47h67n7O0Gy6pLnkuexOH5D
	EH4wr4evQOd35b4FdJdp11Q0BC1sxuld9Ac64UHe0feh8HACjKU3ruhNsyUONAO+
	tgLAewXORydyCiim/WXIHOLVb67jP7j05oI/C0rwcs0wfrK7LUV8XL5CvnZwvn5v
	3kPUQ4knBO2shraPC8ThOCwhrmAJkAY9V7un0EWlsPelbaqecQETkJEzwsWj/liJ
	gCSOW7Xc+zhsgzuTK0HVLi6ws9+ettC+uBr1v9czwP2/hfFYNN/0d7M/XfNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712773791; x=1712860191; bh=LbUIMEaLarj+aDrxCGb4vfWzJ9bA
	enM4+MVOHeGEsfE=; b=cJ61S3u+6iCgepsfGMIsDn03EcpAJ1IIOQmOzoy239AZ
	UFrYCzJ/qQPqNzGZvBGU+7+zwMg8Py8N4yK/+Uo/6o+Fo05HCS1ri71qlkHxmqav
	kekxy4+hK0taK6gwf5TnWrcklAbWg1ZthCvLY4h57BSMIJOC5+vuSLkq4+fE6YTw
	9rRgPFyBLJw1QEKUdg2AA7rFq6RVDbS2r//x8xJIVGW94g7HNdramBJOQEmucsBt
	mSlZptI23Lr95MGe8YxxI5yRkvOmW+aqr37RZn0eCx41VWcQSoosMI8+Ftfq4rt2
	JC7N2zrejh0Q2Q4YPvD4EXcSFl3nMW9VvjsuiB3iJg==
X-ME-Sender: <xms:ntoWZlfiLI-CBoRsZZ6qpc8e8zs54GtnOc7wMEqhzCAyTw3lzoYv_Q>
    <xme:ntoWZjOloKtj9ry8F7be-E7RMHu4hoxm7hOLJ8AuzQetgpfezyQpc-rrzE51fWQpI
    PAC4RVubl8GbSiyThY>
X-ME-Received: <xmr:ntoWZuiANuQ_JuoRAJYqidY1cpvBmKANhG96B_l-jKJoCdBlHXXuOcTgFswr3WmcjiVsnkZRWQclCkrh4apJwfiRfhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefpohgrhhcu
    nfhoohhmrghnshcuoehnohgrhhesnhhorghhlhhoohhmrghnshdrtghomheqnecuggftrf
    grthhtvghrnhepkeetieeguedvkeevfeekleehuedtjeefkeffledvhffhhefgtdejffeh
    gfehgeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epnhhorghhsehnohgrhhhlohhomhgrnhhsrdgtohhm
X-ME-Proxy: <xmx:ntoWZu--yG2cRuNUCy5zzoqSVuK-Sf-_AaIdiWWElExPV5yJLEGYQw>
    <xmx:ntoWZhvKm5wbamPVImMs5YnRYTlg4gLAuuzVeiwuQEsv2X4ns8BOog>
    <xmx:ntoWZtHrs-H09CKPy3wLh6Ba3Kh8Kk1EG-KIpmISK4K_TXlSKRvYSw>
    <xmx:ntoWZoO_wtTnCJ36wbjvoRNIKOmQ_ySfNNNKRmM7irG1Ct8gKW8aIg>
    <xmx:n9oWZnJ517JfIsduQ8q1S6ljhzW1Sc9g5yreNR3StMOjUPJorw3FISpZ>
Feedback-ID: i93394469:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 14:29:49 -0400 (EDT)
From: Noah Loomans <noah@noahloomans.com>
To: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Robert Zieba <robertzieba@google.com>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Noah Loomans <noah@noahloomans.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_uart: properly fix race condition
Date: Wed, 10 Apr 2024 20:26:19 +0200
Message-ID: <20240410182618.169042-2-noah@noahloomans.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec_uart_probe() function calls devm_serdev_device_open() before
it calls serdev_device_set_client_ops(). This can trigger a NULL pointer
dereference:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    ...
    CPU: 5 PID: 103 Comm: kworker/u16:3 Not tainted 6.8.4-zen1-1-zen #1 4a88f2661038c2a3bb69aa70fb41a5735338823c
    Hardware name: Google Morphius/Morphius, BIOS MrChromebox-4.22.2-1-g2a93624aebf 01/22/2024
    Workqueue: events_unbound flush_to_ldisc
    RIP: 0010:ttyport_receive_buf+0x3f/0xf0
    ...
    Call Trace:
     <TASK>
     ? __die+0x10f/0x120
     ? page_fault_oops+0x171/0x4e0
     ? srso_return_thunk+0x5/0x5f
     ? exc_page_fault+0x7f/0x180
     ? asm_exc_page_fault+0x26/0x30
     ? ttyport_receive_buf+0x3f/0xf0
     flush_to_ldisc+0x9b/0x1c0
     process_one_work+0x17b/0x340
     worker_thread+0x301/0x490
     ? __pfx_worker_thread+0x10/0x10
     kthread+0xe8/0x120
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x34/0x50
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1b/0x30
     </TASK>

A simplified version of crashing code is as follows:

    static inline size_t serdev_controller_receive_buf(struct serdev_controller *ctrl,
                                                      const u8 *data,
                                                      size_t count)
    {
            struct serdev_device *serdev = ctrl->serdev;

            if (!serdev || !serdev->ops->receive_buf) // CRASH!
                return 0;

            return serdev->ops->receive_buf(serdev, data, count);
    }

    static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
                                      const u8 *fp, size_t count)
    {
            struct serdev_controller *ctrl = port->client_data;
            [...]

            if (!test_bit(SERPORT_ACTIVE, &serport->flags))
                    return 0;

            ret = serdev_controller_receive_buf(ctrl, cp, count);

            [...]
            return ret;
    }

It assumes that if SERPORT_ACTIVE is set and serdev exists, serdev->ops
will also exist. This conflicts with the existing cros_ec_uart_probe()
logic, as it first calls devm_serdev_device_open() (which sets
SERPORT_ACTIVE), and only later sets serdev->ops via
serdev_device_set_client_ops().

Commit 01f95d42b8f4 ("platform/chrome: cros_ec_uart: fix race
condition") attempted to fix a similar race condition, but while doing
so, made the window of error for this race condition to happen much
wider.

Attempt to fix the race condition again, making sure we fully setup
before calling devm_serdev_device_open().

Fixes: 01f95d42b8f4 ("platform/chrome: cros_ec_uart: fix race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Noah Loomans <noah@noahloomans.com>
---

This is my first time contributing to Linux, I hope this is a good
patch. Feedback on how to improve is welcome!

 drivers/platform/chrome/cros_ec_uart.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 8ea867c2a01a..62bc24f6dcc7 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -263,12 +263,6 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
-	ret = devm_serdev_device_open(dev, serdev);
-	if (ret) {
-		dev_err(dev, "Unable to open UART device");
-		return ret;
-	}
-
 	serdev_device_set_drvdata(serdev, ec_dev);
 	init_waitqueue_head(&ec_uart->response.wait_queue);
 
@@ -280,14 +274,6 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 		return ret;
 	}
 
-	ret = serdev_device_set_baudrate(serdev, ec_uart->baudrate);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set up host baud rate (%d)", ret);
-		return ret;
-	}
-
-	serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
-
 	/* Initialize ec_dev for cros_ec  */
 	ec_dev->phys_name = dev_name(dev);
 	ec_dev->dev = dev;
@@ -301,6 +287,20 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 
 	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
 
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret) {
+		dev_err(dev, "Unable to open UART device");
+		return ret;
+	}
+
+	ret = serdev_device_set_baudrate(serdev, ec_uart->baudrate);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set up host baud rate (%d)", ret);
+		return ret;
+	}
+
+	serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
+
 	return cros_ec_register(ec_dev);
 }
 
-- 
2.44.0


