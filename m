Return-Path: <linux-kernel+bounces-34017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C58371EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A141C2A751
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387F5FF19;
	Mon, 22 Jan 2024 18:47:04 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DF56B97;
	Mon, 22 Jan 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949224; cv=none; b=i4LBDTGsCqGNvWPzg3j8Bz0EGFEA1yY0EyBgyc3zusxKbWMOr6s8CvwIzVzfm/HQx7swFwFLzkSJSCg9RJszfmm5i2i5TBpZwBlFRoGryByisZv5b7lcsxFxuxzyCiaKLB43x0nasn1K6/5ne1mO0eyCPBuUL7tV5A1uY98hMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949224; c=relaxed/simple;
	bh=nywrLQlGPh6nEooDV682/+69XpU75liacZCCI7YZP70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3bq8xMmCdgAN4C7yeys5TZsfQ+yVWrIvGnhq/vHHOY1cU3QHOIWLcMk4lC8Ga0nbthy93kZW0zPDe930dMUdunTzhmYAAKPAQfFCp5qNgK2HxBimiqTjtyk5pRBgIhtHhvqweaJIlGPJ7bKo0aqcmm31NKJeP3zTzswkGahcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso3719221e87.1;
        Mon, 22 Jan 2024 10:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949220; x=1706554020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZWPklz4V2or93x77kLaamHTv28BvI0mJJK9voflkyM=;
        b=O1BSPN0riIN23BsWFHgEtbSCGQ/vW4AZB5SLzlWavdrIcbwkLrzEmPuU8DgMzUOgvM
         QrEoK1ExwO71kOnOP9WZdqY/MfL+55hegZkDJhTnNlNwqPyquQcy47bSbWA+YOYxFnoK
         WWjtvLOlNoGVMaO4lQQG/Mm2Kw0vP/SpSqQcC87KrQsOENzOH2t5Eg58ZfQ981NmQCzK
         OcGrA1UK39JV6K+p9p89W64l43CEek3633avf5m4VkQij4/UIia8Ps/IPC2iJQHyyULx
         0owadb8iC1hpHHWCNoSMgG3W49hRLFmmi8RGo9Hb9Z+I34drf0hlFExeUac53H9TpMrA
         LI4w==
X-Gm-Message-State: AOJu0Yx/OhTeBr02QHo80+DWIvV8/PeJF3HKSkAtt6Phvx42SRyWRjZ2
	hPlzut23H+HZi3sN2CDrlVCQxL9UbWRfA/dp0ayF3LsUSyrhh4Ys
X-Google-Smtp-Source: AGHT+IF2cAqZrT5MLj0oEXhMCXt3pAxmAqTyyiactN/22j6BXalk08EGtyUSPnRSs3SN4R1PYiSp9g==
X-Received: by 2002:a19:3818:0:b0:50e:6abd:67ee with SMTP id f24-20020a193818000000b0050e6abd67eemr819909lfa.66.1705949220429;
        Mon, 22 Jan 2024 10:47:00 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b00a2c4c23cd12sm13569682ejb.217.2024.01.22.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:47:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <keescook@chromium.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Li Zetao <lizetao1@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 18/22] net: fill in MODULE_DESCRIPTION()s for wlcore
Date: Mon, 22 Jan 2024 10:45:39 -0800
Message-Id: <20240122184543.2501493-19-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the TI WLAN wlcore drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 1 +
 drivers/net/wireless/ti/wlcore/sdio.c | 1 +
 drivers/net/wireless/ti/wlcore/spi.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index fb9ed97774c7..5736acb4d206 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6793,6 +6793,7 @@ MODULE_PARM_DESC(bug_on_recovery, "BUG() on fw recovery");
 module_param(no_recovery, int, 0600);
 MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain stuck.");
 
+MODULE_DESCRIPTION("TI WLAN core driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen@nokia.com>");
diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index f0686635db46..eb5482ed76ae 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -447,6 +447,7 @@ module_sdio_driver(wl1271_sdio_driver);
 module_param(dump, bool, 0600);
 MODULE_PARM_DESC(dump, "Enable sdio read/write dumps.");
 
+MODULE_DESCRIPTION("TI WLAN SDIO helpers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen@nokia.com>");
diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 7d9a139db59e..0aa2b2f3c5c9 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -562,6 +562,7 @@ static struct spi_driver wl1271_spi_driver = {
 };
 
 module_spi_driver(wl1271_spi_driver);
+MODULE_DESCRIPTION("TI WLAN SPI helpers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_AUTHOR("Juuso Oikarinen <juuso.oikarinen@nokia.com>");
-- 
2.39.3


