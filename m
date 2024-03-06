Return-Path: <linux-kernel+bounces-94047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23565873904
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0232E28126C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62013340D;
	Wed,  6 Mar 2024 14:26:53 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6F130E4A;
	Wed,  6 Mar 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735212; cv=none; b=AWd4eIs0k9f6ZZhx6BhP6Z9E35+pp9IXZLWdciMJy0dDKpPJd3Z/fzbP7Ed7w6rXl7mXQgLvMb513vB8wSWAcO7Ccjwr2DGbVKCwWoTgDUYHEEqCw8cBh18FhQtqaFdGvlsIM+N/2fftcN3qATO9fpkyaz6ZQdaQ8SUVSDLQwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735212; c=relaxed/simple;
	bh=spXrl0cpkI8U/JGv23K543iF1o4J1oTNfrIlz6uYPbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LP10HIhJU0+vY4T6mKHFU6N9O/433bykt7bTtJrtlsILKeazvskMtuEwEW7Jkuz+mSVYKLgabk08etNaV1T4AuLa9/HV4Pd9ZkZyXmlBL+TCm+B70hxfCudCBAbE89UQqaw71a7az0ATS3NtZoJT0/H9n/BNCtZ8ApfezzVagRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso10066349a12.3;
        Wed, 06 Mar 2024 06:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735209; x=1710340009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/vFaq6XZtMUFoGhIOxwz4EZMEc/T8NwmKiTND7gdLc=;
        b=DSRYOu7oDhRl5bhcQMqWkvlWDV5f2zws7p2QK044oMcTK07/PffIk2a/nU3xjitU9+
         SHyjHL8qt2MdxYcUV+dJdBqX+OFxnRNHSNn9HIGVg7cR+j9i6gWaYfCkiIm+Pk0z7Tpj
         asCFRIf5OpNQNQCnW/8E0VSlutdTChfFu4uh76VaO1OWTsFjqclz2rYxZkSNK5nCqffd
         Jb2t7QLyyCcLcJDeEaxnjteknX8A9msKF+EFLnsLITa+062IioDLO/hwQji51pFhn3V0
         xFjrSrzvGInc6W2n+btmsdr2R3ZBiZNBpwo/QCu+lVlFeQQMW7Rd4vaCUzNrjpSVKhx/
         nUKg==
X-Forwarded-Encrypted: i=1; AJvYcCW5QR9F8jMx28Uk3vQv0rgomuGfptKixxQDmAOxDkEopRUv8QFq3t3X0jDdQJ7y/4yWQaltjfFA7j0rcTRJv6+DmfF8vIAz4kFnw4HE7APOd99E4MGnltL1BGbVljfJ8xOQugfpQYS5
X-Gm-Message-State: AOJu0Yy1uKa2HSQzNzvr+qUatKuPGRjJYOrftgeuZDaOctXingBrvPN0
	monAAx4E4lKBFXnEK/hzpRrFpjNvHt0z2Rk6Cm/ESa+CH+LoYP71
X-Google-Smtp-Source: AGHT+IFJpV1Npg6Fs/H15eBAtNoVnA8/iT8ZzI3QDv8j+bCEzEfPSKZQ/IbVLLRtQ/a+doq0M9fi+g==
X-Received: by 2002:a05:6402:5c5:b0:566:ab45:e6c0 with SMTP id n5-20020a05640205c500b00566ab45e6c0mr10537608edx.33.1709735209315;
        Wed, 06 Mar 2024 06:26:49 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7c514000000b005663e9bd8c1sm6944833edq.38.2024.03.06.06.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:26:49 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS)
Subject: [PATCH net-next 1/2] net: usbnet: Leverage core stats allocator
Date: Wed,  6 Mar 2024 06:26:41 -0800
Message-ID: <20240306142643.2429409-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the usbnet driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/usb/usbnet.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index b21ebe24057f..a3a46794ce43 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1633,7 +1633,6 @@ void usbnet_disconnect (struct usb_interface *intf)
 	usb_free_urb(dev->interrupt);
 	kfree(dev->padding_pkt);
 
-	free_percpu(net->tstats);
 	free_netdev(net);
 }
 EXPORT_SYMBOL_GPL(usbnet_disconnect);
@@ -1710,10 +1709,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	dev->rx_speed = SPEED_UNSET;
 	dev->tx_speed = SPEED_UNSET;
 
-	net->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!net->tstats)
-		goto out0;
-
 	dev->msg_enable = netif_msg_init (msg_level, NETIF_MSG_DRV
 				| NETIF_MSG_PROBE | NETIF_MSG_LINK);
 	init_waitqueue_head(&dev->wait);
@@ -1743,6 +1738,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	net->netdev_ops = &usbnet_netdev_ops;
 	net->watchdog_timeo = TX_TIMEOUT_JIFFIES;
 	net->ethtool_ops = &usbnet_ethtool_ops;
+	net->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	// allow device-specific bind/init procedures
 	// NOTE net->name still not usable ...
@@ -1861,8 +1857,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	 */
 	cancel_work_sync(&dev->kevent);
 	del_timer_sync(&dev->delay);
-	free_percpu(net->tstats);
-out0:
 	free_netdev(net);
 out:
 	return status;
-- 
2.43.0


