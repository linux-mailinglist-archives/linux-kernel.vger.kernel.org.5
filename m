Return-Path: <linux-kernel+bounces-20936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE2828799
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B377B23065
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5239AFE;
	Tue,  9 Jan 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpPkypit"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC939AFC;
	Tue,  9 Jan 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9cdd0a5e6so1406603b3a.3;
        Tue, 09 Jan 2024 06:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808893; x=1705413693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztYy0pG5mb/EUI1krEp4S/p84wNzOo5hR+tihGh7i4s=;
        b=jpPkypit7AEo7Pmy36BF/kYIninjGgEwFsQO/oolRYoK+GsX3d748gEHHHUMuz5S7c
         313RRLXAbo2leus1oBADuNXgHQE3V6B7fSy7ZJXnZup2wX7aV+pXnZo/yaIuOOnm9Dya
         RxH0MHwjwwknzeFs/SvcwGMuNOxahCEwQdhewNdKGXPVF0iP1z7g48ecorDan1IRMrMC
         L/3dITrSE3zEt5ZcUd1zPCe7qiNOEhvwmmPY3mpbIl12qIDWR8zdLj7O+tmfiFeA6b8C
         7QzT/Sj5ND4AcETq5UgHeDpuknTvYOY0FNdoQRMH9r5yNXaaqxWwM7hVS1ZzSQL6tJle
         Gk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808893; x=1705413693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztYy0pG5mb/EUI1krEp4S/p84wNzOo5hR+tihGh7i4s=;
        b=bTjF/E5y9XDoGpylc3oDThlAlP3jj4MNl7z19a/fmiONcHUYqoMWNP34DnnnThmLO/
         t3DYZtZP3LPdOWCY6YCGeHhFUxr47vQ8VhpbxjO2mq/g3CTFzWs/UY7H8EhXCpc56plk
         NIsKZJREMFpBONwA7TyKD0HrMxo/wTW2KbXFe35EjFFnYeXtWbUoWLFxQGP7u6rmqC/8
         O5n2Eb54E7xN2lk3Bk3wu6i27QtEyXQw4lcx+/GV5t5bFLODbZKeYNaRNDaYr3neEa3C
         DeauzpECZFmMd9v0vaFJNBLOElEoSi2UlrkMLWOo/W5lmwgMee6t+RXVLfDu1ubUbW4+
         g6qQ==
X-Gm-Message-State: AOJu0YzVKq7qGe4eHLKiXPtFqnHZ7o53ckeaYLUKMOopFTDDDhm+JdID
	Fyy1tuRl7cJUWockhmsRKLQr3H3FYrBEeQ==
X-Google-Smtp-Source: AGHT+IFu2wBrx1UlnwU1Rv4xXGxgKte8dxiYurI+14HILwPK7gzGiUnBH7pBmZ/pvr4ScLDC3x70vg==
X-Received: by 2002:a05:6a00:9089:b0:6da:336f:a925 with SMTP id jo9-20020a056a00908900b006da336fa925mr3156965pfb.29.1704808893013;
        Tue, 09 Jan 2024 06:01:33 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d9accac5c4sm1673697pfh.35.2024.01.09.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:01:32 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 6/7] Documentation: gpio: document gpio-mockup as obsoleted by gpio-sim
Date: Tue,  9 Jan 2024 21:59:51 +0800
Message-Id: <20240109135952.77458-7-warthog618@gmail.com>
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

Update the gpio-mockup documentation to note that is has been
obsoleted by the gpio-sim.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/gpio-mockup.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
index 493071da1738..d6e7438a7550 100644
--- a/Documentation/admin-guide/gpio/gpio-mockup.rst
+++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
@@ -3,6 +3,14 @@
 GPIO Testing Driver
 ===================
 
+.. note::
+
+   This module has been obsoleted by the more flexible gpio-sim.rst.
+   New developments should use that API and existing developments are
+   encouraged to migrate as soon as possible.
+   This module will continue to be maintained but no new features will be
+   added.
+
 The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
 chips for testing purposes. The lines exposed by these chips can be accessed
 using the standard GPIO character device interface as well as manipulated
-- 
2.39.2


