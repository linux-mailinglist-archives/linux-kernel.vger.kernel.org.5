Return-Path: <linux-kernel+bounces-23982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B8B82B4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125FC1F24E00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C454BE0;
	Thu, 11 Jan 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCUG/FrD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB554BC2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d420aaa2abso34903575ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998015; x=1705602815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45PrX3tP7VGxtv3hFQc544iEjjZ3CI9ChuG4EQT6Q8E=;
        b=VCUG/FrDBNWTczrfAjq+SMYKKypuda3RyWv/3RMvM3VwkLbdDn0Z8663YIF54lb/J6
         7zZFOtUf4RzSr4ykIrXIeTwTh2AL6h4NTBtnwRi2K5AZdzy5pTvN6Jf/ttQxr6+EGcHZ
         STEYY7DQze52yoR5xXKYWSnbAcvaCcG57TDBdBDnnrZFJCO3Hh5sGDbdjdKJ82sBf6x/
         rN9O5g1osmTBID4HPnroPTw2YJqBLiWnAlz+2SdxvxbZ/sf35L3ua68ilo6bnTVfFZAZ
         fSyG/ylV5758Q8aFL8woReWhATdj7MWfWNF65FMwclJj6pTRZ3UXJhOpkMLXfCYNBUCt
         0sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998015; x=1705602815;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45PrX3tP7VGxtv3hFQc544iEjjZ3CI9ChuG4EQT6Q8E=;
        b=V1GhRoAOHYPw4rM+dWbi7yuxeXSySHVX/nvsba0/MlbZrxBBoLmVSajUJGVY4LRIPV
         s2veYeAON+DTtNtN4gqo3sJ2g/gA2PI/QdhDdtgY3/aue30lOwo4PU6nX1BuhkdZV3KM
         MxsWEfVFW8yqGK224G+Zf8bjR7ZT9m9gqwie3LdONQIyxcf80iArfXUpez2/AZzNStfb
         d6oRxN7HPM46I4C9QQjCECX8LGjBoXKfDJq+45vTNGvzDBRkDvlXCbXcNemyTZleXKBW
         M18npXBN1fvwoxkPh9uJ66bLr0/uPxYuwj0pRU6TOQEilmbk8LLAVpaFOOzXDL+CejdO
         EuBQ==
X-Gm-Message-State: AOJu0Yw4pcYwGzcOvJ4tzkcJQluqt4ysBcgj7UwuX2XNEz5ses6Exdap
	HEijSqGV7Uv38HR14bhyF/apIHNTHOSnYlDf
X-Google-Smtp-Source: AGHT+IH6jPbpjavXfb2XhjF9Qj7SJga+lz1w/NpKn2d06Fh3VXdOL8AoHZAdLauknrtPRNDLMJd9YA==
X-Received: by 2002:a17:902:d346:b0:1d4:60b1:27af with SMTP id l6-20020a170902d34600b001d460b127afmr145599plk.97.1704998015184;
        Thu, 11 Jan 2024 10:33:35 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d08e080042sm1483267plb.43.2024.01.11.10.33.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 10:33:34 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/3] mm, lru_gen: batch update pages when aging
Date: Fri, 12 Jan 2024 02:33:18 +0800
Message-ID: <20240111183321.19984-1-ryncsn@gmail.com>
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

Hi, this is updated version of previous series:
https://lore.kernel.org/linux-mm/20231222102255.56993-1-ryncsn@gmail.com/

Currently when MGLRU ages, it moves the pages one by one and updates mm
counter page by page, which is correct but the overhead can be optimized
by batching these operations.

In pervious series I only test with memtier which didn't show a good
enough improment. Acutally in-mem fio benifits the most from patch 3:

Ramdisk fio test in a 4G memcg on a EPYC 7K62 with:

  fio -name=mglru --numjobs=16 --directory=/mnt --size=960m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:0.5 --norandommap \
    --time_based --ramp_time=1m --runtime=5m --group_reporting

Before this series:
bw (  MiB/s): min= 7644, max= 9293, per=100.00%, avg=8777.77, stdev=16.59, samples=9568
iops        : min=1956954, max=2379053, avg=2247108.51, stdev=4247.22, samples=9568

After this series (+7.5%):
bw (  MiB/s): min= 8462, max= 9902, per=100.00%, avg=9444.77, stdev=16.43, samples=9568
iops        : min=2166433, max=2535135, avg=2417858.23, stdev=4205.15, samples=9568

However it's highly related to the actual timing and use case.

Besides, batch moving also has a good effect on LRU ordering. Currently when
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

Some more test result in commit messages.

Kairui Song (3):
  mm, lru_gen: batch update counters on againg
  mm, lru_gen: move pages in bulk when aging
  mm, lru_gen: try to prefetch next page when canning LRU

 mm/vmscan.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 16 deletions(-)

-- 
2.43.0


