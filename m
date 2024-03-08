Return-Path: <linux-kernel+bounces-96392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277F875B89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771021C20EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12380ED0;
	Fri,  8 Mar 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHvKvv5h"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6E163;
	Fri,  8 Mar 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857531; cv=none; b=l5RsBzneC67X1x5IJOcCiSAZVdnIcS5uPDqr8YguD8id6aNZBQReTE5DOCbAlxpAdMh45qncE1IIGZqpR1JHaN1QyDkEfcr7N6E9MBdL+db9lN1IyKYbaacuQ5lQZBo8aPWVBV/K5YtKSOrzBdxjTVGB2WkW2kAenyUoCI90aOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857531; c=relaxed/simple;
	bh=NoWiEoGffuJezyZWQ17Um+qaB1+8zBLrVs97fy9ve34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDSHklF7/qBACaj/PdG6StH+WFOQhwGh/7/yVq97ycYHiRflhxhG4q+F62/SaMO1QPSSiuHS2AykjK4T3ycSjtMA/giJAVNm1weQTfFdW/BUJdbakXNRqvzsZ6fRLUwnFY/92eZCC/tsJCu5bvPKm1vN9JF2l4CQMPIjHPxjJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHvKvv5h; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so943978b3a.1;
        Thu, 07 Mar 2024 16:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709857527; x=1710462327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGA5+tZzMeOjlHUhcX3WLJZzgdRHTP/pyb/RcLBJvao=;
        b=RHvKvv5hWIpIKkiqAgBaX/3R7rCX9f48N4UK193aoLf8F5L+SZ+cbwpnO5cJBnmSEL
         zWFF4maCXqwirfq53NZh6M3OPxVvBl9ZEAOxpHzyZm6p7klv36q2y76kFA+VpwQZDBRO
         adYWmQKPJY23DbHTmTHmzVsB45MQkyUusQoGA6SexiPVgSkeJvxH8aNAQeqsB6DJCYkk
         +U2sdCC0Whb7qIFFXHiXVs5FPMRMSjNxdqPs/sssTN2uGSVUCODwwfiZ8529rNagXa36
         vd9jAUBEoAftRboSFJwcw2oA2QOfk+YgDJ1y92ASq4glDOccga1bptS0abt147696cCH
         BWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857527; x=1710462327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGA5+tZzMeOjlHUhcX3WLJZzgdRHTP/pyb/RcLBJvao=;
        b=TyuhsAPuo2L2vCbFNgDzeciNTjDOZEkglShFZ5WMaQIBSZoglShqaT1ikYg7izeFAq
         pz7AqMrXqbnrHDz18KmWu37vwZVl/L9/rKUwN2GQ7dy/4aBvy8mtp7+eib92lqd2KMC8
         z9p4UisYphZskiVFKGgXLppUNMCDMlcL1LW6ASgJb9b6RjPMHlLzKjZrVzWv3Gj7ysPf
         H738axSAUB+l734Mbx7jbdo5TlvYKhv9suQnQLiiSG84S3xguJzsh64bl+oTv/W4DNDQ
         jCJH9h2uSelkqNrxxc9S74PxDD3WX3ubug9EyafXzl9SwR4Ek33yJT7aAxZ+TFlSY0sU
         OhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdyRljzXFUxt+LFFXIDW/ZGJIqASgeLgbsPjq+JIo6rJb0+8kj9cKfruekijicZzCsKQut9E/VKfrwZxX+YmDxmAE3hjyPPV6oXjWbb97h70H+adiyOoUdPzj+tkuN5laurBIAAkBl
X-Gm-Message-State: AOJu0YyC57z/NdYkLdoiI4i2/RfUnan4WD93kEfPj71anfNqJGtT1U04
	kAbXIspsO1ZjPi4WIoBvMAYqAk4ZZYxHmoLN9dbOFf3oyPFGtUmI
