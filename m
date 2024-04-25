Return-Path: <linux-kernel+bounces-159301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096E8B2CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808CE1C20D62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194317B50F;
	Thu, 25 Apr 2024 22:07:17 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC8171663;
	Thu, 25 Apr 2024 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082836; cv=none; b=JH5JIp+U2WE0N9y70YJ5JYwW+FniF6Hsrq2JNdKs43/42+gwNxjaov3BwqCEqmhqj8CMFMSb4a/ISfPLQZ01HCZ5LcxKChYaZX616EzvX/lJ++gLjlcXaOMQPHmW83cgo34+zZT+gofR12HaCM0OOVcaoInPAFAUBHNZV+CGUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082836; c=relaxed/simple;
	bh=13D6JKK2klk5hO/uMY8wEvGkd6yHJImAi0ZXLYZZe5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzK+54SIS/BHeVNyalfXEbZ3KrIper5s7LUJ90GtKnxGDSoRB6eJp++5fbHlJA28NCslGNgooyDOcDR/GIoY7Qe2Pp/qkKAG/dR1fKTkpR8e2UX+cPbKZWe7Z2J8kRsJdFDrqq9Tn/VKAx0uS0NRIy4BcJqGpNcVp6SQhYcHQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6eba841d83cso341013a34.2;
        Thu, 25 Apr 2024 15:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082834; x=1714687634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOSUTMsrzGUh+EZaDgRrzzwhmdgrzIn+vCN9MSjqzbg=;
        b=Wh9A/NCfx4JiBswaUIyBz/O7VE1rDERKyx89a1lDZQtuczR1XacRtn7P0RxHajXVJs
         tv16pHx0GynzZxv1DSyObcs77e4/xnQ+hy1w4WzXdMx/xtmXaUVWpARRiT7GKUBW49MY
         Eyued7HdZENJEdk8Q0fL0oB/wYC+LLXXGqj+r70YdZbVRjlasOO/pFBaM5iL6mgq+UlH
         Wmdw58aUlA2/tR0ryhj2WMHVRlsAW5hEKfrmbpmRx9YhyxAcDXCdZzn0b0rysfJX6MgU
         IBGYx3V0b5CKzsvGS/y3ZEE4FybgMPlsrj90Je8HafPRHNk8rDfYDj39b8AfE6Qoav3Z
         eZDg==
X-Forwarded-Encrypted: i=1; AJvYcCXfqxCrXonRlVi/Kq9PhXHQ9LMw7SKyNozkZFRQIE9rJ1Ms9hgon8RLKfd00fIqIn1lwcAQiczFdIMutShqAoiyQP/a1+rUH+329/pG
X-Gm-Message-State: AOJu0Yy/U6tEW9MjXvWiSSr1d93ZoVZ41T2RCzHOmRKQRSUCba9FPhWN
	MNHG4rO1F6bqfIDXlx79nqc+IiAr4B03oZZ01aZLilgmxbnCcLfe
X-Google-Smtp-Source: AGHT+IG6gSzPWbwWp5355tnnWnT7Vm9ciJl/9skpqxx0WDAK641I6qUFYo2xHAnEVdPXyLh3QBgctg==
X-Received: by 2002:a05:6808:189e:b0:3c8:4d54:94d with SMTP id bi30-20020a056808189e00b003c84d54094dmr1149679oib.4.1714082834143;
        Thu, 25 Apr 2024 15:07:14 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id a9-20020aca1a09000000b003c76f98321esm1514421oia.41.2024.04.25.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:12 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 2/5] Bluetooth: btmtk: apply the common btmtk_fw_get_filename
Date: Thu, 25 Apr 2024 15:06:28 -0700
Message-Id: <9c22c80334d5a895e9d47681d57d6c7965f3c086.1714082459.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dfd3a5830333e9b59ad1a1458aac8ac2fe28027a.1714082459.git.sean.wang@kernel.org>
References: <dfd3a5830333e9b59ad1a1458aac8ac2fe28027a.1714082459.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Apply the common btmtk_fw_get_filename to avoid the similar coding in each
driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v3: first added to the series
---
 drivers/bluetooth/btmtksdio.c |  6 +++---
 drivers/bluetooth/btusb.c     | 10 ++--------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ff4868c83cd8..10bf273120d6 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1117,9 +1117,9 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 			return err;
 		}
 
-		snprintf(fwname, sizeof(fwname),
-			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-			 dev_id & 0xffff, (fw_version & 0xff) + 1);
+		btmtk_fw_get_filename(fwname, sizeof(fwname), dev_id,
+				      fw_version);
+
 		err = mt79xx_setup(hdev, fwname);
 		if (err < 0)
 			return err;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7835170b1d66..bad6a9888dca 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3123,14 +3123,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7961:
 	case 0x7925:
-		if (dev_id == 0x7925)
-			snprintf(fw_bin_name, sizeof(fw_bin_name),
-				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-				 dev_id & 0xffff, dev_id & 0xffff, (fw_version & 0xff) + 1);
-		else
-			snprintf(fw_bin_name, sizeof(fw_bin_name),
-				 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-				 dev_id & 0xffff, (fw_version & 0xff) + 1);
+		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
+				      fw_version);
 
 		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
 						btusb_mtk_hci_wmt_sync);
-- 
2.25.1


