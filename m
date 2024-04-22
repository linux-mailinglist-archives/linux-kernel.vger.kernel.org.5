Return-Path: <linux-kernel+bounces-153084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CC8AC8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D41B232E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10813C9A2;
	Mon, 22 Apr 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJLnY2NP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59113BAFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777651; cv=none; b=rueGGLShV3s2kOzH3Ev4tkThSr4mVA7Zhgk7RzEVvbthz+roFXrpYRouibCk1yCUdUW2soxjYHBCN4sxwR0s0ZQgb3IxhpYtLmTudx+vhIJqWmICAs2LjvvLwWW2lEkjNoU+LaCcdA1B2uRTLbbMQ+8Llfht0wDhl8wbNvvvsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777651; c=relaxed/simple;
	bh=cRkXSaUBI+idwTIFfGgPlG6dgV5xmDVnjyDMXCOApoA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BG5XyKrrqny7KlRClBsyZ6jCRVDod9ZKcrcVYkABCsnESyOJNVAF/pKSfFrIK1FLa8xBOLOdqczvtAfLcbQjpxaOmfh5rsBY2YmFhMdI5vzeSF8EtsxGuRjSbnHDjmSegDNmxugn6bwFe4g+OW8PP12t2Mnsqt5xI48cV1boqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJLnY2NP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so8619796276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713777648; x=1714382448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXNn2oCStDkLWi9zDGUPVO6qkGiMAPrsXwlwOtBRK+g=;
        b=MJLnY2NPQLR08vvwtKOdHLQ/2FElariZ5KJG28OT6clXnORXJTaJA+Cdjd6dSeXQZm
         8I0qrDL8wzOfRqIvyUm9BsTgW8iHs+O+1k2kDgeivpA0fCvLutLIUF+ctFAVKoJYmZS0
         WmnQvaWFmPe+L1M9KAFTfHlC5hoVquwMFqubkAIa2X2aZR0TM5fh1tpuW4+Lmcw3cUk8
         8jpt9g+M++otcsb2+0jexnstqYfSCaqgBgOTMcYisr8cz9eFs/xcrzFrHhZrbkYA1m8r
         4Ctq8kSEXfGKtNnXzSBFXTNeq8fOHnKN+yP0u6TJLn/Dj/w9Ko4nFhJBb/Nju2Zok4f9
         siOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777648; x=1714382448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXNn2oCStDkLWi9zDGUPVO6qkGiMAPrsXwlwOtBRK+g=;
        b=uW5NDyhE0XLEh+IlbobiXCbWfpAr0az+3svxteb4hMBEdEW3X7a6vqPREiwvOSSm3g
         iko8MZJpKncNZVtaVBQEFph8mfmxViJCoMDH/Pa08UiMr9NbcsV83+rR5Jh5k2blWpY3
         W86cquj5np9UlmkL64TMtffN/W2+i/FItpaxlGBalVTEFAJDqnw6eFONrU0ebK+utBZd
         cro8Su3juJU1DDu2gy9v66ShWWp1ZItPOgcuLZLU782MOWaM9U6k+xV5/bt1unzRdO1F
         QQ4W36N/I1RM2ytCzHQqz7Dngs1F9E31CPCAp29Giq8fA9k/AY8DEuq3OQSgtlkw/Yg/
         +LOA==
X-Forwarded-Encrypted: i=1; AJvYcCWOoKzmrMrbC6HmcnpzaDu5OnCCDbVBEdM93rOE9udne1CYAasLePqm0CQcoJ211/9uYdsABP3JgJRBLc1wItCzFeW12YWYb6KtYegg
X-Gm-Message-State: AOJu0Yz95s/vp1/UKLgxcB+yi/DW6Wiblgu5n9VcUYMRNkHN7szCYMDD
	vZiPOjc7scHn3Blr1b1SrlVz3PULY1xEc0MKJsj6by2vsuQY1LjZFsKOxF2LaNNcJmMAl6ubvuy
	tagTE7w==
X-Google-Smtp-Source: AGHT+IE1kkiDKTCBuFzJnRyFWU0DZ0GmYJcdvmXUZI5xBSsgaPPCUbilRPm6wkB/KjKdt9GMzt/3svbCqmdn
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:59d7:73d5:a990:d869])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1548:b0:dc2:398d:a671 with SMTP
 id r8-20020a056902154800b00dc2398da671mr3042773ybu.10.1713777648659; Mon, 22
 Apr 2024 02:20:48 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:20:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422172027.v2.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Subject: [PATCH v2] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

The hardware information surfaced via debugfs might be usable by the
userspace to set some configuration knobs. This patch sets the hw_info
for Intel and Realtek chipsets.

Below are some possible output of the hardware_info debugfs file.
INTEL platform=55 variant=24
RTL lmp_subver=34898 hci_rev=10 hci_ver=11 hci_bus=1

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

Changes in v2:
* Add some sample output to the commit message

 drivers/bluetooth/btintel.c | 9 +++++++++
 drivers/bluetooth/btrtl.c   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd951..dc48352166a52 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2956,6 +2956,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			err = -EINVAL;
 		}
 
+		hci_set_hw_info(hdev,
+				"INTEL platform=%u variant=%u revision=%u",
+				ver.hw_platform, ver.hw_variant,
+				ver.hw_revision);
+
 		goto exit_error;
 	}
 
@@ -3060,6 +3065,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		break;
 	}
 
+	hci_set_hw_info(hdev, "INTEL platform=%u variant=%u",
+			INTEL_HW_PLATFORM(ver_tlv.cnvi_bt),
+			INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+
 exit_error:
 	kfree_skb(skb);
 
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index cc50de69e8dc9..4f1e37b4f7802 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1339,6 +1339,13 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	btrtl_set_quirks(hdev, btrtl_dev);
 
+	hci_set_hw_info(hdev,
+			"RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
+			btrtl_dev->ic_info->lmp_subver,
+			btrtl_dev->ic_info->hci_rev,
+			btrtl_dev->ic_info->hci_ver,
+			btrtl_dev->ic_info->hci_bus);
+
 	btrtl_free(btrtl_dev);
 	return ret;
 }
-- 
2.44.0.769.g3c40516874-goog


