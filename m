Return-Path: <linux-kernel+bounces-110050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BC0885960
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E00B2823CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE63484A27;
	Thu, 21 Mar 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NMYbxKjV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B8z9YuAR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB083CC6;
	Thu, 21 Mar 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025286; cv=none; b=uG96Zqy1Yy8bNb2T1Xt3uvoObB7gRQyeJHovIsGRZ+QB8QJdm0IBnqcvvoAKz+7YZE0GCAEa7eHnEuhFJwiN89TupCCNRs9L+sejUblNzLpAopomp09THvlz7GGgRanE7ZIQ2lRF+8t1a3JmyOPo9iA4RZp19+UFNy1rjv9Vxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025286; c=relaxed/simple;
	bh=4pwkuVPASujLtvUAcOeumSFvUYsF5sf+M00LrdtdnmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXtXJoSnSduzo4epT1DPxftCzmeQV27meVCXzop/H2xNr5eWTXZ1c7bVfxxR6GSuA6g8AUzLCp82UIJVevHGdzDNU+qMM9clr3MzwC/7A++I0Zvw58X8C1Jx8rHYrh6h3SNAy5iimh+ud0F05T48+PSOD7WJ6HVtdTOhSElU2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NMYbxKjV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B8z9YuAR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAE551FC83;
	Thu, 21 Mar 2024 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711025282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVje2G/MWNXU76aPP5C7g31t/cKVQY55RCzo6eErdoU=;
	b=NMYbxKjVzVQqSddBaVOYu7ujpvbBArz5B1aY6U+HuybMK/O4wdmPrFCt+mDs3yudNjpFKh
	qZiuF+I1UgZoxm2cDDmV5So1PsipAfVQJCMej9iuhMRRoINGYrcMo9KM1nc7i92dUGwxTD
	DHsVciLld0fAjcd2fnhmFtKkMqwedKM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711025281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVje2G/MWNXU76aPP5C7g31t/cKVQY55RCzo6eErdoU=;
	b=B8z9YuARPR1yqmPrxgg9bQI98U1yx3nTKtFsfVmMplhd2KJK/3hs+/NRGTCFQm4VXcHe4g
	zyXjgI4EzvJ8SafYlgtDSBHNOpfBrmtzPe08zePc26C5LTvouJU5adEPQRtPjqSCwXnYNm
	4PbLJm/Az1UUZ2zsjYhW2lg612QQ1+U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D666136AD;
	Thu, 21 Mar 2024 12:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y0NXHIEs/GVCTQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 21 Mar 2024 12:48:01 +0000
From: Oliver Neukum <oneukum@suse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
Subject: [PATCH net-next] usbnet: fix cyclical race on disconnect with work queue
Date: Thu, 21 Mar 2024 13:46:41 +0100
Message-ID: <20240321124758.6302-1-oneukum@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.20
X-Spamd-Result: default: False [2.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[9665bf55b1c828bbcd8a];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

The work can submit URBs and the URBs can schedule the work.
This cycle needs to be broken, when a device is to be stopped.
Use a flag to do so.

Fixes: f29fc259976e9 ("[PATCH] USB: usbnet (1/9) clean up framing")
Reported-by: syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c   | 37 ++++++++++++++++++++++++++++---------
 include/linux/usb/usbnet.h | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index e84efa661589..422d91635045 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -467,10 +467,12 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
 void usbnet_defer_kevent (struct usbnet *dev, int work)
 {
 	set_bit (work, &dev->flags);
-	if (!schedule_work (&dev->kevent))
-		netdev_dbg(dev->net, "kevent %s may have been dropped\n", usbnet_event_names[work]);
-	else
-		netdev_dbg(dev->net, "kevent %s scheduled\n", usbnet_event_names[work]);
+	if (!usbnet_going_away(dev)) {
+		if (!schedule_work (&dev->kevent))
+			netdev_dbg(dev->net, "kevent %s may have been dropped\n", usbnet_event_names[work]);
+		else
+			netdev_dbg(dev->net, "kevent %s scheduled\n", usbnet_event_names[work]);
+	}
 }
 EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
 
@@ -538,7 +540,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			if (!usbnet_going_away(dev))
+				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
@@ -849,6 +852,16 @@ int usbnet_stop (struct net_device *net)
 	del_timer_sync (&dev->delay);
 	tasklet_kill (&dev->bh);
 	cancel_work_sync(&dev->kevent);
+
+	/*
+	 * we have cyclic dependencies. Those calls are needed
+	 * to break a cycle. We cannot fall into the gaps because
+	 * we have a flag
+	 */
+	tasklet_kill (&dev->bh);
+	del_timer_sync (&dev->delay);
+	cancel_work_sync(&dev->kevent);
+
 	if (!pm)
 		usb_autopm_put_interface(dev->intf);
 
@@ -1174,7 +1187,8 @@ usbnet_deferred_kevent (struct work_struct *work)
 					   status);
 		} else {
 			clear_bit (EVENT_RX_HALT, &dev->flags);
-			tasklet_schedule (&dev->bh);
+			if (!usbnet_going_away(dev))
+				tasklet_schedule (&dev->bh);
 		}
 	}
 
