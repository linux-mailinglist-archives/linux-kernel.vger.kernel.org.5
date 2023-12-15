Return-Path: <linux-kernel+bounces-1036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99481498F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BBD1F223B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE322E3F3;
	Fri, 15 Dec 2023 13:45:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B522C852;
	Fri, 15 Dec 2023 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Ss9TS4Pr5z8XrRL;
	Fri, 15 Dec 2023 21:45:32 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 3BFDjRWh071963;
	Fri, 15 Dec 2023 21:45:27 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 15 Dec 2023 21:45:31 +0800 (CST)
Date: Fri, 15 Dec 2023 21:45:31 +0800 (CST)
X-Zmail-TransId: 2afa657c587b3a7-53fc0
X-Mailer: Zmail v1.0
Message-ID: <202312152145312776210@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <davem@davemloft.net>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sd@queasysnail.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1seHN3OiBzcGVjdHJ1bTogdXNlIG5ldGlmX2lzX21hY3NlYygpIGluc3RlYWQgb2Ygb3BlbiBjb2Rl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 3BFDjRWh071963
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 657C587C.001/4Ss9TS4Pr5z8XrRL

From: Yang Guang <yang.guang5@zte.com.cn>

Open code which is dev->priv_flags & IFF_MACSEC has already defined as
netif_is_macsec(). So use netif_is_macsec() instead of open code.
No functional changed.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b935ee341b4..1f2b23d854c9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5103,7 +5103,7 @@ void netif_inherit_tso_max(struct net_device *to,

 static inline bool netif_is_macsec(const struct net_device *dev)
 {
-	return dev->priv_flags & IFF_MACSEC;
+	return netif_is_macsec(dev);
 }

 static inline bool netif_is_macvlan(const struct net_device *dev)
-- 
2.25.1

