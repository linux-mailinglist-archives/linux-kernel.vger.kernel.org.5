Return-Path: <linux-kernel+bounces-160924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218E8B4496
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972A6283B08
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEB41744;
	Sat, 27 Apr 2024 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GoYlWB6V"
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B82207A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714200081; cv=none; b=RyyDvt6S4tTd/lOTbkIyuh3Po1Qj4ENZC3/eBGaOryi9xpuok7jcfO9RtxaoOGkJaKeUuW7hThRS9oAO2/u/3ZxP+bxKW9Wi/w7doBHQoxCQCb4bBxWlC6BjxXcq3qN8F8sPVbKolBa4kR3IpEubWwW6V63JWj8JG45ekoLm6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714200081; c=relaxed/simple;
	bh=33W6eirLBCEmMfk+RL9zaFETyXGRJzBbyASp8CnPpsE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=B4uyjX4AlHH7tIFO8d6pgtx4AzMPdIeoICXYOEnYebmvE9GCIP9Tlw4CNjlTwBSTfvXH2Ss0pRBRHK1L3aNv757klAcdoV92QTGa/m/Mktwb96n9MmaorwRunZb+W0Lj2PRxm1oCVXuxLkZ+N7pko91HjaKAwjNMO265GHfBd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GoYlWB6V; arc=none smtp.client-ip=203.205.251.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714199770; bh=X5DBZvPMjk/9nShMiTcsNTRbxldm349WVIluxfS6Ssg=;
	h=From:To:Cc:Subject:Date;
	b=GoYlWB6VR3FNmf1iZ0DGFU9kBwyLEJSS6fPDuzmZDhHh6ut6MbJB+kYugu+CNgUeB
	 X9TLSAFfatVNNoL7utR+dPnGWVeJKjsHiBr750IMZPPjWqCUPixt/G97q7QzwyzLlN
	 algXzPZHujqzJEWr5wJWdDc+YLgYC/13tF5lgFg0=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 77A02271; Sat, 27 Apr 2024 14:29:58 +0800
X-QQ-mid: xmsmtpt1714199398tq9lrmogb
Message-ID: <tencent_912BC3E8B0291DA4A0028AB424076375DA07@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTyHfvpZyEukJJaftmDSBmHLya5dmQPuN5OP4w6O8yn4Xa+KHxe7
	 0pBeg0y8gfl0tG1LF1PdSIwTVvFeTou/TwA8pOkUK3kWRxyXCa84XuqG6JypXzXvwisa/CP6VKZL
	 wfrhn2Cqh8toswp1ltTtpx5qVjfcy7b1WTfHrzCivn0m4RC3MSWeniilTDLX2ihiNm3HpkyQq9xK
	 peCsNUUQ+IzMnWENODCPKuxxLKuTz2H1uv48n3/b9RciEK68rNlKB06JzH4CgjOp6UJfGcQD6Dto
	 fYGxZA6ShZXgfI+lVc6GKr0RsdMcyyQTR7UkPHzw3W4BnLCRrzZ+af7j2J73dZGycj8TX4bNqHSx
	 LJ9hXt/P3mH9EAFPT3gASQvwd2acHzfEAqUwE+HueGHSHdWgjR8BYKhAOjz8HWtZzPvsqeeprD1v
	 Ag4efn9KTodE2HdHjLzvl9WdD8TgL73F58qZIrOS91b9Nwbo2WVUN/duaEjE5IUs9scZMo6sZUoD
	 uzi1jv+L8MCUMjUvYXLhGWnIaX9CdUp8FqBNo8yfdZk6Q3hD4/ef+C3imesa1H7VBdKRmErClDUV
	 7phGv54DufRGcuhed0Sv4qWQZghxaaiox0Zvr6OnGzZiKSY5CBv3VyyKS6ncYsG6bX0UGx4Y+Tje
	 rox5l3dzMJ9GFDsrCIZ5jdNEqTykGRk0hkDdYonQOZ8CFSsxDHjzP239nWg50hxtMwv8cq2W6nOX
	 uoMP98j00kdCTmhJokAN8N2ZtTEtFqo7bqznmRdrSBmkK3+DmeCMfWDynLJtVl37U6WULe2NgSjj
	 epUUIpnjdjDccFhizmMu9Vk5+BQ5MCRJRr10jJfGr1B/PxC4XiQk4+caS19shhtZRwwhF+orBYIS
	 Y8nnRk4yX0f7FNY+kBf0JvniQ+SDufgRF+GYmoP8IAhZWeloJk3jLMvCKPi5I93KjGgzXSdOL4XL
	 uGuF7WfbJYoEmryHPTYHQkbqWf/t49em8q1jbn3GQWhj/EIH15Bq2P40Wq+fa1fs7rSvm1ezryRb
	 jZpILpH6idUkOA7mY8
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/swapfile: mark racy access on si->highest_bit
Date: Sat, 27 Apr 2024 14:29:56 +0800
X-OQ-MSGID: <20240427062956.31079-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scan_swap_map_slots(), si->highest_bit can by changed by
swap_range_alloc() concurrently. All reads on si->highest_bit except one
is either protected by lock or read using READ_ONCE. So mark the one racy
read on si->highest_bit as benign using READ_ONCE.

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..fb2243f7f06b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -854,7 +854,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		last_in_cluster = offset + SWAPFILE_CLUSTER - 1;
 
 		/* Locate the first empty (unaligned) cluster */
-		for (; last_in_cluster <= si->highest_bit; offset++) {
+		for (; last_in_cluster <= READ_ONCE(si->highest_bit); offset++) {
 			if (si->swap_map[offset])
 				last_in_cluster = offset + SWAPFILE_CLUSTER;
 			else if (offset == last_in_cluster) {
-- 
2.39.3 (Apple Git-146)


