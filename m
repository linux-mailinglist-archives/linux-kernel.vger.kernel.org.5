Return-Path: <linux-kernel+bounces-165918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227638B9360
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8DA1F20F74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6D17C66;
	Thu,  2 May 2024 02:22:21 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542D14F98;
	Thu,  2 May 2024 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616540; cv=none; b=gwbHIGMTxeAGQiLVPMG/MFZKflTQxT6G/vTDeLx0QxlS3s3RuTR8fLwo6Gx/6pGsnpQ01xd/DgmdH47AG8rjoZs+XkhKvzo0eySqnlUjgi7eG2QyTQGzJ0T3IzvjGQLNoWZPP34xAfDzx5ogAyILvpa631mtowgXBkVCug2T0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616540; c=relaxed/simple;
	bh=D3RDOQ/8fxSKRWRmhYenBUYE5f5frU02XXiNz0k1se0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APbTKt9hpewK/AGqQ9jwYGyI8JiwK/IZviacSHwcq2KSmy+C5nomdvhGfHfex537+1ZhX6UZLJSuujLgFnH18jHF/OOdx101GHHC987N197V3rrEiZhVFuF4SJtxS3Oll5YbirG0REfCouRtqbHb3AwWci1RvlTpda53/sbblYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b10ead8f5so39353786d6.0;
        Wed, 01 May 2024 19:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714616538; x=1715221338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGjZKKiGogvWCvWU2bfw67pwUvUo4ozwuFvA3Y52JnI=;
        b=SH6aYDL5frmieOgSPxjxoTY5Svf6OIQl1onxxCfH3mu04bcU1rHdywocg8aFqoYdUL
         SU7i2/IHEopZlHpPZwrppS/0HbzNe0Zzl24mQtN2F1Tz2OgY+sIyuKq6zGK04q7D7p7+
         T3ku84zquKswGNwaqG3fyX3Q2mKHE2Ip5x0fd62pvLI+Pt1j27i//AOv2GAMaq8CgLLj
         V3pp3atstm1dehTt9ZkVbdtrMRyGddKOUCNAczQ0XBU2TMby9SHelIUBcguH0JzVR1y/
         2dvZimLMP0fTJcYnUd5rIcDqA0dwb6/oN2MjdKvhrxjQv/0dkwJjNmnrpUfXyJRA7kth
         IFrA==
X-Forwarded-Encrypted: i=1; AJvYcCXQZVT8tviIHivY7fuAu0rCHbCkB9Mvf0LdulyRRBxMuIozAvouRz+2LiTM0TWuJf0J/LQar2Vskiiy2QkMhxh4NOL9+2nlNAD2IsBfqFw6B07HNQRNqj33EnmvhwWnTxqBTs+zy6ipG8c63y2R
X-Gm-Message-State: AOJu0YzYOdjlu6xvHFY9ndNi63U+QjIeY3NfzXI9y7pyrnXpWn13W4rs
	LOHpisW283dIm0oSni79j+1lyVQiqGk5w/QKbb1xcszgrtXifBs4
X-Google-Smtp-Source: AGHT+IGfUS6p1ttDQH6SYMAnb1Y2lhExSXnCXqIEqoqUVOgmtfmnWeyO8sBV7lA5H9S1LxogcpN6iA==
X-Received: by 2002:a05:6214:c86:b0:6a0:c8f7:e47f with SMTP id r6-20020a0562140c8600b006a0c8f7e47fmr4317888qvr.3.1714616537958;
        Wed, 01 May 2024 19:22:17 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id a14-20020a0cefce000000b006a0fa61359asm4623qvt.41.2024.05.01.19.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 19:22:17 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Fix potential null-ptr-deref
Date: Wed,  1 May 2024 22:17:09 -0400
Message-Id: <20240502021709.141220-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all,
hci_le_big_sync_established_evt() has a potential null-ptr-deref bug.

hci_le_big_sync_established_evt()
  bis = hci_conn_hash_lookup_handle(hdev, handle);
  if (!bis)
    bis = hci_conn_add() <- could fail
  /* ... */
  bis = hci_conn_hash_lookup_handle(hdev, handle);
  set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags); <- null-ptr-deref

There is a missing check after hci_conn_hash_lookup_handle(), which can
return NULL. Especially, if a prior hci_conn_add() fails than
hci_conn_hash_lookup_handle() will return NULL.

This patch fixes this by adding a check.

Thanks,
Sungwoo.

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4a27e4a17..d72d238c1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7037,6 +7037,8 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			u16 handle = le16_to_cpu(ev->bis[i]);
 
 			bis = hci_conn_hash_lookup_handle(hdev, handle);
+			if (!bis)
+				continue;
 
 			set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags);
 			hci_connect_cfm(bis, ev->status);
-- 
2.34.1


