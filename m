Return-Path: <linux-kernel+bounces-9589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1E81C818
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F78D2887E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92EB156DE;
	Fri, 22 Dec 2023 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doFUtE6l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8214A82
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9f8c9307dso1460141b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703240646; x=1703845446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqSwQxD2fbJPgUWI2ZYQp2p14IC1JkNGTdv/EQhR7s4=;
        b=doFUtE6lEf0Y+/gNYJHbqFMUaVa2U0rS4Q/AGXQhPrXHoIYVMI1j2niy6Fx+oAL/tu
         e/j7CYEIlTx5BmZjvwpi4VHrXkWTcsEUOQ2FTZ3u/azjBCHA2bC34h3ADhU0f6QoZuUJ
         2gKhmuaULyCUFin9YtH4GiPOxbufzf2lNS8n5+9JflYT1afvcNtdbO3CWs9Ah2B96PLt
         ClkqPWZFc4jqoKOKGI/Qy9VK/a98mYy/15aqt96tPyBXY7uTrMpV1q023yAD1O9VRXvM
         qFEBGXIRyTIAPFed1imWxeH0YUkzZKCBYZgpeEIH8wu7lvGZgd1YoEZ2q9PYv/4va+Gt
         14rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703240646; x=1703845446;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqSwQxD2fbJPgUWI2ZYQp2p14IC1JkNGTdv/EQhR7s4=;
        b=SdiIwQtO585SxJ1Ov22lrwcmFaf3+3U36rCeYO0QwAqV9ySBC3cZFQcAasW8APk4Tv
         R4Ccd5TIQWI9RZws2TJDLQ7KidLHnq9CRRuqsM0w2w+8exfVlvn7jQYvDWbbcvvnp/bl
         oBdfbkjQAL1ZyUlfmS20uNoKU7b4x/MOlg3fEmyvvMDIgVMEJpwT8MZ7FMKzx0XCIXfd
         bEBgP350yx6EJeoo9x+vUxT3PR/kRHbQ9x9KgMKcK/RwrutkVIO5ckCQv4EUy0wIF23X
         49A+EcUUsIZZuvUlrlGVNz7PMeYd5Op9fTWoFN9RTLlHlxNdgjZYx0RM6Tl3bgSn88fz
         tcBg==
X-Gm-Message-State: AOJu0YzSkzlGxGecAhmHoJkPtgSg4jDxdOPAOBt7pr8JX2vEArDC/IGi
	+DmF9xvsfQgU4VkQf6igJHE=
X-Google-Smtp-Source: AGHT+IEJa5V83giUnWT10v5sm3MCod/3MLsT57MZYMEmnJ7bVD0I31MCuTB3XHt55809YhFqtspSXg==
X-Received: by 2002:a05:6808:2e4b:b0:3bb:721d:8ac9 with SMTP id gp11-20020a0568082e4b00b003bb721d8ac9mr1551420oib.18.1703240645875;
        Fri, 22 Dec 2023 02:24:05 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id gx1-20020a056a001e0100b006d9912e9a77sm364074pfb.6.2023.12.22.02.24.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Dec 2023 02:24:05 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/3] mm, lru_gen: batch update pages when aging
Date: Fri, 22 Dec 2023 18:22:52 +0800
Message-ID: <20231222102255.56993-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently when MGLRU ages, it moves the pages one by one and updates mm
counter page by page, which is correct but the overhead can be optimized
by batching these operations.

Batch moving also has a good effect on LRU ordering. Currently when
MGLRU ages, it walks the LRU backward, and the protected pages are moved to
the tail of newer gen one by one, which reverses the order of pages in
LRU. Moving them in batches can help keep their order, only in a small
scope though due to the scan limit of MAX_LRU_BATCH pages.

I noticed a higher performance gain if there are a lot of pages getting
protected, but hard to reproduce, so instead I tested using a simpler
benchmark, memtier, also for a more generic result. The main overhead
here is not aging but the result is also looking good:

Average result of 18 test runs:

Before:           44017.78 Ops/sec
After patch 1-3:  44890.50 Ops/sec (+1.8%)

Kairui Song (3):
  mm, lru_gen: batch update counters on againg
  mm, lru_gen: move pages in bulk when aging
  mm, lru_gen: try to prefetch next page when canning LRU

 mm/vmscan.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 16 deletions(-)

-- 
2.43.0


