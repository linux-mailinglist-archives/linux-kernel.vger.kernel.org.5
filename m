Return-Path: <linux-kernel+bounces-164753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F88B820D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AB11C22535
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966061BED7B;
	Tue, 30 Apr 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I6NNafXX"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424D1E52C;
	Tue, 30 Apr 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513376; cv=none; b=DTHyADzdwSwZuspxgit9Sxt+bJKNWZudhaqpoxqkinIJEcfkjcNqth/ETrsI84P54YixY+MHneQCRQneQfQ2iupioEv5LFF8xEitWUA6fVlOXba8OSwiQAa1Z+HP5hZ2yjL2vS8apdi68hGcT41YD4IZl9AeLIUf5z7nnYUaZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513376; c=relaxed/simple;
	bh=B5czF32/U9N9vGMTqBvMRHfCgK49Nbyky7mC+RM7k/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fh2mlNgItEyl1DbrJm2rLretYhgW4ca8rAsy6oBESV1kblKimdoZqWWCCGBpGHM4057lQbne+yaDYdnV3HOG/HRzxHBC3XSmcWENS2T6YKRkwkwpawgaFx8CPgE6I4eTceBLcTn5QxkmGdG+qWkAPFrLhqdhoOgtYaqiJXTHMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I6NNafXX; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1vFSs68mphCCi1vFSs6HMy; Tue, 30 Apr 2024 23:42:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714513371;
	bh=Yrun8hUYJhumlCa7N6N8TuH8dMPV0MxY7xh8upjtGIU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=I6NNafXXfR0xR6qCpV+x5Lv+B1Zlc2v4cHd2F5W5ctMI6PYxq/8GJKc6ZH5NPXzhv
	 g4GLE0cn7BePDXJM0KRONwv4UM3bZwRnXzbYxx3ErrG7+Iae7HyzNPeWzuVC+YCTc0
	 oOmVTcGc+fs2L+dU/fbq9TtYsTNADW9fRTjo9QQ/Cq+Kiut0I7hKeLmcDAeN/mJXTy
	 diL7SntVzgRP+cJo5zHBPRjSsSfGMiJkphOF39OmsbkUGSHAE3x81Soj5hi+iiCnkM
	 S0//0VnZ1EYNf5Sa60E1FA3zss7ZITRGtIj/EL5ptpLJoWCR924TW74BS32gTceLg1
	 pfQA26NhyNkgA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 30 Apr 2024 23:42:51 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Remove an unused field in struct dmtimer
Date: Tue, 30 Apr 2024 23:42:39 +0200
Message-ID: <c9f7579922c587fce334a1aa9651f3189de7a00b.1714513336.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct dmtimer", the 'rate' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 56acf2617262..b7a34b1a975e 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -129,7 +129,6 @@ struct dmtimer {
 	void __iomem	*func_base;	/* function register base */
 
 	atomic_t enabled;
-	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
 	unsigned omap1:1;
-- 
2.44.0


