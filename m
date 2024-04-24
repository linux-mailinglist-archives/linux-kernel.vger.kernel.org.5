Return-Path: <linux-kernel+bounces-157012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29978B0B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A5E1C2152A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C015E20A;
	Wed, 24 Apr 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2OjzLRa"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702B15E1E2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966782; cv=none; b=Pzg4458nzbvhazlN8LuQ8MIg2+BPWNawA9+cfFx72Jkboyqc9u83/FQ7F/0W86VPxovsreCKT2uXGovkOgiWLIVsYaeqqGbfcF02XQsTdqHHOrsrMcIN8l4fh+7TDpXdhSeuzo3N8RlsRr5ZW7191EkM+TMOHJCEhvV1fTOLnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966782; c=relaxed/simple;
	bh=cnUuGQO+at3umXaTHjxDsTD3dVrilSiLZ6MuBVufiso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lko8KR+BIV1TggVdx+nJclc5xvgUMGN+Xs0GMlNWJpUafJ7aV6ZAnfiqK3fYq1VgLnh6yK4E8KQHEBdNHOQEhDDDgR848MvSO48+sucU+Loyqv06F4KwdqPG3pWSlixnvBlMeY4fBw3gV17Db9LUrb196GAjYd8DmbPmBA0pYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2OjzLRa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso20274045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966780; x=1714571580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eSXSlkmErEctEhBOKS7ewxnrkbMKKDa4aGhbCp7pwQ=;
        b=a2OjzLRaG4CNb0Zy9lK4lycKRvbn2lknZCsmsIckRcfixWI1KYSwRFiLYEhmp7p+kN
         vbAeyStuZqPkFoaLak+CoTxHaQvzJ3O6xwO88Fg2ZMZvwwACrSbQe54+UbwsU0Za0gVE
         fzQ4kpsXgFWcZil1uJ5nxhFekDYmXoJCcbTe4pU1ZCbmk0LqWUsZU8eZ9RQaCB4H/yUt
         g5dV9lR5bvN3ShcCQRXurWEE5Daowq4aa0f0P2dZDm1Z6NJm6VVqtqTdLPdkzJrnsC6q
         ATslqz2twzkG9Ei8v2cAHFrfG+T00PQ47WnTqzPBVPocR+YFsolnzN1kPGBZh92l+uvP
         nG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966780; x=1714571580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eSXSlkmErEctEhBOKS7ewxnrkbMKKDa4aGhbCp7pwQ=;
        b=RNAeVdLWLOWmGBC1RTh6OgbkzjDve6UbY39dd3bO7sa/5RNiQnFw42jzsvhgUjge5u
         O57LF44cM24dKpDJhwHX/CewlneHIexIz6J0WSYEN2qiPin0CJIBdPBr8CtptvXRyyyy
         mrhT8RDTIMYtr3e0UEiB3H7e+wBZEXaSMkLn6AFL0KbHENr7OE4xrMzL4hvs8cMINH5N
         lnIHDuO3FwBk18ogSqTz7uziKfX2YllCXkfZlYudndvKN9gEZqzoPfjsrknmxkpnexhV
         e580jOjWnLD4H+0y0tbxnMjQjtPhQzlHKyfkenBWE8SaIpeFAZrOcos43nSzetULyLe4
         +dFg==
X-Forwarded-Encrypted: i=1; AJvYcCXiESFWMhfq1Vm5YjTKc79cJVFMxKTHu68zTVqJeSsjGpIdApgb1DaVAGS6zIBjvxDonCUphwZ0mN8ZJ8SXQ6lYEX8Dh3gvDs0AaS7E
X-Gm-Message-State: AOJu0YzYYV1YBeWwstdXzk5W/1nYlHjjGlVIQY04zgqGaXhaoS+6Sqql
	qW3rHlXtFel+IC7qmIokko51Gz3L39m2qHkoYJg3XlnotVAtBAIV
X-Google-Smtp-Source: AGHT+IFpq8EsYQokhHELiawk+TzB5MqVAd/PCoqMESyI7odQvHSf7n7b5/uplpAEizjapcocQJvAIg==
X-Received: by 2002:a17:902:ecd2:b0:1ea:9596:11eb with SMTP id a18-20020a170902ecd200b001ea959611ebmr406501plh.60.1713966780250;
        Wed, 24 Apr 2024 06:53:00 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.252])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001e89c729843sm11140235plg.228.2024.04.24.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:52:59 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 2/2] mm: add docs for per-order mTHP split counters
Date: Wed, 24 Apr 2024 21:51:48 +0800
Message-Id: <20240424135148.30422-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240424135148.30422-1-ioworker0@gmail.com>
References: <20240424135148.30422-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces documentation for mTHP split counters in
transhuge.rst.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index f82300b9193f..35d574a531c8 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -475,6 +475,22 @@ anon_swpout_fallback
 	Usually because failed to allocate some continuous swap space
 	for the huge page.
 
+split_page
+	is incremented every time a huge page is split into base
+	pages. This can happen for a variety of reasons but a common
+	reason is that a huge page is old and is being reclaimed.
+	This action implies splitting all PMD/PTE mapped with the huge page.
+
+split_page_failed
+	is incremented if kernel fails to split huge
+	page. This can happen if the page was pinned by somebody.
+
+deferred_split_page
+	is incremented when a huge page is put onto split
+	queue. This happens when a huge page is partially unmapped and
+	splitting it would free up some memory. Pages on split queue are
+	going to be split under memory pressure.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
-- 
2.33.1


