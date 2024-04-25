Return-Path: <linux-kernel+bounces-159308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3C8B2CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324EF1C20BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6158181B8D;
	Thu, 25 Apr 2024 22:07:22 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83017F37C;
	Thu, 25 Apr 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082842; cv=none; b=jHG3Nu+gUsKfy5i0J/6nustWlE1fyiTp4QUaRHTqOhzKH8OzfPTjY/RD9WA1L4Q1O/wlnAAMGNLHgtqx8M5L26vyb5jS5oVTfTm4AwSfw7KEGcFMeY+0JVFTHFqGG3aP2xJWQkoJr6FJJD7T2ID464DZLNvU2uZ7IwRo1f6nbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082842; c=relaxed/simple;
	bh=xW5D0AJDPSU5A/+eb+O10+/Z0Uzde0cSge0o0CivJsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miWq1bGzmCcacb3104FutxAS6D46z0m6hwuyFYdhd4/B0ZmeoJH/EdS0e5awuRdud3u523PG08L0XML0UMCbMv70NLS1udb4+CJJBy1/ZJ+x5EqUaYP0Jrz1MtygFqT+LXzMpvjtiV+0M0WgNBwdHSwH7x7NXkl3t83ByfH/5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c5f7a3a127so57854b6e.0;
        Thu, 25 Apr 2024 15:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082840; x=1714687640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB6sdF7ZT2w7lYhw/XLWMRpdlEQQxivt35Hb9FtYEA4=;
        b=CecIKH1ESHLdt/vwzCX85c3qXgDJ2CuUSbxllCTq3hWds7gpnenXtOOaPz5nsMQtR+
         ve4TFubN7j5/xATT3gCwgzYKwa+sYE1D9Q5m7PpahuvH9em+IL+02A3Za42BtiK+Q2z7
         JfUOW3IbMlN3GiVQVinx1adCBtsToL/Zdm2s3m5YIHZcXFXk+Loit7isTMgC8xBV/HKN
         yuU54RJLrHYdl2KRcslw7vbCQhMJg8vbBXm7ZxZ/OoK1nrIhE0PK/uXok30YUaY1xjiX
         wvHSEfU6tFYXNVgZhYiR8Ow8Fcxb0L+KbMrZvocWvv51AvqkV7jUwmB3Y72Ee6OPgXX9
         OPzg==
X-Forwarded-Encrypted: i=1; AJvYcCWq7uc3v+bFmFJ7PRUFqMEi9yljrbvS2GSqFtzA7JA4ZiUpN9mjiKZy84+oB0Rfxl3wZHhtKrCTLNJJEQzYByyG2kfyaxKv7YLwQl7y
X-Gm-Message-State: AOJu0YzZsYmGGrfP7w5jBfGLA/JkEW/KCrhFPaH6cWHP5tp1HVh/fLvJ
	jHQYq2zADs8iHFqB95YPo3GG64MTAxndt+hkh5O1d0m+1YgzVG/fIGir91U4
X-Google-Smtp-Source: AGHT+IFTLYQOtDKukzZ2CiKwcNjWdiffw6kNmAkr9+apA39RTZI7invH/+p4ORH+TKEGqVRy/8qcZg==
X-Received: by 2002:a05:6808:1985:b0:3c8:3076:f54f with SMTP id bj5-20020a056808198500b003c83076f54fmr1220361oib.1.1714082839739;
        Thu, 25 Apr 2024 15:07:19 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id a9-20020aca1a09000000b003c76f98321esm1514421oia.41.2024.04.25.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:18 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 5/5] Bluetooth: btusb: mediatek: add MT7922 subsystem reset
Date: Thu, 25 Apr 2024 15:06:31 -0700
Message-Id: <986bef1b3b92452ca0d212ccd9b2bbe1267f320a.1714082459.git.sean.wang@kernel.org>
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

From: Hao Qin <hao.qin@mediatek.com>

Add the support of MT7922 bluetooth subsystem reset that was called the
auto revert to self-recover from the fatal error in the controller like
the host encounters HCI cmd timeout or the controller crashes.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: split from the v2 to make the patch do one thing in a patch.
---
 drivers/bluetooth/btusb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6cfeec2118e9..3485fefc8bad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3002,7 +3002,16 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	u32 val;
 	int err;
 
-	if (dev_id == 0x7925) {
+	if (dev_id == 0x7922) {
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= 0x00002020;
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= BIT(0);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		msleep(100);
+	} else if (dev_id == 0x7925) {
 		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
 		val |= (1 << 5);
 		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
@@ -3042,6 +3051,9 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	if (err < 0)
 		bt_dev_err(hdev, "Reset timeout");
 
+	if (dev_id == 0x7922)
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+
 	btusb_mtk_id_get(data, 0x70010200, &val);
 	if (!val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
-- 
2.25.1


