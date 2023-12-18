Return-Path: <linux-kernel+bounces-3792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD9A8171B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1871C2472F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B83D564;
	Mon, 18 Dec 2023 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFlF86aa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE93A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd4a080c0bso103406276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702907998; x=1703512798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFw1xMXqNfgjkaBSBUL3X2hMTwwdH9z1Qrb9oU+YYCg=;
        b=TFlF86aaxDB2yvv/vLHpZ+mMqZB4dXMTKb1DVlzcFHwKmVZFpPq9uGXWZOGaebS3L6
         i3cbc8RvifUbKROS/icpuPoRwcZUzh2amgNlokOx99ZMxxrq1l8n5Mcy1lV5KGaWuvJZ
         iT/tgEopPb/f8o/0n1+dOOTW/jI2MOHUFUoaBYrzATztpUtVJvhfbs2JZUnE+Apw6eE/
         vT4Ly1jZb5iLSBVEYIWsRybVFYx2CAPj9zBKakkI9bHba7BCMmm1pTp9eG+waknfYVwq
         P0rU4+AP04TchYJ7B3cTFvbTjxyBa7GTBgioKto0hmoLtV6QgpziiYgrqpKCBmYxr12G
         5CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907998; x=1703512798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFw1xMXqNfgjkaBSBUL3X2hMTwwdH9z1Qrb9oU+YYCg=;
        b=WTM1GXiJGf4NaPF8tJo6+5t8d+aUv0gVGnbXllZmG31HZiFGChm8QUOhD8HdqwRz1v
         BeuD+qI3EC8D3fQGhG/wazhoScoLuonZhWSEELW0Oyfog6DYpLebw3KNqjs3diXK9hyg
         wuBZNaUi8l6/NbtF1Bhsejunc7vp5nz0EVpG9SL1TtnvifaZyPdVnrkfpPFwpfjFM8rI
         slvyq4kqKTSw9dbgZqyU5MGJJPezLdayGUz7gT9TfgcgFLAWcjfHZ9k+E8cnvGVOen9U
         A2/0216YinPIxj8J24FculhrGYfAPDs23dHcPQbOWFUWIdcAgsOIB1wRxcw9J4nT8lXP
         ss3g==
X-Gm-Message-State: AOJu0YxLm03QwWTnUKJLN8+zMQyeO4mGYRInk9f4Xr3nbnj1fuNC/tgu
	G1fVoAPreKaSasoMaWMY49hLQ7evt9ht5hmLemk=
X-Google-Smtp-Source: AGHT+IEFAVylPAkwhhH2AZEDt0+C92z4jGsfWuRL60FJ8EEzto9BtF/sl4dbwHDk1YbX1tmslSZZ2vCCzauBKs4CL5A=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:8a09:0:b0:db5:4d59:3b30 with SMTP
 id g9-20020a258a09000000b00db54d593b30mr1613891ybl.8.1702907998064; Mon, 18
 Dec 2023 05:59:58 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:55 +0000
In-Reply-To: <20231218135859.2513568-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218135859.2513568-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-7-sebastianene@google.com>
Subject: [PATCH v4 05/10] arm64: ptdump: Use the mask from the state structure
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

Printing the descriptor attributes requires accessing a mask which has a
different set of attributes for stage-2. In preparation for adding support
for the stage-2 pagetables dumping, use the mask from the local context
and not from the globally defined pg_level array. Store a pointer to
the pg_level array in the ptdump state structure. This will allow us to
extract the mask which is wrapped in the pg_level array and use it for
descriptor parsing in the note_page.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |  1 +
 arch/arm64/mm/ptdump.c          | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 23510be35..4e728d2a1 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -45,6 +45,7 @@ struct pg_level {
  */
 struct pg_state {
 	struct ptdump_state		ptdump;
+	struct pg_level			*pg_level;
 	struct seq_file			*seq;
 	const struct addr_marker	*marker;
 	unsigned long			start_address;
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 64127c70b..015ed65d3 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -220,11 +220,12 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	       u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct pg_level *pg_info = st->pg_level;
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & pg_info[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -250,10 +251,10 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			unit++;
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+				   pg_info[st->level].name);
+		if (st->current_prot && pg_info[st->level].bits)
+			dump_prot(st, pg_info[st->level].bits,
+				  pg_info[st->level].num);
 		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
@@ -284,6 +285,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	st = (struct pg_state){
 		.seq = s,
 		.marker = info->markers,
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
@@ -321,6 +323,7 @@ void ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
-- 
2.43.0.472.g3155946c3a-goog


