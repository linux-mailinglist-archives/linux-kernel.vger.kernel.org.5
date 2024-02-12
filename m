Return-Path: <linux-kernel+bounces-62199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF3851CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7791C2237A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD4405F4;
	Mon, 12 Feb 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="WQ43ewbJ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726E26AC9;
	Mon, 12 Feb 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763085; cv=none; b=Ft0bNwXk60XaauYlUWYe0qrAEUNyaMYvIXaPBdgz8nvHGX3CBGyir+ClbvddZ3Y7nhKkztr9p9iYHAGBCIaZq/SnDzHHhPwO44t+t8F4AVcL5I65+R/6hmNAeXzbe9wGMN/DdhnjKYzeKIGeO7mmKB73aWX96mjv8bO77Cf8NjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763085; c=relaxed/simple;
	bh=0lGQUm+90KYZlz47xHNxcrHu+599ngPLg8L6TVE81vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nW1KVjEc3yXPG7a7mjaiUnyplMxLtsaHAG5/6NgjCZ1tIRc07nVEIvaKxWWgNMf1pl5A84Jl2QZGr94Th4BP7RLfhhetPPU4f7yY9dmPcmqgkcCKZeMfutNtClmYIvK0MWmTEmrnNDs8tb51bUylNogW5DdKcyxiKgr986F8Ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=WQ43ewbJ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363d85fda93so11659515ab.1;
        Mon, 12 Feb 2024 10:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763083; x=1708367883;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNiM+AN62rI0NY0c9YiwkLlKxLPUGxqDQX5HJ1+BhGg=;
        b=IJ/ia/ItIphxaBmhQRiqRaiOl4QwzFyCAMnWIJC0yqr//hb7hzUcxoHOclcACIM5X+
         O7JXOJl50m9hLXxaXzddqzAthbml68lCwhk1YL3ceW7QqostYguPPfh46CmAlTJ92mga
         VP3aPxCj+/3gPKQz7gne1eXhmDmKGKChXcre3WK9Ajzo13nj4gvncZiBgoZuiNdZSjdN
         aHoyrmaX5jolbt/Rp+p1t+MhGk7x7xToeoDbxOqgI6BqKaRi3U2NIqOuRXHrRZeRwRZG
         Y3YEqOuSNd6ZB0609kaYHBbyUzEcJs9pS/TfQOcTFgVDyVaEgDMCBN4EOeZzQ4jCfZ3L
         M6rQ==
X-Gm-Message-State: AOJu0YwVRqvX3Ho9pwOlWshfE4tOlFPQipwIj3avFs8JO0RrwCYFLQWg
	PZqwN0hUUsQS4WcQOwNVmGafGJjvRQy63Ig/FRuzW23bT9bRfwt9
X-Google-Smtp-Source: AGHT+IFFmvWkuM4WujnnyAcBACdfqGZnKD0NTa4x68Ww7GK0iUhFM2efjjWt+7Q641UuAEnz+OFs8g==
X-Received: by 2002:a05:6e02:2193:b0:364:12e5:c7d6 with SMTP id j19-20020a056e02219300b0036412e5c7d6mr2175633ila.12.1707763083137;
        Mon, 12 Feb 2024 10:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7enC5WzJ72fjDcMepZ8KDO1TjTjz7aFO4Nhd8iPJZjMRjF/MJFBfpP1u1DtqgMPfLZNQJnAmIiRz882nXmS4l4jEEVLvHeXMYAIHWUzCXeCAgn2GQMAo6QuMf4+vERJ/TjnYpL+FlmEUS1GThjwFX9UI5brTGCEFF7qUTtCl0lm4pPoo=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l193-20020a633eca000000b005cf450e91d2sm767004pga.52.2024.02.12.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:38:02 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707763080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bNiM+AN62rI0NY0c9YiwkLlKxLPUGxqDQX5HJ1+BhGg=;
	b=WQ43ewbJt4U319YlseqJJU1tKH6gs9A4WIQvLGmCkzw6Elubeg/r9OtkpsVjFolN7BR512
	ku/rkFKNRm9LabXRu/pwN3J63i5Wh1UiyyEgxbkdOp3x2I8gZlUa0ohux0hsaUpngLL/6E
	uWjlze1K9tLfU1HLHpBKurRrC5o55IAOFkVKOxQVVKXFJJQWW0c97n5iyqtWATks8yLU7v
	dMhcru7ejs00hWLS+8plF62ZjkC9sNW1mErOERHyMyQmsXDJrVvk+Sre4NHQnWKXMu2t3u
	hZ9tj5FG31yQ8IzXjDyJfHiZOp7LCeW54ZxH8/T+PX5xfA8DyFOVPg2GIdSNlA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 12 Feb 2024 15:38:37 -0300
