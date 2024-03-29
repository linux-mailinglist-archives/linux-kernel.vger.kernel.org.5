Return-Path: <linux-kernel+bounces-125042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0084891F22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF021C282B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5551C0896;
	Fri, 29 Mar 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF7HNygk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5A1C0882;
	Fri, 29 Mar 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716692; cv=none; b=t//V1KM7fmg8izcio5qNLNjo3Yr3q/o3B2UUgrtVo6Mk6SisUGacTQ0NFQV1psK6swbnseUGT8qb5w+IHR6xJKcHJEHqpFdNn7dNJjkSu2K54gJMvwsQv/T24gKM3rrryJaM4RmCt33/clq3q2oQ75795vSR1zddPv89wjJ3zHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716692; c=relaxed/simple;
	bh=ijg1+AKd926h7eK8HcJHmxSLnjig6arjVgXYBiHQTZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApKRpS+P+ssPCx99R9tfBgWm1irVtjKvAi2tGawAo9N2zVLQh3aQmMoP0n2EOniXeXoBfH1VgqZNjbvhmpoqJGpRZM8C9QBGIoujFDwbk5FbhgZeDsmLNCw1egn456Jh+UfDQG0KT+aKpQRM/ko0FO30P4NDTUBHpHVl6CQSzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF7HNygk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5857DC433C7;
	Fri, 29 Mar 2024 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716692;
	bh=ijg1+AKd926h7eK8HcJHmxSLnjig6arjVgXYBiHQTZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RF7HNygkLo3cqcJ1NmhXeOpsRe8/VhIjbBZxg6wL6hhJYuSS10M6HfIxsTUmphRqB
	 3rr562brrSWVFnRzbLZ8oR+eybYrpQQKHBJDJO2gIp19r6tG9lDHxo3y5vDFco2m36
	 NXRn624GDEPVCGWurcsaqVrEaHpHQKYNAW7INShZTDygFwPeojQYzsXe3jHGVn7PSr
	 U6ygtPGY0D0sEHqGedzYVEwNU9XJvKtlOMDh2SJ4viXjaHnElP0b+A374cp/n8u9IV
	 HKEMnHtYsE8ik3+xGIVS2HmvNI9P6ziY42SGoTw/gU6KDC5hRWlQo2NeZF2HS47hLr
	 Re5BxDY8oZFog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/19] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:50:50 -0400
Message-ID: <20240329125100.3094358-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit cfeb98b95fff25c442f78a6f616c627bc48a26b7 ]

Newer Lenovo Yogas and Legions with 60Hz/90Hz displays send a wmi event
when Fn + R is pressed. This is intended for use to switch between the
two refresh rates.

Allocate a new KEY_REFRESH_RATE_TOGGLE keycode for it.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/15a5d08c84cf4d7b820de34ebbcf8ae2502fb3ca.1710065750.git.soyer@irl.hu
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 1c011379a9967..76b524895dea6 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -596,6 +596,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
-- 
2.43.0


