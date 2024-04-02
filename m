Return-Path: <linux-kernel+bounces-128368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBE895A01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB21C225F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E315A4B1;
	Tue,  2 Apr 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKfSNfAX"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37615991B;
	Tue,  2 Apr 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076374; cv=none; b=DHRD8d7Cbia+tLTWwB1maj0EeJDxR3iH9pAdSkhmCWYnHFxybqb+JXgQ0d+7qfV3Jg5+m9sjGVmWqCXcBfie20wGSf/iY5p4iRgn5aajWROOLGOFbv/tBhJISicRyc+G+I6s2+UeDNt+tozysTLUB4SOppJwspNMoUk32KKKC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076374; c=relaxed/simple;
	bh=7kOXS7xyu2N48jimAAbbKaii/CuXqgupeAVBYRS/FAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRoZkT2mO2UliDvHWcwikuDazApI/45flC2snHwum4PpJg3sMVRC3oBngDvNpHuQFm/6Sr2D5CEsZrfcV479O85MP0JEQLbwqEK9wZz5vEpzST0bKhgh6TtcaxNBrpaTz0CPxJpTPv9ZbugmlrVg21xTwt1M8BjLX0psKL9qitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKfSNfAX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so74116701fa.2;
        Tue, 02 Apr 2024 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076370; x=1712681170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfZ3U3KA3m7+rlF0c1rXbQM13vzumjkY/zbbPelbxk4=;
        b=MKfSNfAXdk2gWsJJiR+uH8RuG9XiPrD9jpa0/9xSarT7gPyDPaPlJX2oq4hLtpaFpV
         VUnC7Wv0N6dGw5a0dY4R6Ame97ENlbpF9B+yln1uB7C3P1/gn3f9g6fzYBDlFS4c3E57
         OGoBz/HFUflSJKq8exzuI+3XXLcRndnm3y5vbuzcbirKxJi0r5zq/7L59g3Kx7RqtZa1
         ga2zRUX+RQwik92+bLTslmmdqlCDnZ5ipGQGFv2FqKgfM0GRGVdCOWgl9KFBr9t+fYxO
         OmeH3SLndajO62PwouMDuemNyM3tbnwKIpyekV+dCKyXDViijgSI8FW6GavgmyioO9C2
         lNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076370; x=1712681170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfZ3U3KA3m7+rlF0c1rXbQM13vzumjkY/zbbPelbxk4=;
        b=kgb3gNQoyNqG9FnTyerXPa+cZ6Br306LPeqtda5MJXhHPkNSw3lOZzEO0ffsT1gggs
         Aw4NV0YF6KYmf4gsP2we6pw5sGF6XTJi4mrTuYUdkzt1p5/cwKfKIXHIyry1huM+LX13
         /XwH+AdU4xEk6K7DYM9+f4JDEUHUFEnFWulG56iNtoRdZiE3geS/mOEmctptMX8Ht0k3
         j5BvVZLOLwFJGQsTMqwPRf8DjOt6mf6t4kiCp49jQ/SA/5Ia1r/XNlvbn8ABXa/V5uSR
         3/7UuQeXspFajU/gCeweryRFk+91cpNmNgkUUqmgd5LPG9u8bgeKzD5PGIynBMqahOAZ
         S7qA==
X-Forwarded-Encrypted: i=1; AJvYcCUupJ9nOax1o2aUvxr59AapIPguYlML9ey2ZA1lVgd7B27W6tbjNDva6C0AHJO1A0aCudjoV87FL8ethpHSqbt16Zzku0kxa5ROOhhF
X-Gm-Message-State: AOJu0Yz6ilX4U9Tl+UW0hEew8hTvc9rjzPv+spWxcwYcHPJNQnpSFwhH
	XJLNX4xx9PBeF2TDEfUxmySOYhqnvA1yKpY/SrUE27omAYkPaZR2nTif8oA1mTveSA==
X-Google-Smtp-Source: AGHT+IGB+J0cG75Ic8ZB0IHlp3UWQ/h/Z/hAMAgnP6BKkTEnm3b6HLien3BCLzqla66bdPSCHGyzEQ==
X-Received: by 2002:a2e:804a:0:b0:2d2:6193:6d53 with SMTP id p10-20020a2e804a000000b002d261936d53mr8109439ljg.13.1712076369699;
        Tue, 02 Apr 2024 09:46:09 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id l20-20020a2ea314000000b002d2c3bb7525sm1699840lje.134.2024.04.02.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:09 -0700 (PDT)
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
Subject: [PATCH v4 02/20] media: i2c: ov4689: Sort register definitions by address
Date: Tue,  2 Apr 2024 19:45:33 +0300
Message-ID: <20240402164552.19171-3-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
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
2.44.0


