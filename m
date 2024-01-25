Return-Path: <linux-kernel+bounces-39201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614AC83CC68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F829DFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316713BEAD;
	Thu, 25 Jan 2024 19:35:08 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65B13A246;
	Thu, 25 Jan 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211308; cv=none; b=H5xOSzNbf8y8bTJZNhX5pMDWeyvhP/qfi2b/2tPOjI4l7ch2tyYlnDgNC++TRY+2cgO+HVl4L22N5LTWysx6j+w6coWdOxAEquwNgsmKkPvUQXDnDQOqa6/+E+x1mZmRwGIQyePcxF06lYC4Vir4Qw44aLO9aPB+vW2MX+9ElH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211308; c=relaxed/simple;
	bh=jidTlJnEFt2vsJqGzwOQ9S+iRY0sloqlgHp7rDmV6bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icloVMzM90CM3S9qs2YvopweFO+liGcJi+93OpEqbR/LYWHzVP+jw0GYDepoauY8ceiI0pp/D6Ez9DMW9Bor/lLg5mPS4mbYPsvQq5wwXvz7LFyv8yM83qcc95NKvWzpvhkE/bLjb90bBMKlt++n/Yck7T2vn//7zx5p07voSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a271a28aeb4so772131366b.2;
        Thu, 25 Jan 2024 11:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211304; x=1706816104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA0yt97kgFg3NLmLPUohxipmTZ3Y9AD4HwjGqKfep4U=;
        b=dIsaFRsAxSSc1NTc6EXkgyOA4MY3zwbW2NLczLuVRYu1yvA0HHFYUooXeXm+JXGmB8
         fGwokjT+id9+96T8nmteLbyNdDqkH3f5V7Q8qgMiiAGxOam6LmIk6xZVStV5vW/vJHDF
         2cxwpKowXYd/zOCYIYPh1CNhkbbP6yLO+JH3X1mPRyWLt07vt/1fNSmAgfMM5yG4Qlvi
         7XVIdV2cYdrPYtUuvZPK9x1wVrDROkRsFR+xil/5pSSkUiVuBVusyN8/v1Fp9ELW5SPn
         pAhe8CG5bZOSP/RMIM/vaOLSIjFvJRAIbPF/Sh/+OeQ+O0zeZfiQGQ6Wx73W/k0NeTKt
         KXtg==
X-Gm-Message-State: AOJu0YzsL5HrbWkUp4ORt/Kb7Eql24WOG1UiK48NfNf9l8/2e6ZXAUJx
	J+qld+qfTElI56rBbwbENjZRPoHS0n2taPKWALQB5t224bj376bl
X-Google-Smtp-Source: AGHT+IFi7MLFRjfPDfswHnEmmxSRibR48i7fi1UGNGH6MfOnM9FVcJyFQBt5DTO1oNsCahLIZBUJgg==
X-Received: by 2002:a17:906:174f:b0:a30:4035:4b0a with SMTP id d15-20020a170906174f00b00a3040354b0amr49707eje.50.1706211304676;
        Thu, 25 Jan 2024 11:35:04 -0800 (PST)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a33f6b9488fsm348785ejc.173.2024.01.25.11.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Nicolas Pitre <nico@fluxnic.net>,
	Steve Glendinning <steve.glendinning@shawell.net>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH net 03/10] net: fill in MODULE_DESCRIPTION()s for SMSC drivers
Date: Thu, 25 Jan 2024 11:34:13 -0800
Message-Id: <20240125193420.533604-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the SMSC 91x/911x/9420 Ethernet drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/smsc/smc91x.c   | 1 +
 drivers/net/ethernet/smsc/smsc911x.c | 1 +
 drivers/net/ethernet/smsc/smsc9420.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 758347616535..78ff3af7911a 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -98,6 +98,7 @@ static int watchdog = 1000;
 module_param(watchdog, int, 0400);
 MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");
 
+MODULE_DESCRIPTION("SMC 91C9x/91C1xxx Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:smc91x");
 
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 31cb7d0166f0..74f1ccc96459 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -56,6 +56,7 @@
 #define SMSC_MDIONAME		"smsc911x-mdio"
 #define SMSC_DRV_VERSION	"2008-10-21"
 
+MODULE_DESCRIPTION("SMSC LAN911x/LAN921x Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(SMSC_DRV_VERSION);
 MODULE_ALIAS("platform:smsc911x");
diff --git a/drivers/net/ethernet/smsc/smsc9420.c b/drivers/net/ethernet/smsc/smsc9420.c
index e1c4a11c1f18..15cb96c2506d 100644
--- a/drivers/net/ethernet/smsc/smsc9420.c
+++ b/drivers/net/ethernet/smsc/smsc9420.c
@@ -26,6 +26,7 @@
 #define DRV_DESCRIPTION		"SMSC LAN9420 driver"
 #define DRV_VERSION		"1.01"
 
+MODULE_DESCRIPTION("SMSC LAN9420 Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-- 
2.39.3


