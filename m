Return-Path: <linux-kernel+bounces-27289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E682ED5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10006B2238F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043C1A71F;
	Tue, 16 Jan 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzTL8GnA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69121A590;
	Tue, 16 Jan 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso11965667e87.2;
        Tue, 16 Jan 2024 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705403245; x=1706008045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVAGc4XL3xs1uMSry25G+l6Lbj7TMq/VrUzFoxhkoKU=;
        b=lzTL8GnAmiCDdrB9X8AY46y+KtpHjUe0jjlCof1XZ//53AcBhiZwsfOT1l7LFYR7AJ
         4oiL3uLCrugQa4P5/gpHNYYbnA4v2pcDuFgbT3iGDmMEuhsU5YXlvilPhkUYR1DkP/DO
         6c/0XR02UZ0XXJr4HYA3SR25cUrKHGlYyBIFi0Ht5Zdn8i7Vy0ytZYrfJY3zxpD2LLry
         2HYjOpilk0PE6rakgdXJKnSjAMnpBtGqWDX3rtsiCx9KqVDuN4y0ottbKFLj3B90BAeu
         ALyg12sGYUP5q8NgQZfDaAk4bWwuCl3QxRaurYStHcbpMk4btO0mqC2P1TkbLH7p1Pmm
         9Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403245; x=1706008045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVAGc4XL3xs1uMSry25G+l6Lbj7TMq/VrUzFoxhkoKU=;
        b=g/zmD6x/Bc7W6XxzDo5CEqaJSHWZaySjHZefqtxJ7/PD03Fmlzt8fwUcWBo0ldJeQQ
         5RmpGti9UPch9sQJdP/ASkd/CuYhP3KD2LKEdTAs1PVAMyC4AAvwfJkXVy9qiOf8zUPo
         FLGG6eDKmnGRucm6D08eCHJmuUBYh2JaVpiGzEwETgftPeRM5BeZ2nbrzPbS0kXpS+JY
         T+dHxuAynoIMEClKiteka2tT9V/qLCQqyUkAy6za3KBZliZsHxnsaJ50HEVfe/hO9QpA
         a2KSytmNR/G0XRZ7C46aSYY0S2Tca3h5O+Lobrfx6lr3ZGsELbKKWeY75KhSn59YpKW0
         5v4w==
X-Gm-Message-State: AOJu0Yyg0NbSS7wIl1UKroVSNH3S/1OgrfCl0exs11nsvJYxvATTjLgk
	Dw17lFzEX4goXPmhc/x0G8M=
X-Google-Smtp-Source: AGHT+IE1zjgAqZDFrlJqftk3i9QAie/p3my2wHOSZKNnxYMT9k9Y+X+BZb4QNjwSDtY8aIciDcTVRA==
X-Received: by 2002:a19:6549:0:b0:50e:abe1:1c63 with SMTP id c9-20020a196549000000b0050eabe11c63mr3434504lfj.32.1705403244776;
        Tue, 16 Jan 2024 03:07:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b003373ece28efsm14329359wrs.29.2024.01.16.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:07:24 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] bcachefs: remove redundant variable tmp
Date: Tue, 16 Jan 2024 11:07:23 +0000
Message-Id: <20240116110723.2247265-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable tmp is being assigned a value but it isn't being
read afterwards. The assignment is redundant and so tmp can be
removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'ret' is used in the enclosing
expression, the value is never actually read from 'ret'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/rebalance.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/bcachefs/rebalance.c b/fs/bcachefs/rebalance.c
index 95f46cb3b5bd..827316a27431 100644
--- a/fs/bcachefs/rebalance.c
+++ b/fs/bcachefs/rebalance.c
@@ -385,7 +385,6 @@ static int bch2_rebalance_thread(void *arg)
 	struct bch_fs *c = arg;
 	struct bch_fs_rebalance *r = &c->rebalance;
 	struct moving_context ctxt;
-	int ret;
 
 	set_freezable();
 
@@ -393,8 +392,7 @@ static int bch2_rebalance_thread(void *arg)
 			      writepoint_ptr(&c->rebalance_write_point),
 			      true);
 
-	while (!kthread_should_stop() &&
-	       !(ret = do_rebalance(&ctxt)))
+	while (!kthread_should_stop() && !do_rebalance(&ctxt))
 		;
 
 	bch2_moving_ctxt_exit(&ctxt);
-- 
2.39.2


