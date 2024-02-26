Return-Path: <linux-kernel+bounces-81545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5867867756
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C212284B01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE812A146;
	Mon, 26 Feb 2024 13:56:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A101292D9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955781; cv=none; b=K9xZbt4UbsYIlgv52IhxbYxfjSbO7KL37WffgpIq4sHy7rlDM/ztZOs20fBVSTxCF+XwBfUOu4nDsK0ZYK+bkmXWsB86lYEYRJ9XpnVEsuN/EOuE5WOxKCe86M+mviaGFeb4N9CujtXUdgoPjr0n9KTxFIyP86d2RWiLZ4qEGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955781; c=relaxed/simple;
	bh=hLvrDMdPAFgM5IKpslImfYlwxbACfbpSQ4vSR01p87g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rm+qmNKlFQPR8KcK8+uhsASEvim4RW0zKTv+VoPBhAl+pRjii8I4CVrax4CA2rgY8CYd7y2E2RKw6Uc0dDThfcqv8emZ5HQO2d5+QR4mg7gjmHJ2oiWSPI16E2S+t0XBhLEu0tBIWE8QBo4ML6hRwYKaPMVSt8j2Bru9bQastS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSh-00047C-FK; Mon, 26 Feb 2024 14:56:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-0030Qe-Bk; Mon, 26 Feb 2024 14:56:06 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-009FzF-0z;
	Mon, 26 Feb 2024 14:56:06 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 26 Feb 2024 14:56:04 +0100
Subject: [PATCH v3 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v3-1-c62a36eccda1@pengutronix.de>
References: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4766;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=hLvrDMdPAFgM5IKpslImfYlwxbACfbpSQ4vSR01p87g=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl3Jh1ebf19STNTB0FF3JXq7kURXIvBtyy6Zh8g
 zQPt07t+VyJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdyYdQAKCRC/aVhE+XH0
 q8a3D/sHscg8PGvNurbxlhXp0CVy232+AHjUoQTFrL3vSRfoHXU20KJuamZ3uU9P7EtGS/wfMuu
 dEx2D4WAiwhSk5wR8CEnDtzRt1EuVKRGmAtO5Uwn1R/qvv2Qnn6P16xC07/VG/NDCrsUivgEtkx
 UQQsYyaJxiTa+SeCbaIbmU0RI1kUxnAFKWHlrhdKtxUmcjgoLrl3wOVk7iuebLIvgJPBEbvHSWC
 RLnTDB1tIcZdfp2dV/NyagG8vZcPGwKwSnBivpS/nfmGmFsqNTgLeqi0acJJFWtafYET5Z7LG2I
 vwvXMd3CZE5wFzCw3GygwAwY+2IUZ49JObzKUdNxalsK4v0XIMSaIiFiIZfs2PiavJ3ToFYnyLJ
 7SqLl5juH+fYrdwSh0qeVKE0NaBE9ns+0d9Kxnr/rLPD/h9EymbVeoGSRcf+0C0VkZxO0svG5df
 xSRAqWr5Cr8qNy0WMRyw34QLR+j2iUV85iQ6iS289gID944/uFbcIIp3+Gb16TzkmCXWnzsl6up
 0BR7P1FH7BQfnUq9Ms/LUc6ynxWK1HaNlYlxZXV/T4dFgm7pIy2moa0Nk/lZoDHPV6xQh/WwQ4Y
 Iq0hwdly0Xc0coAkuNPhD9MWLvTjr+539gcWxoMHWFgGrvGusJCVTnCX4dOnaxC4wn3FIPUg4X+
 9a8dP21HdoO+OgA==
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
v2 -> v3: -
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


