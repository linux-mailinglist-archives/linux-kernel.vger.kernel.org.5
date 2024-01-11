Return-Path: <linux-kernel+bounces-23451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83CA82ACEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15301C21E48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41514F90;
	Thu, 11 Jan 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="p/Gyyjzl"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2B15488;
	Thu, 11 Jan 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=rPIj4y9fevX8UcYY75
	0yZWb32Nkcv9QLiE2/VLvfV8k=; b=p/GyyjzleejASiD4mkhBJ80ClrNHt3HcFY
	rJgFM6Ia8ZcjzZYVSXNcDjwGRtZ5f1I0qs6tpzgAYDJhJ7vjDlzTYVuFly6rkFSX
	zfhNTU5c0yXrVAM3TraXq5h11MZf8GZOyfde2kTvoipqpU3nu86hdtmu44qlcydB
	6nQvgvI+Q=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3v+dAzJ9lXCinAA--.6423S2;
	Thu, 11 Jan 2024 19:08:48 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] [media] Clean up errors in tda8083.h
Date: Thu, 11 Jan 2024 11:08:46 +0000
Message-Id: <20240111110846.15098-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3v+dAzJ9lXCinAA--.6423S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWrGw4fZrWrGF4kWr1rZwb_yoWktrb_uw
	10qFn3G3s0g3s5ur47tFWxXa98Kay8Zw4ktFWUKFy3ArZ2qw4UZw1DKFnrAFWUuay8KFn0
	ya95Xa1xZF1qkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_qjg3UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHBlixWV2z0YPYwABsV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/media/dvb-frontends/tda8083.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda8083.h b/drivers/media/dvb-frontends/tda8083.h
index 3a671ec3f45e..2eaeea3896c6 100644
--- a/drivers/media/dvb-frontends/tda8083.h
+++ b/drivers/media/dvb-frontends/tda8083.h
@@ -24,11 +24,11 @@ struct tda8083_config
 };
 
 #if IS_REACHABLE(CONFIG_DVB_TDA8083)
-extern struct dvb_frontend* tda8083_attach(const struct tda8083_config* config,
-					   struct i2c_adapter* i2c);
+extern struct dvb_frontend *tda8083_attach(const struct tda8083_config *config,
+					   struct i2c_adapter *i2c);
 #else
-static inline struct dvb_frontend* tda8083_attach(const struct tda8083_config* config,
-					   struct i2c_adapter* i2c)
+static inline struct dvb_frontend *tda8083_attach(const struct tda8083_config *config,
+					   struct i2c_adapter *i2c)
 {
 	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __func__);
 	return NULL;
-- 
2.17.1


