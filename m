Return-Path: <linux-kernel+bounces-92888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F687279A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD39A1F26F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5B45C12;
	Tue,  5 Mar 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Hjt1w6se"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3811B809
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667346; cv=none; b=Ck8CVFV+vsjcDzcSRtRIrDM+o8dZFMbLvYQWZHlFIwlR63O9FvB522gPnFX/mzyDTp07U/GiAq7gRMydD1vd6CNaN+DekXEgh20mIwjM1SsQW1YW4lqVcm0RCF9FRluwAdJFDG2IWipiHeLAM6BCD1KOsCB9OQKmrV1QoUwCOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667346; c=relaxed/simple;
	bh=hm4KaFby4sPHLD2JiItKpumEzYHLr40V4Wmk5RBIVas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DnT64pCBrr4uVtOG/uTJ44JWY8unpMPJ+0czAHeEwZPQUSQy2vY9CBDuQX2pX0XRcAyBgz4EO0ZPi0WcaPV50TftOEl9Wvdus+vVgDmrpq9NPIxwRzyBhLC9GHQVSqRDiJ/ykiB5nrZTF1vQX5gH6mTOkjr8rkDTYOarlLv7G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Hjt1w6se; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e56d594b31so772380b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709667344; x=1710272144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buUMhaoDddPV5KgoZBFsQ0zbWZIP6RzvTrPKJ4yK/XU=;
        b=fDq8vaPTfFh4GZQhL2UPW4QU9wigdaHOE4n94mCqbpumzDIPAFEPPM5rgZmoSpSppf
         3qaEsFCq8SxVBOgA16JR+Ev6Q302hVlmt/rWEk7BOC74AfyWzfeFFgaW48Ho4WDl7hou
         EeSeY3wioBNj8MKLNw61Cv34623kQR8K0VDJEYgburQkteVD1A+h05mEceWJeiYvC7o5
         8xDyDKF6jtiaRoaCA3JFedDHISHa4iBQYf2f7iu/xlrj1CC9gjkViT3tWn38i/i/y/UK
         b8zR8nu9scTeyh25JdfnQD365Zd46PgH7CxbVlhy3ZghvU3/vFxi5UHuzQoXyBZ6jb2c
         JA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/jhmN+FvSggkorYUpsnu+T6ik0K+7XP+IMpBOtxLD6LZnxAZrCkzlNupo95oIttRVnTh14XcpnWJntc0B1y7BwHLEs4ownTGd6gBV
X-Gm-Message-State: AOJu0Yzn1ajgnR/7yznS9Lg4KMVREjIbAKfK4w2tLx6Kbp1SnqHJQzhj
	Bv2b9RLouyLsbKxuveI7KX0Oj+svZn6BJxxQDgUgUyGesg3FI2Cx
X-Google-Smtp-Source: AGHT+IHIp1NFYWybcF42eIpSpjJQwg/VDRADtVXgIJH+SS3e8a5GmKma8lTS4PbBUu5OePT2LfV6VA==
X-Received: by 2002:a05:6a00:8685:b0:6e6:c82:5771 with SMTP id hh5-20020a056a00868500b006e60c825771mr5562944pfb.11.1709667343839;
        Tue, 05 Mar 2024 11:35:43 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b006e592a2d073sm9191674pfl.161.2024.03.05.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:35:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709667341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=buUMhaoDddPV5KgoZBFsQ0zbWZIP6RzvTrPKJ4yK/XU=;
	b=Hjt1w6seAhSWPAE2GzYZ1CydK3Bf7WiWH/SaNGkhNAwpKTm/W0kwtEjcS11hiAsA+KDE6S
	20Oja7nv8RNKd+6pKvYroWqCqdSHZmY67VJCtBk0mFGbE6i7UBFFCCZG+zj4Snet+oztZv
	oYeEFNM1jckT1qUXlRo07Qo2Vikah4eoFB1ZYrzHBBqwFeQdh+XfyHkcXeYsJ3zJxsl2El
	wIKkVYuvE2AGjcKGtYbsGVtbk/4zvXx/iHlS56q0ew04yrcZy3x5wLzcDmH8GqfuxWb+ZD
	d+GVWzdnqiZLkfOgGVVw2+0vM9FjEzQKObIPNcV4wYqwcZcGFHWCKtAOBikqgw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:35:38 -0300
