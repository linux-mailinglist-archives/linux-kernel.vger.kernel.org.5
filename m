Return-Path: <linux-kernel+bounces-144551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9948A47AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E5FB2085C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5D6139;
	Mon, 15 Apr 2024 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPBRPXRu"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1C4C8D;
	Mon, 15 Apr 2024 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159956; cv=none; b=FGO/p/0Z1gKX9s6dflxdNAzVUoqCy4ag5tU3pRk0eU12xurjQM7if7+FV1jAyFUvtGfokzq4P/3EFKw+jLSNpEPrp/Qlc3mS6CZQD7Xt6o1TjHdq2jupZW27DcPy7Aobh0EinFGx9HW15SjMBRVQTdKRgx07rgknZUr/ZKrQjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159956; c=relaxed/simple;
	bh=qFieUhNtf7gY5QwzUiRLdl7pLkGjb3T/77XEctVZtHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdIRQLDK3eHRyiOhLPOLPl1A10E5RDfA8MPK4pAm/7VngjAvVVmUeygSQQgDPOFgYu4ZVh+cWFJeu5YxE96Yd6bU/fhVY7GonNejOehH5xABCwlyO/saHM9o6MzV4yuEMuOECdlHKz5h+AQ6+PquQ2k7N8rmZ29C/SanpA1jRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPBRPXRu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e5715a9ebdso21685085ad.2;
        Sun, 14 Apr 2024 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713159955; x=1713764755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4DDC+LwXZjI/6N/5F4H8pVyFKOeGcEAAcQ7ZgvxsaY=;
        b=aPBRPXRuI3kLmx5+AAXtQL1NYTtspA8JrQtecr+CwYq+2AB4cvbFBBBrLYud/4zciR
         uA4fSbaE8WsVkaLXU7N71b1RfLr5PZFMw8ugicdd8wRTLfk+B+WeJXNV7Co+vnbbB5Qr
         pZnTvBLKCEsNt2yQfIRk9ys+lvmij59PqIPIN74U9BqBiS5ayVqcaKiv4Ye0fJKZOFH3
         yB2W/ZiEW/G9tGNwEI5VXs26wF+ModMxJkWsRHx7BDAg6CarwbVE5eKftnq4qIGs3u7X
         LfFawUho8dXsmj22Gzm26BYIJfTHVUmLrXEVE8fufn7aw284l9nTqnRvnmZq/6xIHdhq
         AqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713159955; x=1713764755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4DDC+LwXZjI/6N/5F4H8pVyFKOeGcEAAcQ7ZgvxsaY=;
        b=eFOKARPrqdCxaEM9TecPBL1hRq3bViowKsxkxVguEnzLLnucMAVLFLR8q61gs1aZ/d
         OafaRnPc8O7M1sGOa/xF35a0SqRkpYHoxbxfW7NwEJ1GfP4FnunCR481j9h5k0nrtojr
         tRrOS9Rxwdu8JETGK/vJyZE8aCSFzbsOKu8QaMw3AE7E2B992wwfxX9WKfeTMPNAHnJL
         RfLGMMxNtkGRKSTZUhP5mM8le0N5q1wlIsWT0/pqvWIY2Dnb2npk4ck+3jNB2fgIM5rF
         YuzFXX6pw52ZmXH3WXzLSVZkKL8f384UlqyQTqgj5Cv4A4r3Wf2aI1geQnugNbDO2EFy
         DGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRJ//U+ATvbYOzq0iA7U1DNS+yggks6WbWgzmK3HBYmIvkb1ddcYQnX8CTrWAcWxAwktD2Bn915mHvbb/UFbuso9hMeFTRo2xkfEK7llkgu1oH0a2P8Pulx6tQbtIAWmFLUzWynKMB1w==
X-Gm-Message-State: AOJu0Yyt5Ma8AfBrBrydlF4Gc4lzb2Zq3ubpqFkPvjs2qg7mOE6R0oyG
	5Tllw/vzHRR1yHAZyYWb5HzXz0wiLZWMLoMMyxtd77xgsvPw78ZOnc1ojG6L
X-Google-Smtp-Source: AGHT+IG7dNHrsvuiEQIRtiLysao3KzYqzYQz3Xs4Do5AIQA4ZwPlB4ecyD9+rnHr+pY2uLCHAGVP1Q==
X-Received: by 2002:a17:902:e841:b0:1e4:17e4:3a1f with SMTP id t1-20020a170902e84100b001e417e43a1fmr9161487plg.4.1713159954625;
        Sun, 14 Apr 2024 22:45:54 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001e3e244e5c0sm6995124plg.78.2024.04.14.22.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 22:45:54 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: sfr@canb.auug.org.au
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	v-songbaohua@oppo.com
Subject: Re: linux-next: build warning after merge of the mm tree
Date: Mon, 15 Apr 2024 17:45:38 +1200
Message-Id: <20240415054538.17071-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415152008.0708afb1@canb.auug.org.au>
References: <20240415152008.0708afb1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I admit I know nothing about sphinx, after google the similar warning,
adding an extra line can fix this (I also noticed I should had named the file
as sysfs but not sys to align with other ABI docs):

From ae3350752540696753940166e8e9f2da4b872760 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Mon, 15 Apr 2024 17:37:04 +1200
Subject: [PATCH] sysfs-kernel-mm-transparent-hugepage: fix the name and
 unexpected indentation

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 ...transparent-hugepage => sysfs-kernel-mm-transparent-hugepage} | 1 +
 1 file changed, 1 insertion(+)
 rename Documentation/ABI/testing/{sys-kernel-mm-transparent-hugepage => sysfs-kernel-mm-transparent-hugepage} (99%)

diff --git a/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage b/Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
similarity index 99%
rename from Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
rename to Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
index 33163eba5342..7bfbb9cc2c11 100644
--- a/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
@@ -4,6 +4,7 @@ Contact:	Linux memory management mailing list <linux-mm@kvack.org>
 Description:
 		/sys/kernel/mm/transparent_hugepage/ contains a number of files and
 		subdirectories,
+
 			- defrag
 			- enabled
 			- hpage_pmd_size
-- 
2.34.1

> 
> Introduced by commit
> 
>   a70dabb40c3d ("mm: add docs for per-order mTHP counters and transhuge_page ABI")
> 
> from the mm-unstable branch of the mm tree.
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks
Barry


