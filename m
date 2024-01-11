Return-Path: <linux-kernel+bounces-23447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FDC82ACD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE512877C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6B14F8B;
	Thu, 11 Jan 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kvb+NvTV"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751114F75;
	Thu, 11 Jan 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=i51QH0kSBgQqgJLXWV
	3VOsHVzT/jtGoBpEzEKwK5zc0=; b=kvb+NvTV7u/ZuqZpLmYEV3c6HQeiSYud2t
	gsnjyToasvogNfWmjj3/vEmqcOmocX76St/juDbGU1uMUR90yln7aTeicssaX2fb
	kTrQ18s8leQ+xkkWgHvg5OQAZdRImzUFCxLRL39qlJSSqmbqx9qXtVF971SsDoVD
	AC7/C9xvM=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3n8pny59lc62nAA--.9474S2;
	Thu, 11 Jan 2024 19:05:12 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] [media]  Clean up errors in dib0090.h
Date: Thu, 11 Jan 2024 11:05:10 +0000
Message-Id: <20240111110510.14921-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3n8pny59lc62nAA--.9474S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1ruw43GF4Dtr1kuF1rWFg_yoW8Gr1rpr
	4DAr1j9F98t34xXryDt348uasxtws5Ar1kW3s7C3WFyryIqa47Gr17t3yIyr13GryfGrWa
	v3ZFkFyIya9IyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYhFsUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHBxixWV2z0YJGAAAss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/media/dvb-frontends/dib0090.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib0090.h b/drivers/media/dvb-frontends/dib0090.h
index e5cb311694d9..613b0eb8c436 100644
--- a/drivers/media/dvb-frontends/dib0090.h
+++ b/drivers/media/dvb-frontends/dib0090.h
@@ -82,7 +82,7 @@ extern u16 dib0090_get_wbd_offset(struct dvb_frontend *fe);
 extern int dib0090_gain_control(struct dvb_frontend *fe);
 extern enum frontend_tune_state dib0090_get_tune_state(struct dvb_frontend *fe);
 extern int dib0090_set_tune_state(struct dvb_frontend *fe, enum frontend_tune_state tune_state);
-extern void dib0090_get_current_gain(struct dvb_frontend *fe, u16 * rf, u16 * bb, u16 * rf_gain_limit, u16 * rflt);
+extern void dib0090_get_current_gain(struct dvb_frontend *fe, u16* rf, u16* bb, u16* rf_gain_limit, u16* rflt);
 extern void dib0090_set_dc_servo(struct dvb_frontend *fe, u8 DC_servo_cutoff);
 extern int dib0090_set_switch(struct dvb_frontend *fe, u8 sw1, u8 sw2, u8 sw3);
 extern int dib0090_set_vga(struct dvb_frontend *fe, u8 onoff);
-- 
2.17.1


