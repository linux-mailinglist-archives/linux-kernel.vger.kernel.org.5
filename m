Return-Path: <linux-kernel+bounces-34014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A97837292
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E053EB2F568
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD015FDB0;
	Mon, 22 Jan 2024 18:46:47 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25E5FDA7;
	Mon, 22 Jan 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949206; cv=none; b=EOIPeK2UH+rOdTPC2D8vzhJQ44+MtvQk+OKHfm41MPh6Hh5zPCXbIW2lNuMeZiO/MOuKZwbx69M/kJ+4QMFTWu3zMHoHTLhuGhaD3LkQX8bEIEunyn/b83ZbjyyXgcpv9Fr06Dkf7SHtEysmTzudtCinvCTRFRogHEPQgRlQCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949206; c=relaxed/simple;
	bh=YDcIfrSfiKN2NdFdSMGt71sDj46tBtRgUz/vCg7Mrxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/7WYWZLVlxZI32PFwvzOXlBZl+iqomY5pcEiM/4yJbMlufAUS6GMh8j9i8s20Uq6cKdqhZ7T9ZfGhQLihwMdXtLxwIzwlclX6srtDOPgxoOKt0RTXYbBP3UsVNt0wUUmN0RvoH7uBESyiREsc3azeL/Qct/DQq2xULaI8ZCyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so4731839e87.0;
        Mon, 22 Jan 2024 10:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949203; x=1706554003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mapHSceGJSbOZ4PBXZwobXfFzhFseRWjcJJzG+y4i1M=;
        b=ZN6R9xbl6MXAbhjl+3Y6+LXAd7q00QilcejQqmXt1syJ1EY15CgOPXYDksyFYGTfNS
         tiU453kDX/Sxp5JHtM0aphBH5lL7fOSCgnAxM82uapzYQ4mCvxU0LlsTGKYeZESHPgJM
         9XKXA5DwOoDDVE4zjsmGSKovuGpAjjechSL3bwCeFry8XcW4rutwUzos3Hiljm7cDH/5
         3pMs6jidZ7hv8ebnwvSGr8kct8PlaRSkLO/35v98X46BaLdK6WYFuvBI3J4htKua2e/3
         l4J0miXajV88jMA3j1qKTcM3nFBKFRvnTmEcuAnwRtzACMCuYqWckI86/QmLRpFaeInl
         /DDA==
X-Gm-Message-State: AOJu0YzBi7/J1lh9+qWKrAEeW45sSvX/Xv8j0K3Qewpu1MEqng4wUWLn
	hinrK/wRT82cspWbDkuHxFT2ESr9a4O532wJhGMEHs3WdBNMebUU
X-Google-Smtp-Source: AGHT+IG+gNsZkHYCHT5jSwbqnVvpssQwj8yeHUfZxx62j1G0ooQ1H12+73Yo2935/+QSBLXS0cRNcw==
X-Received: by 2002:a05:6512:1115:b0:50e:f4c0:52b3 with SMTP id l21-20020a056512111500b0050ef4c052b3mr2823678lfg.44.1705949203268;
        Mon, 22 Jan 2024 10:46:43 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id hw10-20020a170907a0ca00b00a2ea4f1b0cesm7134348ejc.2.2024.01.22.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Nicolas Pitre <nico@fluxnic.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve Glendinning <steve.glendinning@shawell.net>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 15/22] net: fill in MODULE_DESCRIPTION()s for SMSC drivers
Date: Mon, 22 Jan 2024 10:45:36 -0800
Message-Id: <20240122184543.2501493-16-leitao@debian.org>
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
Add descriptions to the SMSC 91x/911x/9420 Ethernet drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
Please enter the commit message for your changes. Lines starting
---
 drivers/net/ethernet/smsc/smc91x.c   | 1 +
 drivers/net/ethernet/smsc/smsc911x.c | 1 +
 drivers/net/ethernet/smsc/smsc9420.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 758347616535..56836b75d894 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -98,6 +98,7 @@ static int watchdog = 1000;
 module_param(watchdog, int, 0400);
 MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");
 
+MODULE_DESCRIPTION("SMSC LAN911x/LAN921x Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:smc91x");
 
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 31cb7d0166f0..cb04746bc0dd 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -56,6 +56,7 @@
 #define SMSC_MDIONAME		"smsc911x-mdio"
 #define SMSC_DRV_VERSION	"2008-10-21"
 
+MODULE_DESCRIPTION("SMSC LAN9420 Ethernet driver");
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


