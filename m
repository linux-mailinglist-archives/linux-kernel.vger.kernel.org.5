Return-Path: <linux-kernel+bounces-54132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF484AB46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E4A1C23C20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FC6ABF;
	Tue,  6 Feb 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izbPk/ki"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F64A02
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181066; cv=none; b=uiPfOoIrUbODF2CUl4mQSmcFA2cmscxmhXJBOwg2szqDHCE/dXNEtFiG0mzCFkbrlcSKcjRqePcqaz2VLVlnq7xnoHIaWMeNV1J5+vQJS32WU/IKo5CoJS7GXFqZl1tchQpjZiOvphcSQ+Vrza9ANyh+nOKsOYfv+7PBwYeH4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181066; c=relaxed/simple;
	bh=scT3G8d0hvvoKnSUhP33gl1mv7Hlh/DA/hrWbfGDwHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxoJJoeOzywt4FuZa59ykkmNLcgRB0yERXAI/8vV3W8Lnjj5AF97X5KtAogphzIevBGbXHLhQx1CDocxIafMM7PeSJc8l15Glq5HdFgRNF/HyVehTxT7a9gnVXZITEQMNfWoAWKENgDumZMk9J0AHMHOJ0zj6rFOstFylG72E+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izbPk/ki; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a94c0fb55so2647374eaf.0;
        Mon, 05 Feb 2024 16:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707181063; x=1707785863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfRce3S6zkTbdeJUQAz7cuPiKH1fWL095JK4J+nVs/A=;
        b=izbPk/kir57NJvgAKMPDi+/5oN3LZfklKb3GIfIkBj8tRv8e9KdiFsWAtruBg4ErAF
         pUW2dPW5+4teo+R0IgSh5Isy4KLVUX3wqRuRZ2z+l312zQejreX9Uq7LNG3fqCD4wAVD
         pTpv/GBxdtrHR0HkABsYHoRGy8NM7ojLVeDRQYRAOZMoy1rgcoQaUdD6OTnOwK+sHBNL
         5I85HM1K9gRKFVpFgnmDYkyp1KPU4/6j1M8sv4ejQexb8O0fcD7Z88NriZ1/LQSY264v
         9wlkU2mFnwB1NkGg1Xcd5Z5ZXYxwbAsf9RLvLcWYAnWI5qN/GK8QyYrv1a3ZG6X2W5+U
         ms+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181063; x=1707785863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QfRce3S6zkTbdeJUQAz7cuPiKH1fWL095JK4J+nVs/A=;
        b=wFB1En1XYPvVdzWdfqo7mnChmvMu/RTP3IFub9hs2KpSzMx//FfeAdo+UoIWPsozVu
         DEB8qL9LetZgIpMVs7fgAEYPDhE5Q4hja3bWCZGCxRx996JOBGI64ofvmEzSJ8csjE30
         mzT2hj/az1TEHwe4gJ3DrLu5BojV+sxKv6zCwFIh+jMrD70WYXXp/cvRCOE7KkdCD+Xi
         CY2d4Wt+lkpeLMGi6eNFnB0Yv2Exa5D9g4azqAYvpGQN7mJ7Kqv8ztf/UjIIDcCdqWeN
         5KwqTaP4C+swZKZg7/LO3/ZijSE1bKdKO71ItN33DJ20fHEHUDr7Ohaadcf4sxwDklUH
         CkWA==
X-Gm-Message-State: AOJu0YxHMaJ7kGt6axetyW2MKqcTiNa/IVvUuJJL9PDhZ796jnBq5Bea
	HDdChfkUUgYs/JYOGJC8UA3apzwiT3pSsxAFYKQtPnUjEBLhObMe
X-Google-Smtp-Source: AGHT+IEkNrGGAhGGq6YznIQbjcL0n+tHZBjdMv426y3Dnd50b5v40oZSymJv1GukIXsDf18ToTlDqA==
X-Received: by 2002:a4a:651c:0:b0:59a:96a1:dd0b with SMTP id y28-20020a4a651c000000b0059a96a1dd0bmr1411968ooc.5.1707181063605;
        Mon, 05 Feb 2024 16:57:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUOGPNb1Il3ECY+iuIfD1oWgY/oxiE+0CBIHNHfos6qIESfc4QbFivFBIC2Q/yorbEPoTBwXzYMf1nufYobhyycL8WsUQkjNxIIA1Ttavn1OgRcnnIULYUB13l85FtrssaSktOXw/V16g3FKuyunDgYqvCulKzxqInjSZ2bNfiEiLnNxCdFEUCtFXUFXjMfeetYP9MZAXLXvPm+yGnYTekQ3tSzArYWEfiiuMLLp4FlpjtzBwqMHxyOdINnTUd4FDxY9wYmkqUz54yEzt7Lsw8Awz2NQs3xQD9X2kXi4WnE
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id 3-20020aca0903000000b003bfdff46f1asm155872oij.34.2024.02.05.16.57.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Feb 2024 16:57:43 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Jerome Glisse <jglisse@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	John Groves <John@Jagalactic.com>,
	John Groves <john@groves.net>
Subject: [PATCH 1/1] memremap.h: correct an error in a comment
Date: Mon,  5 Feb 2024 18:57:37 -0600
Message-Id: <dba0f5f01162d6fa16e4da2a9fede7f97080e92d.1707179960.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1707179960.git.john@groves.net>
References: <cover.1707179960.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It tried to send me off to memory_hotplug.h for an enum that is a few
lines above...

Signed-off-by: John Groves <john@groves.net>
---
 include/linux/memremap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1314d9c5f05b..c0ad57241a9c 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -108,7 +108,7 @@ struct dev_pagemap_ops {
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @ref: reference count that pins the devm_memremap_pages() mapping
  * @done: completion for @ref
- * @type: memory type: see MEMORY_* in memory_hotplug.h
+ * @type: memory type: see MEMORY_* above in memremap.h
  * @flags: PGMAP_* flags to specify defailed behavior
  * @vmemmap_shift: structural definition of how the vmemmap page metadata
  *      is populated, specifically the metadata page order.
-- 
2.43.0


