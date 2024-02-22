Return-Path: <linux-kernel+bounces-76544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC685F8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4224F1F21CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89351332B5;
	Thu, 22 Feb 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fRmnCmkj"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101112E1E7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606268; cv=none; b=qSitMRq7bnLy9VlSTPz6wPW0z8QDTSXT8culCb+iHxX1YCk3XasH1frG0bCj3XBHIR86hiTjKkXeDJZ5ylPurrVyqU3cCJCFYSll239K3+Z0hHz+QElQplh3GoT7Pj5NqJKVJGDorqioNLna/3YteqXmaDYaem/tTgHJLz3g7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606268; c=relaxed/simple;
	bh=IyrCjU0IHdunFur8vK+GmkbMCbRfKC8f8kABYQiXC8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpOCKPzJlaDf8xDS9gUhkGKPmtCd/85dQdhdKgXPkbX57CK2n1eZFWoCyS7VBw/cqlJpm01U8zzKuW/Z5oSMFXBgETZa2ulfvp3bm+JpOcMnkUwzKZ60h5inP8wW6lSPQvs7fWJ9nszEr/xF12Q9wJKyBOMGZulRFsKAFzv1nMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fRmnCmkj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-58962bf3f89so2325967a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708606266; x=1709211066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuwAWrKDu1e5t4umhFsz7T/5diX1pTYK82qJWje4hkM=;
        b=fRmnCmkju/sLBMmNqNB/COirjt2ps3VJexDgeX3SubcIjxeGSludpsIQRhpie784Kj
         ZTD9Pnmtt09AJC+GLKsYpRqJnwx1u10NxR6pOpVirOywLVfx7HaKV2XlwIgGQWFiUu2E
         JFGLdigA7fooQDS7qoubSdCMMFtwXT9E5xi/KpKqTFLTeu4YAt/GSnREsf70Q5y3pq4j
         iP9mBtDC2t1u5WSZwTbPRzIToD8ifxAS5xDA7Vr/RiFPnZicz/5h/gvjQpr9xGAVov2s
         xI90/7xybMX4ASqHbKK8MjuK3dgaERiPb6I3JaCKahWoRVDPK5jPi74oC2QtPHCBd/3g
         v/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606266; x=1709211066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuwAWrKDu1e5t4umhFsz7T/5diX1pTYK82qJWje4hkM=;
        b=a5squsf+7r5iFcsOgBzIN8hSEBkg5cRfjTquBBkjZqC0KC5zRc0ani/HPA1WxC+8iR
         QRvuQcSA+Lb1TQ6iTZ6vzcry+zuy6Oq1whZYp/7zG2TlKEu0eK5YBSr2TH0J+pxpQkgm
         TIK7cU9xzFFE2/Sdlaywz7QnHRli2awhVimSUNGqaE9b55b0+/3mllwYJVsHeqKHjIPK
         hFuesZvWio1u3JqV4zWAXOE6M+qewRK17k/84kJnpaJEzr3J2iwHJr9q0JlSV6NtYDIe
         LyZ7h5Ym3SeyHnFAMgFcQWOds38PEJoTXL3zK0KL+DNy25LfAn7RcEDw4ubvls497L16
         bq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaKyn8AoUjnyvIsbkgPz+HiA6NMyX4iU8aafOQyOfXyWaHLUeCqUAeZS3iuSX8RtTZr2YNpOfgjUQdt0uq/XTPTKdw0E0yZCEHZjR1
X-Gm-Message-State: AOJu0YxYw39TI8ln8FUWmZmLtNMeWagnJyUh8wgf9s+iBh4R2SDuZ64v
	cwnFn9CTfVWnbKwSTZcKmJdIPQhDQllZBg7jwwzUWSu70SCDVVxoXfVW2695mXJopUDXCf8J0NJ
	y
X-Google-Smtp-Source: AGHT+IGDnbx1AQNKvK0en3U+xfkxPHfdBufxMOu9UAiAIpFlxTxmhpHnLsLyVE1XX0tuJpWd7vKq9w==
X-Received: by 2002:a17:902:ed05:b0:1dc:51ac:88ef with SMTP id b5-20020a170902ed0500b001dc51ac88efmr1056056pld.6.1708606265710;
        Thu, 22 Feb 2024 04:51:05 -0800 (PST)
Received: from aryabhatta.. ([49.37.248.155])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001db7599aba0sm9898438pld.24.2024.02.22.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 04:51:05 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 1/2] riscv: Add SBI debug trigger extension and function ids
Date: Thu, 22 Feb 2024 18:20:58 +0530
Message-Id: <20240222125059.13331-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222125059.13331-1-hchauhan@ventanamicro.com>
References: <20240222125059.13331-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debug trigger extension is a proposed SBI extension to support
native debugging in S-mode and VS-mode.

The proposal for the extension can be found at:
https://lists.riscv.org/g/sig-hypervisors/message/361

This patch adds the extension and the function IDs defined
by the extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..e79ff1a2f387 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -34,6 +34,9 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 
+	/* SBI Debug Trigger Extension */
+	SBI_EXT_DBTR = 0x44425452,
+
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
 	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
@@ -124,6 +127,34 @@ enum sbi_ext_susp_sleep_type {
 	SBI_SUSP_SLEEP_TYPE_SUSPEND_TO_RAM = 0,
 };
 
+/* SBI debug triggers function IDs */
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_SETUP_SHMEM,
+	SBI_EXT_DBTR_TRIG_READ,
+	SBI_EXT_DBTR_TRIG_INSTALL,
+	SBI_EXT_DBTR_TRIG_UPDATE,
+	SBI_EXT_DBTR_TRIG_UNINSTALL,
+	SBI_EXT_DBTR_TRIG_ENABLE,
+	SBI_EXT_DBTR_TRIG_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+};
+
+struct sbi_dbtr_shmem_entry {
+        struct sbi_dbtr_data_msg data;
+        struct sbi_dbtr_id_msg id;
+};
+
 enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_NUM_COUNTERS = 0,
 	SBI_EXT_PMU_COUNTER_GET_INFO,
-- 
2.34.1


