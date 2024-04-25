Return-Path: <linux-kernel+bounces-159307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4608B2CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B70B2B755
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0C18130B;
	Thu, 25 Apr 2024 22:07:21 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35191802B4;
	Thu, 25 Apr 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082840; cv=none; b=Blgys5hub4KP3ci0kYOJ/vrvAan6KOHyBo0JhShg1OM57eYCq3cAFmPACI429AonKevqe6Vv3fQqGms1AYlBsUy/n5pMQOQkFKggAoglWUmNLVBMqb5MFdIH+O6zBqxWrXBLIRExQveNhS51rgnKcYmrMCPfZiCcFZuOhWQZvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082840; c=relaxed/simple;
	bh=dREXaFKoCNdQM9WiONzzfAPbqjcnDe/Cq2y9I3UGsLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kz4yTz3gfLghtXmrWH7IzruPaQS9JWuzHB9Srwg90QusHwlcQv4NXu7GvMJ0kj7cV8v+6ZClhm6pAd8fSIig3AcbHrHVESSjc6mF61yA5LiLLgf4rIRuSHaOK9dLQLpJKhlejzzxBc8G9M0MzAXHJPrDGiNIKIm36J4hcXWdJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb7a4d64e8so345885a34.0;
        Thu, 25 Apr 2024 15:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082838; x=1714687638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghe6Ntj3w82U0VJxVyYvLCInhwuNPbaLekvh/4FENKg=;
        b=acM8/bXRUUJ26A1kHOI12MwKLyFWuq3jrsVXGAus0FJxfJxWYO0q/lztCIUKgtOBew
         3nVbVhLWHlbi4AZlrEsPW4Fbp0PGiLR5ercFIt+/UHb8E6lVl1LKcI1u+4FFleEEBdFZ
         ZO90KrevAT71L1gtNuUwihxvz5Hlwx4n1zc9qa8fTefeIkaXb+N6h9NNP+hpWVyvs0mJ
         q25eJsVAT2yabRpksEZycT1P6FXnvmkBwhlbAspJrsvnt2aeXG6Et6bVedXNTuABJQBy
         NaX996cpbmKzqg41Bs1qQYGguu1rPySS5zgL7p1HVnxdAdNLZxLrShQkHKrtUzZTLnhf
         HBTg==
X-Forwarded-Encrypted: i=1; AJvYcCWTsrVbOxotJxUrGbobH8WoLfqudK2x0NJ7oZtaNCxTu6n4PwFKU+jXTqpXdPUJrohLK6GhVNt8WZZ8iKjnNHtfNV/L3po9FETyYFae
X-Gm-Message-State: AOJu0YwpUN2/CaO/fQyamdN93R1saq0XJNc33z9v2ZInZWfgn7hKM8aT
	5BeHTWUGE/52IEwK/Ms8UwZ8OM1U2bbbT/zmoKUlde/b4e8eV6ns
X-Google-Smtp-Source: AGHT+IEM+H4ncyT8CeCSalp8L8SuB7uAot40z6mDnViuZECMPrVG9EHcQbkeCYdfrDJwoDtUA3GvwA==
X-Received: by 2002:a05:6808:189e:b0:3c8:4d54:94d with SMTP id bi30-20020a056808189e00b003c84d54094dmr1149898oib.4.1714082838135;
        Thu, 25 Apr 2024 15:07:18 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id a9-20020aca1a09000000b003c76f98321esm1514421oia.41.2024.04.25.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:16 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 4/5] Bluetooth: btusb: mediatek: reset the controller before downloading the fw
Date: Thu, 25 Apr 2024 15:06:30 -0700
Message-Id: <13854f7ce7d4607d37dc24f39c69b3fe6d6e44f3.1714082459.git.sean.wang@kernel.org>
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

Reset the controller before downloading the firmware to improve its
reliability. This includes situations like cold or warm reboots, ensuring
the controller is in its initial state before starting the firmware
download.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: split from the v2 to make the patch do one thing in a patch and ensure
    the reset the controller only when we actually need it to avoid the
    regression on the time spent in opening the controller.
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a25543ff6472..6cfeec2118e9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3132,6 +3132,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7961:
 	case 0x7925:
+		/* Reset the device to ensure it's in the initial state before
+		 * downloading the firmware to ensure.
+		 */
+
+		if (!test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
+			btusb_mtk_subsys_reset(hdev, dev_id);
+
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version);
 
@@ -3139,9 +3146,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 						btusb_mtk_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
+			clear_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 			return err;
 		}
 
+		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+
 		/* It's Device EndPoint Reset Option Register */
 		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
 
-- 
2.25.1


