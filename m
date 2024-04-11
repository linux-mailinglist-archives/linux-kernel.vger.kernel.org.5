Return-Path: <linux-kernel+bounces-140763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C08A18D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D310285EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E31374F7;
	Thu, 11 Apr 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b="UACaogNa"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553522BCF6;
	Thu, 11 Apr 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849504; cv=none; b=mgJaVzgkKvCrYU3k8JHUOb3WC7T+dfJs8eTE8BNnuipyqJwFkHi9YpgwzGr2kzTcRZhEYH12IeNpx4UrPA/nsc9OJRUCMQNCOv9GpD3SKv0gMYm6U18eDM3E9UJkqwDcrnkVTi76lmR0kiFgXFWVsI7NAIpOhGsZiumhOAX5yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849504; c=relaxed/simple;
	bh=tbZsr0sSGSCxXMIDvmmKVl5pXk4Bjcijff8HHwfeNhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElSwteQOTIHTELI5Ljl5A6ncUrcTOFL8P0nGgblm+oNiH3cibQ7abAu5yxvJYfoN4b2i8v44Xa5szKmjvWQTfyrqcEwkRcR1Bed3BSW2TUS7lsiGjXMYiMqkc2y1nLw7PrufT0oVVufbWq3LbfcuJiXc3VSQ4UF8Q87QY7T/h5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io; spf=pass smtp.mailfrom=sylv.io; dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b=UACaogNa; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sylv.io
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VFk3G2nd8z9scY;
	Thu, 11 Apr 2024 17:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
	t=1712848970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwqedZ54CZtZon3qVCNXRRs4jtBdEtTfdznuqHMNeLk=;
	b=UACaogNaDNFa9u/9pXHrT5EB5/wcUyBLPaCzojGFh0mSjyQgDFsYOW2V/Kz6tIK6aeVqTP
	nzAH25k4TITgEKYNKmCp8vsgXQk895XA+HjUqRKfCO5FTLow3p+vuloPYqEvZYGHbdwDjl
	t4MFl47IjSKwnUeO8k4XMiJ8eTcS+DbE/oJ6O279gRQnqd6Jrc5NaOReJDB85YVsblIADS
	vsQFcoop7F3DjMvhbgTa21CRvCeOFNVF8VCOyIXBIWNa+wKIZ7GhaDPxRUyjL0887EAPsd
	Me5Oq7+UAasXWy5fps8CfUH77PqdXhVE7O+4DyEsswSgyXbqTK/mszWpscaKAQ==
From: Marcello Sylvester Bauer <sylv@sylv.io>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
	Matthias Stoeckl <matthias.stoeckl@secunet.com>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 1/2] usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
Date: Thu, 11 Apr 2024 17:22:10 +0200
Message-ID: <57a1c2180ff74661600e010c234d1dbaba1d0d46.1712843963.git.sylv@sylv.io>
In-Reply-To: <cover.1712843963.git.sylv@sylv.io>
References: <cover.1712843963.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dummy_hcd transfer scheduler assumes that the internal kernel timer
frequency is set to 1000Hz to give a polling interval of 1ms. Reducing
the timer frequency will result in an anti-proportional reduction in
transfer performance. Switch to a hrtimer to decouple this association.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0953e1b5c030..dab559d8ee8c 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -240,7 +240,7 @@ enum dummy_rh_state {
 struct dummy_hcd {
 	struct dummy			*dum;
 	enum dummy_rh_state		rh_state;
-	struct timer_list		timer;
+	struct hrtimer			timer;
 	u32				port_status;
 	u32				old_status;
 	unsigned long			re_timeout;
@@ -1301,8 +1301,8 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!timer_pending(&dum_hcd->timer))
-		mod_timer(&dum_hcd->timer, jiffies + 1);
+	if (!hrtimer_active(&dum_hcd->timer))
+		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1323,7 +1323,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		mod_timer(&dum_hcd->timer, jiffies);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1777,7 +1777,7 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
  * drivers except that the callbacks are invoked from soft interrupt
  * context.
  */
-static void dummy_timer(struct timer_list *t)
+static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 {
 	struct dummy_hcd	*dum_hcd = from_timer(dum_hcd, t, timer);
 	struct dummy		*dum = dum_hcd->dum;
@@ -1808,8 +1808,6 @@ static void dummy_timer(struct timer_list *t)
 		break;
 	}
 
-	/* FIXME if HZ != 1000 this will probably misbehave ... */
-
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
 
@@ -1817,7 +1815,7 @@ static void dummy_timer(struct timer_list *t)
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
 		spin_unlock_irqrestore(&dum->lock, flags);
-		return;
+		return HRTIMER_NORESTART;
 	}
 	dum_hcd->next_frame_urbp = NULL;
 
@@ -1995,10 +1993,12 @@ static void dummy_timer(struct timer_list *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		mod_timer(&dum_hcd->timer, jiffies + msecs_to_jiffies(1));
+		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2387,7 +2387,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			mod_timer(&dum_hcd->timer, jiffies);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2465,7 +2465,8 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2494,7 +2495,8 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2513,8 +2515,11 @@ static int dummy_start(struct usb_hcd *hcd)
 
 static void dummy_stop(struct usb_hcd *hcd)
 {
-	device_remove_file(dummy_dev(hcd_to_dummy_hcd(hcd)), &dev_attr_urbs);
-	dev_info(dummy_dev(hcd_to_dummy_hcd(hcd)), "stopped\n");
+	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
+
+	hrtimer_cancel(&dum_hcd->timer);
+	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
+	dev_info(dummy_dev(dum_hcd), "stopped\n");
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.44.0


