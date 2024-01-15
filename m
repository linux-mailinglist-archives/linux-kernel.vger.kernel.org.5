Return-Path: <linux-kernel+bounces-25657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0282D431
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0391F2170F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5385C97;
	Mon, 15 Jan 2024 06:25:38 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E45ED5666
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 450A36025325C;
	Mon, 15 Jan 2024 14:25:26 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: akpm@linux-foundation.org,
	rdunlap@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?user=5Fnamespace:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20kbuf?=
Date: Mon, 15 Jan 2024 14:25:19 +0800
Message-Id: <20240115062519.31298-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kbuf is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/user_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 1d8e47bed3f11..6fabf388bb8a8 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -928,7 +928,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	struct uid_gid_map new_map;
 	unsigned idx;
 	struct uid_gid_extent extent;
-	char *kbuf = NULL, *pos, *next_line;
+	char *kbuf, *pos, *next_line;
 	ssize_t ret;
 
 	/* Only allow < page size writes at the beginning of the file */
-- 
2.18.2


