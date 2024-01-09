Return-Path: <linux-kernel+bounces-20932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83382878D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A41E1C21296
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5933986F;
	Tue,  9 Jan 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0a1SQYU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22B39850;
	Tue,  9 Jan 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9af1f52bcso1306472b3a.3;
        Tue, 09 Jan 2024 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808849; x=1705413649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8f5vyy0tPHI86sp2s5tsFXKkVf05GsuTSdlf4bjqw8=;
        b=G0a1SQYUFc3F/45LEUDRooiNuZwcVnWM11EC66C80iPeqrMz3/YaEuBPqWVbYEbhba
         TCvqMTG2t73vPl4IkzrvoYugfbVsoV94p2jPusOGLlrOSz2deLzgEYwlumXVElYKocSD
         qoEQQR3TS6z2mQrLJH95XsWgFrdYTQTLsDCtFyxFZ+p0b4sC6WoN66aIAoDrPVQh/j68
         xIVSIM/7OFfIiLG59MeJrGxgNH2v4dl3UKSOi/3uzK8kFU+EsmiMW1q0FFMP/SEYnhSu
         raHlpKSWY1g3V88GmjnWPy3yAy0R/sy64GBinaBXAG8bm10PrJK0kz181aypXXlO6wmJ
         s4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808849; x=1705413649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8f5vyy0tPHI86sp2s5tsFXKkVf05GsuTSdlf4bjqw8=;
        b=FaOkLmOK5zA2OKMH88oZuuw6ax2Ep+NSTCTwCbCVLOkYN3zXQ1OY8PVc+2Eq0S6+WR
         9GFPmZTz+VO1ut1xdhKKp/KrWCJap1UtdOrFmaT7rwuVOFCuvLgVVIoUQHK5pdhaVzoU
         VsYHD3znhE9ZoieRoURLwvnZ+xB6XEvMJcH8jgJVJNauLZHIUtdG3f4yCgoIU5iBdhdX
         cCHPRSmlMMcJsmpvIv2/DiecEWNrw/i3SFlPwECEXKqcxhWi6HCkvP/G4NbzCngI6wPY
         jKvUzc62JtAHcRlCF0Xpdy9FlnV90FK39l/xRk9dEVgpkFxF+GTJ7jUpSL2caOQtrTMs
         FKSg==
X-Gm-Message-State: AOJu0Yxxwn7FUPRLG3nGOXj0beYsk00aum+0Xup7JxiO/0X0biHnx12+
	9WxY9sypFI92vNN4tcL5CWVWM8/5ieKAeQ==
X-Google-Smtp-Source: AGHT+IFkkWND24KvGMQY0dL1e+re0wSJe275+ChZJ9ghrnuWVEp3d3qUALc5DGtNWpeqdrehsy7EiA==
X-Received: by 2002:aa7:8543:0:b0:6d9:c7f2:841c with SMTP id y3-20020aa78543000000b006d9c7f2841cmr2387041pfn.35.1704808848641;
        Tue, 09 Jan 2024 06:00:48 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d9accac5c4sm1673697pfh.35.2024.01.09.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:00:48 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 3/7] Documentation: gpio: update sysfs documentation to reference new chardev doc
Date: Tue,  9 Jan 2024 21:59:48 +0800
Message-Id: <20240109135952.77458-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109135952.77458-1-warthog618@gmail.com>
References: <20240109135952.77458-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update GPIO sysfs interface documentation to reference the new
chardev document rather than gpio.h.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/userspace-api/gpio/sysfs.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/gpio/sysfs.rst b/Documentation/userspace-api/gpio/sysfs.rst
index 35171d15f78d..ef080d811451 100644
--- a/Documentation/userspace-api/gpio/sysfs.rst
+++ b/Documentation/userspace-api/gpio/sysfs.rst
@@ -5,12 +5,10 @@ GPIO Sysfs Interface for Userspace
 
   THIS ABI IS DEPRECATED, THE ABI DOCUMENTATION HAS BEEN MOVED TO
   Documentation/ABI/obsolete/sysfs-gpio AND NEW USERSPACE CONSUMERS
-  ARE SUPPOSED TO USE THE CHARACTER DEVICE ABI. THIS OLD SYSFS ABI WILL
-  NOT BE DEVELOPED (NO NEW FEATURES), IT WILL JUST BE MAINTAINED.
+  SHOULD USE THE chardev.rst.
 
-Refer to the examples in tools/gpio/* for an introduction to the new
-character device ABI. Also see the userspace header in
-include/uapi/linux/gpio.h
+  THIS OLD SYSFS ABI WILL NOT BE DEVELOPED (NO NEW FEATURES), IT WILL JUST BE
+  MAINTAINED.
 
 The deprecated sysfs ABI
 ------------------------
@@ -34,7 +32,7 @@ standard kernels won't know about. And for some tasks, simple userspace
 GPIO drivers could be all that the system really needs.
 
 DO NOT ABUSE SYSFS TO CONTROL HARDWARE THAT HAS PROPER KERNEL DRIVERS.
-PLEASE READ THE DOCUMENT AT Documentation/driver-api/gpio/drivers-on-gpio.rst
+PLEASE READ Documentation/driver-api/gpio/drivers-on-gpio.rst
 TO AVOID REINVENTING KERNEL WHEELS IN USERSPACE. I MEAN IT. REALLY.
 
 Paths in Sysfs
-- 
2.39.2


