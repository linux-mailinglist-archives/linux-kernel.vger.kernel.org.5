Return-Path: <linux-kernel+bounces-20934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D483828793
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D5C1F24AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D073987A;
	Tue,  9 Jan 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtKD7s6F"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C239AC0;
	Tue,  9 Jan 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so2490045b3a.2;
        Tue, 09 Jan 2024 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808878; x=1705413678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8cU322h1T8euUzrnOuJXn7OTljQAN5GoNSLAaiJuHA=;
        b=TtKD7s6FEqUK0WZdyQN0FIMCNM02FJNPokEFfhRuPa7kUDrhUnuJVWHjm9LQfrPZR9
         gIQiFl24w1XPLT5bYEeuH4pZaExdilZGw17o+xu7HfsKlsvIAXJrE5ATm+WprNTYysu3
         ldUUBc0LWppXgJj2eBdzzZ355+iQXnGNYo4+4iS10ucWI8AdJOr+DU7xkyz1lC5nxVzm
         2HZ0aytG/xZGWpMuABKcGwwKEGw33n/M7ia5D1gWPE4uXpGQqCBsPylignBflfcL3gIn
         rF3VVLrQyBCykO/BsR4vsTVnJeR7i4ZRBBjN5EGchPXet7u6IUIDklSk0kJa4qezFsnf
         h9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808878; x=1705413678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8cU322h1T8euUzrnOuJXn7OTljQAN5GoNSLAaiJuHA=;
        b=RYpP6kZffuVvZ5TcAKqy5za5uPCb56Vixr0uQGJV/hZ1ru4ME+3uCjPbxrGV88o10i
         qtn4C/6NWtezTcYUruoyBCoYoV+L4GvdD64DrqQSXNzmNLYLzclLJIj31XoApTVFLdG4
         LclZeYu3Aw797FK9ZwtsXNn5cQ7U30wMVTtWJC9Cm1HXezFQOZGSvGEJNO+j6MC3Bn6M
         UwIAys1D4eZ67E1qWY2lORR9iYhQ57I2/oVwusCPaQhkQH8zCluroWZW+P+HTxod3WX7
         OJO4HBEGikQ7NYNyDD5fgLwZ3Z2gernECL4b8shnUNQpRnrqZTBq+u9wvn1eZNf8bYEo
         dQSw==
X-Gm-Message-State: AOJu0Yxvx4S/4HpwlXxIbhEQ+o+SM8gfCnKg5+bN9N6Mu9i2QSRMPNI7
	BAM5EN1nthxuQ8zdBpesYI88n2oFFOgDCA==
X-Google-Smtp-Source: AGHT+IGZGf9ihOaEtUP/bSov92VbNdkmIgqrMUgoZElHfLwK/P3e/DGRfGlHn1GwwF+/nD5tSDFOJg==
X-Received: by 2002:aa7:9315:0:b0:6d9:a856:ec9b with SMTP id cz21-20020aa79315000000b006d9a856ec9bmr4873088pfb.25.1704808878005;
        Tue, 09 Jan 2024 06:01:18 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d9accac5c4sm1673697pfh.35.2024.01.09.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:01:17 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 5/7] Documentation: gpio: capitalize GPIO in index title
Date: Tue,  9 Jan 2024 21:59:50 +0800
Message-Id: <20240109135952.77458-6-warthog618@gmail.com>
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

Capitalise the title of the GPIO documentation page to match other
subsystems.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index 9b0630f30d3e..8489b8a3991f 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ====
-gpio
+GPIO
 ====
 
 .. toctree::
-- 
2.39.2


