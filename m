Return-Path: <linux-kernel+bounces-20433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6AA827ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F6EB23691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8DB65D;
	Tue,  9 Jan 2024 06:33:10 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81EB645
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4T8LWF0rBqzW8d
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:24:41 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4T8LW64nSZz6yMNs
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:24:34 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4T8LVw5S1Vz4xPYn;
	Tue,  9 Jan 2024 14:24:24 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 4096O92i032550;
	Tue, 9 Jan 2024 14:24:09 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Tue, 9 Jan 2024 14:24:11 +0800 (CST)
Date: Tue, 9 Jan 2024 14:24:11 +0800 (CST)
X-Zmail-TransId: 2afa659ce68b109-9212b
X-Mailer: Zmail v1.0
Message-ID: <202401091424115185126@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <kherbst@redhat.com>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <lyude@redhat.com>, <dakr@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <bskeggs@redhat.com>, <keescook@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIGRybS9ub3V2ZWF1L2Rpc3A6IHN3aXRjaCB0byB1c2Uga21lbWR1cCgpIGhlbHBlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4096O92i032550
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 659CE6A8.000/4T8LWF0rBqzW8d

From: Chen Haonan <chen.haonan2@zte.com.cn>

Use kmemdup() helper instead of open-coding to
simplify the code.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
Reviewed-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nvif/outp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 5d3190c05250..6daeb7f0b09b 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -452,13 +452,12 @@ nvif_outp_edid_get(struct nvif_outp *outp, u8 **pedid)
 	if (ret)
 		goto done;

-	*pedid = kmalloc(args->size, GFP_KERNEL);
+	*pedid = kmemdup(args->data, args->size, GFP_KERNEL);
 	if (!*pedid) {
 		ret = -ENOMEM;
 		goto done;
 	}

-	memcpy(*pedid, args->data, args->size);
 	ret = args->size;
 done:
 	kfree(args);
-- 
2.25.1

