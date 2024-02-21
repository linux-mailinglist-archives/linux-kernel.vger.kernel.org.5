Return-Path: <linux-kernel+bounces-74381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58E85D340
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A0B239BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B03D96D;
	Wed, 21 Feb 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IQd1Nuev"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022113D556
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507093; cv=none; b=s8R3L9jLkdvbr85eqhOoWBlZzTr2RAkmid9fXA8zudYzIhTJre0PPTQ66ulOkvTKxGeiNmVW1nToaRubzN17p1yLP5Doi0kF6O2zkyd80O5LYwMezJ5rz91Sx2J/NtWTLZXJSai0JEfKskrWrUiBYOiXgmXEOYtNXfc9DqY8QA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507093; c=relaxed/simple;
	bh=Ro149mtR33sBAX78qfBcjmuA+prlryiG9GLzx79kIRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCcEBL91UEr/tgyV1DIKz0IjOS/IFssY+CdolMA/EdiG8ZSfNPpe5B+2TSZryT/qQ26GSTbulsFDdoPMqmyV65INfnLaYZiBXEPDO4gQYektLnq7IDckMEGLLl5fA589783eg6hjmvss/gjJBZQEQtUFu8U/0KTach3LCTnt+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IQd1Nuev; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507082; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=110m7iZc1QLgWsXce59I4X/s2/RhnD8RnHOHhZoz85g=;
	b=IQd1NuevHtDTaw39RcHDYewFAw57AJXzkpS2QqKJz+60rla7WEinc7zy79Sp7R2JvXXCjb2KRELXyxTG/SB2lcP16lAw80IDsHZ/e+6OD+zfKpu723DiWxde9Ur1VZbTcTcR1HOBfHMWaSumLt9Ip/KIaiJgxwD+WKnxk15Ncm0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0zSe40_1708507080;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W0zSe40_1708507080)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:18:02 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 6/8] dm vdo: Modify mismatched function name
Date: Wed, 21 Feb 2024 17:17:26 +0800
Message-Id: <20240221091731.7007-3-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
References: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/md/dm-vdo/flush.c:97: warning: expecting prototype for waiter_as_flush(). Prototype was for vdo_waiter_as_flush() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8278
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/flush.c b/drivers/md/dm-vdo/flush.c
index e4be450aa12c..57e87f0d7069 100644
--- a/drivers/md/dm-vdo/flush.c
+++ b/drivers/md/dm-vdo/flush.c
@@ -88,7 +88,7 @@ static inline struct vdo_flush *completion_as_vdo_flush(struct vdo_completion *c
 }
 
 /**
- * waiter_as_flush() - Convert a vdo_flush's generic wait queue entry back to the vdo_flush.
+ * vdo_waiter_as_flush() - Convert a vdo_flush's generic wait queue entry back to the vdo_flush.
  * @waiter: The wait queue entry to convert.
  *
  * Return: The wait queue entry as a vdo_flush.
-- 
2.20.1.7.g153144c