@@ -1196,10 +1210,13 @@ usbnet_deferred_kevent (struct work_struct *work)
 			}
 			if (rx_submit (dev, urb, GFP_KERNEL) == -ENOLINK)
 				resched = 0;
-			usb_autopm_put_interface(dev->intf);
 fail_lowmem:
-			if (resched)
+			usb_autopm_put_interface(dev->intf);
+			if (resched) {
+				set_bit (EVENT_RX_MEMORY, &dev->flags);
+
 				tasklet_schedule (&dev->bh);
+			}
 		}
 	}
 
@@ -1212,13 +1229,13 @@ usbnet_deferred_kevent (struct work_struct *work)
 		if (status < 0)
 			goto skip_reset;
 		if(info->link_reset && (retval = info->link_reset(dev)) < 0) {
-			usb_autopm_put_interface(dev->intf);
 skip_reset:
 			netdev_info(dev->net, "link reset failed (%d) usbnet usb-%s-%s, %s\n",
 				    retval,
 				    dev->udev->bus->bus_name,
 				    dev->udev->devpath,
 				    info->description);
+			usb_autopm_put_interface(dev->intf);
 		} else {
 			usb_autopm_put_interface(dev->intf);
 		}
@@ -1562,6 +1579,7 @@ static void usbnet_bh (struct timer_list *t)
 	} else if (netif_running (dev->net) &&
 		   netif_device_present (dev->net) &&
 		   netif_carrier_ok(dev->net) &&
+		   !usbnet_going_away(dev) &&
 		   !timer_pending(&dev->delay) &&
 		   !test_bit(EVENT_RX_PAUSED, &dev->flags) &&
 		   !test_bit(EVENT_RX_HALT, &dev->flags)) {
@@ -1609,6 +1627,7 @@ void usbnet_disconnect (struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	if (!dev)
 		return;
+	usbnet_mark_going_away(dev);
 
 	xdev = interface_to_usbdev (intf);
 
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 9f08a584d707..d26599faab33 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -76,8 +76,26 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+/*
+ * this one is special, as it indicates that the device is going away
+ * there are cyclic dependencies between tasklet, timer and bh
+ * that must be broken
+ */
+#		define EVENT_UNPLUG		31
 };
 
+static inline bool usbnet_going_away(struct usbnet *ubn)
+{
+	smp_mb__before_atomic();
+	return test_bit(EVENT_UNPLUG, &ubn->flags);
+}
+
+static inline void usbnet_mark_going_away(struct usbnet *ubn)
+{
+	set_bit(EVENT_UNPLUG, &ubn->flags);
+	smp_mb__after_atomic();
+}
+
 static inline struct usb_driver *driver_of(struct usb_interface *intf)
 {
 	return to_usb_driver(intf->dev.driver);
-- 
2.44.0


