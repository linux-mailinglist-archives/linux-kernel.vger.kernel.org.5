Return-Path: <linux-kernel+bounces-96585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C3875E94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FA21F23405
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7804F1FC;
	Fri,  8 Mar 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SBkYY+8g"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC34F1E3;
	Fri,  8 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883141; cv=none; b=WggQ6cpKd0jr3GvVgs2ZZvYC1a5q4Ufq8h7COQ5+TKxZmHae256DZc9iO4FaKck+yibHGbY8UW8Aq6RN/gFZ2gEnrAGoDehA2FreKbZti8eWc1bsfWv0PKV8bvL0vBptXcGFa+KRtt7bv8/G1GYyH10LMYzVsjIxhJCAJFXXdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883141; c=relaxed/simple;
	bh=z/Jzop/xcOF0UsmGrGdSmhNu+gX+BqNaPpjSqxQzzAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PxMK/GSoh5st0E+0aVNICX1k0/h2cbPXZQ/kY55T7AHV/ryU9z6nLr3V7gAa5lDuF2qfqbjNK5WU2J1O+PKVKmL9m41oN8lRUHph87x0/zTTc3ti+sw8frgBuX/wqLUq9pcq9+P7qlm2FS+AKe4Si+A9Osmo5I7FrwdU+IrWR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SBkYY+8g; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709883136; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LEaQuW7svx3Ut6/i/Znb5O8w/jVnOY46iEm+jkT/Fhw=;
	b=SBkYY+8gqafRV7K99BeLRo78H2jOHqgoIuYA3CjbRaLIHCZZgf1d8R2J+2Jk1WK8qc5WYlN2C+40sX9BBokEeqz6tcRMJbn3QLXpnJsda4052Xb5FaNqluV338DB15SZ1MOUsGIVgLXq0f/XxFAjPCiccqmeZbkEi5SchbLY5+Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W21nh7e_1709883135;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W21nh7e_1709883135)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 15:32:16 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ACPI: Add kernel-doc comments to handle_eject_request function
Date: Fri,  8 Mar 2024 15:32:14 +0800
Message-Id: <20240308073214.11262-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds proper kernel-doc comments to the
handle_eject_request function in the ACPI dock subsystem.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/dock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a89bdbe00184..a7c00ef78086 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -380,6 +380,8 @@ static int dock_in_progress(struct dock_station *ds)
 
 /**
  * handle_eject_request - handle an undock request checking for error conditions
+ * @ds: The dock station to undock.
+ * @event: The ACPI event number associated with the undock request.
  *
  * Check to make sure the dock device is still present, then undock and
  * hotremove all the devices that may need removing.
-- 
2.20.1.7.g153144c


