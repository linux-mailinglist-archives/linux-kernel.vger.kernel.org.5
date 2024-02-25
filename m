Return-Path: <linux-kernel+bounces-79974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BA862912
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D3D1C20DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA979EE;
	Sun, 25 Feb 2024 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Zc5Tcx3k"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9E7460
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834142; cv=none; b=UAYbCWLnn6itYBGpiQPuVp73Cus/kCjEbWp9eIOJF1eR2PmBdNvnQ4TZM6qLpVchN6yHJUWYzm80zH5+lqOc2yx2MvmMDaCZiJ3yqk/+zK5cda8gEBduomZBePyJQaP2Ar7QmwlVxTWTZLxeWgrJWpJ+Dt+zKM4LdO9mCE9A+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834142; c=relaxed/simple;
	bh=uomHFrNlcUsTDh2dhGspQ857QYmROGH5u+KIa214i3k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MVWswjPi9HibulKjH/QjY3tQgqf7/EbBbRLfc0npBNm0mLRJVQ1oK+lLZjbmI4QHB7+N2ymCrB/MF7wMS03bnk+NY2lgrJOB7U0+WtkrWP3HD+jICmkigMC6j0NAilongTFjRDKQlyuUrXhFGRR4dfHafImbvNRw6gR589WMMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Zc5Tcx3k; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834132;
	bh=mM8ldFl/qvZA4i5D0hWX4szQECAim3lPn4D9ZGUp/mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zc5Tcx3kZyC6FFGehKcfawDx5hTxHQ7ZwK3C7bmsAkdDOF0I8fbfm3Hf/iN++6mn6
	 ufeTyQY8q5fp5sTsK7n4X/S18yCf+sfpEChBpN74nW9Ln7REmF1fyqWI9W3RVitrT8
	 UIulKOJQ/shd6SFcKFCVV9MbQRzxeGwHS9e5eWgY=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708834043tmfqrrb4n
Message-ID: <tencent_D3D0CC5A7E63CF04557ED42E411D9379E908@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS1VwAnrDYUcZ7d0pPvmBjSTY5Yr6MGP4+wgDoV/3RwBtzqHPz8B
	 9NZCYvFMIyI72jHYNnb9P56Uf86eKkFzRQ0noga19bN2djCx32UBvGgjLGRGrrvouKBBJu9oimKx
	 8BP3SmPeC9gOV9w9LxchAJxqrGtdYYqqQ3IrO9OXUWuW200UYuKwOIt0+ZIFpDSHyYITVwU7DDbZ
	 u/M2OLWoIgX4yF85YxAfWFg2Ah2ghe4P06FrNPDlRA+iZFWQ+T2DNP5+gXT7C3axgaK6H75yBh/m
	 H/CGgtNMmAxGT8JTgqTtOraONBWz6URXCY8Y8MFqPmu55QtAYAJPiMbCxZLM3ljw9ACq1SArSJPO
	 5O2S+sOEfh+I2MYP25lKKMF4Iat7EOl/zP6O5VptE1VIKFfx+Tq4QGpIomFgzIh2o5u77pOu9Yjr
	 dnqZI/2R6WocdX/x0FdLg1slNzXkgsXniu6l97TSE0UTBQ/V61B4EUjNHMT/QninsoxrWiXYFaht
	 tPrbfUp53t/RzDzMeeWOvzDEzoCuWXk79ys8O9Wg99z0RwVN/QSAUqZFMAiYqJbsFb3U0/wAwBl5
	 83HgpdMyq6AergDJHIhVrzGCRLMhMvCQaZdAACP6Rgu+EEk2kUj1cCudm+xCxnXJfnQuMpzGdMyV
	 jFVgLVzHFaPbZ+8gJFR9/7DQHcDb/fANpkxMpxKv/6LLpCraJV2rtgxEVX5DO4ok4WSyS2r/DQ29
	 os759hbWADR5ZyxzTrhaGpoSzEzoodl+GjSMUOGT8l+00hbonx6EjeiwNefySxpp5bFnz60R4mco
	 rbKrEbHf1gBW3pBRZoNv4EsboMKyVZRyivgYJjFyu0/ybjuBBYW1vELhVCcuynymBMCpI5CZ7POo
	 UVXX/Am5BCMnAVAJqJGJwxMMHFhYVipeID9fCod9wBlhf9CnUK1BogWbouEI+C1tQFOnHeY52A2D
	 b05nJPlSC88g2OvDJoH/nRKI5etIP8d/LHTpB+MDmzls3YFC8gZqDSVpZOe6raP3UH9rQpV838iU
	 6U+Sc2xZiT87K2zyBX0vSqPUNLblm9Emui6U3QW7c2kvgnwO6WSlS6lx4p1NQ=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] epoll: delete these duplicate static variables long_zero and long_max
Date: Sun, 25 Feb 2024 12:05:36 +0800
X-OQ-MSGID: <20240225040538.845899-7-wenyang.linux@foxmail.com>
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

Since these static variables (long_zero and long_max) are only used for
boundary checks and will not be changed, remove it and use the ones in
our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..22864d6de04f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -309,9 +309,6 @@ static void unlist_file(struct epitems_head *head)
 
 #include <linux/sysctl.h>
 
-static long long_zero;
-static long long_max = LONG_MAX;
-
 static struct ctl_table epoll_table[] = {
 	{
 		.procname	= "max_user_watches",
@@ -319,8 +316,8 @@ static struct ctl_table epoll_table[] = {
 		.maxlen		= sizeof(max_user_watches),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &long_zero,
-		.extra2		= &long_max,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_MAX,
 	},
 };
 
-- 
2.25.1


