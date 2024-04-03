Return-Path: <linux-kernel+bounces-129282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CE896834
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320BC28AFC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018EF83A19;
	Wed,  3 Apr 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT3MiuUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7198060D;
	Wed,  3 Apr 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131701; cv=none; b=uB4kCn74HUO7fl3YOzzyoSvhb9g4xuwDQ8CWeC1QtEhbjCLPWZgFxdv4rk2A2VF5CF5Nin4P3NlOVGed2B49nSptYKUseE86vbZ8bwPqwgT2Y+MP45TPj5UQxyUYNFLftTDGRAEAtpyYJyvwPTIVyLPG9I5R31UuFlQi+ubHpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131701; c=relaxed/simple;
	bh=lKYFOQA74WUrBNKESAlJ+e055R+fsTrHN/bgM387ZAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJzvmH98dwSVvUePjqEKaj61G2RLSAflTspvoUU22F8AJx9xF9po4E5eOj2eKbpevzgSr98xNJ68By/s0bsML748M8xpUBpBKN0pOG4CG6hgwbh6+ZGI4nkffPoA+QgaLxYJXCBVfS09Hzk4P8Dne8v0wR/qpARsaS4LcC8VdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT3MiuUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AB5C433F1;
	Wed,  3 Apr 2024 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131700;
	bh=lKYFOQA74WUrBNKESAlJ+e055R+fsTrHN/bgM387ZAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT3MiuUUoRKbKfg8e79CuzUU5j8DeVThGzzSbXP7Tufl9ihYjw23nkR2j6Gd+bsfK
	 PmiK96NULKtD+T4PKVP4quu4w6VnbNK3ZmBfRcH+I5gCpO9m3IWlsbsUt2oaf+oqV7
	 m0rMmCJvslOmatp2uk4KVRu9lK9+y9jAU1UbL+SuNFtnW0wdQpSAhg0vZiuTo+PPHc
	 1ytWDH+QHejAcipmgYlY8tOIVRARva9FTd1Q9quxbwpC68c3HQ+5UfXWkdcakGg41B
	 evlQBxwb3xDk4fXhi8GcHRTntCZVcARhXa0mCemSvoT2kEXem8H5EGDhiGhBvSNjT0
	 p31fbxHliBgXg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org
Subject: [PATCH 05/34] 3c515: remove unused 'mtu' variable
Date: Wed,  3 Apr 2024 10:06:23 +0200
Message-Id: <20240403080702.3509288-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This has never been used since the start of the git history. When building
with W=1, the unused variable produces a gcc warning:

drivers/net/ethernet/3com/3c515.c:35:18: error: 'mtu' defined but not used [-Werror=unused-const-variable=]

Just remove it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/3com/3c515.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index ba3e7aa1a28f..4725a8cfd695 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -31,9 +31,6 @@
    Setting to > 1512 effectively disables this feature. */
 static int rx_copybreak = 200;
 
-/* Allow setting MTU to a larger size, bypassing the normal ethernet setup. */
-static const int mtu = 1500;
-
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
 static int max_interrupt_work = 20;
 
-- 
2.39.2


