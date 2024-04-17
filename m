Return-Path: <linux-kernel+bounces-149306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203E8A8F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465902832CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42485C69;
	Wed, 17 Apr 2024 23:27:49 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DBFC1F;
	Wed, 17 Apr 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396468; cv=none; b=INi+AzzD/bhtP0k/hogZMPFKQKjNIDIbJpZkljMGoWrXeHOTONiSpRv9ZasRZ6q1AhcOffJzpr/zyyjY7Tp6K01ktnlmUJkQbnp/vTdP0MLUJ5b6Qc0s/dhE48H8ny3Nl+FbCqCHgDIq9U9zUInij1ZzjqPu5L7VsMraj5BwGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396468; c=relaxed/simple;
	bh=5UVlu9occiDwBRGiitQP3mupRzJhLkxhOOPiHCK9Abs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqTLiT/cZgaj0trfuu9+nZpmEOnJU70yFlkSpGY11U0pIJ6Q1kBRtxg+jGlOXnHfkC8qj8GQ+wx9/+aStwufvih0bSuDh4n5tCv8hmsz21uTLclQVxI3f+CWdHOvuiJJapq0GsjPiQkQGvT3xdtr2Tf6zn5i2sl+1pIEXq9FmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36b00f8fbedso4905ab.0;
        Wed, 17 Apr 2024 16:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396466; x=1714001266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQzDJkz2ShC6jD7BVo0uLIszI5IpreqEnXzr4s/NGaQ=;
        b=JZFYc7OGg6MCpG5BM42PoeS2Sdn2mALRkY2qpSMghpl3Rdkp4229dg6+W2Tzis/JtP
         vynQ2qTAWs2FZy4WI2L7h0XiZ/I/bLozH2D2UNteiumORJjeX+qgSCy6ceXNCDTGUBiv
         h1Wjd1XMLytjhD5MXOg7JmEh61RW3onoC3OJ7Ok97olYGwyKYEYnHwkjGdQsUMRW+gBJ
         UsD8KM3pOlrhEuqP8V9QFfxQ6Ntp4Ivcpa5UElo5HHtfawEFo7ojuMC4fcJ5/j1xlgxC
         +uhBzQ5gtSUMdhtIKcF8k7twp+hBrth/IUEsqQfvmJXDjUywzh/4UXNIvKxa6nfOxWJx
         1ZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQUl/B8tO9TrYh3TXcW7spWcBse95G2XMDZfg5YnyWiNz3SszJsuFGa37Hm3SD7N2kBx16cxl4nsyRNJUaiMvVlyBARhiKiFwFR1I1JEX+psJJBVNMXJPJR/+tLnUukDsby5ZzL9HsNgEtj+Kl
X-Gm-Message-State: AOJu0YyGBc0lqMBu2AhDLpP92DdWmdsCP1SfOcp6frndoEWqdIVOF6cO
	dj0gFQXL3MwOCXNqKn/St3cTn4f3RFHvJed9b8tpM8TbYlglNGu9M16BuA==
X-Google-Smtp-Source: AGHT+IHL12Ajqijo9myETQvpt8lM0eXfIcwvisdIpqkdziFih0gh9xV5GzluCrEZV4FK+iWxNsCX/A==
X-Received: by 2002:a92:c561:0:b0:36b:2ff9:9275 with SMTP id b1-20020a92c561000000b0036b2ff99275mr1319293ilj.2.1713396466596;
        Wed, 17 Apr 2024 16:27:46 -0700 (PDT)
Received: from sean-ThinkPad-T450s.hsd1.ca.comcast.net ([2601:646:8002:f344:5981:35f1:46e:37bc])
        by smtp.gmail.com with ESMTPSA id r8-20020a63fc48000000b005dbd0facb4dsm149695pgk.61.2024.04.17.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:27:45 -0700 (PDT)
From: sean.wang@kernel.org
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: sean.wang@mediatek.com,
	chris.lu@mediatek.com,
	Deren.Wu@mediatek.com,
	jsiuda@google.com,
	frankgor@google.com,
	abhishekpandit@google.com,
	michaelfsun@google.com,
	mmandlik@google.com,
	abhishekpandit@chromium.org,
	mcchou@chromium.org,
	shawnku@google.com,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Bluetooth: btusb: medaitek: fix double free of skb in coredump
Date: Wed, 17 Apr 2024 16:27:38 -0700
Message-Id: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

hci_devcd_append() would free the skb on error so the caller don't
have to free it again otherwise it would cause the double free of skb.

Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ac8ebccd3507..812fd2a8f853 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -380,8 +380,10 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 	switch (data->cd_info.state) {
 	case HCI_DEVCOREDUMP_IDLE:
 		err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
-		if (err < 0)
+		if (err < 0) {
+			kfree_skb(skb);
 			break;
+		}
 		data->cd_info.cnt = 0;
 
 		/* It is supposed coredump can be done within 5 seconds */
@@ -407,9 +409,6 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
-	if (err < 0)
-		kfree_skb(skb);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
-- 
2.25.1


