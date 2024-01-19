Return-Path: <linux-kernel+bounces-31209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D6832A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6FB23A33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949352F70;
	Fri, 19 Jan 2024 13:36:42 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4204CB5C;
	Fri, 19 Jan 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671402; cv=none; b=Ey6F2roHftg0/Af4t0CLuUg9pE1MaiuHW2jOo2RUga41r+sZ+OxKU4P8BvonJQs7iKFC+UzxcbAFkty6LjfSyNQngg3RXG5G1DGNsPX6Wr3rVdUVhqJXkf50gIFF6Vi5Hm1IMR2jqKHRNPgu8xH3W/fwaKbrCmjBHB339Gdp7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671402; c=relaxed/simple;
	bh=K2zoFDuph9hofj7/rftY6gDK/TOENrkXlqmOUpQDQps=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=F5spwz4+AGEqHruE1bK7JgaPWpuNxmUXpMspOca1TsVrlCLK3cwV6yOuUfOVwJDOT3yOMDUQDoSXAbozdVGJsmyEp1lEjumo9hS+FF1vKtP5sg0JotrMB1Qb5YdqDasl8q0juElbZLhskISyLp5xt9KTYrQkoFW2QvQe+VL+jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=fail smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alpha.franken.de
Received: from hutton.arch.nue2.suse.org (unknown [10.168.144.140])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6582F1FD17;
	Fri, 19 Jan 2024 13:36:37 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: fw arc: Fix missing prototypes
Date: Fri, 19 Jan 2024 14:36:34 +0100
Message-Id: <20240119133634.96420-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.96
X-Spamd-Result: default: False [3.96 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-0.79)[-0.791];
	 NEURAL_HAM_SHORT(-0.15)[-0.735];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Flag: NO

Make ArcGetMemoryDescriptor() static since it's only needed internally.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/fw/arc/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/fw/arc/memory.c b/arch/mips/fw/arc/memory.c
index 66188739f54d..fb78e6fd5de4 100644
--- a/arch/mips/fw/arc/memory.c
+++ b/arch/mips/fw/arc/memory.c
@@ -37,7 +37,7 @@ static unsigned int nr_prom_mem __initdata;
  */
 #define ARC_PAGE_SHIFT	12
 
-struct linux_mdesc * __init ArcGetMemoryDescriptor(struct linux_mdesc *Current)
+static struct linux_mdesc * __init ArcGetMemoryDescriptor(struct linux_mdesc *Current)
 {
 	return (struct linux_mdesc *) ARC_CALL1(get_mdesc, Current);
 }
-- 
2.35.3


