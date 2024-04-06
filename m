Return-Path: <linux-kernel+bounces-133987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624989ABC7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116261F21B01
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EE3BBDE;
	Sat,  6 Apr 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBaNZIBu"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48E2B9CE;
	Sat,  6 Apr 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418634; cv=none; b=V7jRZ2OJomm56S0EWKbylFp4Dw+lmbMQR5bCP94tptqvR0t7q6Eaz0bUKcFW/ur7CtBzS3vD7g4acUx07AB9hq3o3x/iK3m8Npj9CP+jBjTsMR3NJiv2cDDj5FoeioUrPsldpPHKnXqKiTGXap3yywlL0o57ecFjW6ZxBPjab1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418634; c=relaxed/simple;
	bh=gfHsICriPahC35P7jVRATWSMKQ54cQM1rAEH8ivXihU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xs0sgFZY6saYiRhwH0y0XBWwjIka9HIMPg8pv0TXjkNvOMutZFOfqMZmqeWv0sPRUQtBRRQK/iNKTMXvyEicUVr5p3CDr9FJ0Ppe69sP+MpQOGGqZ1hoo9sgnIoQp8PabY09qoqjS3Pcy884g9mFA5jr+owEZ/W7D7R0K0T2hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBaNZIBu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41551500a7eso25648265e9.2;
        Sat, 06 Apr 2024 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712418631; x=1713023431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KizauJRdNHma1kBeTxnRBigYFQKW9iBaZFPCHtWf6Xs=;
        b=PBaNZIBugU2+bDGuZ3m2TqrfWp0q+D2do2MGUIVcNycb9PlpS/0k0u0KIzPc1jS1rd
         IuB8hcxz+R8f1DAubn3mMJrfFB2SzCEddZxZ8Bmgg1Zkk3qVGo4D5F+xnuifS1d4W0e7
         3cxT0EmnawrxCYnLo/DNsNseRblevh6cGLF+atYleBWevVRCQ9J1X9pLdn8WyNiabYZt
         Pc+6WtaygG4n4FfYgh3ROskEREPmv8WyrUu1oWfOFsSA2iIVYzePcw5kRfrtG2uqUpQG
         5+CDoLeuVtXUstTDwW+G6dwAUPn2aHOdyWdX3fnuPEwnYWeM7SQV3bNsGAWNJoL8RzhI
         XJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712418631; x=1713023431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KizauJRdNHma1kBeTxnRBigYFQKW9iBaZFPCHtWf6Xs=;
        b=lVMfDPg/sUDKFYOc2B+epdxJjzFMcZUx5zF5uLDoxxKTryXNQub8uC061aM8f8ykEb
         6ThQB69tMoN29gUpjPijN3H6ZXr8BKQSxeYBUVe8r5HoI+ZLKr5+Ge3had9PNYyLDO3i
         LGhU/eRMOV+Qr6vjmHBQSSeLErxkgGtxBvyRTl4TO2HiMZj0E0ebVZSbxIf1ClRgKM6P
         8M8KrlQ3rSDAe8IusgE3h1AzZ6IlbeH9mKC6aD0ZzWFqHGeIe2tV8V/Znw/BOY6bJieH
         lheRTjQKOe/8i0rpzg+yMFr6DgXPjtevdQCQsC7wkEj12MsQRUTHFrcs5SekLOotBzHU
         dPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/sohRfoTTBYdDRHEweJnH60U9Ub5g1qiVhHD4Goh7nzR3U/oQw23lh656LW9YNdUMLlzMS8iLpS31ua+EovfusF13TDMGzNvkcQVIrcX6NdNVI0fO01dMdzpK/l75Y3NZgCeg6P4Xg==
X-Gm-Message-State: AOJu0Yw4vcj7oiFtsM5KDi14R+VkjIFmuYbaxG4PlTrPnzeEIZbZOTYG
	QZB/EHg3T4eL+JKxVEONTkyiIol81AjfToweb5DM4lccZ4yPD/9T
X-Google-Smtp-Source: AGHT+IEX61QUDMUQR1U4gPCNIAbhyQuFUOusTeCCVGPOwKV1CgBSqkXIP7gv9z0oTj6fNWHaCOwEIw==
X-Received: by 2002:adf:f192:0:b0:33e:9292:b194 with SMTP id h18-20020adff192000000b0033e9292b194mr3304149wro.14.1712418631205;
        Sat, 06 Apr 2024 08:50:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b003455d32e944sm1084418wrt.96.2024.04.06.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 08:50:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Khalid Aziz <khalid@gonehiking.org>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: FlashPoint: remove redundant assignment to pointer currTar_Info
Date: Sat,  6 Apr 2024 16:50:29 +0100
Message-Id: <20240406155029.2593439-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Pointer currTar_Info is being assigned a value that is never read, it
is being re-assigned a few lines later in the start of a following
do-while loop. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/FlashPoint.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 3d9c56ac8224..9e77b8e1ea7c 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -2631,7 +2631,6 @@ static void FPT_sres(u32 port, unsigned char p_card,
 	WRW_HARPOON((port + hp_fiforead), (unsigned short)0x00);
 
 	our_target = (unsigned char)(RD_HARPOON(port + hp_select_id) >> 4);
-	currTar_Info = &FPT_sccbMgrTbl[p_card][our_target];
 
 	msgRetryCount = 0;
 	do {
-- 
2.39.2


