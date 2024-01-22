Return-Path: <linux-kernel+bounces-33120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B18364F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28121F25D00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8623D3A7;
	Mon, 22 Jan 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyduDueS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8383D3A5;
	Mon, 22 Jan 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932135; cv=none; b=dnFm7PKqRHAZYLuJkQKE6adUKA4rE85kLIMrrQ9vBytVSvaYX65rZCS45V9JCEf347ybVOKvqYEYKTASikN1s7B3/gsQ175HZKONPL6lfiwYEhLcXti4W5glG88EPUTt/xX1NH20nPFW0TlQ9ovIDhPaaRWdidIf2HCFOnFBzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932135; c=relaxed/simple;
	bh=nAMTkjMJIaXjYcOCizDe0zOvCWo33wem2AkpQiC3kwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdmEdcMnT0/C8RW4MkXaWV+WAy28Ab3zpPI8Zo8aPZjdpj+LD4yV+2VDFAJUZDNYyy6iLfJ3PzOOJp268oEVArqDWhtfY+IjOYLJbmTlTh+OcmISV4+XD3tIWzEdH4NhfUjwO9W5NSLTM1RMmKju/fAE1/3jVdFuNQAEczIpNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyduDueS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dac225bf42so1572554b3a.0;
        Mon, 22 Jan 2024 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932133; x=1706536933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBzi1ZtxV0Wz7ndzuxElZ9M2KGV6gvPDf2DJXynnwTQ=;
        b=FyduDueSHCYN1ACFZYchcdZrzppPqP2phGJCVzhKskSiqoINXx9Q76uXtUGEdPx+hx
         vdJ5crR00I5+w7hi9dp0mZcIm6/UVsz/H+9C5sgBLO0sBslTW/QWJ5otLE5y62jJ3Mdw
         ohph9+HI4efka5ZE/n6jXRFmeaFpf3E9otg6I/qDRjJMxNPnMjOnKT4Lv9lkA5pqCX80
         pKs0z7uqMNCBQxxTdn6cS5ObpYHvdllyWvyw/72jtQI/ZNvLlTNXdO6F0twl76sB89F6
         KwVT0g6lt6hWnj5QpllmhaEqTINXA+1BuAdIoWZM5DBCP+uwU6w08zAuCHxr4EMO2XW0
         WArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932133; x=1706536933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBzi1ZtxV0Wz7ndzuxElZ9M2KGV6gvPDf2DJXynnwTQ=;
        b=twRuRH8O7rVSJBJonRxEfP40SXwswk3kKEjBLYfVxI+QCfGx70xlz75gI6ayXuRUZK
         So+OqxsPfgBHYNBNrrk2+wClGVjZgjgaxyWmboqqafLBGCLP5vEB9q+Fsnob60jG1KAo
         AB6Rlg5n6Ox6t0Jqmi+5Fkam+EsNOYtn8CYOzzBvQPn87V/f5IvtamJnwgeudS4Nm9e9
         4qIJD+FV9LTNB7UC/3XMg7L/zKqSOjFLL1CLqjlwRZZSYZzg+WPV4Ur449c2zV4hrZ6Y
         8aFZIQ5/WiMsWXow0Q5ocirtAWKFbdTBra6PHlggfTfwETlNZVpoBgDZ9ClgoUfE9bUn
         nMGA==
X-Gm-Message-State: AOJu0Ywx531KaHhbqMrFVurVvpqqmae7O25jde0fgIFbUGcpLLCTQB5W
	RKjE2TbgglOJ/h+AXynllfUWzMcCy3iKeLCd8REC+/g6m4L1sauu
X-Google-Smtp-Source: AGHT+IFKfnPZmrXZUyjCuKiG06NUlweMDcTv/4/v6opBAhlyfpqRgZ5fNFEBBrFZxZsGuLn7V76+0A==
X-Received: by 2002:a05:6a00:9a2:b0:6da:dbd9:173b with SMTP id u34-20020a056a0009a200b006dadbd9173bmr1998094pfg.49.1705932132016;
        Mon, 22 Jan 2024 06:02:12 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:10 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] nilfs2: convert recovery logic to use kmap_local
Date: Mon, 22 Jan 2024 23:01:48 +0900
Message-Id: <20240122140202.6950-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recovery function when mounting, nilfs_recovery_copy_block() uses
the deprecated kmap_atomic(), so convert it to use kmap_local.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 0955b657938f..b86b2cfb662f 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -481,9 +481,9 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 	if (unlikely(!bh_org))
 		return -EIO;
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memcpy(kaddr + bh_offset(bh_org), bh_org->b_data, bh_org->b_size);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(bh_org);
 	return 0;
 }
-- 
2.34.1


