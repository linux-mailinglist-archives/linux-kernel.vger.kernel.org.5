Return-Path: <linux-kernel+bounces-23444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8282ACCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86541C219C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93514F85;
	Thu, 11 Jan 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AqDB763c"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635315482;
	Thu, 11 Jan 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=E/FuEQ3OYO/IfCE99M
	BZVD6H72f3xwyvo/YuntoXCFk=; b=AqDB763ceUH1CelSPHMG3MIF5kMccr8EfX
	5kTnIFqysLtvMdvj+MwLQARHM8346z/rYOcFTOYjF3Jcnez7YC1hX8wFpu51T7pk
	vzak6idgzbmy36eW5GPYG3H1JZIprQ6xalk/VMkCRuO8jZtDiiiEqtRxqDHdd2eL
	WQOe1Sbso=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3P770yp9lkaE4AA--.31508S2;
	Thu, 11 Jan 2024 19:03:16 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] media: stv6110x: Clean up errors in stv6110x.h
Date: Thu, 11 Jan 2024 11:03:15 +0000
Message-Id: <20240111110315.14833-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P770yp9lkaE4AA--.31508S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWrXFW7ZF47ur43XF17Awb_yoW8GF1Dpr
	4akry09rZ8Ja47A3WfAa4IqF45KFn5uF18Kan5G3WxArn5JasxK34qkFZ8Zwn8GFZrJasa
	qF1avF1xAF1SyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYYLQUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhBixWVEuYGDMwABsl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/media/dvb-frontends/stv6110x_priv.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv6110x_priv.h b/drivers/media/dvb-frontends/stv6110x_priv.h
index b27769558f78..81410595820a 100644
--- a/drivers/media/dvb-frontends/stv6110x_priv.h
+++ b/drivers/media/dvb-frontends/stv6110x_priv.h
@@ -20,13 +20,13 @@
 #define dprintk(__y, __z, format, arg...) do {						\
 	if (__z) {									\
 		if	((verbose > FE_ERROR) && (verbose > __y))			\
-			printk(KERN_ERR "%s: " format "\n", __func__ , ##arg);		\
+			printk(KERN_ERR "%s: " format "\n", __func__, ##arg);		\
 		else if	((verbose > FE_NOTICE) && (verbose > __y))			\
-			printk(KERN_NOTICE "%s: " format "\n", __func__ , ##arg);	\
+			printk(KERN_NOTICE "%s: " format "\n", __func__, ##arg);	\
 		else if ((verbose > FE_INFO) && (verbose > __y))			\
-			printk(KERN_INFO "%s: " format "\n", __func__ , ##arg);		\
+			printk(KERN_INFO "%s: " format "\n", __func__, ##arg);		\
 		else if ((verbose > FE_DEBUG) && (verbose > __y))			\
-			printk(KERN_DEBUG "%s: " format "\n", __func__ , ##arg);	\
+			printk(KERN_DEBUG "%s: " format "\n", __func__, ##arg);	\
 	} else {									\
 		if (verbose > __y)							\
 			printk(format, ##arg);						\
-- 
2.17.1


