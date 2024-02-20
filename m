Return-Path: <linux-kernel+bounces-73224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E621C85BF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673111F22872
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E3762FF;
	Tue, 20 Feb 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxvNhJSv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD96762C0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441901; cv=none; b=WukvU2HvbG4XGPjqcfpygZHd4uI01uyQIfbKwYqzsw+vjYuuXnWNcs5C6wnMuY23b4g7r5MiGD64zmjJwicgafZl8DqlhmdMKP0RT+opD9hEK+AIwMp2yb+yza8oHY52gi61afKUXLw4TKZNqPM2clJifbUz1smlJ3g/j0aTNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441901; c=relaxed/simple;
	bh=IXOljfRlcheaKYN7knK3H0eeyYTrPTnwQOEMdeKsDl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJS4mDFUbYMlurLEsemkLu8xVku3BY7515qcbV0k2kjnw0jk9c9/vy5ofhPIFqCCcw2AqEkw/FqWuI1mhH+j11hu82BR74toFu5ApBD8MH+CP/+vz21ri8MqZTbkz3CAYLXO2jNnT83rej5pgLsGCplVCl9qxj2Cbv+wwJ4Qr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxvNhJSv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60853aafd93so23086717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708441899; x=1709046699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNvbES0Rox8H1wht4HUzRcs5UM73wH2hWBF3+Zr3EJM=;
        b=LxvNhJSvCdbOAbRiGa2V1QJ+W8znDywkHUaSl5z6PdFGLwbnPODNpRsc+I9eSaDAsR
         pxkwkf15vtjdml1Vesshnlu+OsOLKPSn9MDXp6kz1ochuTGVBCrLzFP4MOTbD4Yv2ko3
         T3moUrI3Vs1ObvrvmstJ0cSqQbvOP3+WncSdAKjEOI9Lii8+x65O+/+ofqkqNAzP+Psm
         qpygqW3JwgrCnhMH4JPw3His3PwDkeCN5w0vamgt12rkYE1px954Rg74q1zvZbYTzk0M
         fi1QxGZT688ZqDEZK/4qQc/gvG2+o/7pFglAiolisoDBYtVYwxRarG6h1s5ZoT+I9PmN
         S0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441899; x=1709046699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNvbES0Rox8H1wht4HUzRcs5UM73wH2hWBF3+Zr3EJM=;
        b=hPf5gBeQKb9l40iYLSJlW3fjRrhyEIA0wBv5Dh8PtHSQ/RpBaCaEiszIQtHkIR4Uxv
         L+FT36L2HYrvXmm3booCYa3brv3cE/3v27rAp/pJ2oeR+yCRZrK6Lg+ekeKPDIz44xZG
         MyvCFsYiCaUPe0eX0Vbw/SaE72LoEjHl/jFBDr1PUGNJxbK+F4u46S8s/7NiLOXq6HZ3
         6Zy/nxDEr+wG3Rl7tp05dUifiTYeuVXHs6D2owmmEuW4yOWy4+VzBJ3mPIbn2WBSXCRw
         y0cpbUBSNc+abaAkgZV2VygKNMLAjeqmvnr2UAMa6EBoIh8kAJ2OMwapYDFLlkvqyWcu
         9NNw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7YawZm54+1Iz4WzQymCh94tazT6Zz898Zysn6GBt/sZHoObe5MzAl22U7BUqnRVMFfoWykbUuYMskN7LqyfUtYNy33wmX9l2zbrd
X-Gm-Message-State: AOJu0YxzTpR1v88yf80FTnUKy6BFXt+QWr9qIe/Lf42oFy2mFxKupIgy
	lbpt9GSWDD+TK2s7lhKNHmLac0b40G41V+ebVpe42hRZa2rfG+GjWFE5Xl4EcX3E49JYZldY9Vr
	yPvaexd7YkNXNsuGlPA2hKzhvuw==
X-Google-Smtp-Source: AGHT+IHCqDd6jqD2mbOLFkiBYUplNEQYmBoUC62S64EpeNg2nL7Cr4ldMVQ2DcP6j+oQX8xSeK3buozpPcCMj1N+Kv4=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:d695:0:b0:dc7:7ce9:fb4d with SMTP
 id n143-20020a25d695000000b00dc77ce9fb4dmr4178814ybg.12.1708441899532; Tue,
 20 Feb 2024 07:11:39 -0800 (PST)
Date: Tue, 20 Feb 2024 15:10:32 +0000
In-Reply-To: <20240220151035.327199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220151035.327199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220151035.327199-4-sebastianene@google.com>
Subject: [PATCH v6 3/6] arm64: ptdump: Use the mask from the state structure
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com, 
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev, 
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com, 
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org, 
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
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
index 23510be35084..4e728d2a1f2c 100644
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
index 64127c70b109..015ed65d3e9b 100644
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
2.44.0.rc0.258.g7320e95886-goog


