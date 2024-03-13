Return-Path: <linux-kernel+bounces-101257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3D87A4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF601C21DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DDC1B7FE;
	Wed, 13 Mar 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mK9O3G37"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CC1C2AE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320877; cv=none; b=YeRUlzZYiNBlrB+RovwOokoT9lzPydztZPHqtrU5JOreYFahcbTqbTIHplkBiDaG2WQmKdAuMgQcDUFgcIOyZzi8pLfzMEYSK1L5KstjQgGkbCKCHvCa/Ce2vq6CfGSp5fAjcccQOK/wJgVms6y9ZZ/rYK3pgJlRXi053j740yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320877; c=relaxed/simple;
	bh=p1R7y5pFOz92dX0u9NXz7gE9a+wJB4NCW2eDeHOad4o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XIQEphXFHZU2+ow1GC/TUokWs0Gf3xKFAgRw1edd/MqI2RvTNE+iW3fqQBKx7N711GwlEEC+pmGcLOAHoFYXYJtN3y+l1DWhSVr15HZs5rXZBM0lLmZIiTtvWujabrlTIlv7xU3JWfS7ggzK0+2YRTJHlVVVHwTPPAbb6XzDsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mK9O3G37; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710320566; bh=IpcshdCHJmiDl9hRbSo6NfdvgHjdhK4lTAtjiK1XwD0=;
	h=From:To:Cc:Subject:Date;
	b=mK9O3G37iZS8cN38/nDVZ70+X3Al6QZ69hrq2ixMcBp8WXsR5iglBY9qD8jyT95yA
	 aCS8YnR/hbjeJAHJLrqkYNvrCcUXN47WK0q0/rMwkTlD0dXE22VVYpCSwJoK4vDH2A
	 VoSRhlT8YiFL30vewf6+n5xDDTNFcDCLTiD2Ixxs=
Received: from localhost.localdomain ([36.111.64.85])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id A5958CA; Wed, 13 Mar 2024 17:02:37 +0800
X-QQ-mid: xmsmtpt1710320557txqjklc5i
Message-ID: <tencent_8E6B496F6B4EC012379A594046F8880B3D08@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeHNMjRYCaEEjtpXD8Vrc7IsM2F4/b56gBd6o3rURmAibDw5W+lB
	 pxBSv4KVYSpZ8+Zu4mShgaj+J0pYaFHkMDfVmi8tbxo+hSYQG84QTk7qADjEgqX31Y/X733hM+Ya
	 G5VnOtYUZ32qxWZOQsdJoIZlukhpqWKoa8kYowGyBNfrRIEtFfx8sRupkaSeS9P6qqRMVfM2qXBf
	 vpWwIiRsBkQdjWu6GI5pz1qow9UISquV0SsxDsUEr1/1HbXUGVmMSouUFLemcuOPwAnjz5q1upTH
	 x69UkaJWlzJg5JDbETHCvq7PYePnQysA7+8+2Xo3wCPscrKXxo3JQbyJLl8grz9dJx0kuAtUkJqd
	 xzurZcW7KMf4PuhlJLsJ9M/QWESuXH65f8VAAk+5tsXFhWP8c/WDMAlssYTjwBtBngQxB/+ZJwuE
	 0QuBE3TXiWRNtL0RwqzbS/Zv9oNlCUzhC1Fa6WYn8zanOVl7pffJ1ik+un63H3hZm/ZbpAH49/pV
	 6/8opKdmCt1XSCrBs+ClZEL+MUVna5+gyt5URBqZxCosHDyrs9tPtyDBDhCCm/VwoEUwbWBbFNGo
	 IXsCbFluoNHlMpZeq9SW2X7d8gIpyYxT6Eo3DMMws94n9ZUNN881erTwbcdnw8mg/Nw/K0DEE7O3
	 V7MQmVs212yVdLHLwUDPn6sNF5FWLH7298q9sCvSUUCaaHxZuHqJCFtSYJseF5BGpQr05VW6Rr9D
	 KHeTlLvcONbhEl/JJcUcdtRUKNWhExaOwuGnMiKbRxyx9z6v5j3UtAKNOnyqg37IieUWWUuif5C0
	 xCdlFvJMqudLcaj76YeFZpkCtrwva8D+Ah27/aRZzlmzjiATBmbAYSz9Oo0FCbCo13f4Wuwwm8oS
	 yF/MAWS3kELvu2JBgKHT1VPRoSTdUKfS6gzKvn6VyuiosvW5JyhULV43v75Ij4O+VTYQLDkqYaN9
	 8YbXtnkKl5Zou1p7gkqzZMMC/aXqKjo+6dc/+rSl8cCUT6ANYauZGVzzyruOutmrg28u09aB5BRy
	 OtWplnK5PDzXGs5ycevPLYvZJWEAc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yuu Lee <379943137@qq.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Yuu Lee <379943137@qq.com>
Subject: [PATCH] locking/mutex: fix documentation spelling mistakes
Date: Wed, 13 Mar 2024 17:02:35 +0800
X-OQ-MSGID: <20240313090235.2212-1-379943137@qq.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix 'task_strcut' to 'task_struct'

Signed-off-by: Yuu Lee <379943137@qq.com>
---
 kernel/locking/mutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbae8c0b8..82d19846e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -362,7 +362,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 		 * checking lock->owner still matches owner. And we already
 		 * disabled preemption which is equal to the RCU read-side
 		 * crital section in optimistic spinning code. Thus the
-		 * task_strcut structure won't go away during the spinning
+		 * task_struct structure won't go away during the spinning
 		 * period
 		 */
 		barrier();
@@ -401,7 +401,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 
 	/*
 	 * We already disabled preemption which is equal to the RCU read-side
-	 * crital section in optimistic spinning code. Thus the task_strcut
+	 * crital section in optimistic spinning code. Thus the task_struct
 	 * structure won't go away during the spinning period.
 	 */
 	owner = __mutex_owner(lock);
-- 
2.41.0


