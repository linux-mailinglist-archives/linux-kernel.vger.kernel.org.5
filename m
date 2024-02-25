Return-Path: <linux-kernel+bounces-79971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F486290F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B01C209D6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4448F6A;
	Sun, 25 Feb 2024 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="q1GDrCw2"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F563A5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834048; cv=none; b=f+bWwLOD/GnIyl6PG/HdK94QhlAh/v3YSoFEZaqnueI4i7xvTHdfcY/XvUImcOOrPyfk2tB9zCnVUdNYxGosPcMoyONJMZd6RhdUXov1fnP32UqrMIL5D9zi/U8iOn9Kc2OLCdEglqOpA9WXzqf24+E3dK2mkDCJGPPkfDG8SLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834048; c=relaxed/simple;
	bh=n4omDxV4NCigiHoXtDZYmYa5GO5MOa7NnKVrOwi56cY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YxeYICiajmrvU49YJ2jSlrggv6A9kapzTJn4IfgKP1xuft/K7mCFsGTp0J/pbRyVkNkdG2u4yYza0R9vyTd9Lkh6hgKCTlfWWwWPlJBECV4Q5ojrYPcnFafwKh9KoQ13iLyw8Xaac9EBr0fwLvtpssOn53xTX7l2wTOBQFlHk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=q1GDrCw2; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834044;
	bh=Y+FZfOgwRIGUoE4+U/hqrjcY1yVeyxZep1ZRA8BRMi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q1GDrCw2/ByxMqZlAmH07DTvGp8RL6vYCE31G3MW1o2Del/O+DaOGYPkIF0yLPBO3
	 cyuw96d3SsKTyMte40WAmDHwYGIl7yEOKfq7F+6cjBo+pAXMcqZnx+ftCUwT02unMs
	 zXfUcTUEwCRC0bafsY0oPJoL/XAVFgJ7ee7XY9AE=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708834024tkfqjjbuk
Message-ID: <tencent_E7EFE2D9AB2A8E7A2EC8659220BD9E99C205@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLa3HjHfIQsC2V4sWkk+PJiQspQqNqYaYaD8jqA8h+7n0t0RZgqo
	 e1Us4DRjg5j4c/vpqJeIj07p1lJZblbZ+/dTQSFg4gtzXRZHd7dvNsQsiv+4xZszlbTSw8ko8zdN
	 5ivPHC/eCQaw89qYNWC6YeAvaYWGOF65ZZioyeOYhfjJJy1UWbVw0/d9sGsQsicYOvnBWB2ZPILC
	 nuDuqCfbjNKDBb5BdRYuXx7BKJZ2wLrkVSTcnieuBs87eFc3Tg/fj4uY/bjz9AtyxjznSdd5IReT
	 G/l4OJRJNyFXqFH3Mk8RrZPBSkM482A06AhASk6wojU1G0r2c6KgBjFqAObS+iJh5iXozN5ovbds
	 gti8w1Ju9q35K1CbJRbuiKrBVSu0qO7NlgRwVi8mzk6NUN8jG8zTP5PIXS1+0tV7vcwTK8SU8Dvw
	 Y7OK7vDlPTbwyNlgqnoEsiOwDJNTtnNMaR/QwCLZfgNm6+cEaIoHlFywkB5OMFPef32f5MBfupR7
	 sgmEP49iJ8MM44Ozp8jAfPQAyrstVFQLjgLnRe5K/nx4I5+3oO82xKvr+4RYfAgT/0sCQNErdXjp
	 rh5dQBFJ5lln/S+vcP+nGWtdrCOZcztt2XLFGgIbPxQSP5KvbIQ9BPjQuHhl6S6uie04H491P+5n
	 GjR6Iq7JJcCw/tjjvzL4qkagVL0blrYX3ADowfGqVfx7wyopct4Us0k6zJCzNBbuoAFpX3rO6aEm
	 Nd5sVW72xfPUrv/4XY+bE4qqKgTdSVtzoCwo6uLp+IsMSTVsj4akeTKhs/fD7nhy17lcmu3sQznA
	 F6YrTn5wzqslar7R4nhdkbeYG5i6v4sbxniNRzSlSMsdx3gox36gWWS6pvrOh1W7ptkU0dufZpNq
	 wfDUHA/uSKq/UgraKKpqAjcj9nY7TDjZFVGNGymsyTD3SNv6qW0Qk/PsafS/NOK4hN1JnXRPikZt
	 wwNFUREtpwmcWzVYtbcoFdpuj6BAxmQ8gu9U6dAnHsULcRIC/MsAGuCBg5gBOqw6R1n7se9q/WBI
	 u8NzthVLMrV9xKIA0J0y9vvWXnf4TnBPzN8Y+fP3XO8eotxKMiQDzfHfJ+kJeLuPsHGNevmA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sysctl: delete these duplicate static variables i_zero and i_one_hundred
Date: Sun, 25 Feb 2024 12:05:35 +0800
X-OQ-MSGID: <20240225040538.845899-6-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since these static variables (i_zero and i_one_hundred) are only used for
boundary checks and will not be changed, remove it and use the ones in
our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 lib/test_sysctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 9321d850931f..ee69dd277a1e 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -26,8 +26,6 @@
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
 
-static int i_zero;
-static int i_one_hundred = 100;
 static int match_int_ok = 1;
 
 
@@ -78,8 +76,8 @@ static struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "int_0002",
-- 
2.25.1


