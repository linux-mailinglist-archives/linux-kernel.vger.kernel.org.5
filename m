Return-Path: <linux-kernel+bounces-49016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A6D8464D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6E31C225FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EE33F1;
	Fri,  2 Feb 2024 00:05:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E01C33
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832337; cv=none; b=linqSH6tTl0/NVfV8yyIiQctm4pRLa3zJhecTSV60vPeNAbyI/rFW1ovThr+BH0AR/ydFpkEgjVnOLW3cOxXxesIkVWJceajl5WBeQmJ+6mduMrqFTUSbySUfb3QF7gJpEF5GYxhm+2afzlUUIYUFJwRDnsBT15TJ1qACgc2tQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832337; c=relaxed/simple;
	bh=kd7VQnmUsU71voZAonpOddNGWnAdyA27EvCrZxkYNtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7fPHRIkhzcons1yfD9rteAyqs5teZMZEfbOd+iw7tFVMav6dChBBq9EcbyfjmrqFpYjFMGeechWVn0LvjVTyudJ9SDoJHssTRe3vwjnjsbx/23jm07g+IvWS4tBVUjx8Bu89Ri3LeUh4/0qt3h0Ba3UPVF4cyW+spP8wjSXaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rVh3Z-0000d1-Rc; Fri, 02 Feb 2024 01:05:21 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rVh3W-003xQ4-2u; Fri, 02 Feb 2024 01:05:18 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rVh3V-00AFlM-1i;
	Fri, 02 Feb 2024 01:05:18 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 02 Feb 2024 01:05:10 +0100
Subject: [PATCH v2 1/4] usb: gadget: function: move u_f.h to
 include/linux/usb/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v2-1-b46cbf592962@pengutronix.de>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4753;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=kd7VQnmUsU71voZAonpOddNGWnAdyA27EvCrZxkYNtE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBlvDG8vb2JOsyYBFyujuEewJZ6KYXGm1e9DbMmf
 HZzC8NbYGKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZbwxvAAKCRC/aVhE+XH0
 q4QSD/9DlXykK/GdUGTIk0dZrjfZ2NO6ybr8iWub5ZNkM+HRa2vK+wgpnaA1Lp0ZuGx7AdE+btI
 GhobdvFlAfkJm5s7DIaBiAwWPVVRsG+0iOq8ijbudTpZNjaRkYa2as8grR46uYti8rLIp531Xwl
 tH7+Yqa+qSRCfcT2SsJLT+1E7BLs0moqWCM9SPWtDpJ2IC5DMAKzui3uEtmwQMG3TjQhKO/tLbQ
 eFT5eLja7+Z1XePuOd+JINcYG39SNxnYh58N4u2fPRu017waV9pymdoT02KVQxjRQ6RT7+fhKxA
 n9BU033ocdSD8C43bVmXg4caKFPeIk1qeklnN3ypV3bid3HG7gGUu3W/CzR5VVNca4bVwrZ+aCN
 mEscAisDgAit57QyY4jZLgXh9OIKmlFJ4CDQ7NDJtguebd/2NNn6DNMHYkkM3sdjUQrBnpNGOup
 kqaMojrb10ajkK/kczqvERlSpk4DSkYryUzWqHZXZHHSLIHs/x1mvZKggZPxSpIUPzmOxfWl9ei
 SvBYVrJBRaem9lxeSZ+KilLMMS6C6fQGyX2V0JczkzIhNOAD2roATBqkWnnjJ8ocV0vE4ZMSW3x
 9a6eecgk9ddUUfvD3ZnLI9WwcS48HplXoQ1UY2oubzxU6DnFoTF9O9vWwkAKvKZScKn8i9HfYeL
 PPAX19srMDFvTtA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

We move the u_f.h header to include/linux/usb to be
able to compile function drivers outside of the
drivers/usb/gadget/function directory.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v1 -> v2:
  - new introduced patch
---
 drivers/usb/gadget/configfs.c                   | 2 +-
 drivers/usb/gadget/function/f_fs.c              | 2 +-
 drivers/usb/gadget/function/f_hid.c             | 2 +-
 drivers/usb/gadget/function/f_loopback.c        | 2 +-
 drivers/usb/gadget/function/f_midi.c            | 2 +-
 drivers/usb/gadget/function/f_midi2.c           | 2 +-
 drivers/usb/gadget/function/f_sourcesink.c      | 2 +-
 drivers/usb/gadget/u_f.c                        | 2 +-
 {drivers/usb/gadget => include/linux/usb}/u_f.h | 0
 9 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index ce3cfa1f36f51..4fa3eeafba814 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -8,8 +8,8 @@
 #include <linux/usb/composite.h>
 #include <linux/usb/gadget_configfs.h>
 #include <linux/usb/webusb.h>
+#include <linux/usb/u_f.h>
 #include "configfs.h"
-#include "u_f.h"
 #include "u_os_desc.h"
 
 int check_user_usb_string(const char *name,
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb937891..c7f6e06f39b31 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -30,6 +30,7 @@
 #include <linux/usb/ccid.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/functionfs.h>
+#include <linux/usb/u_f.h>
 
 #include <linux/aio.h>
 #include <linux/kthread.h>
@@ -37,7 +38,6 @@
 #include <linux/eventfd.h>
 
 #include "u_fs.h"
-#include "u_f.h"
 #include "u_os_desc.h"
 #include "configfs.h"
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c8a9dd585c09..a5b667a03ca83 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -16,8 +16,8 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/usb/g_hid.h>
+#include <linux/usb/u_f.h>
 
-#include "u_f.h"
 #include "u_hid.h"
 
 #define HIDG_MINORS	4
diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index 17ac6ace0cffa..d500025f45128 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -14,9 +14,9 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/usb/composite.h>
+#include <linux/usb/u_f.h>
 
 #include "g_zero.h"
-#include "u_f.h"
 
 /*
  * LOOPBACK FUNCTION ... a testing vehicle for USB peripherals,
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 20c6fbd94f32d..2d551ba385c71 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -33,8 +33,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/midi.h>
+#include <linux/usb/u_f.h>
 
-#include "u_f.h"
 #include "u_midi.h"
 
 MODULE_AUTHOR("Ben Williamson");
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index ec8cd7c7bbfc1..ad59be1f9c54d 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -18,8 +18,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/midi-v2.h>
+#include <linux/usb/u_f.h>
 
-#include "u_f.h"
 #include "u_midi2.h"
 
 struct f_midi2;
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 2edbd9b510d60..4283fb2e365bd 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -13,10 +13,10 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/usb/composite.h>
+#include <linux/usb/u_f.h>
 #include <linux/err.h>
 
 #include "g_zero.h"
-#include "u_f.h"
 
 /*
  * SOURCE/SINK FUNCTION ... a primary testing vehicle for USB peripheral
diff --git a/drivers/usb/gadget/u_f.c b/drivers/usb/gadget/u_f.c
index 6aea1ecb39999..90a7f742549a4 100644
--- a/drivers/usb/gadget/u_f.c
+++ b/drivers/usb/gadget/u_f.c
@@ -8,7 +8,7 @@
  * Author: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
  */
 
-#include "u_f.h"
+#include <linux/usb/u_f.h>
 #include <linux/usb/ch9.h>
 
 struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len)
diff --git a/drivers/usb/gadget/u_f.h b/include/linux/usb/u_f.h
similarity index 100%
rename from drivers/usb/gadget/u_f.h
rename to include/linux/usb/u_f.h

-- 
2.39.2


