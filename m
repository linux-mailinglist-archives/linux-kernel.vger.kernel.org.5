Return-Path: <linux-kernel+bounces-107993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE88880495
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E2B1F2309C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153842D058;
	Tue, 19 Mar 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG7vviuR"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132E2C1A3;
	Tue, 19 Mar 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872297; cv=none; b=iIa7Di+QLpaluGt8kKklH2kCR35rCRHIXyBfPeSvHdufryPNaso+gJkVf076Uv3xjGyVTPNXYclzqAa1hPrMAWWeQhFMMQnLGzsDhRhS7zGYu3H08WFmuvrsbyHsNJEPFeH39npAdgDegyZDDZ9PC+GjoSVrPesf3MfWayx4ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872297; c=relaxed/simple;
	bh=QXOhZ8fhXE7YnPA0G5NXIgrRxRxesAzI8MRpaajT7O0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXd5gRpzF+WDQh6n09cElX9cWKgM8HITqKMZe/WeXXSjrl/8eqxlozPgbhof+apSFzyBYFx6Y1JQJcd8BVQY+LULu3alH6YatjeLitMl+R+E3Fl4UcZEcfZlVJLMlQv1l2hNKhOJamuIg2GBk/H5hkxx4CqcE/qGu9mo376RJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG7vviuR; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a480985625so2785731eaf.0;
        Tue, 19 Mar 2024 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710872295; x=1711477095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szEDIHxruW7I+bn4nLl0COJDZkTjlh/OkXkS2Z0jyIg=;
        b=nG7vviuRO5G3S+CNnzmCopkBt1Rte4fKSZ1bHal+4ya2uBMoEjh0nFQpWfB3IS/q90
         KbPTP5yN5EEr6poiO+NcMRL+FfEMZ+Zjunrv8lVbfjQ5eoE9IdFtYuF55T1t9HPG9Dz6
         eJT0e2cJOsd3wY9iYGHXl+g42Uv6ctjsRlQQwCiN2V0tw89udEeTwHeuq08cnelIGLJl
         6iy92xjW15JAw5O9rICaaIN4ysIo+iEXdMg5VLJTUcaxN1ipnpvzuX9/kDX3+bP7pCfu
         pzJcBNapANTh2f2H7qwBfohC+HcEROg88QUlPhPYJSljkFmL/YOLGvV7JtD4KEm1dIWL
         3q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872295; x=1711477095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szEDIHxruW7I+bn4nLl0COJDZkTjlh/OkXkS2Z0jyIg=;
        b=vFMigq1OdOYTCn8mCI22JQbPXAm8r5BqCQ3qRJJuVCapXppw2Y9HqhIoa/czwcB5cM
         jcePPj2sbBmoPfhQIPVW4rDMbk4DxGtOALnLfyA0YNU4Oj9eWn4wGC+uYtQAXY1nBMe/
         lSutU7Uu2yRtsRghXAxFcPoLeTOQQ5P4X9HCcKYtOAGN7K6DqTvIK+oDBC+6u4GzmkWf
         ZNQUdEKDn1HGgz1UOUKyFg+Ayy3DPefXAZhJz6QacHkMsfGkHc5tBcarsS86ax5xic5h
         sV7wayhQRg564/1Kjj8DbEG9cvk0CWlYMqykTHNDU37bjmYwyiOdGhlMcStcHskoiPe9
         xFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU99gKkEUkirlNpdWpLTfEYclcs3ZZK5tioGpWl8hkyQ8EQTP9gcPrcXAx2u2gJeH6DQyxAx7oAyCOpNT3mHAPlh8TYTUYFX1m5AonMwaur0EI2rHenfxikkyw3y5q4wbdEzmflZ5tm2dU=
X-Gm-Message-State: AOJu0YxijLRc5SNwouoFecz/mZoDYy4VYURQ62rBQ87aL1jBicKBRwxt
	CsUGnpPaHxjoIYyNNcNyKAMJ3Vzr9kYUg2oqxS0C7f1fY8XkQi4O
X-Google-Smtp-Source: AGHT+IGxxtutI/2GkkVuAhNVSZPhi80oTxv/DyzjTcVfeJcKiNA+pSwqWAtuLjgZtrOVMTMsW0Uc4A==
X-Received: by 2002:a05:6358:7f96:b0:17e:8f64:1e92 with SMTP id c22-20020a0563587f9600b0017e8f641e92mr14702410rwo.13.1710872294995;
        Tue, 19 Mar 2024 11:18:14 -0700 (PDT)
Received: from Ubuntu2.. ([14.139.121.51])
        by smtp.googlemail.com with ESMTPSA id k188-20020a636fc5000000b005e438fe702dsm9216950pgc.65.2024.03.19.11.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:18:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH] staging: sm750fb: Replace comparisons with NULL and 0
Date: Tue, 19 Mar 2024 23:47:35 +0530
Message-Id: <20240319181735.366565-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace '(foo != NULL)' with '(foo)' and 'x != 0'
with 'x' to adhere to the coding standards.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..4537f007a810 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	while ((opt = strsep(&src, ":")) && *opt) {
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


