Return-Path: <linux-kernel+bounces-152760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852168AC3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA91F21FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528518B09;
	Mon, 22 Apr 2024 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QNrB/lfm"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F918059;
	Mon, 22 Apr 2024 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765037; cv=none; b=ZLLt4SDs7XoxniJaLNXiXx5MdyvXbl/FW7CTRp+ymde8Uz1taSu2vzbebl9BGwGYXRbsGDU3t0SThocGZoWCtNYbIo64R/ImIuf5brk3zoV4KU93l4HxC4HM38LTh22LsC9wd84TrQ+RWn8RWwettMBWKPr0N4xIoWf1MH3sd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765037; c=relaxed/simple;
	bh=wGfpoWSm6fFunl81xx0OAs77f3/yN+iTSevM4zdbNxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RX/H3fJzcFRal7v8vLKTfYVxqEbtHJn8d1qSMJuTO13PiMz9sfqrJs+xpOPUUyllrqLWPxZoeLl0B0kS9h6+aoXwGhyIajUOyQ1lUc8neulsScY/I2Qn/SydHX6tjI4/Vq4IBb+wFfKX168Y3Z85WN7DXDSNFVYZqf0PDm+D+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QNrB/lfm; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713765032; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gbEIARgYdC2FJkyc7mZ73e93KYSKUIL9lR89ZCA2+nU=;
	b=QNrB/lfm7BzuZAW4tQDbHeX45/ilsBv0hNuk9rVjncZaBHFyND/0ZL4Iwvoh3+70WrMmXT5arD740jcdZAQZf6JqwWP45PEGLrPj/SJXsv8PHcYrpFY0tGJcmU2+BEwAoblAaRWa0B6xHy/Reutfr567QS+IkRNQjVla9w3NKFQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4z0UcW_1713765023;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4z0UcW_1713765023)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 13:50:31 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] wifi: rtw89: Remove useless else
Date: Mon, 22 Apr 2024 13:50:22 +0800
Message-Id: <20240422055022.33388-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assignment of the else and if branches is the same, so the else
here is redundant, so we remove it.

/drivers/net/wireless/realtek/rtw89/phy.c:6406:2-4: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8812
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index eaa18140d1a8..ca5a098c30a4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6403,10 +6403,7 @@ enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
 			return RF_D;
 	case MLO_0_PLUS_2_1RF:
 	case MLO_2_PLUS_0_1RF:
-		if (phy_idx == RTW89_PHY_0)
-			return RF_AB;
-		else
-			return RF_AB;
+		return RF_AB;
 	case MLO_0_PLUS_2_2RF:
 	case MLO_2_PLUS_0_2RF:
 	case MLO_2_PLUS_2_2RF:
-- 
2.20.1.7.g153144c


