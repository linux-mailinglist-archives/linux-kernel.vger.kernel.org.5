Return-Path: <linux-kernel+bounces-59187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026A484F2D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3301C2505B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091B69953;
	Fri,  9 Feb 2024 09:56:27 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA769946;
	Fri,  9 Feb 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472586; cv=none; b=m7YguIhaM1t31d1IrJyvJLnOes5WPU7esOiciOt8XwvoY0ChpAbUP89cdcPvGqWqQ/kiMK34Q2blANASDpUtUn3Rlq39TkSzfmT3VutTOB5zApJ7aEvYb6+/6Nu56gcyz7sHH9B2tJqLuT3Ce7RWpS8myujvrt5ylxAI5LMRxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472586; c=relaxed/simple;
	bh=IIJB+il/YAqgBdhhLd/x55BSBVFoKksYvq3l+V1p/Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qkS+vgroR7TXcAKDLxaccuo+Ue7a7hmdaC9qtAr2QLztTDmWq8c8fnYhOCzMDtsYsHCisq7fqAvG3ylDJhnL1QQNkFDPCNlyupGeKsgwsl2XG6Z2/yn0FVPqdP9draEzod7JNQwZmu8QtxnEqQ8hTopik+Jrg+EuovtOqhMKj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so1177399a12.1;
        Fri, 09 Feb 2024 01:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707472582; x=1708077382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uin1djr9wjEmSC5e19XpHLz28aFoFMGRjrPrYFjt5vY=;
        b=RQHGY3jKxEwqXVagp3Ymutom3zlxzpwaHHg6FUM2/Oxl/LEpVolwsbZ1Qoun6gVVra
         wUbAdVzc5dZ18qU0k6nvENdgDmwHoGp2ps4IapuBs7XkR8jpcwDRoqAUuNgf6b+h6LRX
         lgZlloZ8aubgvw0PYxEsU8vtmu4qjIUc2rn9t084zk1kPgt4SxWTtjwgaW5ERHjpAKm+
         Te0razsDP6VqkRgMrop2GN1CubaEOpVHPIt6FMDAZW0MGnM7DSuzm+uww6kCmRbYVh7K
         Td3LNwL4vetk+VYlkDSl5ZtVFmFFwIMuOJfpIm2N7hw2FuQ0UAJr+uuZ5PR3Nex3LuVb
         XAbw==
X-Forwarded-Encrypted: i=1; AJvYcCUkTIHOdWhPUFKI3ZvFJcYBqzr0y9Apyy0XxlXTcVkNDI0wHRXj16qQTgPKqsm3KcvcfpY+COhmgG7iONW2ypK4BRRjeEqTpemPYhnZ
X-Gm-Message-State: AOJu0Yy2boDzWrh9oLx/bPnT4fYHPMC7/ccIqaRJ3foMa9Xc9Vm0KnSa
	5r/azSbuZdaLp2iy34JGhmqFTkF2BUpqfK5lXVqOqrkvaC0LK/EL
X-Google-Smtp-Source: AGHT+IHs+9l8aKZ19hOvC2jXHCv+iPMgv9WAYscFS2sh3Jeul6Kv3oCDFgLl25Yo8CAQn5mb3wfa7w==
X-Received: by 2002:a05:6402:1ed3:b0:561:4020:982f with SMTP id g19-20020a0564021ed300b005614020982fmr911342edg.22.1707472582146;
        Fri, 09 Feb 2024 01:56:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbSl2hNlU4WsCI+NqYOEx9SQaLAJgRfQpxVSepjWk1PtiND6yCBP8k5iLpU9HoXzKF1IiRHZ164tV7B9sN19SFWtY0jKL7aA9uAC38XO377YB2mo3YfWpAyvDXkmA8puojk+ahxzhEIwV9j5zkERaen1q4RfuKW0WB4wmeASyDYeYxXL/eSg9vWGhHRnVT+jhcoWlNg7dpp9j9XYEG0dJHL/UM8EhETe+j1TYRTRAwF7s=
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a23-20020aa7d757000000b005607fdd90b8sm624693eds.23.2024.02.09.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:56:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net] net: sysfs: Fix /sys/class/net/<iface> path for statistics
Date: Fri,  9 Feb 2024 01:55:18 -0800
Message-Id: <20240209095520.252555-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Documentation/ABI/testing/sysfs-class-net-statistics documentation
is pointing to the wrong path for the interface.  Documentation is
pointing to /sys/class/<iface>, instead of /sys/class/net/<iface>.

Fix it by adding the `net/` directory before the interface.

