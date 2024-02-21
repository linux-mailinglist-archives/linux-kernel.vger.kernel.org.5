Return-Path: <linux-kernel+bounces-74371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284B85D325
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83186B24256
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADC3EA83;
	Wed, 21 Feb 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dop/TkNu"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9E3E46D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506644; cv=none; b=ofQK3wk/6TawcV0ViVyyeoFpwCaXQqXOMD/se/h48263wV7UuCRgcE1za1NacdStHvbZvSdsgWqrCwKzAF0vaQd56zoSCSoy8lfOmnVT8t5xNJ8LxBS0fAyCnyBPR3I5bvYt7lD10SgJwjf3Af2nx6tk2FlCEzUv6M3gP+tPOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506644; c=relaxed/simple;
	bh=iSAF8mw9yPYD+iDPeUrECkO4z2kAalTw8m6Jdp/05oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQcGC5hJ6pb5oRvWfP+x2KKjp1fAqJeuenHkcOJtPWdhDdkwJW0wpGGkr/7UwNb1AgSliFTE5cUPSQbriMr3KIqTT6xxiHG1lw/Fu6pGR1z5zJgoCtNoCoifUazzvc8iOuLLAXlNw6U+2XB8Dn4TeUlFAu+zcRZzyQn1DgrL7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dop/TkNu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso1734204b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708506642; x=1709111442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZrK/F617BnVPDrc38OOvpBVEVkH26jNk6vxgeNneU4=;
        b=dop/TkNuXchRwE0BX/jqUdui17Q0eknLzP4ndHUGFXbza1MNbv15+uuKHv+ab/AyXG
         sUzJ3XeKII3R6RM0eHrTjdY7s98zNamq9BDn3PXDAtfgI7vw5lIwa2qqaAqiqx86D/UH
         qbK9q6uCJAFfj42wYzts2NI7iicvX7pBRJiGHJHGdQ4O6r2Jt2HFDmxC2RQwvI6IfdHl
         l/nzLVKWMLLJsGKKFDIX0IFa3jnoqZfu3Rty2en2WTrAGUBX/zE/xtICD8Hlow8jnjt4
         IOzZPsaJYrfWea9WlA6Kr0Ae6blgVnhprNbuB0d+NP5HSn/B/8Lw9njIEBih+wTibhgR
         OCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708506642; x=1709111442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZrK/F617BnVPDrc38OOvpBVEVkH26jNk6vxgeNneU4=;
        b=TB07xhwQZKXOtXoi2lt/O+wI9qcrVC8TLuXQ6Jpg9NkyXAn9EYlYSD1B7jreKCIZZA
         lH7YVmVrzf8OLpto1zjQ9i1geSAMnGkYi3xnDdyYj+koUDLyGku+v8RrFYHINtKVe/28
         IttTRTiruXU8o6drT8OWw4IkrgiLXWgEdBf23pgTlc2x3QcfpoN1DCkHuPUrytCQg5Bn
         ePWVwWwigsHFaLupfSiWPV7TBNZXg4MloHsVSehSM/XFlU2P2orBg09aaOeojNhEZdjD
         YjxoJ2o4yRlF+ZoiAihYan0aCdByR6XeMY4HQeZNYSiyPfUu9nqB0dLl2vta6tdKZ610
         wygA==
X-Gm-Message-State: AOJu0Yz8idyQw8AU9G91I/RFHRUhppBL6/BMyg4OQGUf75w1LncH7IG5
	mEEH/8ImNh4ZsejHoVD7h3Cpk56wiJApGG08mDlJwsU6rEUzzArqal9OVBSptj0=
X-Google-Smtp-Source: AGHT+IGXZqxfiiMDC6vtnenG2qgZLaSI/0g1HeRJtxblZfh2W0gcZVCz8c+V7ui1oDCM/18JuK1pdw==
X-Received: by 2002:a05:6a20:6f88:b0:1a0:64bc:743 with SMTP id gv8-20020a056a206f8800b001a064bc0743mr17634507pzb.7.1708506642497;
        Wed, 21 Feb 2024 01:10:42 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e5f3:9cc7:f0fb:8762])
        by smtp.gmail.com with ESMTPSA id jk2-20020a170903330200b001da18699120sm7628159plb.43.2024.02.21.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:10:42 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] mm/swapfile:__swap_duplicate: drop redundant WRITE_ONCE on swap_map for err cases
Date: Wed, 21 Feb 2024 22:10:28 +1300
Message-Id: <20240221091028.123122-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The code is quite hard to read, we are still writing swap_map after
errors happen. Though the written value is as before,

 has_cache = count & SWAP_HAS_CACHE;
 count &= ~SWAP_HAS_CACHE;
 [snipped]
 WRITE_ONCE(p->swap_map[offset], count | has_cache);

It would be better to entirely drop the WRITE_ONCE for both
performance and readability.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/swapfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..17557003858c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3320,6 +3320,9 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	} else
 		err = -ENOENT;			/* unused swap entry */
 
+	if (err)
+		goto unlock_out;
+
 	WRITE_ONCE(p->swap_map[offset], count | has_cache);
 
 unlock_out:
-- 
2.34.1


