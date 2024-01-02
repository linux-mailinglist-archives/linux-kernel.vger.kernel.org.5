Return-Path: <linux-kernel+bounces-13989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7182168C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718631C20F81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82684ECB;
	Tue,  2 Jan 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgcb7+aA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D646A3;
	Tue,  2 Jan 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d45f182fa2so42783265ad.3;
        Mon, 01 Jan 2024 18:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704163327; x=1704768127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfOHaDOQFWCjFE5eYECAufdGX/M8ENRMe8BdoJQwdrM=;
        b=dgcb7+aAMoauuTzvh8Nau8kLSePNZJYoHi3AkeNl8se+Cw6TIjRVVaKMoFNAnEMEuL
         PElVf5uImFZ3ErbOc7D1VzSEmOyedcATKhRxmy1moWexiM2+EZ/I1MUDACj4j+OHj1fx
         +YGgZRJdtX1Tn7vbXwjfR54z+OlfD9Qu8pjpC4ZBvxGZZZMI1yySTM47cGqcXBKt/TD3
         LmCpOMDE72qQQfxPpkRdMEd2Y0WS3EZhutpB4M9c/gUn1kVzZyYrQ/Mx9QUgcGW0sBiB
         rmEJYmaYpwH2f8okSsAEym46Jf+Vk+ZxKZUU4mqjLGmijiG1w/V8q56B+WPHOXXN5rIs
         WWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704163327; x=1704768127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfOHaDOQFWCjFE5eYECAufdGX/M8ENRMe8BdoJQwdrM=;
        b=iBTA1d4dtLHmjOoieydFu3kXxgtEM52T3CGJVfjf2U96IrSLtApZ2hXYkdzkgMR0kf
         uxQwBSjtCcyDULVVxTNaUijyWccx2415UP+uGch2KX1QiR8QGdSGdkvvf6GlqcGBpadP
         mqhpVYKVB0yg9y0RRtGSY2+mSN9QcMthhV8SJouy1bJ5UgMeBIfWUAhvbgJRevcXeeAh
         OB21wlxf/liCgQtrVo8cWI92LbAbClWufbWneoU1/mvO7rNlaL8/5U0nnmhzOWfzlqMf
         7f1K+VYgFP4iDFdu6Mm6xjF+hz371DvEWtvEbK7Gvq9BPCov4VTh25NQpUde5Ken2N5l
         0b9w==
X-Gm-Message-State: AOJu0YxEupkK/OaBmbGGDSAMvAaKgRQx3qb+XvleIEu8cOv7UeYNkjhD
	DAamdKKhsw0CZMLzUN1M/d4=
X-Google-Smtp-Source: AGHT+IGBlPFEg45SFGKot3B9Qmhip+YFNIfepomX4SLuIrjxOfMELCEVoF3xRzLbgD7feppLDqQifw==
X-Received: by 2002:a17:902:e88d:b0:1d4:be70:21c0 with SMTP id w13-20020a170902e88d00b001d4be7021c0mr2015443plg.16.1704163326602;
        Mon, 01 Jan 2024 18:42:06 -0800 (PST)
Received: from localhost.localdomain (45.78.55.121.16clouds.com. [45.78.55.121])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d1d1ef8be5sm20895643plh.173.2024.01.01.18.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 18:42:06 -0800 (PST)
From: Guoxin Pu <pugokushin@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guoxin Pu <pugokushin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] block: fix length of strscpy()
Date: Tue,  2 Jan 2024 10:41:15 +0800
Message-ID: <20240102024115.4395-1-pugokushin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 146afeb235ccec10c17ad8ea26327c0c79dbd968 ("block: use strscpy()
to instead of strncpy()") , the length that should now represent the length
of the string with the terminating NULL was not updated alongside the
change.

This has caused blkdevparts= definition on kernel cmdline to be not
correctly recognized and partitions not correctly initialized, breaking any
device relying on such partitions to boot, on stable releases since 6.6

This patch fixes the lengths to contain the terminating NULL.

Fixes: 146afeb235cc ("block: use strscpy() to instead of strncpy()")
Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Guoxin Pu <pugokushin@gmail.com>
---
 block/partitions/cmdline.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index c03bc105e575..4657704c3e37 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -79,8 +79,8 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 			goto fail;
 		}
 
-		length = min_t(int, next - partdef,
-			       sizeof(new_subpart->name) - 1);
+		length = min_t(int, next - partdef + 1,
+			       sizeof(new_subpart->name));
 		strscpy(new_subpart->name, partdef, length);
 
 		partdef = ++next;
@@ -138,7 +138,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 		goto fail;
 	}
 
-	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
+	length = min_t(int, next - bdevdef + 1, sizeof(newparts->name));
 	strscpy(newparts->name, bdevdef, length);
 	newparts->nr_subparts = 0;
 
@@ -148,8 +148,8 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 		bdevdef = next;
 		next = strchr(bdevdef, ',');
 
-		length = (!next) ? (sizeof(buf) - 1) :
-			min_t(int, next - bdevdef, sizeof(buf) - 1);
+		length = (!next) ? sizeof(buf) :
+			min_t(int, next - bdevdef + 1, sizeof(buf));
 
 		strscpy(buf, bdevdef, length);
 
@@ -250,7 +250,6 @@ static struct cmdline_parts *bdev_parts;
 static int add_part(int slot, struct cmdline_subpart *subpart,
 		struct parsed_partitions *state)
 {
-	int label_min;
 	struct partition_meta_info *info;
 	char tmp[sizeof(info->volname) + 4];
 
@@ -262,9 +261,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 
 	info = &state->parts[slot].info;
 
-	label_min = min_t(int, sizeof(info->volname) - 1,
-			  sizeof(subpart->name));
-	strscpy(info->volname, subpart->name, label_min);
+	strscpy(info->volname, subpart->name, sizeof(info->volname));
 
 	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
 	strlcat(state->pp_buf, tmp, PAGE_SIZE);
-- 
2.43.0