Fixes: 6044f9700645 ("net: sysfs: document /sys/class/net/statistics/*")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../ABI/testing/sysfs-class-net-statistics    | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-statistics b/Documentation/ABI/testing/sysfs-class-net-statistics
index 55db27815361..53e508c6936a 100644
--- a/Documentation/ABI/testing/sysfs-class-net-statistics
+++ b/Documentation/ABI/testing/sysfs-class-net-statistics
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/statistics/collisions
+What:		/sys/class/net/<iface>/statistics/collisions
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		Indicates the number of collisions seen by this network device.
 		This value might not be relevant with all MAC layers.
 
-What:		/sys/class/<iface>/statistics/multicast
+What:		/sys/class/net/<iface>/statistics/multicast
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -14,7 +14,7 @@ Description:
 		Indicates the number of multicast packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/rx_bytes
+What:		/sys/class/net/<iface>/statistics/rx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -23,7 +23,7 @@ Description:
 		See the network driver for the exact meaning of when this
 		value is incremented.
 
-What:		/sys/class/<iface>/statistics/rx_compressed
+What:		/sys/class/net/<iface>/statistics/rx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		network device. This value might only be relevant for interfaces
 		that support packet compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/rx_crc_errors
+What:		/sys/class/net/<iface>/statistics/rx_crc_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -41,7 +41,7 @@ Description:
 		by this network device. Note that the specific meaning might
 		depend on the MAC layer used by the interface.
 
-What:		/sys/class/<iface>/statistics/rx_dropped
+What:		/sys/class/net/<iface>/statistics/rx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -51,7 +51,7 @@ Description:
 		packet processing. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_errors
+What:		/sys/class/net/<iface>/statistics/rx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -59,7 +59,7 @@ Description:
 		Indicates the number of receive errors on this network device.
 		See the network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/rx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -68,7 +68,7 @@ Description:
 		network device. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_frame_errors
+What:		/sys/class/net/<iface>/statistics/rx_frame_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -78,7 +78,7 @@ Description:
 		on the MAC layer protocol used. See the network driver for
 		the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_length_errors
+What:		/sys/class/net/<iface>/statistics/rx_length_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -87,7 +87,7 @@ Description:
 		error, oversized or undersized. See the network driver for the
 		exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_missed_errors
+What:		/sys/class/net/<iface>/statistics/rx_missed_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -96,7 +96,7 @@ Description:
 		due to lack of capacity in the receive side. See the network
 		driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_nohandler
+What:		/sys/class/net/<iface>/statistics/rx_nohandler
 Date:		February 2016
 KernelVersion:	4.6
 Contact:	netdev@vger.kernel.org
@@ -104,7 +104,7 @@ Description:
 		Indicates the number of received packets that were dropped on
 		an inactive device by the network core.
 
-What:		/sys/class/<iface>/statistics/rx_over_errors
+What:		/sys/class/net/<iface>/statistics/rx_over_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -114,7 +114,7 @@ Description:
 		(e.g: larger than MTU). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_packets
+What:		/sys/class/net/<iface>/statistics/rx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -122,7 +122,7 @@ Description:
 		Indicates the total number of good packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/tx_aborted_errors
+What:		/sys/class/net/<iface>/statistics/tx_aborted_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -132,7 +132,7 @@ Description:
 		a medium collision). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_bytes
+What:		/sys/class/net/<iface>/statistics/tx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -143,7 +143,7 @@ Description:
 		transmitted packets or all packets that have been queued for
 		transmission.
 
-What:		/sys/class/<iface>/statistics/tx_carrier_errors
+What:		/sys/class/net/<iface>/statistics/tx_carrier_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -152,7 +152,7 @@ Description:
 		because of carrier errors (e.g: physical link down). See the
 		network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_compressed
+What:		/sys/class/net/<iface>/statistics/tx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -161,7 +161,7 @@ Description:
 		this might only be relevant for devices that support
 		compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/tx_dropped
+What:		/sys/class/net/<iface>/statistics/tx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -170,7 +170,7 @@ Description:
 		See the driver for the exact reasons as to why the packets were
 		dropped.
 
-What:		/sys/class/<iface>/statistics/tx_errors
+What:		/sys/class/net/<iface>/statistics/tx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -179,7 +179,7 @@ Description:
 		a network device. See the driver for the exact reasons as to
 		why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/tx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -188,7 +188,7 @@ Description:
 		FIFO error. See the driver for the exact reasons as to why the
 		packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_heartbeat_errors
+What:		/sys/class/net/<iface>/statistics/tx_heartbeat_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -197,7 +197,7 @@ Description:
 		reported as heartbeat errors. See the driver for the exact
 		reasons as to why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_packets
+What:		/sys/class/net/<iface>/statistics/tx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -206,7 +206,7 @@ Description:
 		device. See the driver for whether this reports the number of all
 		attempted or successful transmissions.
 
-What:		/sys/class/<iface>/statistics/tx_window_errors
+What:		/sys/class/net/<iface>/statistics/tx_window_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
-- 
2.39.3


