Return-Path: <linux-kernel+bounces-4193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6A8178FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A521C2549D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1713674E0E;
	Mon, 18 Dec 2023 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdadFdtp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20987740B2;
	Mon, 18 Dec 2023 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e1112b95cso3689125e87.0;
        Mon, 18 Dec 2023 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921270; x=1703526070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78C4018Wj6QQ6G/TMfHrY+9uEZBmbcTZYvwwuREmiaI=;
        b=XdadFdtp/8+DeNh9A5xmVYAA3wh/UFHiyaXZTK+jVPAcXB1B+hpytXV/Q8lXTzoz9t
         D/eOD+Tx4pCW5vpUE+PxEFewrLuhIUnYGYYNlVAPALgHm+q+mD+QwnctpfcpREcTRAwE
         W36w0ESPMEk00qGn87u07KyHZFyAWa581BKd9c8LOlfWZbGiqReaAH3y5KwYfuQ/Qn6U
         kc9Mx/vch3tAMSCq0mo/5tjEEiamA4id8BGeue2ywvUhAQtAxguqWxswm9GaV70DAp31
         2lRrk8M53qmvoRPMTkN1iE4fRDUDqLvmKuGe+LHVGtikw0gUouDWJNWELtWnxWxnPK+h
         xN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921270; x=1703526070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78C4018Wj6QQ6G/TMfHrY+9uEZBmbcTZYvwwuREmiaI=;
        b=QxbC9w7o7zg99GzTi3ftpZb/AnQDEpA2dFaNzF2acGl9Ruq53hTOuZTskGUDqsva5x
         cJjfI0cEHhTVhNUOry1QJBrmhg8rb7OFIQOJv+PBUJjE2q4ovbtB0l9pG6R1Y8fNr5BG
         pVk6k2ZhW5SmK7ZbS9hW9ub/dCJEcAMKXhkxOdvBtVhh2mBr1IxhsGxyD+dDYbY7fihk
         NMqviJ6SqTDVQBegTYUlWnskPUYwUasLSgDu9YKAM+Oi//g/S3a+Az8rAmLaFZW5Y78p
         VCv0/wn34brVP9J9Pz+ytcWpx2PMqUY47YChOSo9+TB85C5PQm5G03Zoz4DsmAWmWgFk
         buYg==
X-Gm-Message-State: AOJu0YzvJ6T5eJGLy2L1Nh/s+GvW38FaDyP4GSXfgp4qs/kgina+6kqf
	mdOxoNPRfOlFSju3vbbVOnTani9GGqMHcg==
X-Google-Smtp-Source: AGHT+IHoW+UvwA10FafX4ZKJJjhDgqd1FlaW5EV33a76GpIWRud9d485W+bLdB7KmpgrDAKBtd49oQ==
X-Received: by 2002:ac2:4e11:0:b0:50b:eadf:f175 with SMTP id e17-20020ac24e11000000b0050beadff175mr5774966lfr.91.1702921270413;
        Mon, 18 Dec 2023 09:41:10 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id g42-20020a0565123baa00b0050bfe7a602csm2978189lfv.74.2023.12.18.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:10 -0800 (PST)
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
Subject: [PATCH v2 10/20] media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
Date: Mon, 18 Dec 2023 20:40:31 +0300
Message-ID: <20231218174042.794012-11-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218174042.794012-1-mike.rudenko@gmail.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
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
index 64cc6d9e48cc..cf1303744e7c 100644
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
2.43.0


