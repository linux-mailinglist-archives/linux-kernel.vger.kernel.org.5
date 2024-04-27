Return-Path: <linux-kernel+bounces-160810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3778B431F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB6B22B10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA4125D6;
	Sat, 27 Apr 2024 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5xjg01s"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604E6FC3;
	Sat, 27 Apr 2024 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176889; cv=none; b=bx8hxCp3T9F4ct4o8XvWRyqZbY2VulrfuCbTCJK9J51FkggZb9YJ7uFmd5Ejp78iSbeT4ZxcBMY8tlKmHwXqdbMarPHOAwluErziaDmjVpkYe8Mr5veWdg+/aagAEZ/MywGolT+EU2HgGIZBeHMzPG+yADhkTLmF4jakBC2In8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176889; c=relaxed/simple;
	bh=RB7T/ZPt8GF8humdrVunLWisepJhVBYmwEGCa0VAicc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwtfrOUs7OON/hNNlNX0M7PhM7qKt/jgUZ3zWa49nh/m/tGV1L42IznGxKuWCCUl/ZvUuIV7+H2D0jucpHeMp6SwV9M0Xz0lNHibLmJgzEUJFvgjRncPss+Pds5CB8jYNp/fFo+Uwgq5Nq1GSc7Z6yknWhiJDJgsD9PHvqNtIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5xjg01s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso6521745e9.1;
        Fri, 26 Apr 2024 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176886; x=1714781686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMiseJ9oP1enUq1gn4sMf++rFxBUicZHq9TM8coF3CA=;
        b=P5xjg01sNLKMT15vjQrujuWBol3RhVt1zdM8kpHqJrp5hb23luzNbBsMEbLQrSmdCA
         1nwJNL9W1+W+6g0raPV6BMzTL0Ui8b+Gm7jjCSTl/ZKpjnf3pItN++FB7SQfx0SekxlO
         xrVmm7lc0iCrQYK3sMh+ft7WOizYfQVGdMERIpa2jGt7fzmFvVKcmOwOu1zdieJYdrtd
         2A++rN4HXa80KFBgI3Yec2UBERVuT1W2ez690HLAlbqko6L9yYOfSS9bKkbP9zldXtQs
         LNrEfUKE8lNsV1NgMhVRYMzaO4F0TLknSZU/q/3uYkUnR2PvOujzmMpG0XuYyoN/H8tj
         +4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176886; x=1714781686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMiseJ9oP1enUq1gn4sMf++rFxBUicZHq9TM8coF3CA=;
        b=RCQb2knpaNbG25L8ThVFqaSDS49QBpFp+GkfGe0LukIzmBNykDltkHB4JqJgpumaYT
         ZPbGJ08dLpAED01fK7tfYcoctn5rFWVxXiztl3bc0krsCN64gPlZBVqTHy4YeIGA0pq1
         t683wwGF2ezAjq8XOcgM05kWHyFJzS3J9RXgyHUmBRQN20NxHnUbMSBBOfYCJXANCKVO
         x9wo3eKNHTofo2l/sPx7lPz/jynZfY0jnpfkKp5CLHwFQA0HdEbfhc0AwyaWFDRAB5+Y
         y4NStU6QJhdexXVxpAz/9Aw0sfKs5sHgxxcAzhXJck7/EJgJ35ws8HgCj+mOPzHOuviG
         Un7w==
X-Forwarded-Encrypted: i=1; AJvYcCXkGCsu5NtmJdqFYTu5ikWPvINhKkqezbtJkOE8VllraPUa4AjX4pajfsh8U+GYdN1LDRcn7RqfjjIpexN/UPSAypBSB2m2o7XE3dSNY/CfVl5RJpLdkuYFFHE8JesYMs58hieu0wLGnzTd
X-Gm-Message-State: AOJu0YxE4Pr9FeKwsZtp16xv/7LBrxc18L9Xragd69tAzJrmQjq2NWL8
	dU7Q5oZLlheVD9uUu6glPt/IbaP1MRGixxLKLAk4Cn8cmR/rCNz4
X-Google-Smtp-Source: AGHT+IFXqMP90DTmfKs7CdFc3nKMGKNlZz1aY4NaG5XS/PSfcwLaoAlAm6zzYdLyVe3Zsy1ziPIjAw==
X-Received: by 2002:a05:600c:1395:b0:41b:cc7d:1207 with SMTP id u21-20020a05600c139500b0041bcc7d1207mr300775wmf.19.1714176885632;
        Fri, 26 Apr 2024 17:14:45 -0700 (PDT)
Received: from 2116bb4b8996.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23748079wrw.4.2024.04.26.17.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:14:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH 2/5] crypto: atmel-sha204a - remove unused includes
Date: Sat, 27 Apr 2024 00:14:36 +0000
Message-Id: <20240427001439.12726-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240427001439.12726-1-l.rubusch@gmail.com>
References: <20240427001439.12726-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessarily included headers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index c77f482d2..5c3fef6e9 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -5,17 +5,8 @@
  * Copyright (c) 2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
  */
 
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/scatterlist.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
 #include "atmel-i2c.h"
 
 static void atmel_sha204a_rng_done(struct atmel_i2c_work_data *work_data,
-- 
2.39.2


