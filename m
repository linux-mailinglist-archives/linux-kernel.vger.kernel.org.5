Return-Path: <linux-kernel+bounces-160809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C608B431D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13588B217F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF5B8F66;
	Sat, 27 Apr 2024 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrumP7qu"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C5611B;
	Sat, 27 Apr 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176887; cv=none; b=rpC9oOCUTDYugpdjAddUJx0ci3TqFor4Ke83N8jIxynyxFhSjwUeB9PlgT8nojZ8mw2EAHcfgpPOAFVH5djKCWWYzuGSEhco/40sB9fZfUrIqxNYCWL9vqMbVdkyc0a/s/8KssVHwdKnXZ3wJj3fZ6I7wYNuTYhR6wo7DtkGwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176887; c=relaxed/simple;
	bh=NU1d+mluF9avwg/CVEuJoMhXuuG/d8undlE9kBOzvM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rClXJBxi2Et5QaliZq+g68u6VDEaznZqX7w5qUgvpvNwMTIIMP1m+YTfM1+oSkaTwwoxwnC6ZejJOJ0wkevsxHhECCghr07vhLg+RWbcRhpDQek/4VXcEGtpwkGlGkNeqQrZEpKSG8XgmWZE4iNi6CIQ91qgizmYHxAR+FtlkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrumP7qu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34782453ffdso2514221f8f.1;
        Fri, 26 Apr 2024 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176884; x=1714781684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjCfCCeucpD7gDkmMDMuXuqpCswmNACU1GJc5lMp4Mg=;
        b=RrumP7quN+heHAg2oLXoX7s90VG1E9ckrSDTSAVgg3qPGahS/V5H2SEtpSBdSjZtHb
         0GH4AEAmuhbehFI37zGop6kT8OGjSf09W9P4t3e++x1TdJlky/QrxH1feKGLprG8qz+4
         ocqiiNdSPpzbL7wKBncP1Ql7sMpyCzkghuLf9TuAUrV/UCAjvqKpBYk9dKhRGemweumU
         QM0IqF+L+P8jNafCjMztZTx2jugFC98jPdC8Icx/SlD/+R6FUhD0kpqqc0djKkCXkOCZ
         8wtQgDPofu/s6kYilf7ilNvUF6viqA6A05Ul9fVzlnhTeNubIublI3re/ni2kDLheR8/
         44XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176884; x=1714781684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjCfCCeucpD7gDkmMDMuXuqpCswmNACU1GJc5lMp4Mg=;
        b=wrD4BcqYf3DN5k7TQCqYxzURJ9FYThXSPHlVdSoNppVRrGlC6N+8BjpXRj0dVfIDfP
         dykQPkmqPsLdpq5tb9PbLAmEAKocKLpsBddnClT0fuZOaAbxFtvu58aQxL2P6dgmU+2B
         aor6nUy5v1l9w8+IoxYrjwLyffWTP3AUoB5XuALI2TZNrUbCjC5agdZuLOgBJi8KrHn0
         dSaNqgi7t3pTAZtjFoUKOXdWETfKlmi0ru5zqrAsXgbQiEVZ2OfnZlJY8TOMOd8cOhjP
         bcqQltYkYHotCg3dDeit+359sUGXswM3OCJNfZrjZEaDYGYyQrTuQ+9vXR+EYP6ZnMx3
         TYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVVZYfMDxbraBE7xZSlAwzfkk2GV3nj5mcPtTTNSTsG7HdzQ7ybPDrShsSERGoBGgCFPMBmvwC0o9Wr6lLMLTWONUT+uM+kZQFgOO0JjHeeFAF9VW1xE5pU/keGfxYMFJlJxRtY+1dFBD83
X-Gm-Message-State: AOJu0YzrLr3pQRgx0O8SWfLYOm4ZhQrXclYAH+Y2CPJKp+ZtmdxqBJLe
	Z1grdrrWhvXFuQDJsNHFyxCJ9FSSha9ripkmdGklXaBetYsJEyOU
X-Google-Smtp-Source: AGHT+IHbbjw4s9G62DgHBPWcgS73Ei+GWQ+p5oOBA6ZFjffoNABr4s2scObXnnCnCLYEfmbzk+pRPQ==
X-Received: by 2002:adf:9dc7:0:b0:34c:924e:14d3 with SMTP id q7-20020adf9dc7000000b0034c924e14d3mr619514wre.30.1714176884662;
        Fri, 26 Apr 2024 17:14:44 -0700 (PDT)
Received: from 2116bb4b8996.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23748079wrw.4.2024.04.26.17.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:14:44 -0700 (PDT)
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
Subject: [PATCH 1/5] crypto: atmel-i2 - add missing arg description
Date: Sat, 27 Apr 2024 00:14:35 +0000
Message-Id: <20240427001439.12726-2-l.rubusch@gmail.com>
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

Add missing description for argument hwrng.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index c0bd429ee..a442b47a4 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -124,6 +124,7 @@ struct atmel_ecc_driver_data {
  * @wake_token          : wake token array of zeros
  * @wake_token_sz       : size in bytes of the wake_token
  * @tfm_count           : number of active crypto transformations on i2c client
+ * @hwrng               : hold the hardware generated rng
  *
  * Reads and writes from/to the i2c client are sequential. The first byte
  * transmitted to the device is treated as the byte size. Any attempt to send
-- 
2.39.2