X-Google-Smtp-Source: AGHT+IE1/ntw3jlhoAiRluZaxPT+dxi/Syac8xM/yjVl3j8vj5lcBMBvjRqmvZOc1eiTyLawL98Fgg==
X-Received: by 2002:a05:6a20:a106:b0:1a1:82fc:94e2 with SMTP id q6-20020a056a20a10600b001a182fc94e2mr145477pzk.44.1709857527115;
        Thu, 07 Mar 2024 16:25:27 -0800 (PST)
Received: from localhost ([2601:644:9381:2f20::5510])
        by smtp.gmail.com with ESMTPSA id p12-20020aa7860c000000b006e50e79f155sm13050105pfn.60.2024.03.07.16.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 16:25:26 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: netconsole: Add continuation line prefix to userdata messages
Date: Thu,  7 Mar 2024 16:25:24 -0800
Message-ID: <20240308002525.248672-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a space (' ') prefix to every userdata line to match docs for
dev-kmsg. To account for this extra character in each userdata entry,
reduce userdata entry names (directory name) from 54 characters to 53.

According to the dev-kmsg docs, a space is used for subsequent lines to
mark them as continuation lines.

> A line starting with ' ', is a continuation line, adding
> key/value pairs to the log message, which provide the machine
> readable context of the message, for reliable processing in
> userspace.

Testing for this patch::

 cd /sys/kernel/config/netconsole && mkdir cmdline0
 cd cmdline0
 mkdir userdata/test && echo "hello" > userdata/test/value
 mkdir userdata/test2 && echo "hello2" > userdata/test2/value
 echo "message" > /dev/kmsg

Outputs::

 6.8.0-rc5-virtme,12,493,231373579,-;message
  test=hello
  test2=hello2

And I confirmed all testing works as expected from the original patchset

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 Documentation/networking/netconsole.rst |  8 ++++----
 drivers/net/netconsole.c                | 12 +++++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index b28c525e5d1e..d55c2a22ec7a 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -180,7 +180,7 @@ Custom user data can be appended to the end of messages with netconsole
 dynamic configuration enabled. User data entries can be modified without
 changing the "enabled" attribute of a target.
 
-Directories (keys) under `userdata` are limited to 54 character length, and
+Directories (keys) under `userdata` are limited to 53 character length, and
 data in `userdata/<key>/value` are limited to 200 bytes::
 
  cd /sys/kernel/config/netconsole && mkdir cmdline0
@@ -197,8 +197,8 @@ Messages will now include this additional user data::
 Sends::
 
  12,607,22085407756,-;This is a message
- foo=bar
- qux=baz
+  foo=bar
+  qux=baz
 
 Preview the userdata that will be appended with::
 
@@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
 
  echo "This is a message" > /dev/kmsg
  12,607,22085407756,-;This is a message
- foo=bar
+  foo=bar
 
 Delete `userdata` entries with `rmdir`::
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0de108a1c0c8..d7070dd4fe73 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -42,12 +42,14 @@ MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
-#define MAX_PARAM_LENGTH	256
-#define MAX_USERDATA_NAME_LENGTH	54
-#define MAX_USERDATA_VALUE_LENGTH	200
+#define MAX_PARAM_LENGTH		256
 #define MAX_USERDATA_ENTRY_LENGTH	256
+#define MAX_USERDATA_VALUE_LENGTH	200
+/* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
+#define MAX_USERDATA_NAME_LENGTH	(MAX_USERDATA_ENTRY_LENGTH - \
+					MAX_USERDATA_VALUE_LENGTH - 3)
 #define MAX_USERDATA_ITEMS		16
-#define MAX_PRINT_CHUNK		1000
+#define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
@@ -671,7 +673,7 @@ static void update_userdata(struct netconsole_target *nt)
 		 * checked to not exceed MAX items with child_count above
 		 */
 		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
-					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
+					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
 					  item->ci_name, udm_item->value);
 	}
 	nt->userdata_length = strnlen(nt->userdata_complete,
-- 
2.44.0


