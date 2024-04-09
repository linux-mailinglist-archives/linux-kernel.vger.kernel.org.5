Return-Path: <linux-kernel+bounces-136970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993DD89DA75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DF71C21DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB035132814;
	Tue,  9 Apr 2024 13:35:21 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D712F376;
	Tue,  9 Apr 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669721; cv=none; b=bTIkRmSL6uyIzcAPzKhiy5WBLM88fdCzwZ/MBr03kgE7j+ohBl9on56I0YZDfhQVLxsJPigfdeWhm2uRggglP0ZL/5Z6hp+dLHYeGUL5jx5Yu/Eni073tDuKVuafwFx3NuE1r/mr+p5RpePAq4Udh7RySMiFaZbm6SLBssuGd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669721; c=relaxed/simple;
	bh=f9nTh0EfACiC5uRI99Wmu8UneIV2W1Qj3qTkTY7pT+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ay/qFASev01rOsV4gzGj+DonaYrd8l1VfAT61li2RCwMjU3yPw3L//y97nvOurLn/8JYnHCE8FJcc+VL6dYIfMQQDzHuFUc8KftFQIdPIQmuoTYFJAo7F2m2IZj9zwMzINBWVF8bWoVuL67ve2cE/SOR+DpZPUn5UR+I7T8AEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso6298157a12.0;
        Tue, 09 Apr 2024 06:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712669718; x=1713274518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6lqza+y20jmgL1FUPxo6ruPEO/LBvmrDYaeR7EHG0c=;
        b=kMI6byNhrmySNkJU/VxQedIEhwmjRpfTqBXbkipVlQh8zogrry3xfd1M403xJ7s2l4
         +QILkVK4WrkrmaNIcQPrQfdL5qs6zTcHaVFqfW1DzCHe7IhaDhrZ3i5Ff7XVqaRoS378
         kgiu8CszkCfr/mXPbZjYtwqOAgEGptsF9uB8ZoLv1gG2c9lo6Fl2ikX/y9pxh8X8bHGs
         z0fqI5OCCIGA6gVJTYAKxHVgdzjn8fBPbdPH5Fbd6RwQNA88HTfPlh81p9VhGNohQ9a2
         jmEnibFW/FAj3810L0BrKDgAxg2OMHeIWnpnGTdq1ENmfXdxzhaR4y3x7mMgkq0RwJ70
         9XlA==
X-Forwarded-Encrypted: i=1; AJvYcCWCWuVk9mkAg3h3gvl37cAFLGYfrLBhrrgkK5eQNK3rOqoLr1cKpmIlk9OvCU8oU4OhP+prCXtKbV/iLCkFpAMDhipKkuNj2mQxfTxMMmLAStyrLwS9G5RCjHtN8Ml4G9yf
X-Gm-Message-State: AOJu0Ywa9hzETCsr8O9J7HS0Vwtt6ep/NP3BKLC6pBQeyuf/IhFGCBtW
	opxietGiNBp4xgYCsKety08PjZ+qNLqni+LlHXjHppnZCHY/TaDG9MEwVYn3
X-Google-Smtp-Source: AGHT+IF4N0TpR/1q5j5evnyE0GihgQz26tXPuy2DErdFrHORTKmYrFyu8s8q3bMATTb1WkDayA2P9Q==
X-Received: by 2002:a17:906:694f:b0:a51:b228:9282 with SMTP id c15-20020a170906694f00b00a51b2289282mr5964031ejs.44.1712669717916;
        Tue, 09 Apr 2024 06:35:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906830500b00a4734125fd2sm5704159ejx.31.2024.04.09.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:35:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Oliver Neukum <oneukum@suse.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS)
Subject: [PATCH net-next 1/2] net: usb: qmi_wwan: Leverage core stats allocator
Date: Tue,  9 Apr 2024 06:33:05 -0700
Message-ID: <20240409133307.2058099-1-leitao@debian.org>
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

Remove the allocation in the qmi_wwan driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
PS: This was compiled-tested only due to lack of hardware.
---
 drivers/net/usb/qmi_wwan.c | 8 +-------
 drivers/net/usb/usbnet.c   | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e2e181378f41..5528a9c2b9d6 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -133,6 +133,7 @@ static void qmimux_setup(struct net_device *dev)
 	dev->flags           = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->netdev_ops      = &qmimux_netdev_ops;
 	dev->mtu             = 1500;
+	dev->pcpu_stat_type  = NETDEV_PCPU_STAT_TSTATS;
 	dev->needs_free_netdev = true;
 }
 
@@ -257,12 +258,6 @@ static int qmimux_register_device(struct net_device *real_dev, u8 mux_id)
 	priv->mux_id = mux_id;
 	priv->real_dev = real_dev;
 
-	new_dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!new_dev->tstats) {
-		err = -ENOBUFS;
-		goto out_free_newdev;
-	}
-
 	new_dev->sysfs_groups[0] = &qmi_wwan_sysfs_qmimux_attr_group;
 
 	err = register_netdevice(new_dev);
@@ -295,7 +290,6 @@ static void qmimux_unregister_device(struct net_device *dev,
 	struct qmimux_priv *priv = netdev_priv(dev);
 	struct net_device *real_dev = priv->real_dev;
 
-	free_percpu(dev->tstats);
 	netdev_upper_dev_unlink(real_dev, dev);
 	unregister_netdevice_queue(dev, head);
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index e84efa661589..f3f7f686fe9c 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1733,6 +1733,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 	net->min_mtu = 0;
 	net->max_mtu = ETH_MAX_MTU;
+	net->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	net->netdev_ops = &usbnet_netdev_ops;
 	net->watchdog_timeo = TX_TIMEOUT_JIFFIES;
-- 
2.43.0


