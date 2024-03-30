Return-Path: <linux-kernel+bounces-125617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBF8929B5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EE8B22449
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5CBA26;
	Sat, 30 Mar 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="j1aCOlEw"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CED881F;
	Sat, 30 Mar 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787619; cv=none; b=uHKInowc5QXZTdrGWSIcO1HyNtkmN/yXJf6teQACgNnAOrVX0WD4ZHeqR1u24I5RS2YXjouYaPoh9lWdEa/mB8bHZv47RxEJNI6jJwR/S8eXJzxNXXZQn3TKAGGaR891zFa0B354Pf/FTpkY+VOleJ8f6zZ5kCjJl+iUo58nkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787619; c=relaxed/simple;
	bh=NnGqycWyMgrqtn4VdYQ5lLrY/jrFOUXth/lMty4JYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc5Wq0X6t9/HKjHv7+OsBYJHgS5uC5wJbhTuMvLle6eMIUemfPDnMn2/KPObue5FVnZuUj0kzsJ+V6r6+kUkz4vB6y3xwKd5WWBs0DGyG3SFtd9lAsQVfgBqnTTQ0BigN0qAPz/AvU2GXTGFiQ4GeXgZqYjAPc71T3QTMLp/C4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=j1aCOlEw; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id qU8Rrc5yvp4zMqU8SrdPqN; Sat, 30 Mar 2024 09:32:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711787541;
	bh=W45diehFRu0ilTy3yuLbniJUjWNxtFJBsavO8BYE9DU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j1aCOlEwaqP6X3Kc2oB+BS0/FjHi9NYqu72fOLHMt60i9oCMlvfd28cTRXXjCmMna
	 IrzUx3b0TbYkGaVXr10a4dzj4/aAVz0EqKP42YqmiSaQXDrEE9cgeqgVwM1tZuIL1/
	 7zdmEKZylV928aOgF5ltoCVKQ4pg4SkMOrPBVIFesZ6Rj0KMHVeXSg+Lf/neZDty3/
	 +gb4O+iQmJ/lxHcctOKlw0OKsglVHwJ6Oesq/qrmZAA+N4xSyKZKLJ7G6ZkalID+hD
	 KkQ9af6ngzwIjF7L5BVZOa1ApDJXX8IFZ599QOycC5h/uy30lk4gMxPGX8j9ZjE2t0
	 7JqztYzCMuEUQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 Mar 2024 09:32:21 +0100
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rkannoth@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Date: Sat, 30 Mar 2024 09:32:12 +0100
Message-ID: <8c1160501f69b64bb2d45ce9f26f746eec80ac77.1711787352.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UTILITY_NAME_LENGTH is 16. So better use the former when defining the
'utility_name' array. This makes the intent clearer when it is used around
line 260.

While at it, declare variable in reverse xmas tree style.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
  - Declare variable in reverse xmas tree style [Ratheesh Kannoth]

v1: https://lore.kernel.org/all/af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr/
---
 net/caif/cfctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index 8480684f2762..20139fa1be1f 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -201,14 +201,14 @@ int cfctrl_linkup_request(struct cflayer *layer,
 			  struct cflayer *user_layer)
 {
 	struct cfctrl *cfctrl = container_obj(layer);
+	struct cflayer *dn = cfctrl->serv.layer.dn;
+	char utility_name[UTILITY_NAME_LENGTH];
+	struct cfctrl_request_info *req;
+	struct cfpkt *pkt;
 	u32 tmp32;
 	u16 tmp16;
 	u8 tmp8;
-	struct cfctrl_request_info *req;
 	int ret;
-	char utility_name[16];
-	struct cfpkt *pkt;
-	struct cflayer *dn = cfctrl->serv.layer.dn;
 
 	if (!dn) {
 		pr_debug("not able to send linkup request\n");
-- 
2.44.0


