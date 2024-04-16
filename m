Return-Path: <linux-kernel+bounces-147711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1A8A7809
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4181C22CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009513A894;
	Tue, 16 Apr 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVUKQ4Xo"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025813C830;
	Tue, 16 Apr 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307546; cv=none; b=PsF1ZzsnM3MXjY+JjEH54a0pmAA7Uf0pA6drdVPFcwKAaoX5pBEuT+BFAS1qxfB26PwaNL+DEtpb3uaxdqUi2o1ikrMiY9fEHBj6XopqlDjtRrbYro9U97VLP8f5sbMBQiv0w+q6fZ2MASoaY7+ECWpT15hatrND4Fr4K7rQ8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307546; c=relaxed/simple;
	bh=K4PLJDc96oGdajL43d4DQTDBd3c8uU2qyB3w9d2ZmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMJNc8esXsyPTtLZXb7bJLayefJcKazQ1qd0xUH7vPL7ijOWoYntXlNazx9xRt+MTCeArJkUbqQEIYOJ0Qy4X7T7Q5r3T8nsb8TNaH2YGi0KOJpWjBO2kJ1nVaApsbNk9b7hMTC5E5O4UDkwKC8jmM+BLasX+YECnYwNQv48BeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVUKQ4Xo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d6c1e238so5889572e87.2;
        Tue, 16 Apr 2024 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307543; x=1713912343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+BIOfq3ynaR01vX89L5lVtxWYrZ7VGc3tkryXiEmCM=;
        b=AVUKQ4XoNStUrFzDfk/Ikl65+5qV/XppwpTHSCIfx65/GclknAI2WYJdCmqjZzy+/9
         7/PhOyerRuPxHmwI2vO3Ikxudc8qGUuf0SBQOwBXiNnKu7v1eyv2fC4i6qZ57NkzOwMv
         LaEPaPtMxFTSCOSxNsSfeuhKMcWn2Fp+VL6YGEJ8+iRU04MdTfmBR4UHjA29ap3oIOmQ
         AFqMqrNHjOp5TTud1f0+02qRi6havTC5Hre0sVEkdDQauDmWJSSGoJYILx5Cxnovqerp
         hWQBMhjwKvFHMU39jUqP20mT5yoEcTmi1TA/XWah7PmhEF2xzoJLVKyMHnExa8fXE1ab
         mVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307543; x=1713912343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+BIOfq3ynaR01vX89L5lVtxWYrZ7VGc3tkryXiEmCM=;
        b=boR5U7LTpCL7pXMLaHO0SI8481Ns5IT0oV8fQ2VGZvWdBiYlmIrl+OBTX+9XULxAV3
         0IO24Tdajk2e7lNeucTJCRWUQZ4CKReNh0Kk8d+HF5uOCNCMCfMzw80Afajk3BNEIfn/
         2JsRiyX+jI/4u5FRsS2k8hIbJ9OKL/KJQQeik9MqfyICE8V44eLMHnatJdHhHjzaTAJ5
         R8mGcEG/uwX8SnAL+rWwJlQyqB1ABbwHO85Nsmq/tpV8IbLA+Rci4bwlnqIzs3bAw6ol
         bYYMi+Cxb5LtXjPW3J0MYwpVP11JOiR8QVnMtCcrGBvfdPCFOBC30Lz0qU+F4XpY0bU4
         86fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvWUvOld23xe6sK0zSZ1hx2XvjJ91uilsCPPH3sqUFFeWxQSAQv7AgSTQK4PHrWclcQStfs4gbq6CTLFGySGZkl2yeV3kEnLXzaq4k
X-Gm-Message-State: AOJu0Yx2EckJDvPhmaFcwQgsX6rJ8QTjx/m1T1vstWH1H48ihpEqRtxl
	cP2Ww4XImdlPrmlTQU/wNX5+ZMLATuolRkU3lihnMeK/M3FFx0zvSXvGxbaa3r4=
X-Google-Smtp-Source: AGHT+IFrdonpuA3ezRfw0gWz+Hl/anAr616WSLB6KxDR86CbrAF7GyGoXp6ryMS2huLpt84nWzPCYQ==
X-Received: by 2002:a05:6512:4023:b0:515:cb94:af57 with SMTP id br35-20020a056512402300b00515cb94af57mr11740814lfb.57.1713307542314;
        Tue, 16 Apr 2024 15:45:42 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b00515d1dfab34sm1734382lfd.81.2024.04.16.15.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:41 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v5 10/16] media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
Date: Wed, 17 Apr 2024 01:45:18 +0300
Message-ID: <20240416224524.1511357-11-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_fps field of struct ov4689_mode is unused in this driver, so
remove it.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 12bd4b010c05..31352838c3ff 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -60,7 +60,6 @@ struct ov4689_mode {
 	enum ov4689_mode_id id;
 	u32 width;
 	u32 height;
-	u32 max_fps;
 	u32 hts_def;
 	u32 vts_def;
 	u32 exp_def;
@@ -237,7 +236,6 @@ static const struct ov4689_mode supported_modes[] = {
 		.sensor_height = 1536,
 		.crop_top = 8,
 		.crop_left = 16,
-		.max_fps = 30,
 		.exp_def = 1536,
 		.hts_def = 4 * 2574,
 		.vts_def = 1554,
-- 
2.44.0


