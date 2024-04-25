Return-Path: <linux-kernel+bounces-159299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B061E8B2CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7FD288CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC9179956;
	Thu, 25 Apr 2024 22:07:15 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B715665D;
	Thu, 25 Apr 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082834; cv=none; b=AWjwVJx9diij45au/keRJfh7oK7f219NxQTF/gOmZAyuorl6viwtwmoUu0JPpsuQ3HcowMlxFQSfvbyKyqtrhHoLNs+9UHNFR+dM+DblTAYh7MpeC7knoKcghMp7KJJ/GnIqVAEsTElkvddOIBhUEyGCsaHgluvW5i3WVIJ00l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082834; c=relaxed/simple;
	bh=BzmTF0f6Or1J1FCkmctHWn62o6eb0FlQ08LbgnxooCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vk9Y4gq3bL8aS7zvGEaRzBMXFIcfsjb9CEcXeI4pZAPYoyqOKYM0Pv9idivwkVXHvJpZVeiykIIZbyRKfVo8XAwpDOG5rMdFCocNG6Y8eqt2mSYRKfsOSW7LjEU3zIDPp2fBtKzzEfH24UVnVC8MYr3Glf3kfK//GLJ4azTyOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c70418ef53so147606b6e.1;
        Thu, 25 Apr 2024 15:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082832; x=1714687632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lStmgiqTJIXMZ0FpbHnHRZG5n3g0ZAPBxl1jPCO//LA=;
        b=n/HRGcqCDz/ELZUei9/10BD2rUl8XxgXwAHs+QiQiC0S6Z+PFQ4zEd050QvNQHSYZB
         MJ7PW4T2OJZFvkU6JirfavHeJSx54E/BAfCsdrOZrrzRQFFqRTVT+fN54HqbHRFqqnOk
         8ZqBfSafs8OVEPv9lMQTZ5U7rhn73dXlLSML6AyfGc5YB/VqildMwAwnzzeo7pzxD2qp
         Eu5uoiPmoKbo4E4XgnOzSHQNCqqjhc7eU5IBe77dnZoz6IZ/O4U70IKsFbBOOcOJ2Ggq
         l8pIu0W0172FTgoP88+nm+q+BAL5EVMdr0IeKWM3+bw8D2kPd66XDJgH9BB3IrzDBDtK
         ci7w==
X-Forwarded-Encrypted: i=1; AJvYcCV8tiEXTZbzczbw46+4UTfMMWkO+qoWwVh1jRQt2ICuFzTWxOBwz9hW7JveOkx90OHIqETTucLstL9lV6SU4xcpz1FV8c6iscByFod5
X-Gm-Message-State: AOJu0YyOqGq30nFsaqJXvLxFqNdA8xe0Xr0Zubm7tY1S6M7+BO2uZkTO
	vLo1cM6HU5anb0nArHct1xLy9aH073AfuTu2AixT2T3XweDDbkdl
X-Google-Smtp-Source: AGHT+IGnZRhr6DaC2jeDPcFMkAZdwigwlzS7ta02Yx9OWUvO003Lg3x4ruU18ekQ5ot8jHcYzT7pcQ==
X-Received: by 2002:a05:6808:bc8:b0:3c8:4de7:6736 with SMTP id o8-20020a0568080bc800b003c84de76736mr970276oik.4.1714082832086;
        Thu, 25 Apr 2024 15:07:12 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id a9-20020aca1a09000000b003c76f98321esm1514421oia.41.2024.04.25.15.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:11 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 1/5] Bluetooth: btmtk: add the function to get the fw name
Date: Thu, 25 Apr 2024 15:06:27 -0700
Message-Id: <dfd3a5830333e9b59ad1a1458aac8ac2fe28027a.1714082459.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Include a shared function to get the firmware name, to prevent repeating
code for similar chipsets.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v3: first added to the series
---
 drivers/bluetooth/btmtk.c | 13 +++++++++++++
 drivers/bluetooth/btmtk.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index e882613036a0..7ead7f967019 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -103,6 +103,19 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 	}
 }
 
+void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver)
+{
+	if (dev_id == 0x7925)
+		snprintf(buf, size,
+			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
+			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
+	else
+		snprintf(buf, size,
+			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
+			 dev_id & 0xffff, (fw_ver & 0xff) + 1);
+}
+EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
+
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 56f5502baadf..ef225980f110 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -159,6 +159,8 @@ int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
 			    u32 fw_version);
 
 int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
+
+void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -193,4 +195,8 @@ static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	return -EOPNOTSUPP;
 }
+
+static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver)
+{
+}
 #endif
-- 
2.25.1


