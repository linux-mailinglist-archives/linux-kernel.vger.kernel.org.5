Return-Path: <linux-kernel+bounces-144073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA5F8A4186
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B9C1F2157E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3723749;
	Sun, 14 Apr 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="p2J3HcOQ"
Received: from msa.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273D1AACB;
	Sun, 14 Apr 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713086903; cv=none; b=rY6/RZ2YGO7vrM5ye+kgkUFPGeNXEa1eQegYy+coSImHHdu2ZZNKvh0rAO7W9KpE/8dWTPPIdMQyTdwkouKVXBZgvbpWxrsPAz3cvDccnosfwK1LT6umNGavxq6qN40dUMJF3oLPwt+cuyZ6iY67ps9N94BZe+yKwga1+3+kauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713086903; c=relaxed/simple;
	bh=SwFno6/zyg5+YPfqO27044qCoN7mde7l5fHl3+x/0MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zb0D9NSm1m7azgOsZxgUc3vn+A0h4JQdlcdXJrxKqIt0T7Ljx5h34IoUCK3WvzKwrgt422N9KuYfh+OOjqFgQUFzv9eWNRqopQkbpmLzN1Sh+pDSLTZamfTThVXtC9Q+G/+Uyt1Ky8+RN1jEKfv4N6htZVMhizp0U6HxY3t16Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=p2J3HcOQ; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vw9nrfdj8tTfTvw9orcZic; Sun, 14 Apr 2024 11:28:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713086897;
	bh=br64ne69Nk3JhZZXN1tyM5lQFY4iCsNufrWPd+JT82E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p2J3HcOQKImDyRyHCZqjWt5sZ1rfQObiAPANSd8CpT5QnEm29YQEtFJy6X2a21nxP
	 DCzIeSqld4PWTB+gk41ttlC1RDOevMPW1ZosyfrH2vCxQF5GdAGrHn7OHDSGSAbkRX
	 W6xNZesbTZPptSX6Q0aLkQTjmz1gSbOZuSlKXj0VO6xLX554Sh8aeX7HJacEE16zA4
	 CXYmRW6SUnCbrftDr0o8Q/Ra6SRV6/yuCSTKe1OKpvzYRRVaCmz0gZ57cEXMu0gATG
	 o5o+Xsr3FxTh5sXxCl+WPHquhykfUMDfzYWw1yEDndwvo4+NfMiNhttI1qgpvFztyP
	 Gn290icfctTJg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 11:28:17 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: akpm@linux-foundation.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND] intel_th: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Apr 2024 11:28:13 +0200
Message-ID: <2aca50a9d061faecfd4ded80b5874cd3be9b855d.1713086613.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch has been sent about 3 months ago [1].
A gentle reminder has been sent 1 month later [2].

Neither one got any reply.

So, I'm adding Andrew Morton in To:, in order to help in the merge process.

Context:
=======
All patches to remove the ida_simple API have been sent.
Matthew Wilcox seems happy with the on going work. (see [3])

Based on next-20240412
$git grep ida_simple_get | wc -l
25

Based on next-20240220
$git grep ida_simple_get | wc -l
36

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/9c092dc6db15984d98732510bb052bb00683489b.1705005258.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/994d0c38-6307-4da0-8e9d-c70972372149@wanadoo.fr/
[3]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/
---
 drivers/hwtracing/intel_th/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index cc7f879bb175..86c8efecd7c2 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -871,7 +871,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 	if (!th)
 		return ERR_PTR(-ENOMEM);
 
-	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
+	th->id = ida_alloc(&intel_th_ida, GFP_KERNEL);
 	if (th->id < 0) {
 		err = th->id;
 		goto err_alloc;
@@ -931,7 +931,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 			    "intel_th/output");
 
 err_ida:
-	ida_simple_remove(&intel_th_ida, th->id);
+	ida_free(&intel_th_ida, th->id);
 
 err_alloc:
 	kfree(th);
@@ -964,7 +964,7 @@ void intel_th_free(struct intel_th *th)
 	__unregister_chrdev(th->major, 0, TH_POSSIBLE_OUTPUTS,
 			    "intel_th/output");
 
-	ida_simple_remove(&intel_th_ida, th->id);
+	ida_free(&intel_th_ida, th->id);
 
 	kfree(th);
 }
-- 
2.44.0


