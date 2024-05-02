Return-Path: <linux-kernel+bounces-166773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02C8B9F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A54282C80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9416FF3E;
	Thu,  2 May 2024 17:18:36 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17216D4C0;
	Thu,  2 May 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670316; cv=none; b=mkmoNSld0TtbsslbZ5ibWKgBZRnKqVwdkpDiPtNWzYau5Vf4bSXgheP9WPhmtqeEf2LhsKiRw1LywpR1OleE4aXKS6382SGxOTP9fHZERrEtTfliFOe14K9DSAACB1EXiWjQ5AZzTO/lma/EG8JCX+2cENY92B2m/Q5FuC2NAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670316; c=relaxed/simple;
	bh=D8D6R0MTWj2AZqJhJXCP7hDVz2lRpbK9k5gLOEwYack=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=azNpQYP6PzDTSLMoIaKT1UtivxXLNmC8JHnivZTDv4JmCDxAdx4nQbtiTcwKc1PpBWbXnyr5b71FeDJ1fOz79JUGdSzCxi/6Vnz759Do/6DrpQswlSoxNh582saZR5XUvzcKUcYXj20T/usSS9891MfH72VLAiQqFedHd8oY6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b10ead8f5so42940946d6.0;
        Thu, 02 May 2024 10:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670314; x=1715275114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AV67mCTFYc91UN8X5RKRCwNnRRGn+tgUiRcAMg+Lp/c=;
        b=k3bD0dAwKNJ3TSLT+oBONGiouw575F0ThErc4ptJvN9cDmPWK1G0qvL9292mGUr+zO
         3Ezxc4sBz3spGwyRNQEpS+yAsM0yWFRyh6jwxYZiw7sXGJJnGsISCIyM8lJUxObRmv39
         5ZLOQqqtScsUhFq56xRuFKs4LTal9d3LuPcB52mT7CFiml+3NXj5MPrHzKuF56ssAtCq
         skREktmH880xvEBlv3q26aQWUlUC8rATrM8/BzMBttnbkB5Jbt3XcLAluYHv6cI/ag5D
         PvQHvVZHp05hXNXF4nb3TK7/hqwSbwwk44b4X/TZTgWdc6b7xN8UnbxZDKUxd98Pppee
         DP1g==
X-Forwarded-Encrypted: i=1; AJvYcCVHwaV7SBvBjM54bDkIud6toDFRGchhQLTP1xg1lSI10koDFZA4Wr2/2qeEvmIpVORwrxZ1y+6T09XdONOc1Qb1mG0ONyXA6gsewV/mV0aOwZOZTZ5TnuRg9rcIMvLj7aRgW2hOzl3pP8J2aQ9j
X-Gm-Message-State: AOJu0Yx2pyB8mPHtFpz49HyXWrTAdFBC5Augy1F6s40BVsaH9cVOu+wW
	Ng39hpVZ8vZaTtQHOEn7yAywS3nRQdTi8R1+ws8LswQLhTAqc4O2UkA7lGDgff4=
X-Google-Smtp-Source: AGHT+IG76hAVVzixKJNiNS1uQxw3tD2j5Qxdsv111stKqLTEIAybpvLVL2I9gxSheLqcAdTrWdRcSg==
X-Received: by 2002:a05:6214:2aa1:b0:6a0:ce12:b8a4 with SMTP id js1-20020a0562142aa100b006a0ce12b8a4mr235826qvb.21.1714670313840;
        Thu, 02 May 2024 10:18:33 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id n18-20020a0ce952000000b006a0e08d2b24sm496355qvo.79.2024.05.02.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:18:33 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: HCI: Fix potential null-ptr-deref
Date: Thu,  2 May 2024 13:17:10 -0400
Message-Id: <20240502171709.1280128-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential null-ptr-deref in hci_le_big_sync_established_evt().

Fixes: f777d8827817 ("Bluetooth: ISO: Notify user space about failed bis connections")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2:
- add a Fixes tag
- make the commit message concise
v2 -> v3:
- fix a wrong Fixes tag format

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


