Return-Path: <linux-kernel+bounces-36243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E3839DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0540E28DC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18038824;
	Wed, 24 Jan 2024 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="KSTIVbxI"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB25689;
	Wed, 24 Jan 2024 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057926; cv=none; b=pFvwEyrzaiqkD0iuya0dNXbJ/o2viS4Kkw3nqOUkiLPrtdirsA+/lPMa67BunSv9kv8CvznlWxjXpI9tsH8PcVR9o7FzmiUF8qaRY2cA9+0tIIr3HfzUG+6al8kbC8re3QzyZYfNfXoxIYwgYxR9UCDGMLB5mNdEpxoy1/qIs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057926; c=relaxed/simple;
	bh=bnDZ18PzZiaqrfIIydrSzNCN+uIZ5h48OVhffyfN5fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaLN30PNtvP3o8vmDRW4fGc2ZTQB7gli20Y0ne4eghnkBI2CUPXufHqXtQXzoJoI9pPL/WW5wofsBf/YCpkYX5H1GHmtWZDNM4W2APbyHf0r+fizAUzh5de28ECT7jbdyE5ZGZ0+zOXgcDmmQbWuU9CrdusLMbbxvAuhuId652U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=KSTIVbxI; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=pCs+y0jFrd9vwNY8aF2JjaxuTN4JFwXk3TK7B1Y6y98=; b=KSTIVbxIiyc9Muc3XdvntahxwW
	zX4bLc6KLjak4Xc9XVYkeg8MCg6n0zXFgY4+AISWp9Dsa70hVb04dwZczqbF2EzaNXnr+x/XCgbS1
	qK0gMvMHCXJ8i1J39IoajxkdN0NQkEi2NocMO5azudtu7EsER5PWX++ME0ovhQ5rR9hfJyF0UO1vX
	fm0Sx0p6wkk1Gp4FdXXlZX9SupKbhsUe2/dkmuKsORCPNolawLN2l7gn29yiccbZO3IBn1GZugVcA
	lfAca31W8mzpAmVEIYAQF9KKNR5rFkx7LyuwZK85Vw82b/b3fk1xIm5WcC1xmTewzzq08vaZ5pPTy
	0N7fHRMA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLB-00DVeW-1G;
	Tue, 23 Jan 2024 18:42:05 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH 2/9] ntsync: Reserve a minor device number and ioctl range.
Date: Tue, 23 Jan 2024 18:40:21 -0600
Message-ID: <20240124004028.16826-3-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124004028.16826-1-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 Documentation/admin-guide/devices.txt              | 3 ++-
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
 drivers/misc/ntsync.c                              | 3 ++-
 include/linux/miscdevice.h                         | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 94c98be1329a..041404397ee5 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -376,8 +376,9 @@
 		240 = /dev/userio	Serio driver testing device
 		241 = /dev/vhost-vsock	Host kernel driver for virtio vsock
 		242 = /dev/rfkill	Turning off radio transmissions (rfkill)
+		243 = /dev/ntsync	NT synchronization primitive device
 
-		243-254			Reserved for local use
+		244-254			Reserved for local use
 		255			Reserved for MISC_DYNAMIC_MINOR
 
   11 char	Raw keyboard device	(Linux/SPARC only)
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..a1326a5bc2e0 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -378,6 +378,8 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:thomas@winischhofer.net>
 0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
                                                                      <mailto:mathieu.desnoyers@efficios.com>
+0xF7  00-1F  uapi/linux/ntsync.h                                     NT synchronization primitives
+                                                                     <mailto:wine-devel@winehq.org>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
                                                                      <mailto:nchatrad@amd.com>
 0xFD  all    linux/dm-ioctl.h
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 9424c6210e51..84b498e2b2d5 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -40,7 +40,7 @@ static const struct file_operations ntsync_fops = {
 };
 
 static struct miscdevice ntsync_misc = {
-	.minor		= MISC_DYNAMIC_MINOR,
+	.minor		= NTSYNC_MINOR,
 	.name		= NTSYNC_NAME,
 	.fops		= &ntsync_fops,
 };
@@ -51,3 +51,4 @@ MODULE_AUTHOR("Elizabeth Figura");
 MODULE_DESCRIPTION("Kernel driver for NT synchronization primitives");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("devname:" NTSYNC_NAME);
+MODULE_ALIAS_MISCDEV(NTSYNC_MINOR);
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index c0fea6ca5076..fe5d9366fdf7 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -71,6 +71,7 @@
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
 #define RFKILL_MINOR		242
+#define NTSYNC_MINOR		243
 #define MISC_DYNAMIC_MINOR	255
 
 struct device;
-- 
2.43.0


