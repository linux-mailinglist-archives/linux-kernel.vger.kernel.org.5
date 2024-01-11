Return-Path: <linux-kernel+bounces-23436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28882ACB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A95F2853D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272C14F78;
	Thu, 11 Jan 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AYHDEu5w"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585914F60;
	Thu, 11 Jan 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=rTcDu0eebd2RMcVuyl
	5k3Y1QNttZ6C2BpHiIWidQK8c=; b=AYHDEu5wI9CYANYHAN4n+DyWPofeDb1mui
	VFMryXInnQ9/zyvEzE0WfrKhmKtBwBb7TbzJC4Zw7u1c+FxAeKJpiRPEqtORl60t
	yowweTUGimcdPIAnRAMTG6X8pVjBKmHckmlLCcW88+/r+SNrikUqcKy7Hx+kFYXv
	fmKtvGm4g=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDXv_LxyZ9lZoKnAA--.26025S2;
	Thu, 11 Jan 2024 18:58:58 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] media: dvb: Clean up errors in cx24110.c
Date: Thu, 11 Jan 2024 10:58:56 +0000
Message-Id: <20240111105856.14655-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXv_LxyZ9lZoKnAA--.26025S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWrur1rXF43XFWDXFW7CFg_yoWkZrX_Cw
	nrJw1fuFs8XF1fCF1Utr1qyayvy3ySvr1v9anYv3y7AF1ruFZ8G3s09FnrKry0qF4jyFs5
	tas8Wrn2kFsrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_AwIJUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGBJixWVLZWpRWwAAsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/media/dvb-frontends/cx24110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/cx24110.c b/drivers/media/dvb-frontends/cx24110.c
index 9aeea089756f..65dd9b72ea55 100644
--- a/drivers/media/dvb-frontends/cx24110.c
+++ b/drivers/media/dvb-frontends/cx24110.c
@@ -224,13 +224,13 @@ static enum fe_code_rate cx24110_get_fec(struct cx24110_state *state)
 	}
 }
 
-static int cx24110_set_symbolrate (struct cx24110_state* state, u32 srate)
+static int cx24110_set_symbolrate (struct cx24110_state *state, u32 srate)
 {
 /* fixme (low): add error handling */
 	u32 ratio;
 	u32 tmp, fclk, BDRI;
 
-	static const u32 bands[]={5000000UL,15000000UL,90999000UL/2};
+	static const u32 bands[] = {5000000UL, 15000000UL, 90999000UL/2};
 	int i;
 
 	dprintk("cx24110 debug: entering %s(%d)\n",__func__,srate);
-- 
2.17.1


