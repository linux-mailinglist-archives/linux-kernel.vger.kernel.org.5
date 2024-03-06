Return-Path: <linux-kernel+bounces-93643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66618732C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71C8B254D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62225DF31;
	Wed,  6 Mar 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DNO8QwTP"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED15DF05
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718035; cv=none; b=lUIEAwMLfnzlVYLgaJxQsw/We086BZhhjf19LjLQ14KyQj2bUdy0QEwI0HqVdKjezsegSGceoFkDdFM5l+TYcTdvJtdCeLwLiN5VRCwztT9LlMrjP7v3JnJ5S6OgSYB60d9M/koIkntDNIZSIEEpGlPfcQfScp9At371G+rClVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718035; c=relaxed/simple;
	bh=yAmwTThFElfEUXuzDwez7+utuY3FM973SAHJmZYL1KY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hPsppFK8mTFvACwGaW/S9TpUGD/BbZea69JEDDesxiNMhZeUOzRfbq+WEJyYvV7egPykCqs2NQyebShHMn6y5cDIWkRBXSz+69TIKqNfHDld8aiFfN7R7QSwVsnn1BHxj4MXG425aIedPkGzV5NeXDgplqObJfYte9uQ5TjpqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DNO8QwTP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90b6474edb9d11eeb8927bc1f75efef4-20240306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ekRAdx9PacrM+v9N8B7aPw62g80zVfoirlx+37NhmtQ=;
	b=DNO8QwTPESmv3TC7DhSCetbJHh8NTV5szUqFOiz29AZ1rDP0131XamuPaU9zpHM+8zMp82ffHL2lvL3fCSGo9fcuSK3XhIF11aMiuq+uLww+ah7nBVCkdU0nowZgXR5C52PVvWEqWFImev05cJfZoNCcvr0ohPZLg8ECFbyw2so=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3b8956a1-6c99-408c-ab7f-263a0ce9db75,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7a4f1590-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 90b6474edb9d11eeb8927bc1f75efef4-20240306
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chunhui.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 887273234; Wed, 06 Mar 2024 17:40:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Mar 2024 17:40:25 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Mar 2024 17:40:24 +0800
From: Chunhui Li <chunhui.li@mediatek.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>, Chunhui Li
	<chunhui.li@mediatek.com>
Subject: [PATCH] printk: fix _entry_ptr build warning
Date: Wed, 6 Mar 2024 17:26:47 +0800
Message-ID: <20240306092647.16010-1-chunhui.li@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.708200-8.000000
X-TMASE-MatchedRID: Z2f9DQPf1tkE7MuQrZP2o5dc7I2df+ms75oFMklhrnhGL0g1nVmkYVO4
	BD7nLMxnlTJXKqh1ne2/LclmUK1hkobzTO6asfbjyDp+jSvEtWv0O7M3lSnTW5soi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNRqXnrxrKCOXFcwn/U1iS4dD30h1PAU6P6/GTBhLbUgDqhGWfuPUaq93ob
	md2bsjHipWuuOW0EtOvAgHKzqJDgOL28eWhdXbLK92atjiJrAoF0aD5ljt43pMcHZD6gqu7wxMj
	fifIXfowkvVoA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.708200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1CE3B773FBAD0C22075C8D3E0E295523F7348289C887245A523E5D76D60A61202000:8
X-MTK: N

We build with Werror and suffer build error when
enable CONFIG_PRINTK_INDEX, such as
gfp.h:223:2: error: unused variable '_entry_ptr'
ratelimit.h:31:3: error: unused variable '_entry_ptr'
kallsyms.h:172:2: error: unused variable '_entry_ptr'
[-Werror,-Wunused-variable]

Fix the warning by appending __attribute__((unused)).

Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..749c1c4257f1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -392,7 +392,7 @@ struct pi_entry {
 				.level = __builtin_constant_p(_level) ? (_level) : NULL, \
 				.subsys_fmt_prefix = _subsys_fmt_prefix,\
 			};						\
-			static const struct pi_entry *_entry_ptr	\
+			static const struct pi_entry *_entry_ptr __attribute__((unused)) \
 			__used __section(".printk_index") = &_entry;	\
 		}							\
 	} while (0)
-- 
2.18.0


