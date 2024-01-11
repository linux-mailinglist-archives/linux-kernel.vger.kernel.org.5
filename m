Return-Path: <linux-kernel+bounces-23440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264AC82ACBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85E01F23330
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4EF14F7B;
	Thu, 11 Jan 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hTBaQGFH"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF2F15480;
	Thu, 11 Jan 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=N9zQ5wa+iStKjHSOSd
	HguEeq8Pmm0nn8gVdbjE4lePo=; b=hTBaQGFHYl9mYXekNYgy0u3gK6Oa1FRbyZ
	d14X9ELJzQZ7ShN1WCjxEVnEmxXSTSasODb/4PZYQHKKOGuRlCVL7VKBYM+Kxkqr
	w0FxoLu9ns20xS0jHXPMZVicwoPya8y75otrxMaY83MTGuPVzcfBz0/fTDHUruX3
	b5wgG3JRg=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDnD9uNyp9lMK44AA--.34025S2;
	Thu, 11 Jan 2024 19:01:33 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] [media]  Clean up errors in cx24110.h
Date: Thu, 11 Jan 2024 11:01:32 +0000
Message-Id: <20240111110132.14745-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnD9uNyp9lMK44AA--.34025S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFWrGw4fZrWrGF4kWr1rZwb_yoW8Jry8pF
	4DAw1DtFWUX3W5XF4DJ348CFZxKwn3GF98Ka93Wa13ZF1S9rW8XFn8tw42yr13G3yfGa12
	q3Za9ryxCFs2yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRo89_UUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhBixWVEuYGDKwAAs8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/media/dvb-frontends/cx24110.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/cx24110.h b/drivers/media/dvb-frontends/cx24110.h
index 834b011d3462..839551841893 100644
--- a/drivers/media/dvb-frontends/cx24110.h
+++ b/drivers/media/dvb-frontends/cx24110.h
@@ -34,11 +34,11 @@ static inline int cx24110_pll_write(struct dvb_frontend *fe, u32 val)
 }
 
 #if IS_REACHABLE(CONFIG_DVB_CX24110)
-extern struct dvb_frontend* cx24110_attach(const struct cx24110_config* config,
-					   struct i2c_adapter* i2c);
+extern struct dvb_frontend *cx24110_attach(const struct cx24110_config *config,
+					   struct i2c_adapter *i2c);
 #else
-static inline struct dvb_frontend* cx24110_attach(const struct cx24110_config* config,
-						  struct i2c_adapter* i2c)
+static inline struct dvb_frontend *cx24110_attach(const struct cx24110_config *config,
+						  struct i2c_adapter *i2c)
 {
 	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __func__);
 	return NULL;
-- 
2.17.1


