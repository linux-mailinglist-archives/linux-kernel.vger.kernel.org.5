Return-Path: <linux-kernel+bounces-162924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C768B624C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339221C214AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955713D898;
	Mon, 29 Apr 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiNWwyLu"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913013D284;
	Mon, 29 Apr 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419147; cv=none; b=AuGwdNyYpvV6RammNcGRmirDbIskQ+GmsKRwIIomOb/5X/qhguy4n+l7tWsxuvPUWqrn12gDwNCU4UPvI5ZTfz1OO+w06ak2bimb18pwoVj4PaJdXUZGChUzvKmildBrKawU+LXQpSS5k2s1lczJJWDGTi0BN46BkY3G9Unj05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419147; c=relaxed/simple;
	bh=yo2ZY7mWqxpesSA/A8LUGk3k8sUcGBjXHIm0oMMv0MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g36Gix+iNNdvQ2oLbz/ee9MpWsT6O+sbgmIMkUx/zRlAvfIyCfcG9dDP3l2p35F7/Qqq+h0+2/d9i0RzqTuCuoXMNLld3Mak9q+1t0hCaWekxwz6vM8J/kUf+21QATW50sN9oKmrSD4Gj/8Z2X81zEmDfUvGnScbDVmpidcTNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiNWwyLu; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7dbc33bdf08so207703739f.1;
        Mon, 29 Apr 2024 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419145; x=1715023945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXjRrzdCYkLhGXxn6Tze/QfNBLWvJeKdggxRtTTTxXs=;
        b=EiNWwyLufLy4dFxMtuiBhEStwjlJINIcgqL5MLjA09SCt2TB4dSY+dwofIsLBT9k8z
         U2kEvKtYdKCK3MUiz6/VuhVP6y5kFzQapVTNoc+blhVpM7XZaZ5UQ6/dQwGhs0g4NzrP
         14qSDRsm5SX2ztFO3gEYA4Q2XvN1tcrYk1NJIbwLLo5GAiflKlaWJM8D0gD3G7gLcJC8
         fD2L4yBEGnUv4G5+ru/goBmXMw2O7hgI9uL5XolO9doM9XTosr0bBazuokWlvz8xsWir
         32XV0g+d3XFp43FOOKcZM1sR+F+jKa9UpJdS1PEPJG3vHZ8MU7nXLAH27zQ0FhN8Vh6Q
         nCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419145; x=1715023945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXjRrzdCYkLhGXxn6Tze/QfNBLWvJeKdggxRtTTTxXs=;
        b=PpC1alvr7NVcarPmw6AxelcB+CeruIltOE5wSQ7/ymPWEa708dqzGBZLm1k4p7TfYy
         6WB2Pz578uucGR/zyU5zzwe9EJc73iNCvvGTeMyCZsxeXMFu9Kw3gxUufQT1M1OcAINi
         l/vimtQwH79+uFMj3J+4awOEiP2NQl2UT0V97wizdOpbwyHBAByh93g8duGG8+2yhSZc
         clMop0nKZcBd4wr8/25jYbchK7OoqABEBod7+7L85v5Norwe2/mYg4tynqg9qe+7DHTU
         RsgeJyAuE9WFg0VU9L/P+EEGoGm9N/TR5RxGH1LVSKXjVduGmWioMIWXOFzfO4MDmzTw
         XXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTQi8nX7cafgEhmMq9eKS94LJTIRPSADaECm9kZvUKcOKSkWt7vgi6BqqnEovqiqxMEhk4SXEVFYVRYT/a+gG8a6BDlKj5WjLkaZPbDQl4NBgFSvIJr9GHKh6wvJkRYbEMwaZjtY2
X-Gm-Message-State: AOJu0Yx5jOw1v77THFyUudqTMhH1gr/E743OmIDZedLb3FrEFSMiVS+Z
	aBMGgh+kgYc5GDgFLjcua56kSxBHiOwH8kVnc2GCU+elblqxiU6G
X-Google-Smtp-Source: AGHT+IE3p1obx5NHUH2g77zVzvLUE0eATOj9FCak93YZ3BbZGAqnDoiqRrtDkzEy/gCQsLpjLsG6lg==
X-Received: by 2002:a5e:d818:0:b0:7da:c331:c5cd with SMTP id l24-20020a5ed818000000b007dac331c5cdmr8530527iok.6.1714419145679;
        Mon, 29 Apr 2024 12:32:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 11/35] dyndbg: silence debugs with no-change updates
Date: Mon, 29 Apr 2024 13:31:21 -0600
Message-ID: <20240429193145.66543-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ddebug_apply_class_bitmap(), check for actual changes to the bits
before announcing them, to declutter logs.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 368381dbd266..8320cadeb251 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -606,8 +606,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -622,8 +623,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.44.0


