Return-Path: <linux-kernel+bounces-23125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E482A801
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA7A1F24250
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A6CA7B;
	Thu, 11 Jan 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZl7fhkJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE345382
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9344f30caso3467970b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704956818; x=1705561618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBLgaRParyslbYcOxEJ95TEGXR6cqF/gTpqxREqx/6g=;
        b=IZl7fhkJiU7i8qOS5CMgsRvxBC129q0qV/5dYGDYbIeZpg0xOQ8L6bRj6VC01/4yJi
         RdHNQHbz2Uq2zsR/sU/tHPMMYrHJTQN9fEnqKhAgVAyQQHo3QvfM6VuJIFahhVipD8Nr
         Rl4Ug6uWvP9FnpuwUznbHKVeasX9GQBbiVISiFjv9WXaLeW6NYGelJQhZCogCUk5Jx/X
         MJ1xBoiuXLfgJGvUq7JSygdnxoOos1sbsBts6csqiWfe6l3xBCeVPW5e0fHFLySujgZs
         hNBVqBI++ilR8cNQyZSCp6TN4ZXG/4Lyi7JSE2fSYAAihJxg2XXuF4q+SxxqDLLH3myl
         JYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704956818; x=1705561618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBLgaRParyslbYcOxEJ95TEGXR6cqF/gTpqxREqx/6g=;
        b=MDSrsHe6F3dTRqDnNJQ5qu5YHGhcwFJ9NL5ytjMUvMLn/zW/GwvyC8b8Hj0zB1jL13
         g00vVYLcGRo462TLPSw/ywv4o5psjZHSNmOkb70XF2CnGbhdTo+YBwbfaghQrfAdVNTW
         IHWl5O2ThrEqlOcakjyCKJqUweNHTnSFBnmOYcabLb0YksIGskmGPu2viEMd7bPHHwRO
         pkzwzNBxs/KFXbqToHJHI7XnObUyrjht5NrmrU42ks0X7htbKoPh4nFz3t9zxFiQI0+Q
         vH7RnRVOOGHpOP7kqdfKdi1T+CQ5t83PfjoYsg+e+TBZDDRn0p7X8EZRNa2+uAFDOJzc
         YwxA==
X-Gm-Message-State: AOJu0YxCuyHkVAan8/XuSK+PHyG4eTwM8VoMF2lhU5sp3JVCP4jojD2U
	PHznnqIxebkVL0pk+9wuuGU=
X-Google-Smtp-Source: AGHT+IHLg/wvK+cJEuAzXcUSRpvXGXcCEfsgYLiy0xQz+a/8N4iZ35+BwIE4lwxaCTkrMXvwSd2ztg==
X-Received: by 2002:a05:6a00:cc3:b0:6da:bcea:4cd4 with SMTP id b3-20020a056a000cc300b006dabcea4cd4mr491210pfv.16.1704956818501;
        Wed, 10 Jan 2024 23:06:58 -0800 (PST)
Received: from pop-os ([27.4.4.207])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78e86000000b006cb4fa1174dsm441585pfr.124.2024.01.10.23.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:06:58 -0800 (PST)
From: Pranav Athreya <pranavsubbu@gmail.com>
To: Forest Bond <forest@alittletooquiet.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranav Athreya <pranavsubbu@gmail.com>
Subject: [PATCH] staging: vt6655: Remove extra blank lines between code blocks
Date: Thu, 11 Jan 2024 12:36:52 +0530
Message-Id: <20240111070652.71717-1-pranavsubbu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

drivers/staging/vt6655/rxtx.h:22: CHECK: Please don't use multiple blank lines

drivers/staging/vt6655/vt6655_stage.mod.c:38: CHECK: Please don't use multiple blank lines
^Ignore the blank lines in vt6655_stage.mod.c since *.mod.c files
are included in .gitignore.

Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
---
 drivers/staging/vt6655/rxtx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.h
index a67757c9bb5c..be1e5180d57b 100644
--- a/drivers/staging/vt6655/rxtx.h
+++ b/drivers/staging/vt6655/rxtx.h
@@ -19,7 +19,6 @@
 #define DEFAULT_MSDU_LIFETIME_RES_64us	8000 /* 64us */
 #define DEFAULT_MGN_LIFETIME_RES_64us	125  /* 64us */
 
-
 /*---------------------  Export Definitions -------------------------*/
 
 /*---------------------  Export Variables  --------------------------*/
-- 
2.34.1


