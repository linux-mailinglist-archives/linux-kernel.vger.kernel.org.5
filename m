Return-Path: <linux-kernel+bounces-24610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F282BF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E81C22D04
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1C67E8A;
	Fri, 12 Jan 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BOWCWzkc"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50A63510
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2866b15b013so1475105a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705058262; x=1705663062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPz3Ba2qsBHXEcQ86Ca39sCiPs3HQbwo2qACoN41JeA=;
        b=BOWCWzkcDobvb19D6MKirzVlhdsI7DTfKHE6ZAKYsqPLOBfn/R3AJbsRAsVSPmbhTs
         Ewyo2nh5Yc1Th9+XNRtl27D02DcHEDREMwWxxuApSYpHI0l+sh6huf10fIW7KR9sXj6c
         mt8WR47zY8dDMMi14qEUclB+wyMJljXcKeZYT8tvVgDzqgF49dcMP6th8R4ayKGBOLaQ
         4nZ2vSEf8e4Fd33VKJ02Miul6cbojQmkthaZZNV0UX6B+e/QhU+i1ugUuuB8zRRZbiRD
         tcJwhyHlELwPvS7wJrfqGYCThnOfTLBvABDEca9GMPEl4zXE3yWOcJpn6XcEu7ojvMVb
         YfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705058262; x=1705663062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPz3Ba2qsBHXEcQ86Ca39sCiPs3HQbwo2qACoN41JeA=;
        b=polZ8f7jFxNImC/W23Dbdsu9ySAASZwINZ8dbPzkwnr1xd1H85iVs3zQBCDi9w2ELX
         ezi1MqJoa4862AdHWQQO/FBekaj07BS7hMSIsjren+t/4AEo/ZS2KwKLTp97bKS/U5up
         mJd0MOPQrRFqdX3w7Aavrdfn76mohII/b+bVdwkz2aNL4eLcrrH/+gjS4IIuQiPoSKD7
         BChJCDQSECR/pu1iYg9RJtJkeIseieZEp2YWgs3y2aIEQB4t//8g02cJQVvlERmrbU51
         dStrvDLD69YSFapotg2VHmZXk+qLLLyxVwRN8L1J+q0q1yshcoAfjgJflAMS+hBe87YL
         bjJQ==
X-Gm-Message-State: AOJu0YxCijJ0+ER4gzmLTWCByYbYbuefbtQXPR8ygKceMqp66D3IN7cN
	c3MRUC9zv/wzn+6H5QjCTDRIIUnxrlHlYQ==
X-Google-Smtp-Source: AGHT+IFVJJimodUIGj6PoQdC5SEaQIRT46Bqli7WQ7LcyrkwR9voMH6TUpcHgpr8DRtDtz2TFWl/UQ==
X-Received: by 2002:a17:90b:4c42:b0:28e:fa5:7afd with SMTP id np2-20020a17090b4c4200b0028e0fa57afdmr681589pjb.4.1705058261938;
        Fri, 12 Jan 2024 03:17:41 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:a276:8a4e:2aa1:5f09])
        by smtp.gmail.com with ESMTPSA id sd12-20020a17090b514c00b0028cef021d45sm3794179pjb.17.2024.01.12.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:17:41 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <apatel@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 1/3] riscv: add SBI SSE extension definitions
Date: Fri, 12 Jan 2024 12:17:13 +0100
Message-ID: <20240112111720.2975069-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112111720.2975069-1-cleger@rivosinc.com>
References: <20240112111720.2975069-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add needed definitions for SBI Supervisor Software Events extension [1].
This extension enables the SBI to inject events into supervisor software
much like ARM SDEI.

[1] https://lists.riscv.org/g/tech-prs/message/515

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 47 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c      |  4 +++
 2 files changed, 51 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0892f4421bc4..11cad3ec4a18 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -31,6 +31,7 @@ enum sbi_ext_id {
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -243,6 +244,49 @@ enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
 };
 
+enum sbi_ext_sse_fid {
+	SBI_SSE_EVENT_ATTR_READ = 0,
+	SBI_SSE_EVENT_ATTR_WRITE,
+	SBI_SSE_EVENT_REGISTER,
+	SBI_SSE_EVENT_UNREGISTER,
+	SBI_SSE_EVENT_ENABLE,
+	SBI_SSE_EVENT_DISABLE,
+	SBI_SSE_EVENT_COMPLETE,
+	SBI_SSE_EVENT_SIGNAL,
+};
+
+enum sbi_sse_event_attr {
+	SBI_SSE_ATTR_STATUS = 0,
+	SBI_SSE_ATTR_PRIO,
+	SBI_SSE_ATTR_CONFIG,
+	SBI_SSE_ATTR_PREFERRED_HART,
+	SBI_SSE_ATTR_ENTRY_PC,
+	SBI_SSE_ATTR_ENTRY_A0,
+	SBI_SSE_ATTR_ENTRY_A6,
+	SBI_SSE_ATTR_ENTRY_A7,
+	SBI_SSE_ATTR_INTERRUPTED_MODE,
+	SBI_SSE_ATTR_INTERRUPTED_PC,
+	SBI_SSE_ATTR_INTERRUPTED_A0,
+	SBI_SSE_ATTR_INTERRUPTED_A6,
+	SBI_SSE_ATTR_INTERRUPTED_A7,
+};
+
+#define SBI_SSE_ATTR_STATUS_STATE_OFFSET	0
+#define SBI_SSE_ATTR_STATUS_STATE_MASK		0x3
+#define SBI_SSE_ATTR_STATUS_PENDING_OFFSET	2
+#define SBI_SSE_ATTR_STATUS_INJECT_OFFSET	3
+
+#define SBI_SSE_ATTR_CONFIG_ONESHOT	(1 << 0)
+
+#define SBI_SSE_EVENT_LOCAL_RAS		0x00000000
+#define SBI_SSE_EVENT_GLOBAL_RAS	0x00008000
+#define SBI_SSE_EVENT_LOCAL_PMU		0x00010000
+#define SBI_SSE_EVENT_LOCAL_SOFTWARE	0xffff0000
+#define SBI_SSE_EVENT_GLOBAL_SOFTWARE	0xffff8000
+
+#define SBI_SSE_EVENT_GLOBAL		(1 << 15)
+#define SBI_SSE_EVENT_PLATFORM		(1 << 14)
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
@@ -258,6 +302,9 @@ enum sbi_ext_dbcn_fid {
 #define SBI_ERR_ALREADY_AVAILABLE -6
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
+#define SBI_ERR_INVALID_STATE	-10
+#define SBI_ERR_BAD_RANGE	-11
+#define SBI_ERR_BUSY		-12
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5a62ed1da453..cfd8d51fa2a9 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -57,9 +57,13 @@ int sbi_err_map_linux_errno(int err)
 	case SBI_ERR_DENIED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_BAD_RANGE:
+	case SBI_ERR_INVALID_STATE:
 		return -EINVAL;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
+	case SBI_ERR_BUSY:
+		return -EBUSY;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.43.0


