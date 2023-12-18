Return-Path: <linux-kernel+bounces-3790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5D08171B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE44F283D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD53A1DC;
	Mon, 18 Dec 2023 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPZ7iWSK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691413A1AC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3335231c733so1378329f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702907995; x=1703512795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/snQWpLs/9aDAfFwDwLoi7Q0iJhDc3rGT80KePC/RNs=;
        b=WPZ7iWSKl1JRBaFmrbik+HI9MDrQtPrfCxHSsLNW3sP5Ojjd5v0hICyuupS4XScg8Z
         iuKMp8JchtduynlhpyGRgRaURWL+0wU3VGMF9xZ2cFES+osl4zD0M0aiICqWjp0fNgnR
         SX2eO0uLZsbS8ctIqJA8OjKHQpnlsuXh1ZoEoWXQzp7bCP4xbw1aaITnpjfpNKBRppim
         zlORkhUTIMaBLQbjQ3zio3oZlcGGjA9sdOq5lWNRQCRmV+dHqBoDmcqprH5vFYW1ohpM
         xrMwqLgRu9vX6C+pnN4nlEFT1Sle+aSEjgES3BQSJxxoA0DQcaLIrFNbY/SUrPJ/gPD2
         dNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907995; x=1703512795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/snQWpLs/9aDAfFwDwLoi7Q0iJhDc3rGT80KePC/RNs=;
        b=WSz/lUgmGRMBavAqfVVLQRi1+hP85MEcZmesNEm0rHsAiViGY3tKdY42fJ6Viaj4GS
         dE0G120ieVTD1Y2Qs639CWFQxWpf+GTyITrgw6943A/zqa38M1M66yFK4YuQZEJ1EOL+
         GaOmYHhzWDXWETd9rd7CDb+6C9WyfXMmkh9MZO2gOHQE58eeqm7+v42SWcc8qvk8Zpjh
         z22DPhLV/pqvRP6vFhna08Je3iJJdHAxAdxYPYO46p6xBV1R/Q9Wyq9ZT05/0T3YACJ3
         5aUzWMunLGZc7swjj6EPw4WcQzk1RG65vtU1E9MWuzSXeXiGJ+wDv5BJ5fT2OU5SrqfQ
         6Fpw==
X-Gm-Message-State: AOJu0YySMrer4q9zyD0foRrp7LXq9vEcK5/xChJ93vJ0U91b/833m3b6
	pPmi8pxhlGeEI41geQA/PjKK81IayTbx8pu7QRs=
X-Google-Smtp-Source: AGHT+IGcU8IkdlfTmgAO7aC/oFs5X2llBNjhnb3I0wUbMfWOUAWu8CT+O1oF7roOu+Kzu88bosaE4t8ma3t0wuku/bU=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:adf:f548:0:b0:336:68ff:e929 with SMTP
 id j8-20020adff548000000b0033668ffe929mr7158wrp.5.1702907995808; Mon, 18 Dec
 2023 05:59:55 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:54 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-6-sebastianene@google.com>
Subject: [PATCH v4 04/10] arm64: ptdump: Expose the attribute parsing functionality
From: Sebastian Ene <sebastianene@google.com>
To: will@kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com, mark.rutland@arm.com, 
	akpm@linux-foundation.org, maz@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	qperret@google.com, smostafa@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

To keep the same output format as the arch specific ptdump and for the
sake of reusability, move the parser's state tracking code out
of the arch specific.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h | 41 ++++++++++++++++++++++++++++++++-
 arch/arm64/mm/ptdump.c          | 36 ++---------------------------
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 581caac52..23510be35 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -9,6 +9,8 @@
 
 #include <linux/mm_types.h>
 #include <linux/seq_file.h>
+#include <linux/ptdump.h>
+
 
 struct addr_marker {
 	unsigned long start_address;
@@ -21,15 +23,52 @@ struct ptdump_info {
 	unsigned long			base_addr;
 };
 
+struct prot_bits {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+};
+
+struct pg_level {
+	const struct prot_bits	*bits;
+	const char		*name;
+	size_t			num;
+	u64			mask;
+};
+
+/*
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the pte entries. When the continuity is broken it then
+ * dumps out a description of the range.
+ */
+struct pg_state {
+	struct ptdump_state		ptdump;
+	struct seq_file			*seq;
+	const struct addr_marker	*marker;
+	unsigned long			start_address;
+	int				level;
+	u64				current_prot;
+	bool				check_wx;
+	unsigned long			wx_pages;
+	unsigned long			uxn_pages;
+};
+
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val);
 #ifdef CONFIG_PTDUMP_DEBUGFS
 #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
-#endif
+#endif /* CONFIG_PTDUMP_DEBUGFS */
 void ptdump_check_wx(void);
+#else
+static inline void note_page(void *pt_st, unsigned long addr,
+			     int level, u64 val) { }
 #endif /* CONFIG_PTDUMP_CORE */
 
 #ifdef CONFIG_DEBUG_WX
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index e305b6593..64127c70b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -66,31 +66,6 @@ static struct addr_marker address_markers[] = {
 		seq_printf(m, fmt);	\
 })
 
-/*
- * The page dumper groups page table entries of the same type into a single
- * description. It uses pg_state to track the range information while
- * iterating over the pte entries. When the continuity is broken it then
- * dumps out a description of the range.
- */
-struct pg_state {
-	struct ptdump_state ptdump;
-	struct seq_file *seq;
-	const struct addr_marker *marker;
-	unsigned long start_address;
-	int level;
-	u64 current_prot;
-	bool check_wx;
-	unsigned long wx_pages;
-	unsigned long uxn_pages;
-};
-
-struct prot_bits {
-	u64		mask;
-	u64		val;
-	const char	*set;
-	const char	*clear;
-};
-
 static const struct prot_bits pte_bits[] = {
 	{
 		.mask	= PTE_VALID,
@@ -170,13 +145,6 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
-struct pg_level {
-	const struct prot_bits *bits;
-	const char *name;
-	size_t num;
-	u64 mask;
-};
-
 static struct pg_level pg_level[] = {
 	{ /* pgd */
 		.name	= "PGD",
@@ -248,8 +216,8 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      u64 val)
+void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+	       u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	static const char units[] = "KMGTPE";
-- 
2.43.0.472.g3155946c3a-goog


