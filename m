Return-Path: <linux-kernel+bounces-51189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9F848783
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AF31C21ADE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B055F846;
	Sat,  3 Feb 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev2ZlBDK"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD55C8EF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979093; cv=none; b=rUTnmVITR3NXeWc08wgFwOyyHGYBQwrgxQi7+By2p7P6yosJi8ct9QwjDuSHtHQbo96Agl+uhXk97VihvOcP34KP2mRlCkS3MlE+urio1+Gfmb4IQRAqF9f0O5IFbuAz1as5o5Wo1H2fHjFNhMB1BTxmnnpHA0zjFzQDe90h8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979093; c=relaxed/simple;
	bh=a2OG5inng2XwCM+xjK9nJgfWWl1tseTOrhwjbgIF/y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FYNfv2v4u27FYds+JKY4o/bzlCcm6LmlEh6qx9HMJgZ7nyPU9dusNrajEs9nXvA+2kVn8EHUD/I0PT/ihR26JqajJsg1M+CKen8aAXCnR3083qhRfaPGCKKMTpzh6vfCMm02hVNCKOONdP6JvXDgef5q6IiNXC6+GmYP6PZFdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev2ZlBDK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2434931a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979091; x=1707583891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2f67kU//P87HeqhHQJd0E1lsyn7wir/Giu2Il+t7u78=;
        b=ev2ZlBDKeVnHj15YVBKLCu0bTHptUNXYvqJXQPVZ8BgN9ZSp6kqxjepyuZuNalG7cp
         QLIsvuBtInZMlIeXew0WvoRPJMhGFjsHDSLNcTNyVGbQD55sQ9VlZuMHMKiBBmVBQpos
         lutvF3F49kymQns9D6IxpouoGO0wIMRJJS0JAohgS7wNTBthfRjqXj04AFIQM1QWYBo1
         9YD9+z6Pazs00R9FvojXEGxNh3LXWce5HiSCOMqjc4LBwZtuHSGR5yLZWoSZZGeQIkw9
         3DhJWpXYUtl4fmZFdo1q8xKQ2IMvirAzZLr6Xre+fO+IYk4t8oDqqIX51kD8tNELNycn
         QNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979091; x=1707583891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2f67kU//P87HeqhHQJd0E1lsyn7wir/Giu2Il+t7u78=;
        b=hE0A9dOrbH6Bd463OsIAMUligxaQJSpKmjg0ny+Fwcg7oP+NcF+sO2leAEVEe8u6zn
         sFx68QY7X8Y6qd4RGQeE8uLjOOkN58g46G26B/0b94b8xpd/AxJXs1KCU8bEEUCwI/ij
         rPiLPMucu2R9d22729n+TOhwI3ir4M3NRqjeO33tgdzijJgUJYUOw+OFb7Q9WB3GVTxu
         5hZ6sC8zygTszLwO2P0bF3J81m1Ai2k38LxlX7dZEyYmmu/7rZ0a7MV/gXaBfm0zWnl+
         VhBy6zN0RoeNYp3u5T8fheWPFJhCEx4Ot+6JzhNktH/vTxS5In1HD8GaGInn0iysiJkE
         Gasw==
X-Gm-Message-State: AOJu0YxR3/ajEopo0QUW+H++60kyS/bDNfnySQIR95oY99WZEC6p1hGP
	zbTOLQj5gFZ6tPdNHq23u5kXsCicHutxeESDFmujldYN3uNS1ymQ
X-Google-Smtp-Source: AGHT+IHhDcmD8X+7rW+aMDaQQnH/xqH0DG80QzaXb6LAqgE+ZXfaZHVBJV+/kb+kN34lt7Nh993jRg==
X-Received: by 2002:a17:90a:dc07:b0:296:ec9:6232 with SMTP id i7-20020a17090adc0700b002960ec96232mr7477868pjv.10.1706979090764;
        Sat, 03 Feb 2024 08:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPE0VdD4Pz7o0ke7OUcflfjLqedg7oj8+my2iGnEqGRLzIT/ZHb1GFNWOwftvcdxs/+kGWXykhQL/wdRKMDGOphhBgQ3unRXiq
Received: from localhost.localdomain ([122.161.75.254])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090adb8500b002904cba0ffbsm2051861pjv.32.2024.02.03.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:51:30 -0800 (PST)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH 2/2] Task: Kselftests : LKMP Bug Fixing Spring 2024
Date: Sat,  3 Feb 2024 16:51:23 +0000
Message-Id: <20240203165123.149564-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modified the function arguments, adding %s format specifier
in order to fix the "format not a string literal" warnings

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index 92276f916f2f..e408b9243b2c 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -17,37 +17,37 @@ static pthread_mutex_t ksft_print_lock = PTHREAD_MUTEX_INITIALIZER;
 void __test_msg(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_print_msg(buf);
+	ksft_print_msg("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_ok(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_pass(buf);
+	ksft_test_result_pass("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_fail(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_fail(buf);
+	ksft_test_result_fail("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_xfail(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_xfail(buf);
+	ksft_test_result_xfail("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_error(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_error(buf);
+	ksft_test_result_error("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_skip(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_skip(buf);
+	ksft_test_result_skip("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 
-- 
2.25.1


