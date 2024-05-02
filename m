Return-Path: <linux-kernel+bounces-166723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772A8B9E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8921F1C20AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418D15E7FF;
	Thu,  2 May 2024 16:28:09 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D315E1EF;
	Thu,  2 May 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667289; cv=none; b=IyXxZ3agVpeLCP46Dz/tbUBUJHy8/DwHBHRw25MCGx/U8Xd+/rJ7ADeZxcyhr76J+6/ocvtsTsnrYaI8USY0AWs9mBZr+G7QGMmDS4lAkJnA23E4T4MGbNj5dNXn5y5oPj41tPM6LKA3vuL4AOsgVH9tYr3o1tgPVG/P957iZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667289; c=relaxed/simple;
	bh=8CN60vsDhsaBYBw8dNPoZqC4vHRsiqNxpPf+1mCw9fI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cxh08/JO/vSjmWGIS97KCos6V2U5WbfRjmPvcOssbLFCY056N37tRdnpTmpgzwwEYHhqXdlN/5QCMTxokUbFxfqQXAe6DXAboVhJiYzH2xa0aYna2j7lBYCR/Uf42oU+aKRoaZZ+M1QEre1wTVG4tIKStidQa+NvvehTQgo4CS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79100a90868so335646185a.2;
        Thu, 02 May 2024 09:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667286; x=1715272086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLr63wSRKN1zYIcrCH+ZmDq9lvkzTwxbqszK/XM362s=;
        b=StTiWlY1ifL8W0YXYqLBwXk8/elJJQdpP3f9tdRUAFu7742SFvmYkAkT5nKdQgmXR2
         Tq590Djp2oNQ2RMsNY5UV0lHY1VVl+MX1EsScRErGQG7XND1kOJVErJiGVuo2zjzM4Iy
         gZLSm8xeL2vz8mkQmet4Zo0Fvu7PMiKvKgbgZ2lEaSojWBhh93q9hHjCEyX+jJ9djFqR
         nfWnbK4X528Q8Yejh6vqriwNy1zBpYxSWsmEpqCl4Y2UizznCxdHIlIHyUHE7ze5A+U+
         QsjlmRu88PAYIIFcO4y6tNj/m9CECphgDnNm7IjFvNAVrBOT5PJxYMYnqOLfdz68+KOm
         UUfw==
X-Forwarded-Encrypted: i=1; AJvYcCWYmt4ZdYS11gRuwXBauSY1p1trBf7PMnInIDJDgd+AkfpVSk8J4XZ+UiOoeKQyP+TuMUArO1rXXundUN6CI2Fv0V/riG/kGHTanaMwZveuHihIC+cT1GjK3Pdz+o2lrEPY5N7fwb1X8KNpj7z5
X-Gm-Message-State: AOJu0Yylv4+as6tV5A7h+tm0FHzmLdYWtVZCY/RTjwvneUfd7gPaCq0F
	2bgSFCd8GinTknABBXRyidBMiXgpv4uAD48Nfl1ZDUgFXmaY0A6cJBJdiqtxSPs=
X-Google-Smtp-Source: AGHT+IE8O/JMsKuYSwWcU2BZsRBaUrLuaKL/7Li1OU1jCXzWkSXo3VNANI02MVjKmhk+yuspNLJFvw==
X-Received: by 2002:ae9:f510:0:b0:78d:5c65:f2a0 with SMTP id o16-20020ae9f510000000b0078d5c65f2a0mr91478qkg.21.1714667286493;
        Thu, 02 May 2024 09:28:06 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a0a8c00b0078f1ae252c6sm483349qkg.49.2024.05.02.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:28:06 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HCI: Fix potential null-ptr-deref
Date: Thu,  2 May 2024 12:09:31 -0400
Message-Id: <20240502160931.1135175-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential null-ptr-deref in hci_le_big_sync_established_evt().

Fixes: f777d8827817 (Bluetooth: ISO: Notify user space about failed bis connections)
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2:
- add a Fixes tag
- make the commit message concise

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


