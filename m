Return-Path: <linux-kernel+bounces-87108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B274E86CFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DF01C20A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD370AC3;
	Thu, 29 Feb 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcPaGFY8"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAF3839D;
	Thu, 29 Feb 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225633; cv=none; b=DWK5k+DN1ehjL4xv54Pzetk6qvx/DNQVfXjIGjNVxoy8koUTyVgEbLMoBtsDxXhoYZwTZx2LUEZrpHRg5DXeyp4s8+aacZ+vnslUCFnw/iwn4OSl0vJWutGKVjTvz5C4sUCq36bQOp5j9GSCGDeIv78MPoekDsS1PEuHDaETjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225633; c=relaxed/simple;
	bh=j+5NIEvfEP01ISHJtm0jL77SI9sa3eRsj8mG3FtpjjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYEh3FZ35MayCrTFSdSWs1Qvt35IppSU3v+PV8u7ITFSJ7naRIkC7TPzZlQpdTOBpaSxNXWAPkghc7JJo5lGHaYvy7DZYA+AfAXMBrAA24OAZJ8VvkxJA96xxY7aqNsuXCbrOka7qGcgYgjSJG4Un14vqiR458KSdufv5+SaW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcPaGFY8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so13223291fa.3;
        Thu, 29 Feb 2024 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225629; x=1709830429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnpFbPWiqT+OxvexmGOJHCE54uMlgYM+q9V2u9d1aOc=;
        b=gcPaGFY8I6jSSGlLZ9cTf8FWYiDUbwTllXSi5qBWemag/RJRIWDTfJ5TjCS84P9+Cf
         /I2/nRdIxNBQxtUo+CpOfBz1JxxsDcWkt9eBQ4Y1NdgrWVhvIOjeVEpdRz5AYOwrIa4/
         Moxu6Vwk0ajcKZdIeCEOSLGgCwfEXRcX6Z7VPBlsTFAoxJfFVy6/ir3Mj9czayjJp2Al
         PoDzsrdR+R9G18bjdh/AvG1d5XSqIS0a4h4vKJNDXsTjZjKfDFXyeQjK6L1uSmCNynLd
         VVHxokSm8coPopWhaPKmWL8iW6FPkyr2dT2pqkqoCON7mdj3nT08SHrfEa8nljuOm0vz
         /OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225629; x=1709830429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnpFbPWiqT+OxvexmGOJHCE54uMlgYM+q9V2u9d1aOc=;
        b=UM6fPYUxu2PbNEBpyUjnD8mUh09QHdvsqCrwVYGUX/yIzA+g6A5GSq36zyfqk5trGO
         gYZOQyIJdGVRQ6XslUa15p5VKt7zWhfyYonCSBby+GkFhKsh5gV5lqqgJp0Uacik4SZr
         0kkDN5EifbB/KFNAdNj19XrWNP9sFt75+hcIsk5H3M77dWOYC4/ahgUgihFg5ziu7J6e
         SkIpcn9yqni7AEuVBdjyX5S5FVOk4FrqDYufXOFjkxL1kEwbw9fK+3pK9PibvVaCAS9J
         ySMEb5X4ltlIQLMgaXdiaa+8kuEPmFSjK7LiYuOx0lTEafxWk+b1Q0hfQ9MjSJXuPPEb
         WgcA==
X-Forwarded-Encrypted: i=1; AJvYcCVvkIHfoxD9C8aTazpVV0XA8GWhFvCJkIW6ioCebFXD9Jy4fCl4/FalExbT8hmYGUQ769tv3in4pprR1rg1nRrUdFMtXBJPYwryoYWX
X-Gm-Message-State: AOJu0Ywee1kF8cVmNBuenm6kU/wEjg6X5gckjrQvrqhfKg2HeL1vownv
	sabZKITeRJqQpII4f+Hnxc0wV3b5VpX/i3dAuNtraBqkUolHonvaDPLiAxSIbqQ=
X-Google-Smtp-Source: AGHT+IEht79WtOAZjamDNriTIW5A1q8EutVCuO4inc1EIpvWDUFQOqiWIbZBnrlqvhQxwrgjY11N8w==
X-Received: by 2002:a05:6512:3b10:b0:513:1b56:d46c with SMTP id f16-20020a0565123b1000b005131b56d46cmr2392229lfv.45.1709225629338;
        Thu, 29 Feb 2024 08:53:49 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id f14-20020a19380e000000b00513156a7601sm315668lfa.49.2024.02.29.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:48 -0800 (PST)
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
Subject: [PATCH v3 02/20] media: i2c: ov4689: Sort register definitions by address
Date: Thu, 29 Feb 2024 19:53:15 +0300
Message-ID: <20240229165333.227484-3-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put register defininitions in the order of increasing register
address.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 5a509e908e3c..a6c101044eb3 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -19,15 +19,15 @@
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-fwnode.h>
 
-#define CHIP_ID				0x004688
-#define OV4689_REG_CHIP_ID		0x300a
-
 #define OV4689_XVCLK_FREQ		24000000
 
 #define OV4689_REG_CTRL_MODE		0x0100
 #define OV4689_MODE_SW_STANDBY		0x0
 #define OV4689_MODE_STREAMING		BIT(0)
 
+#define OV4689_REG_CHIP_ID		0x300a
+#define CHIP_ID				0x004688
+
 #define OV4689_REG_EXPOSURE		0x3500
 #define OV4689_EXPOSURE_MIN		4
 #define OV4689_EXPOSURE_STEP		1
@@ -41,12 +41,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_VTS			0x380e
+
 #define OV4689_REG_TEST_PATTERN		0x5040
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
 
-#define OV4689_REG_VTS			0x380e
-
 #define REG_NULL			0xFFFF
 
 #define OV4689_REG_VALUE_08BIT		1
-- 
2.43.0


