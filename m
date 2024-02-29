Return-Path: <linux-kernel+bounces-86386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D5F86C4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FFE1C21072
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD058128;
	Thu, 29 Feb 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtAdUVKY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA015821A;
	Thu, 29 Feb 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198094; cv=none; b=Ch2j/PzjWPLL+gu+fHazlrH6P+oYYkYu4mrAmBg+d1Toh8QbLmcdss+q+pS4JbMYnyMRGzbz8EPBxCP9OY/kTXOLJ0vIamp7oSpdr6qi0gIC71WGgV08M1hLBlBuoBXdV621DLiybSqfpYKdwEgu9BVGFxPG9LkUDAAHaDOOnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198094; c=relaxed/simple;
	bh=C5R2TmBzlumHMHH2p7vy4pdnmxWie3CbQH1AmU1xvos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sKXhfV0UsfDQot6ptDjngnseP645cLfQN4nV6lYeoajIfNuhkn/qA14+RmD6sHSchkzqR51mp++30fxL2n3ZELPE1PsxRx6Uqve2SE9VKunKmIciSYO3rq4HHeDqhZkekEYSISXo7oHt4WkfIkhr8m/QtkkWmbnT1zV1Wmm0Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtAdUVKY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513173e8191so683770e87.1;
        Thu, 29 Feb 2024 01:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709198091; x=1709802891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzPR/m2RFv6uhgD4TF2TCBedYS7ZWfD3SFjKIsmd5XQ=;
        b=JtAdUVKYXjykd2Skxb7cmJF8BaNCOmvKWCcCij4/ia0XQtHgk8f/q7Jl5DjIPVhvWR
         0c2n92tk1TAn8r8KsfTyL0WjFTRTcju6mOY6ugL06KAGNCrUqs/AkzUK7Jnn1cBeGPhv
         UeqPpf0c6Nqv/wXsUa/Ue4HnFDOCWHci2usJx2cN4r3lIRHu7UgoPCOrhMctCvIWwSlS
         dy+V8/JxUBIFfP0UhF8EP8dwy53BTD3vZOzXiAfZcU4q11H9mNNGcLrTYOkEDaLQz49a
         rVv2g1v9utG0LkeLLtc3o54PuPxwtMQPmm9deFMK+9OY8YT7h5TySHQxLOHnuK4/760/
         OTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198091; x=1709802891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzPR/m2RFv6uhgD4TF2TCBedYS7ZWfD3SFjKIsmd5XQ=;
        b=uUFsc26DedEfxvFnvtJtzciC6OZxS6O+1fLQB4OW5IAyELu2e3c7itEQyC2AOXm20b
         A57p5i213yACUJr11vLx3eVwB0QyeQQWBaZsogrE8Y7OpwIdbdVaEIXN2G6rRqWwlRbZ
         x7SIfjGEMYk6dxgEeDov5WvoN8Njllc3wRIBvRmkq+Q27Uwmzr4z93PsrWQx3C1ZjJSB
         ZlFf8WHye5JKx1fKmWC7c/1USNMpICqrmy4f2TOux9BwGyJfEach0k4NqVWX9uCMQf8J
         ni9scpA4oQciQF4z3Prr9vH05I7+aDpunNffFNh38tYpvn/dkiEM3K6PjXYmFw/zEUHJ
         FS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8AgVkT43AZiLa3y6Vm+xS4E2pwdteFwz0v6Dd6PFg82lHV+jYEJVPZ0F1sfc2CZMXTlmrCFhpo277VarZYYTaQWrPrKvMBDklj/tq
X-Gm-Message-State: AOJu0YzBcVRUUXmR6FgGlt/AvM52l8yeWwQ/tfF4Z6qKhyHVNCRxQDot
	lP+2NQuN5KoGBdktj6Ymp1KQct3nD1B3Jcv7q4IDQhdEj6i4KbVz
X-Google-Smtp-Source: AGHT+IHww30pD/DmIG+i8xRd/dPP7OIbG5+LBh5J2pDzBeUzdf597VyaV4CRLyS6vRbwRGNWKL5UFw==
X-Received: by 2002:ac2:4951:0:b0:513:1829:57f with SMTP id o17-20020ac24951000000b005131829057fmr1048326lfi.5.1709198091210;
        Thu, 29 Feb 2024 01:14:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id jz6-20020a05600c580600b00412b843cd2esm914807wmb.0.2024.02.29.01.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:14:50 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] f2fs: Fix two spelling mistakes in f2fs_zone_status array
Date: Thu, 29 Feb 2024 09:14:49 +0000
Message-Id: <20240229091449.105032-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The array f2fs_zone_status contains two spelling mistakes in
literal strings. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bdb27e4a604b..072c4355d3d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4921,8 +4921,8 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
 	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
 	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
-	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
-	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
+	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICIT_OPEN",
+	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICIT_OPEN",
 	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
 	[BLK_ZONE_COND_READONLY]	= "READONLY",
 	[BLK_ZONE_COND_FULL]		= "FULL",
-- 
2.39.2