Subject: [PATCH] mtd: ubi: make ubi_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-mtd-v1-1-7861914e2218@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAl052UC/x3MTQqAIBBA4avErBPMfukqEWE61UBZOBVBePek5
 bd47wVGT8jQJi94vIlpdxFZmoBZtJtRkI0GJVUhc1kKs2rmwayo3XWI7bRirO2ECnVjVAWxOzx
 O9PzPrg/hAyyWXvZjAAAA
To: Richard Weinberger <richard@nod.at>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=hm4KaFby4sPHLD2JiItKpumEzYHLr40V4Wmk5RBIVas=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53QKcNrjktXADPGUmCKaUXE36bdVGpJoQuZmg
 HmIRTdDH1OJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed0CgAKCRDJC4p8Y4ZY
 pvXsD/9b54CWHkFqIZDw6puqub0R65fpfyCbnBt6KgmF+7+HqrdtyNBPOjJu/UVoWyBPs8mTpF8
 Fr/EuqwE64j+yLE0li0wpiiBwMFNhQg1045pH0RKd2P+uOPt2feROURnw9y2AcqDTgj00Bc9c2p
 sVrcsC0gby0l139OTNhwS4OmIKjBeviIS5H7KGjOa2V9FTcPCKTZM0hfcxnhRdh16287xc8aHtV
 P0gGomJyGhqWmrCpzq8cS7OHY9YI+XeYIQRR/m23GexXGaZfDKtBWeNXs6LWjJRoJZnFk4zygd4
 tl03RvtL/UqU0EVhsRy1HvBElr53MAr0jsB6OKw8jAISXUBjSduVTUc4FjcML4+PWYrUqTzNv5O
 OlBXc+Gkes+bklbvIcLdRF42Jjrx1/NHWgG+NCu7tDypOf+wgdSua7qnzwrfYvBlXFyrlmlh2o8
 /vommG+7f3pGEnEFxzT+L2X6z7FLxG+kFysTyr9TggdQFu3u4FYqJJQJLTSTxL3O5x68CllV87K
 xLYsDozwK24EUqDWz67pX/831S9vNLdPID/p/rdNrjgrIYyV3K7a6nrHFwQWa9jNJ4tvx/SVYQh
 2vdKdYWGsRV9fUAeQbpiRMhLEE/kl4Sr7ip/As6ZU0indk39JSAse1Y6HLN8vrUjpNpy2SsC4Cc
 UEONh4Qs++V3xug==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the ubi_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mtd/ubi/build.c | 2 +-
 drivers/mtd/ubi/ubi.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 7d4ff1193db6..1938b61e1b74 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -111,7 +111,7 @@ static struct attribute *ubi_class_attrs[] = {
 ATTRIBUTE_GROUPS(ubi_class);
 
 /* Root UBI "class" object (corresponds to '/<sysfs>/class/ubi/') */
-struct class ubi_class = {
+const struct class ubi_class = {
 	.name		= UBI_NAME_STR,
 	.class_groups	= ubi_class_groups,
 };
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 0b42bb45dd84..21c3208a9210 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -812,7 +812,7 @@ extern struct kmem_cache *ubi_wl_entry_slab;
 extern const struct file_operations ubi_ctrl_cdev_operations;
 extern const struct file_operations ubi_cdev_operations;
 extern const struct file_operations ubi_vol_cdev_operations;
-extern struct class ubi_class;
+extern const struct class ubi_class;
 extern struct mutex ubi_devices_mutex;
 extern struct blocking_notifier_head ubi_notifiers;
 

---
base-commit: 77bf032528393d2dc9430b3cea1fee8d0762a86f
change-id: 20240305-class_cleanup-mtd-b7dfe2ea8c26

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


