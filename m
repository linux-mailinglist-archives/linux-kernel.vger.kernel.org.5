Return-Path: <linux-kernel+bounces-159306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BB8B2CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7811B2B2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED51802C1;
	Thu, 25 Apr 2024 22:07:19 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8317B501;
	Thu, 25 Apr 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082838; cv=none; b=Tkp5W9klEucdKYnSDa08OHbAWj2F3hpvre3pcx+WhUK8fq8GXNFok62tEgXswANbRzQ93DCTtMW5kksGA9KDHD7wjDReQ7KXFV6AVWP1gzYqi7p8szVPHKExGuSRUyEiQomGylAZvmussKj7YPgSZYlD8+mcytxXGhAl+W3wsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082838; c=relaxed/simple;
	bh=umhtewTB4BfLLgpEvQ+Dp1EDXrNUIEf2w2QrQYChkIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp5efv3BuwreCQaIzADBbyJC1qohIOtv5o0D0+dd1xzVUpw+9aP3HWEBiG+4PGZvL8R8vOCSwg0dWMfCWk5bfDl6b/naPSh183xkDruONjD9yOQV2DV3eoNSoZE23t2WA7QUWwb4zD2SQ/NXdqxiubEjMYea1wQlEkdRQ9PkaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5acdbfa6e95so348872eaf.3;
        Thu, 25 Apr 2024 15:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082836; x=1714687636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDeY9bcalP61bq7Yrea1EZ8X+JxvOuN8Y2tqOpBrKaI=;
        b=n4UXb6AJ0bH9PmH0511HIBBe3iHBbt9hB4YRQF1TNTGtqdygbqkdvucDZTPYNdpmTd
         iRNu+hRTPoivfO9k8V2rpV8jQZoe6HCeS5wPrbqNStAhmqoxVBbve4p7V4MXnyBfbAXi
         3SpNjwuglsYi/gCOTHMrThDNkXVrO1HfQUfytLfYhAJ8dco+N4Bn8OvbopHjsNh9KwCD
         bT3BhI7+kGPTACpvo5T3nv0qVe4NbRxH6Y1nFbNE+HPZCxoL70O6IOu1v3v0mcJwrRtN
         3bxNWnmuNiU59YczgWajqoY1ict2SzYMTvGh1lbdLv8ShK+HF1KP9yYCJn0DyCXw1x8e
         yqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWISb12zHgNgIO96aLepypWdrs3OJ0mrbBMubc85Gcpvc7K8mweCBgRYgXmTZxkFqknvQiEtgfXTrTqtbhGmT4ieD/MAJi4WZ2pAKvU
X-Gm-Message-State: AOJu0YxSMTvCIcw8jeHEScDEi0cDgybp/NxGIWVCygFfTggvUkVJ3VNW
	MhxSXIlda5IlmsE+ozfo3R25CTVGbDwqrJpO09c+dAqgjrGwnwHV
X-Google-Smtp-Source: AGHT+IFX6ngfhSp/W7LZ7JR+f93Nfg4mCIdoKo+WNIvi95e0Bl/AV+9Q/L5kQJNxPBNf+UiZSKodcA==
X-Received: by 2002:a05:6808:1a26:b0:3c8:4b12:107b with SMTP id bk38-20020a0568081a2600b003c84b12107bmr1180386oib.2.1714082836118;
        Thu, 25 Apr 2024 15:07:16 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id a9-20020aca1a09000000b003c76f98321esm1514421oia.41.2024.04.25.15.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:14 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 3/5] Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset
Date: Thu, 25 Apr 2024 15:06:29 -0700
Message-Id: <2eeb87a4360356fbf2496bd0567f6432edf818ca.1714082459.git.sean.wang@kernel.org>
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

Extract the function btusb_mtk_subsys_reset from the btusb_mtk_reset
for the future handling of resetting bluetooth controller without
the USB reset.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: refine the git message
---
 drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bad6a9888dca..a25543ff6472 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2996,28 +2996,13 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
 	return val & MTK_BT_RST_DONE;
 }
 
-static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmediatek_data *mediatek;
 	u32 val;
 	int err;
 
-	/* It's MediaTek specific bluetooth reset mechanism via USB */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
-		bt_dev_err(hdev, "last reset failed? Not resetting again");
-		return -EBUSY;
-	}
-
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		return err;
-
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
-	mediatek = hci_get_priv(hdev);
-
-	if (mediatek->dev_id == 0x7925) {
+	if (dev_id == 0x7925) {
 		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
 		val |= (1 << 5);
 		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
@@ -3061,8 +3046,32 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	if (!val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
-	usb_queue_reset_device(data->intf);
+	return err;
+}
 
+static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *mtk_data;
+	int err;
+
+	/* It's MediaTek specific bluetooth reset mechanism via USB */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return -EBUSY;
+	}
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	mtk_data = hci_get_priv(hdev);
+
+	err = btusb_mtk_subsys_reset(hdev, mtk_data->dev_id);
+
+	usb_queue_reset_device(data->intf);
 	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
 
 	return err;
-- 
2.25.1


