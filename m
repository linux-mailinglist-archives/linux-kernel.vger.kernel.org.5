Return-Path: <linux-kernel+bounces-19940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A61827722
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E8C1F23B36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651754F9A;
	Mon,  8 Jan 2024 18:16:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219D54BCA;
	Mon,  8 Jan 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28d25253d2so222975166b.0;
        Mon, 08 Jan 2024 10:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737793; x=1705342593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dXzIJH/jfI8GyGnAn2GJG7HEpoYW5iSZORDdcu0tvY=;
        b=eVqcjTFL+PIbEQIkCKUEO7Oyy2J5KrSC7bpdWZrZm9xFR5ufc6HKAKFNliYbg7tLfh
         WAe026PMQt9TEmmwcNMkEzdU59TvPQxkd7SwWbVq+cQ8o4Coj4AYXLPQek3paPmM2UhT
         a3/w6dpSX5da7wopnhpIFgSVsWDeYX0LIXYpfMpAJQCMOO7BOd+jBWXUV5Ijef0Fs1lI
         SDoZw7rl6PpFSOtpRH/Oqtu8mR5huT4ZZ6jmrjPMzWXYmQx9VcYWo2m7U7mjpYhvanq6
         Ftzb7T4aed0b4BNRoy7+g0hh6hvt6+qcpcwarnuJcJSLFV3hDzBqKiV6JclCzRJrvhNw
         ULiw==
X-Gm-Message-State: AOJu0YzmSBZkXnfEPwUZTJa/lAJjFuHBYjoo4cG22Z8tEFg2BGMBgP/J
	ShrRcrp8ZznytIGu/aZTUkU=
X-Google-Smtp-Source: AGHT+IHBzE/SVjNbJRfqW1HRvRsISOWJ3tOLdS1nIL63m2/vIPI0g2VCfhUcWYz8Ra/i6J1rXQYELA==
X-Received: by 2002:a17:906:d289:b0:a27:f1db:6331 with SMTP id ay9-20020a170906d28900b00a27f1db6331mr1669730ejb.153.1704737793425;
        Mon, 08 Jan 2024 10:16:33 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id p11-20020a170906140b00b00a26b3f29f3dsm133489ejc.43.2024.01.08.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:33 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 01/10] net: fill in MODULE_DESCRIPTION()s for 8390
Date: Mon,  8 Jan 2024 10:16:01 -0800
Message-Id: <20240108181610.2697017-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
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
index a09f383dd249..a224bb80833f 100644
--- a/drivers/net/ethernet/8390/apne.c
+++ b/drivers/net/ethernet/8390/apne.c
@@ -610,4 +610,5 @@ static int init_pcmcia(void)
 	return 1;
 }
 
+MODULE_DESCRIPTION("National Semiconductor 8390 PCMCIA ethernet driver");
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


