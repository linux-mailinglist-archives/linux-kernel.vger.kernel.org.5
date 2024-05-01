Return-Path: <linux-kernel+bounces-164955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F08B8566
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAFB2217F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D84AEFE;
	Wed,  1 May 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jmps/2J9"
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33432210EE;
	Wed,  1 May 2024 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542164; cv=none; b=k71h1l+Uy2uWYH7S8svrxuu6GAWy0b6OfQ4+pfpAGtzQa+QTkHviUrgXz2qBFXtjdtf6/84fBGs9BfpivZy2MVKNu/bVTW+JgoMG2pJkQMC2UAfkXxH8clMCbsfWdwF+/ftF4kN05wfk9WEeaDYfMOXDtgTigrBqKYYiMbkP3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542164; c=relaxed/simple;
	bh=/bfHl25T1ErekIGpv7GqhWKjHMj3kURow4DUhvA1XuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucNSW4qncJMqo9XNqTrsPdAkGTZMgjxdXHIjWwIV65J8MhP+CZWhQeZv8WlHvDMG8ZxzN+gu2VfE3h+/vmhxzfujB6iktz9HFar/DjxZcoPQZI4V5+Cyqqx4KiGaU+11l30p0q6nl0t3l+n+jt+hFVPVvXucZ9xGGp+bi83p+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jmps/2J9; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 22ihsnjwQ2DIx22ihsslTp; Wed, 01 May 2024 07:41:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714542091;
	bh=GrXhC34dkfPzEz4DZ6QAKxewlmGX1gPA1Hzs/EClZkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jmps/2J9fr/NqaIQGN8fIXN4GY6Y7XSLJhVlkhDNSleMCucp7sEJ6y6HJDl/iVzIj
	 hVOctkISIgjfIQPd4omQ79rR2TcrT44uFA+9vMMP+qnitfKLU8f0Lk/DkLME6LRWkR
	 ySms2KPSQ143zHxwabp3cQcg/hnxBtneRz1uCbP+q21iCEd86c/X0SLcgjN+Q+PFgX
	 BhvSRVtyzztWL0L+iMnlXhh9DC8eBPIQ1EVVptMF6t7xFFNq0/HyKiw9bCTyocDTFA
	 rVWaBI1gqB1gCNBaJ2Q7LI5eFnSSiwdYFM/GvP8ZhrkwLhM1bFYzq+iaPyCBuq9Tz/
	 Eo9ZJgrsSqYlw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 07:41:31 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org
Subject: [PATCH] Input: matrix_keypad - Remove an unused field in struct matrix_keypad
Date: Wed,  1 May 2024 07:41:21 +0200
Message-ID: <4f1a946789445500b6118b9ee1d6ef5255f8c696.1714542052.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct matrix_keypad", the 'gpio_all_disabled' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in commit fb76dd10b911 ("Input: matrix_keypad - add support
for clustered irq") and its users were removed in commit 8cf4b3683a71
("Input: matrix_keypad - consolidate handling of clustered interrupt").
---
 drivers/input/keyboard/matrix_keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 695c03e075b5..7a56f3d3aacd 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -37,7 +37,6 @@ struct matrix_keypad {
 	spinlock_t lock;
 	bool scan_pending;
 	bool stopped;
-	bool gpio_all_disabled;
 };
 
 /*
-- 
2.44.0


