Return-Path: <linux-kernel+bounces-82548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E67FA86863A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F62B23E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4791B7E9;
	Tue, 27 Feb 2024 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8jt4L5U"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D85C82;
	Tue, 27 Feb 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998238; cv=none; b=td2UF99tPTi9H+iaUGIqIv3t9goibrhN7jDyIRzCx0FzOMAUhJHsGysT4nwRodk+E3XmlBxzA0qPuh4qVO/T4FN8tCiluFqATeLXii78mG2Lz99t+zv1jYiFWRzE+ezULd/LsHwZWIisJOpugChNnC0ZXEzSx2TTgklft+EofBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998238; c=relaxed/simple;
	bh=j7zNrS6w4OXY4CVV/O7t9lLDRVKmN0/utEFP2dhGLAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/NPAMJh1pjHNdRUdvqc4dvWlSn9h1uAYFNnmErp+gRIYXBGvrO7xHftLvxK/vzOCmI3OqK2q3zKPkDbBV+FD3JEXZ6hYaytH8/UT7RH0rSTg4f9sNdwdB1t18wW3xDIgR5hk2EJHs/K4Ccc6Qs9Ur7wDwn2T4iGFEUrl0Wampw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8jt4L5U; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3233103a12.3;
        Mon, 26 Feb 2024 17:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998236; x=1709603036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0x/8WhipzRjO4ImNAfx0bJ99WXNifjcXUXU4wwsmQ4=;
        b=W8jt4L5UZNucGOeEmiyvKFqnOvjFtLpwXFiCYyA7htw+WoBgLP3gmwmykwFGGx9d8j
         eZfU5v1alAAqPhhGIQHcryoZh9sKHVS/Tkaa+bpruV91lWs0XdArYw+GFG/z4cldxIQn
         cuzfRmQ03C2nrBLxrgyIFXT7k/rAaMmWku3RBlXaIs61UD8g19SL2eGakAzaHqnVnPO7
         K1fSiYXhsGf+AP/qGYC/EgSUX5YSComXLOrtW4VvjfGBiKLYeKbY4AP6/J+lrDOTWcUR
         Kv2QskNGwRZjGXT7gWMpodXB/3bPTX6b45zvkVbLgExU/JLlVwDjYaq72ExQLadcB3Tv
         lF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998236; x=1709603036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0x/8WhipzRjO4ImNAfx0bJ99WXNifjcXUXU4wwsmQ4=;
        b=FGQrdJGgF5eqky34MjXwXTlruRJ3kitaKq24U/GIIa79zZp8uSyQGHTI8t5WdNjDCM
         /dNpp3rCMwBoZoLSzRjS3tsXFvRwR+R9IWPFG1vVP+LolGiIjtQvh+W0cYoceIgGRiyC
         dnkLxFQX+xIht9s0bYpX+kTul6ud6WRfX++rnEzpzzvs0P3B4NdBAAAMsm1AWEdkDnd8
         SEBHdGf1ucrOguVwwEptX/jWrg+twJnfFPnTeCltlB7nnBQHs+asv/vbBEWF7QVP45Cp
         Z9T6+d9XG63ETj95eh+WJ8VsW/QyhDWBtUopFiP13jA6Oub4hsnYHiS2tVkwo9gXC0Qm
         HZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFCrdUn1M+0vU2RcimEEi/Fp9oadn+hc403I0rMfU4qz+GFkfmqb0P1d97vpp/ctapodQZCFdFZcz3Y9cqy9HARDYieCjN/mNyKvHo35Pn9Y8EbJPrjR0T/QEgCdrord/fGmJF
X-Gm-Message-State: AOJu0YzNEFms3++aZ1QvxIgYPDEbm5LvKmnsQYJN0zORp/eESIHtdttl
	6OWXwG+wQO0G5ISO4Iv8hQvnTZiRKdYKUcyi4I5vDmV4K6VuTXy2
X-Google-Smtp-Source: AGHT+IHQ+t/f+xfdjVntT7eUf9xvqU5Zrbkvj+1eeCAYkDwu3vieDOSJtXBEHA1TsIXTSmCcC26U0Q==
X-Received: by 2002:a17:90a:e4f:b0:299:699b:c5de with SMTP id p15-20020a17090a0e4f00b00299699bc5demr6890674pja.19.1708998236180;
        Mon, 26 Feb 2024 17:43:56 -0800 (PST)
Received: from localhost ([2804:1b3:a701:f25f:5d54:1a06:6870:7ad6])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090aa39300b002990cc5afe8sm5082111pjp.42.2024.02.26.17.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:43:55 -0800 (PST)
From: Vinicius Peixoto <nukelet64@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Vinicius Peixoto <nukelet64@gmail.com>
Subject: [PATCH] Bluetooth: Add new quirk for broken read key length on ATS2851
Date: Mon, 26 Feb 2024 22:43:26 -0300
Message-ID: <20240227014328.1052386-1-nukelet64@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ATS2851 controller erroneously reports support for the "Read
Encryption Key Length" HCI command. This makes it unable to connect
to any devices, since this command is issued by the kernel during the
connection process in response to an "Encryption Change" HCI event.

Add a new quirk (HCI_QUIRK_BROKEN_ENC_KEY_SIZE) to hint that the command
is unsupported, preventing it from interrupting the connection process.

This is the error log from btmon before this patch:

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 2048 Address: ...
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 2048 Address: ...
> HCI Event: Command Status (0x0f) plen 4
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Vinicius Peixoto <nukelet64@gmail.com>
---
 drivers/bluetooth/btusb.c   | 1 +
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_event.c   | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfb49bbaa28..96c9318c0874 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4489,6 +4489,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 08cb5cb249a4..33b5da0830e2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -330,6 +330,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_LE_CODED,
+
+	/*
+	 * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE command is
+	 * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is required
+	 * for Actions Semiconductor ATS2851 based controllers, which erroneously
+	 * claim to support it.
+	 */
+	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bffd2c7ff608..4ae224824012 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3641,7 +3641,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		 * controller really supports it. If it doesn't, assume
 		 * the default size (16).
 		 */
-		if (!(hdev->commands[20] & 0x10)) {
+		if (!(hdev->commands[20] & 0x10) ||
+		    test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks)) {
 			conn->enc_key_size = HCI_LINK_KEY_SIZE;
 			goto notify;
 		}
-- 
2.43.0


