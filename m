Return-Path: <linux-kernel+bounces-111586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E2886E30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13621C21370
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE4747F6F;
	Fri, 22 Mar 2024 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHkxsTwo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDB4778E;
	Fri, 22 Mar 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116671; cv=none; b=s55+aQwNu9VmDYJiVDdNWwl3pukkX7Kdi2nFHHm9vEt6Pdt4jCCmiRVWheCPWxVhrA9gT2ezbKQIlQEb8DqkNwD8W3qVYKtfAu/1jra+MJCb/SziqlqjKSZmd7oYkK4nr7zPu9AYvB3uUw60GBOvjV8X3AgXpAW6AfM2f9wGFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116671; c=relaxed/simple;
	bh=K5uPUA2OyjgCFH8me7FwNdu+bR7wyQUyYW7gljhoZMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzDDXrJvfmKgUyMfo4kGZPkfU7STtC6hppbJRPp4VO1P7d+0u1JiQ/I51+i27b4Rm3INOHc8OGZ+UCSpK5fztfE1rDjDk305tmKOO0AxJ0jZbr1aii0yn7+P/HIIxQ9aELViY1WyRGfUNrGQBDzpRK80G1L7bn6bafqwHc8t04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHkxsTwo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e07cd7b798so12034865ad.2;
        Fri, 22 Mar 2024 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116669; x=1711721469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3h6PneUm3Z4gvfwV64qLMOpLiMWQad8Wzjqdi//Xhw=;
        b=nHkxsTwoC+N0enhgvXaEQstyGAPRLdIb7gf6/MtM3pGQU+hfCOjv/22D9XxlzaWdgY
         jVuliVI/uCPuy+ytJIv0yMYb1CDKDbnwI1S3N1sw0R1JACXXq6NPlLVJZCDXsYR3lQDr
         YAsjrolndFI2WuM7m8No3pjY0z36lupShdLDsd4e5ntEW/Jhs/Ui07Rn1I7eZvK94Dk+
         75DjBW0nt2RAwy/z95IMkV59+DNTPkQUZNf89Jvpdyd8hvSjslisLWOcwjVUKXSEBUtq
         sNt8aBfO71qIMKq+Xtl5NDkebHbqmiAZdD+co/Vz/8jAgGM416ZDL6BytCRsJQKVYW73
         VpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116669; x=1711721469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3h6PneUm3Z4gvfwV64qLMOpLiMWQad8Wzjqdi//Xhw=;
        b=pTZRaZb6d7BXeJ7W0rWKSaBRB4dCsbmcEX8zMbkWLPqHnT5MgVoP40oDuMaNVBqlQ1
         6cuimNDrx/9cshPMcEtDv9YWhun3wNfhXSCxxBa63J0NNOKSRpl7yzkfPZTgTA6Owbub
         wxrji91sflvxXn13b/8usZCxVHNfBS+FDuKkNneJc/JAnKSsKzXAZRKybQA3WG4UbHEr
         PkE9rf3BNMfEVMvflL/xwHIwDEhtBtmojyLLpEEVe1vKw+F/jb6UJ4mXBZDT24mNEips
         8ryMdUh5V1EpStRGgJnZ7JXefGDiRwwHYb0O9jE3rBxsqC+ALMouugYL/f1rQBKXfmqL
         z7/g==
X-Forwarded-Encrypted: i=1; AJvYcCWO2bHO9QRWM818lusLi0FC9W2oNpZspfQu7QoNf8tRn5YWOW/jPM8n11w/oj9G1BeEnqT1k4gZOgV8608pZXrgugKgAbTwNzqgBigZGdMQ/5RMMXGsfutZ7wQhVuH5Uuq5CSJ5gv7sFPQ=
X-Gm-Message-State: AOJu0YwvwwEulZtN9Ay39y4xCQL4hINCPeDeayZOIcHMw2w+J1zw+Y/v
	lVKR51iOZQbCiLwwwnKlB7BjzJ1c+W8bQ8HUgaZsfJxXI0l8M2ZU
X-Google-Smtp-Source: AGHT+IFiJEAMOip5wmA1PHPsOgaVcNDNXXYBiJuEfiSe2wtyjN7SbcnsNVnLyI2KCgkn7iUft7ndkQ==
X-Received: by 2002:a17:903:11c9:b0:1dd:a16e:dea4 with SMTP id q9-20020a17090311c900b001dda16edea4mr3075150plh.67.1711116669312;
        Fri, 22 Mar 2024 07:11:09 -0700 (PDT)
Received: from Ubuntu2.. ([14.139.121.51])
        by smtp.googlemail.com with ESMTPSA id kg8-20020a170903060800b001db8a5ea0a3sm1956577plb.94.2024.03.22.07.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:11:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: 
Cc: sudipm.mukherjee@gmail.com,
	dan.carpenter@linaro.org,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v3] staging: sm750fb: Replace comparisons with NULL and 0
Date: Fri, 22 Mar 2024 19:40:31 +0530
Message-Id: <20240322141031.2776-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024032208-blunt-ferocity-22f4@gregkh>
References: <2024032208-blunt-ferocity-22f4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
with '(*opt != '\0')' to adhere to the coding standards.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..c4b944f82fb9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	while ((opt = strsep(&src, ":")) && *opt != '\0') {
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
@@ -1147,7 +1147,7 @@ static int __init lynxfb_setup(char *options)
 	 * strsep() updates @options to pointer after the first found token
 	 * it also returns the pointer ahead the token.
 	 */
-	while ((opt = strsep(&options, ":")) != NULL) {
+	while ((opt = strsep(&options, ":"))) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
 			g_noaccel = 1;
-- 
2.34.1


