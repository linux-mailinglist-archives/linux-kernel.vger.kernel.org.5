Return-Path: <linux-kernel+bounces-6384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA881981D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975D31C250F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD61DA30;
	Wed, 20 Dec 2023 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGrmfskl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08B1DA24
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2158769a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703050150; x=1703654950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEWrGakqE+F1LdpSKKHnuv1LFOcw6TlFqunjfDsouyQ=;
        b=KGrmfskl0YM0zuBhYp8euVo25ScmOjugirBHRd8rVjwdR/L2qt8xtpPM/+t6QjRPeX
         BEmMS8vyjPiW2H0gk5VEGh1DboY7wyz4W9JdkDzpSh7Nm+HZdLNztlo7JLu6cHREFD43
         r1iyeI4ZI/4q/biQrBM+nrHtyIUfpRYLTLmTw0rbpN7pxZwvphtKdpw+fS4ucQ+lVqoS
         DPp2kjmttIqmnT0aiVY35PVnOW5BxulXXSKrVW0/mAu7sdrPNcq/Cul57UgsGF1+Mx+d
         csow3QlTHzfnmrKBN5JsqCq+QqNR85YRTo0/pY4EfHNJS4GRh4hrzB/Lmw+UhPFOZzcZ
         3CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703050150; x=1703654950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEWrGakqE+F1LdpSKKHnuv1LFOcw6TlFqunjfDsouyQ=;
        b=kyGZu0LBrwqIoZUkuRv9PCsmDikTbSztushxWdVkG43AzHp+1CPYczZYlFipCUa8kO
         cV+fmxPXkAvO0nIa6kK0+6FYcP4AfmTVbJbYsV4VYJPpxLQ3dJtmDB7tvh9YA8gna6Sq
         c5+H4qSQBfEPHd/qP1p1mjS3gtVyoouoZejAePW3/2pWkqNFR5ge47aj3UL3upVSA7l5
         tK/pIWBTaHYI3IOl/8q1g8J6XrVXtaG/qxd0/4o8uQhli9rSDiXziY5ay0X1ty+tMrCG
         9LDGEFcxtaVZafP4nqiS8k9JMbDFpQl9KIfU50yauVozyDV9nfMTr0F9Ko4vnOqN3fp6
         UOzA==
X-Gm-Message-State: AOJu0YyfUzUB5tWlHeOUYvWYK7E6PXuqTlKoD1n9+xMko9OmgbnCU9p2
	2o3ckVz6BlFe7IW/aJ6WDriMEDrFrqi1L76XKy4=
X-Google-Smtp-Source: AGHT+IEqjZJTRgn3/S6IXYZ/iWhcmRd+yjH2Er7v44/flHcMZBD2655sBYvpQalpuxIcXUCaFEe1/w==
X-Received: by 2002:a17:90b:4b47:b0:28b:cc2f:4e02 with SMTP id mi7-20020a17090b4b4700b0028bcc2f4e02mr573114pjb.20.1703050150531;
        Tue, 19 Dec 2023 21:29:10 -0800 (PST)
Received: from localhost ([101.224.17.173])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090adb9100b0028bd70dd5fesm333413pjv.12.2023.12.19.21.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 21:29:10 -0800 (PST)
From: "jiajun.xie" <jiajun.xie.sh@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	jiajun.xie.sh@gmail.com
Subject: [PATCH v1] mm: fix unmap_mapping_range high bits shift bug
Date: Wed, 20 Dec 2023 13:28:39 +0800
Message-Id: <20231220052839.26970-1-jiajun.xie.sh@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiajun Xie <jiajun.xie.sh@gmail.com>

The bug happens when highest bit of holebegin is 1, suppose
holebign is 0x8000000111111000, after shift, hba would be
0xfff8000000111111, then vma_interval_tree_foreach would look
it up fail or leads to the wrong result.

error call seq e.g.:
- mmap(..., offset=0x8000000111111000)
  |- syscall(mmap, ... unsigned long, off):
     |- ksys_mmap_pgoff( ... , off >> PAGE_SHIFT);

  here pgoff is correctly shifted to 0x8000000111111,
  but pass 0x8000000111111000 as holebegin to unmap
  would then cause terrible result, as shown below:

- unmap_mapping_range(..., loff_t const holebegin)
  |- pgoff_t hba = holebegin >> PAGE_SHIFT;
          /* hba = 0xfff8000000111111 unexpectedly */

turn holebegin to be unsigned first would fix the bug.

Signed-off-by: Jiajun Xie <jiajun.xie.sh@gmail.com>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5c757fba8..6e0712d06 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3624,8 +3624,8 @@ EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = holebegin >> PAGE_SHIFT;
-	pgoff_t hlen = (holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
+	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {
-- 
2.34.1


