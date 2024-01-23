Return-Path: <linux-kernel+bounces-35956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D0839923
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7792979F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8285C5D;
	Tue, 23 Jan 2024 19:04:07 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F785C40;
	Tue, 23 Jan 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036647; cv=none; b=AHLaj+CvmL1iWNCjfQHyW4RPz+IQnaVV4gMHUZqWEbZAWaDvHwe9FEcMIYT1tMMY4YKI6rTm6yzwn/cIjSBD9s57StdBlznC45DYzuOCBO8OAobAZDBqFMYkaO0Ik+WoQdbFyp9aiDX3jhHB4KnRWj5gbrG1xQeniNGx3BX529I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036647; c=relaxed/simple;
	bh=pzPwDMOCE0MMJ2sYG8Gsy5L1FligvJrj5Ckdv1712os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1b5FxhuPGdLtSsF5pTh9GHsd1VxkgjaZXqig86wZfBJ2phGdrVQBcaAyqHhghjeQPSVwRFSnwfX9MPW72IF6NgVFEXQNbR3yAxANaraaP+J4fAM1NBCErQwbAnYrH4jcKswh4HBQmuA/uysqS4PUi5ETnnUiQWkv1Rhc9ixGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100cb238bcso751526e87.3;
        Tue, 23 Jan 2024 11:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036643; x=1706641443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTDhm5SHc5SG3eH0usr1EHvpWxPR+i068Kqq/mbcS7o=;
        b=bX7j2qwN7rMmipVHIuYLHQVk/VFHDuZAO2jvDfeOJCOqhFd0jo+HggnE3CIjeM9wYO
         JFmeBGa0xJJ8sEXf9yk4KBvqsuW86mpcEgjKE5OdjZoqkmHSQ83UdevAH0BYJZJ3DIMU
         KU++tK2Ih74sCQHvRBsQ1xSVX4HmeTidj8uhaXixv7ZVKZQE9O58zk7MBdBZLzhEoqPq
         LYS0TsNj8RZdWTQAUp+fxtG2nb7m/5KOLzr6a1EjKNDsFJZUVzuqHLUF02rUdgY0iRua
         OkEenz+qPs+9LvSwJwWyNpTxMPuqXqUVdgqwSKRrGaNAldbm8CGfApddtt6aTHRrpWEQ
         jfaw==
X-Gm-Message-State: AOJu0Yyfm/NC2XjngSmXabaDyMx1dZclbqFbBAdVX00A77usWimpFGb3
	OE6WEUMp0arqvA5t6QC4Q6Rg7yJN4HjWTjcs1jzLsTVR2zShd5+e
X-Google-Smtp-Source: AGHT+IEUE4HOOR8HL0lMaoiCgV296HwGsCkhj4NcWX7SNO412QiFCGFLI8fDlwRmX0M85wU0iKjUmg==
X-Received: by 2002:a19:e006:0:b0:510:f16:f383 with SMTP id x6-20020a19e006000000b005100f16f383mr17398lfg.122.1706036643219;
        Tue, 23 Jan 2024 11:04:03 -0800 (PST)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907a70500b00a2e3a1ae471sm9523370ejc.6.2024.01.23.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net v2 01/10] net: fill in MODULE_DESCRIPTION()s for 8390
Date: Tue, 23 Jan 2024 11:03:22 -0800
Message-Id: <20240123190332.677489-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to all the good old 8390 modules and drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
CC: geert@linux-m68k.org
---
 drivers/net/ethernet/8390/8390.c      | 1 +
 drivers/net/ethernet/8390/8390p.c     | 1 +
 drivers/net/ethernet/8390/apne.c      | 1 +
 drivers/net/ethernet/8390/hydra.c     | 1 +
 drivers/net/ethernet/8390/stnic.c     | 1 +
 drivers/net/ethernet/8390/zorro8390.c | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/8390/8390.c b/drivers/net/ethernet/8390/8390.c
index 0e0aa4016858..c5636245f1ca 100644
--- a/drivers/net/ethernet/8390/8390.c
+++ b/drivers/net/ethernet/8390/8390.c
@@ -100,4 +100,5 @@ static void __exit ns8390_module_exit(void)
 module_init(ns8390_module_init);
 module_exit(ns8390_module_exit);
 #endif /* MODULE */
+MODULE_DESCRIPTION("National Semiconductor 8390 core driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/8390p.c b/drivers/net/ethernet/8390/8390p.c
index 6834742057b3..6d429b11e9c6 100644
--- a/drivers/net/ethernet/8390/8390p.c
+++ b/drivers/net/ethernet/8390/8390p.c
@@ -102,4 +102,5 @@ static void __exit NS8390p_cleanup_module(void)
 
 module_init(NS8390p_init_module);
 module_exit(NS8390p_cleanup_module);
+MODULE_DESCRIPTION("National Semiconductor 8390 core for ISA driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/8390/apne.c
index a09f383dd249..828edca8d30c 100644
--- a/drivers/net/ethernet/8390/apne.c
+++ b/drivers/net/ethernet/8390/apne.c
@@ -610,4 +610,5 @@ static int init_pcmcia(void)
 	return 1;
 }
 
+MODULE_DESCRIPTION("National Semiconductor 8390 Amiga PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/hydra.c b/drivers/net/ethernet/8390/hydra.c
index 24f49a8ff903..fd9dcdc356e6 100644
--- a/drivers/net/ethernet/8390/hydra.c
+++ b/drivers/net/ethernet/8390/hydra.c
@@ -270,4 +270,5 @@ static void __exit hydra_cleanup_module(void)
 module_init(hydra_init_module);
 module_exit(hydra_cleanup_module);
 
+MODULE_DESCRIPTION("Zorro-II Hydra 8390 ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/stnic.c b/drivers/net/ethernet/8390/stnic.c
index 265976e3b64a..6cc0e190aa79 100644
--- a/drivers/net/ethernet/8390/stnic.c
+++ b/drivers/net/ethernet/8390/stnic.c
@@ -296,4 +296,5 @@ static void __exit stnic_cleanup(void)
 
 module_init(stnic_probe);
 module_exit(stnic_cleanup);
+MODULE_DESCRIPTION("National Semiconductor DP83902AV ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/zorro8390.c b/drivers/net/ethernet/8390/zorro8390.c
index d70390e9d03d..c24dd4fe7a10 100644
--- a/drivers/net/ethernet/8390/zorro8390.c
+++ b/drivers/net/ethernet/8390/zorro8390.c
@@ -443,4 +443,5 @@ static void __exit zorro8390_cleanup_module(void)
 module_init(zorro8390_init_module);
 module_exit(zorro8390_cleanup_module);
 
+MODULE_DESCRIPTION("Zorro NS8390-based ethernet driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


