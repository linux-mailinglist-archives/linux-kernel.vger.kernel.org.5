Return-Path: <linux-kernel+bounces-33999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03368371C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103DF1C2812F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACC5BAD7;
	Mon, 22 Jan 2024 18:46:10 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620335BAC3;
	Mon, 22 Jan 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949170; cv=none; b=LORvqpeeI1HIHja6/+8Uj3mLXLwrGksTY4ckEkI/EZ+2Bp7EVR22iHwpxYamWroWs2xrE5kmRzNNtOXEqpr5TAZatCmzmGmwLsVkBuBpFxjKDo6ughN8QHdYcAABDPOrW9JLNzLg4DDMYWqO4nrJWKwReSZ32kjjcGuPoMvmubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949170; c=relaxed/simple;
	bh=pzPwDMOCE0MMJ2sYG8Gsy5L1FligvJrj5Ckdv1712os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxRLTDgWVMGjsCEFjZ1ACdDJRH2K8bfBC11ZCy7TkB5RTbo+flU/4UlTAnhOq5lFWF7EwO/1yNd5oSyeWDNAN9QilORB5uMTgkCcRxMbXT4T8buZ/qOtq++GncMJ9WOBrTnu/RhsrnUY6vHWkhw246918eegqKZ4HgfhSooFXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso4001445a12.0;
        Mon, 22 Jan 2024 10:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949166; x=1706553966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTDhm5SHc5SG3eH0usr1EHvpWxPR+i068Kqq/mbcS7o=;
        b=bB615LudaehmQT52lYKiiw9SGf0iKkhUOvq5B7lYN/dEXFT5GXLcGQQmdgvW2OXw+e
         7bmD7R58o7uc2nrQ23wgLlfFP+HKlkUQekI85pn4SgtXNL0BjtDESGoux2V4EiTgYM+o
         E7NdfxIv1DyiNHx00n0ObiowAsRWr9TQs7Wvi1DdeTCTKw/WvUipyR8rRDv7w7nLpyNF
         J60pfq6Gsl/hnrZrxGR8gV9DRwHwezKLBkir1Z8CzxKy6plpTsk6jtwWj7yCAw77mWcH
         rjON3GMhZ31q4hlRlidwBMFGHNSoyKi2OOjv0YZ9J0qdZwLPQz3JahHySWbA6Ufd2Jb2
         8uMw==
X-Gm-Message-State: AOJu0Yya0gbNtlzzix8GAcICqjGZgcVnI/QW6XLYKKlAc2nWdEae9NEM
	94Qxhy6Eq6c9GHCbc/DrG7UKfks8OYyBYOAMuNZcl5G4D1upZe1W
X-Google-Smtp-Source: AGHT+IEor1MIAxud/tRkTgpWSv4+yqjOAEaOocwNlrk4ZnCQLsKMERbdNHXkgGvUKu4uL0Gc7VLSrQ==
X-Received: by 2002:a17:907:a0d0:b0:a2f:ec73:9928 with SMTP id hw16-20020a170907a0d000b00a2fec739928mr2033807ejc.150.1705949166523;
        Mon, 22 Jan 2024 10:46:06 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709063e8500b00a28badcf367sm13620121ejj.54.2024.01.22.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	geert@linux-m68k.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	netdev@vger.kernel.org (open list:8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULT...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 01/22] net: fill in MODULE_DESCRIPTION()s for 8390
Date: Mon, 22 Jan 2024 10:45:22 -0800
Message-Id: <20240122184543.2501493-2-leitao@debian.org>
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


