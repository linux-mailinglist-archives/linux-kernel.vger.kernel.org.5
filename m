Return-Path: <linux-kernel+bounces-157027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7AC8B0BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C511C214A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0615DBB3;
	Wed, 24 Apr 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc5eYssj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648E15CD7F;
	Wed, 24 Apr 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967151; cv=none; b=L/YCupRyDSvQCsScj6sQxmfASxT1UVPozZmMFm6DwC6DhTdXOa5dKFVcluEB2VvVFvADPNzjFokW3XgbtbytLMOsJyCSRwZtUIZzYIsYImeL5b7uKf2tNLWQU2F6gKIbc7PUEKVAdTV+VedivoUSqKGDPZOINCWyo05taP7HJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967151; c=relaxed/simple;
	bh=36CNnFWY8oKhWu6nHOETa4usiZ+wFiqJ0a8d/Z3N+OA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lLUFVphKmTcm8j++loycGUN/fP0L203XZCgRE1Xv2Adex0bGWjqYWnI/xNzNM9m4s4fjz04WMKiou65kmJm0P9SX+Y7+3kfUdXc6OHwUGdz/fUBDaINLDCyCj5PYwySSUvEpIlfBBuT6nAjTsuZ07UhjPreRe/v3Igm/tiTL+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc5eYssj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b21ed1aaaso1659025e9.1;
        Wed, 24 Apr 2024 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713967148; x=1714571948; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJSK88kKSjWjJrR7QciaX7Rkw9NhMfGWUv/hxrWYKfY=;
        b=Tc5eYssjcgo4UcD4h6cZwPD6MeYdvko4zm5bqPEuVT6kvtSMxPiQxtW9TGjYS0gC1w
         E55MvgJlG3AQ5OIRROt1MtI2nm9xvM5/vxjcCQ9vMVeD+Vr/PzeWeqOCQ7G9ODdLYb53
         FsEoYDyGk52fbUQy1bdXfPE1DOi1Ho77pf7nexC1hfrMYJ+DYSacUflZP5udPHHDkpEB
         0K5sP+i2eoDfjEN2RUf2djcDzJ8WBbDebvK/15ZmRl/v+SwtLPCb8b0AvClYenUhCNDc
         kdzeuChj0auD1D66kl8G4sclJXLw/jNSbwz6BvO4p5w42L9VC2Wi31IhKYw7JQVMvTac
         j8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967148; x=1714571948;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJSK88kKSjWjJrR7QciaX7Rkw9NhMfGWUv/hxrWYKfY=;
        b=aPxYEt6rf3JMzVrs9UmnPznaRDUFCjc7+wdz+2K5DAh5b/EgvmazDgOOiVJ6NOE6Bk
         vU3pDwb1JxKYGlO5aRj0o2sET3cZV8aWMhi0zHNpcllXI+GC9ZhITxvvxU5gZR+bvjBs
         gX2ErNBE1ntsr0sbsvRLN3aYzYw2vRV60+2Nys9IQ3cZZOnfesewghpkn4VoK4iwZmZn
         5Zc+K4XV5GeK4EOssGvi5gwsJko/q2rY/ilHuXVlyLKt7nN7isOxD8dQnn4UnACjpIv5
         E/S+YNXPbhq16+7pIgYg1dPRFX5YvuBP1r/J0xzVVV72b/fXdI+MhNtKKJNpCAjLM1fO
         w7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyyEe0uArehrtQsiXUnQXsEgbGwxX5jgxv/LtFLGWM/eVeI2XCiAzIz6jwFWDyGR9v3hIJN0FOgTj2lV0EUI3lBX20aDr9cggfoLGLfHXPLqFbh129ILFeKGpvtio3/Gbx59fQvdC+jKlYrdJd
X-Gm-Message-State: AOJu0YzbtldBEUGVYNE2SiBXG9bPujGGhLJUv3MISTz2mRk8Nqt2TNdu
	kBgOi9uobBP9PCVIUDrxvy/Rt4wNJE1YBvpGtCZNQtQqC+GA99m/
X-Google-Smtp-Source: AGHT+IGvI1V9iSHdj1mECtIufQi6jTuMKHCWJZBW4U55pxqw7G0QMcwowWKepL8LvTuog96mciWVig==
X-Received: by 2002:a05:600c:1c09:b0:418:d58e:4bea with SMTP id j9-20020a05600c1c0900b00418d58e4beamr1898909wms.16.1713967148231;
        Wed, 24 Apr 2024 06:59:08 -0700 (PDT)
Received: from linux-l9pv.suse (226.red-176-80-67.dynamicip.rima-tde.net. [176.80.67.226])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00418729383a4sm23716687wmq.46.2024.04.24.06.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:59:07 -0700 (PDT)
From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Manish Mandlik <mmandlik@google.com>,
	Archie Pusaka <apusaka@chromium.org>,
	Miao-chen Chou <mcchou@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH] Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor
Date: Wed, 24 Apr 2024 21:59:03 +0800
Message-Id: <20240424135903.24169-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chun-Yi Lee <jlee@suse.com>

Since the d883a4669a1de be introduced in v6.4, bluetooth daemon
got the following failed message of MGMT_OP_REMOVE_ADV_MONITOR
command when controller is power-off:

bluetoothd[20976]:
src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
Monitors: Failed>

Normally this situation is happened when the bluetoothd deamon
be started manually after system booting. Which means that
bluetoothd received MGMT_EV_INDEX_ADDED event after kernel
runs hci_power_off().

Base on doc/mgmt-api.txt, the MGMT_OP_REMOVE_ADV_MONITOR command
can be used when the controller is not powered. This patch changes
the code in remove_adv_monitor() to use hci_cmd_sync_submit()
instead of hci_cmd_sync_queue().

Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Manish Mandlik <mmandlik@google.com>
Cc: Archie Pusaka <apusaka@chromium.org>
Cc: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 32ed6e9245a3..21962969411d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5475,7 +5475,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
+	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
 				 mgmt_remove_adv_monitor_complete);
 
 	if (err) {
-- 
2.35.3


