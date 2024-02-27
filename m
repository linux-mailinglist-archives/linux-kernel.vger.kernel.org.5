Return-Path: <linux-kernel+bounces-82775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B71868981
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0B91C2110D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7A53818;
	Tue, 27 Feb 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL23UPDg"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108728366
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017492; cv=none; b=RKjsDazX83I+CXt6uIWhZEXrITthEqT1XsqSt9RwSH+Wj7f/nTF6fYuROkaKLf+1TrvIHW5gAq71hVb5aVRsj9bDHjHPlK52ZQhmZ8gIgR0ZipITxWYubNmEHUwxkulEtmYbTuO1xFAzTXgou4Hzrjntd42I4hxLUZJDeeHObjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017492; c=relaxed/simple;
	bh=zBL8nxW+5/neV82/pCUbPddBMc5jugz9xVoVZc2ucAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MSitVehquCPJk2VCX7ILKt71SoBXTZAVWFE/Cpo+g02YDRBlIyL3x5NCbRQof2kY0x2TcoLSSK2aLVdqsLtvnfoEQ5TmbVF1t4yrAdqWqMuWy361EEEBWnTOrgEmWxVdOilamuiZDMsZKPjaa8/3I3lh8bI15R4MxFiZV67BRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL23UPDg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dca8b86ee7so14067525ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709017490; x=1709622290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xh9xry9yXUPCbuZkIvBEujR1IE4YpcvcS1See1vKpM=;
        b=QL23UPDg7H6PcMBeDbhFvmyqnBBLnGgwHxNxe7I3oTQJFUGuHf2b1TGe5vyMuujCo3
         aLP9GpQSTRrdMkPeYW9PA1TPygKVJcU2jegFtbBDssjzl8ZHCeVNE4swCxlqvPLHd2mi
         Ot8Y4tUsh+aR6Km0m3iAjWXc6ja9hsY4kZUqlqfuY1c3Lw8grXhEkSDFhwltDzXSll5h
         WAcL/kBqxdzfDmG3VXcNG+1rhp4C3y39UGkBbksco8a6WlgeZwc/NWfEawZivU6NY4t7
         enCvIrOzSnXqpcqUQeFdsICVbe5dSWqn8eiwINnlz/i+LdKPmaLqIuBvnMHE79Aq4J/g
         OaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017490; x=1709622290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Xh9xry9yXUPCbuZkIvBEujR1IE4YpcvcS1See1vKpM=;
        b=nZHAikzApwfo734+AXEMBBtTP/pt+r6eZMhjWEAMLdKlcrw2c9q8EjhFrpKhQSUEhL
         TqJfmoR/d3j2X3BTDKHU0knJyc0cJyZuKSVE2uFMXvyhtcLxe4L1Ak5KV7OOnAVjkudS
         mkRhTZmc9O0SJ7Hj3DsFvsWWbwa+2arGwLOXz+ZbeBD3VNCY7oPwp+h7qGp1Bfxd0tvC
         qI6AwzQnRWsFii0jUD7AGbTX82GhcWdt5Yr98cFmHTRWjPkHlPLjts/YQ9z5x0afEI4P
         U+okrE4NWf/ZewddhPb8CFJu6LY1scfLI37LRCqd6S7gUmDilexldvY73y9xYaSoSb15
         irBg==
X-Forwarded-Encrypted: i=1; AJvYcCVDfxa/23xx0PcVtsaOzfQcOQFldXAXd8JwgZd4Y1a5ymmOpDsxJQXwpXv1UzWuczkEh0/OjnxTtgADPVWRRu4i++vZlXAti/ryntEa
X-Gm-Message-State: AOJu0YxC9Kiy57TONdZTv+mZrMB9m/Ye/jNTNLvVQStH5CZ8Vv2V5OKR
	tLiH/kqVahJc7fzrHZhPnYu/aFo0vgFeVPFuv57S0kOdimRzcc2Q
X-Google-Smtp-Source: AGHT+IFubJiiCFCQwBy1qas5vdMziZFMm526L3DDKWQXlWMXfbEBJ85eKPkdLH/2M/cev2JqXT7G0A==
X-Received: by 2002:a17:902:ed8b:b0:1db:d13d:6bf3 with SMTP id e11-20020a170902ed8b00b001dbd13d6bf3mr6479790plj.62.1709017490243;
        Mon, 26 Feb 2024 23:04:50 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.225.117])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709029a4900b001dc944299acsm783347plv.217.2024.02.26.23.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:04:50 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	21cnbao@gmail.com,
	david@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/memory: Fix boundary check for next PFN in folio_pte_batch()
Date: Tue, 27 Feb 2024 15:04:18 +0800
Message-Id: <20240227070418.62292-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, in folio_pte_batch(), only the upper boundary of the
folio was checked using '>=' for comparison. This led to
incorrect behavior when the next PFN exceeded the lower boundary
of the folio, especially in corner cases where the next PFN might
fall into a different folio.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 642b4f2be523..e5291d1e8c37 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -986,12 +986,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
 		bool *any_writable)
 {
-	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
+	unsigned long folio_start_pfn, folio_end_pfn;
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
 	bool writable;
 	int nr;
 
+	folio_start_pfn = folio_pfn(folio);
+	folio_end_pfn = folio_start_pfn + folio_nr_pages(folio);
+
 	if (any_writable)
 		*any_writable = false;
 
@@ -1015,7 +1018,7 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		 * corner cases the next PFN might fall into a different
 		 * folio.
 		 */
-		if (pte_pfn(pte) >= folio_end_pfn)
+		if (pte_pfn(pte) >= folio_end_pfn || pte_pfn(pte) < folio_start_pfn)
 			break;
 
 		if (any_writable)
-- 
2.33.1


