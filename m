Return-Path: <linux-kernel+bounces-111481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055F7886CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378641C20AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4A481A0;
	Fri, 22 Mar 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Gdezwygt"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507F4778C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113999; cv=none; b=R0+KFSql8/7TVTZkYF0OIsXbmtHdw/26TWBVO9ouggmvUEmZk7AXC96Qy+HTLeUnKut/a6dcZijZX9qhvJPmdXkrYg7iTDRtnfQJ+w5F1RJrq1cHmZW8KKxaWzwYecmV1YyeezFoC3F4Ddo/uVBq56Stkqay/CKucD3Ldl8rzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113999; c=relaxed/simple;
	bh=VV2JXqlZIXNmDwvyRmPDlSHbg6dDzm/mw4VXKDld0GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvadvKf449TEIlo+Z5d9QtQ7ed1hiy7JQpeDrVwyjRR0yPu02Pk13nRnCAUipgei+NWp5p+KPaXGm0YsMW6sMRBlXUKufW6psMG59WoU0dCLI8Q8v3m0XTQ+uCDyvyfsTNnoeqj1vREI+gpPcR6T2bHrIvMjo+41qtBn+wA8OGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Gdezwygt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=G46JTusxROSZbvDtQb/zHy9QMZR61747Z2bE4tfyB28=; b=Gdezwy
	gtVYvG6fUBnafQNtvPMSn+20p7q9ArY2uYJGuMdTJ3ram/pYm6SfTNor6X25oRVK
	fYLkMTgokKUY7ao4UILIqWUXpJHeVU9mfrv6d0u1M1/7hmf/n/kdYtpJqq3qBNMK
	nLAKlCfIX0HIpfkrKDqvRq5yOrqo3A8RfcXz8OXTmozYZnpebfs/3oIbpCSbJk7X
	rnZrpXRChgng9c4gjWTwnJeV0cf1rtqZqI606XoHeEO9WQFvG3Tp3o23d/ReNrIC
	AaQ5tQLY7ftt9n4xTh+aRoPqZrSig9kVsliEYtQWqZI9b+95sOHpCQ/d2WAXaYNn
	zuwfZFVUV9RR80oA==
Received: (qmail 3870157 invoked from network); 22 Mar 2024 14:26:23 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:23 +0100
X-UD-Smtp-Session: l3s3148p1@vfApxT8UYJNehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/64] i2c: amd-mp2-pci: reword according to newest specification
Date: Fri, 22 Mar 2024 14:24:57 +0100
Message-ID: <20240322132619.6389-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index 143165300949..2ad0bb4661b4 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -112,7 +112,7 @@ static void amd_mp2_pci_check_rw_event(struct amd_i2c_common *i2c_common)
 	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
 	struct pci_dev *pdev = privdata->pci_dev;
 	int len = i2c_common->eventval.r.length;
-	u32 slave_addr = i2c_common->eventval.r.slave_addr;
+	u32 client_addr = i2c_common->eventval.r.slave_addr;
 	bool err = false;
 
 	if (unlikely(len != i2c_common->msg->len)) {
@@ -121,9 +121,9 @@ static void amd_mp2_pci_check_rw_event(struct amd_i2c_common *i2c_common)
 		err = true;
 	}
 
-	if (unlikely(slave_addr != i2c_common->msg->addr)) {
-		pci_err(pdev, "unexpected slave address %x (expected: %x)!\n",
-			slave_addr, i2c_common->msg->addr);
+	if (unlikely(client_addr != i2c_common->msg->addr)) {
+		pci_err(pdev, "unexpected client address %x (expected: %x)!\n",
+			client_addr, i2c_common->msg->addr);
 		err = true;
 	}
 
-- 
2.43.0


