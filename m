Return-Path: <linux-kernel+bounces-74378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9284B85D339
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31C21C21B28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F93D0A9;
	Wed, 21 Feb 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lH8N0zeI"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D243C6B3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507077; cv=none; b=gBqaOkPRr6ym+jBlXXJWaxe6QYk0ZBf/mpMkL3G3LK6B0yBvkq2/eTtRp631QHd3mKid3GwGJLxJ9lG9ZABBlrbkEhc2pCtwBywLE3pwoFzQj2yKQO01khjvahB1DzE3hAgP/DvVXaQR8l3JQaukPFSVwyJSvWnYMUXWHDJxzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507077; c=relaxed/simple;
	bh=G2NE9a3jMDn12v81Nz9NQjkLjoIDixLqd4nghLAIyiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyESv/1OI4hyPr8TKGAxfBZse4eT1h+6+inT4dTEaOyqOeL+IzqRJZemQQQfv73LFy39ypS1fmvz5S2gjnW0baEnbVJI318sScPwjozwNXbHZ/U/eKzB/xR770NJUIGf1qnh6pmLQl7OsGxT9OD5klUpBcHBknc7kfD5fQyU4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lH8N0zeI; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507066; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TQpuyVvZ75dhIqkp8INYA616KkgNbSy6gSD3mv59K00=;
	b=lH8N0zeIQ6GZEtVJniJy61LPlFhRlb/tzCYeiKLExKKpYFGeDD2JRsyNcWDbjVcHtZLa1/ZVdYU5O/rPWj4IkbIfjMSgAWjIxEwku/L7D5fKl+7DEIKA9Tv22K0xTqYaV23SnvRud0BQXbc+VkFMYVsp7PriAXGcLQK2hFOcF68=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0zPhvC_1708507063;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W0zPhvC_1708507063)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:17:45 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 8/8] dm vdo: Modify mismatched function name
Date: Wed, 21 Feb 2024 17:17:24 +0800
Message-Id: <20240221091731.7007-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/md/dm-vdo/admin-state.c:310: warning: expecting prototype for vdo_drain_operation(). Prototype was for assert_vdo_drain_operation() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8280
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/admin-state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/admin-state.c b/drivers/md/dm-vdo/admin-state.c
index 8663c1e91616..3f9dba525154 100644
--- a/drivers/md/dm-vdo/admin-state.c
+++ b/drivers/md/dm-vdo/admin-state.c
@@ -300,7 +300,7 @@ static bool check_code(bool valid, const struct admin_state_code *code, const ch
 }
 
 /**
- * vdo_drain_operation() - Check that an operation is a drain.
+ * assert_vdo_drain_operation() - Check that an operation is a drain.
  * @waiter The completion to finish with an error if the operation is not a drain.
  *
  * Return: true if the specified operation is a drain.
-- 
2.20.1.7.g153144c


