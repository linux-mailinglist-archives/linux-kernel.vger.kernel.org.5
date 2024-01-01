Return-Path: <linux-kernel+bounces-13918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DC8214D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B40281B35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30062946D;
	Mon,  1 Jan 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAT8ku4r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481598F4E;
	Mon,  1 Jan 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d427518d52so45140015ad.0;
        Mon, 01 Jan 2024 09:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704131603; x=1704736403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P2BWNvYBepeLwb8q83GJwuE1J0b0OLLscBDVehSnTxA=;
        b=KAT8ku4ryMcRo8eQWCGlD3bN1k2R1Oe8LMgkn5lSHiJfG9koKVKv3vSTTHqMTFNbJJ
         YXvA1PWJLPNObbaMyI2YjxIKJVKczSlVhlX6NuNSDjj+bg/ywDzcg3dF3j8d8KLkB28U
         d47D+Ue5M4RpB5rRA7Un1vVnluGOZNp4pT7K/42/k2SngQsFlDEzgPYOIr4pu/5JDitz
         LXopRIGEU1uaPA8r2z7z9nnbHCFgsu8uqv1yZbMzrQHdLVuHuAO/6MbvbJOFrOt8Ueyg
         XMB2NnvXdsObz7i6owBaj3iqj90NX0olDWlqS5cmyny2TDnffatiLni71I1c0bsy2dJG
         oOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704131603; x=1704736403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2BWNvYBepeLwb8q83GJwuE1J0b0OLLscBDVehSnTxA=;
        b=G18cjzNZBsds87iQGubrBP/BbAy2Ce0VgJrTXAz3VfJ20Vn50PpgIhStI2u82zyDcC
         EZ+lFkc26ZFO3/VGuZ0T3+ERvF0RMEj5Cf++WcnlOIxLMdqooFYTtp2ASX7zZ+4yZE+N
         +M835gM8bIXM/1adfZggW1JS3IYePK6qXk56mvYbKLgspZxnge8EcPt3MjJ2b4V/uDx4
         TsCK/aukiO/QMyngfBS/ZskdnJwr8L5JJcMBuRH4CXAocgTzw2N8nod2V8hlQhEIUa+z
         qbhV8F3wQwvq5saLGX2un/gv4LnpIjWb4m1GBIKAhU0j4ipL6AYBnjHVHdvmQWl/vizX
         Yt+g==
X-Gm-Message-State: AOJu0YyOgyDRNtD94Vm7KaFtsFr+BYLQeMHCSpfvP5rqFku7Tuwx+Uen
	qiRjZ3B+fdlOmqUHIXO0zro=
X-Google-Smtp-Source: AGHT+IG+5A3KCbkUups7IoOdYOFwSobipBI/piCU/mQUi+kjTuXEP6dOoXqMdpw/27xVJZ7NXtQhfw==
X-Received: by 2002:a17:903:2652:b0:1d4:b66b:b48f with SMTP id je18-20020a170903265200b001d4b66bb48fmr2421015plb.19.1704131603339;
        Mon, 01 Jan 2024 09:53:23 -0800 (PST)
Received: from localhost.localdomain (45.78.55.121.16clouds.com. [45.78.55.121])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3561680aasm20325367plb.82.2024.01.01.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 09:53:23 -0800 (PST)
From: Guoxin Pu <pugokushin@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guoxin Pu <pugokushin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: fix length of strscpy()
Date: Tue,  2 Jan 2024 01:50:52 +0800
Message-ID: <20240101175051.38479-2-pugokushin@gmail.com>
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

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Guoxin Pu <pugokushin@gmail.com>
---
 block/partitions/cmdline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index c03bc105e575..c2aac5f4ab82 100644
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
 
@@ -262,7 +262,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 
 	info = &state->parts[slot].info;
 
-	label_min = min_t(int, sizeof(info->volname) - 1,
+	label_min = min_t(int, sizeof(info->volname),
 			  sizeof(subpart->name));
 	strscpy(info->volname, subpart->name, label_min);
 
-- 
2.43.0