Subject: [PATCH v2] scsi: Make scsi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>
X-B4-Tracking: v=1; b=H4sIAKxlymUC/32NQQrCMBBFr1JmbSQTS1FX3kOKJOnEDtS0ZNqil
 Nzd2AO4fA/++xsIJSaBa7VBopWFx1jAHCrwvY1PUtwVBqNNrQ2icos8/EA2LpMSL2wUNv7kg7M
 XtAHKbkoU+L03723hnmUe02e/WPFn/9VWVKi6TtdEZ0ON07eXTQNTomOkGdqc8xfhtMxTtQAAA
 A==
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=0lGQUm+90KYZlz47xHNxcrHu+599ngPLg8L6TVE81vo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlymWvEaMUcbqZliWm13EdoggzqpVzGtyKn0NtO
 z/tCOLLZjyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcplrwAKCRDJC4p8Y4ZY
 pvHhD/93Yw+N/lWfQNo8IvQP3P6fmgKghr3f+sctlJx8HtP8R7YcMW/5CJ66O8MyXonvjhKNPnd
 B39xJjVpR1nB0gLR1ekJTQIxBdudLKS0AcVHw/mmuwgmLmpYnBbdq2L6A9Bc+/CzsaeUVtKMQt5
 nSWWtHCzORievpVAqM7xDbhJsXGtYhJAQJcvT6eunx2Z6q7wnIR4r627w4QKus0LgknzxOef9d8
 ZyEolVTTzcZERsg3/jKq1inazxN6V5qx8p+Eh85VFEyV3ovyo5oflOgBAid08150MTBQV1igth0
 x5rHG5cS06zy8rDkJU5QVbEcgkTHuFNadCdT49TboXltpsZp8fGQfc7yteWd+4oHAjXgWZeqDfu
 8pQ9nc2ewNhCfbzrFAOLAacfrLexjSUpU7+lsJAOwEl1oQW4u/Rvx3R+hcGzih9UdtUNZsCPsPp
 +AT3/nhr1htBwH8vrbjfgcHVbLu0NTOnEOUSv8lj1tLhe39MEo6uNOa78aTib/AHH15Ectvl0GW
 RoI/D/CKSmeMrRLRqPe8eTOmYvhvUphfrQQkB+Y+DGkRlEFUliGUYBDH7KsGDIQvwKdMC+9aWNX
 zvtmdKIMZJEnrl064iVLuG+dRUWdcMbbbwrPEsiCKBbD8WWUCvo3rQ4j7vK+DwpwK5DZdGk19eS
 ygKf3BiBeFUMuUA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the scsi_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Improved changelog to remove the word "Now".
- Removed unrelated whitespace cleanup.
- Link to v1: https://lore.kernel.org/r/20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net
---
 drivers/scsi/scsi_priv.h  | 2 +-
 drivers/scsi/scsi_sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 1fbfe1b52c9f..9fc397a9ce7a 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -156,7 +156,7 @@ extern void scsi_sysfs_device_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
 extern void __scsi_remove_device(struct scsi_device *);
 
-extern struct bus_type scsi_bus_type;
+extern const struct bus_type scsi_bus_type;
 extern const struct attribute_group *scsi_shost_groups[];
 
 /* scsi_netlink.c */
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..14d0be0da0c6 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -549,7 +549,7 @@ static int scsi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
 	return 0;
 }
 
-struct bus_type scsi_bus_type = {
+const struct bus_type scsi_bus_type = {
         .name		= "scsi",
         .match		= scsi_bus_match,
 	.uevent		= scsi_bus_uevent,

---
base-commit: 59828c7b5975f442ad5bb74a031fe388341f323e
change-id: 20240211-bus_cleanup-scsi2-16c3cfba91af

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


