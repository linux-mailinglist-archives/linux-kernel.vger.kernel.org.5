Return-Path: <linux-kernel+bounces-157168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B4E8B0DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8ADB23612
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0450415F413;
	Wed, 24 Apr 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ojYUiW+j"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196715ECFA;
	Wed, 24 Apr 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971445; cv=none; b=hMohp8le6FvV7CcLNwSIBy64qcGtE1U0MaNWwH7gvHnMu0ZGAc94mP82AF2B0Q6MjIXyHMPKJPdr7kuOWwtK9TBvP9y7Ps8n3uAXY45DnbfkrWQdvDKdtVgDLk/ApWajEA7YLcKfj4qhLkyCxh4Dc0m+a2JW9TvK4phO5N8sPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971445; c=relaxed/simple;
	bh=GFl2gu8Goy0sQALB4lF37DA+Kra9rUwAZesJFurH4rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfQ9efHDCjULwkptqB7+zUc+YCA3L2oXNfVWGAKa1EtIvlasNzmj941CxT2u17TA6aNbzmxUanQPE5PUSsc13LkBFrjKfF/1UganpatyTryTyT414g4L1nIhNMr7j6Z5D3WqdeodzXdemX31B8oeJ9N4F+r0SdZI9hYmTeN2uRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ojYUiW+j; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zeGYrqtWgiGtUzeGYr9Zdc; Wed, 24 Apr 2024 17:10:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713971435;
	bh=52xXeYcoGXz0lSYfxzazhbEEwDc4t9B8gSUrHzsiJZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ojYUiW+jkhTC2+vHxP5BROWhlLUgGzgMGXDqSHxECTHdhp9qv0QpvOnKeH/WJqM4U
	 JrH2nDSMqjfAuk7z+iJWsbs9HMg9WJbeIYVU0V0gNt6G28+GJEyO8/pCJO6+f5tMEs
	 lIOTu4n+By+gmnLool45OGoCGMksgA6t8NVhxTkTIYBrFSq3Smt3K02kTxlc9ADJLc
	 1AzXM7cIqHxiTmzQS2pSpAgLLsu1YoEyRGrGSv9xLq5HvGNoTrDpyZp+dU3eKbQXEe
	 jhnv6iqZdQfNWCwzkZ/N2ycq5oyLKzG3JdhHvMs2os4b03GePA1JC7JE1vSJsfv+ag
	 EDwtPNlpG6u5A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Apr 2024 17:10:35 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] mfd: ssbi: Remove an unused field in struct ssbi
Date: Wed, 24 Apr 2024 17:10:29 +0200
Message-ID: <8a76de25cefb533d94dfe35062bbd9a8e72f4bb9.1713971415.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct ssbi", the 'slave' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This is a left-over from commit 97f00f7120fe ("SSBI: Convert SSBI to device
tree")
---
 drivers/mfd/ssbi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index b0b0be483dbf..f849f2d34ec7 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -64,7 +64,6 @@ enum ssbi_controller_type {
 };
 
 struct ssbi {
-	struct device		*slave;
 	void __iomem		*base;
 	spinlock_t		lock;
 	enum ssbi_controller_type controller_type;
-- 
2.44.0


