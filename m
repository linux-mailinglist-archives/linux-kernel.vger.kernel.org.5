Return-Path: <linux-kernel+bounces-105149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FCC87D9BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285C42820C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9B17984;
	Sat, 16 Mar 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oktPMqE9"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C7D27D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710584185; cv=none; b=sbQ7Ovq0lXTgNLQZYmnaTuBUaL1xCUzu2IoMq5rTsiSjZFft/DcNxf/N8bD+SmLz35nHCIOUopl1MU1QSQvNEjcfvGZsxlpMTxt5jdAGa9Tk2iangDPnoZTsqyhRQVS0m8hytKPhO1+QvnGW23nEBE36UNIpNeMIdn8+EizPn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710584185; c=relaxed/simple;
	bh=U28zfjF4OS2fGHai986hSwR2HqlyXw1brLjxlL3M6aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b48e0FJXALESduDmVNM30GCwBY8A6RSY+3nmwwoX5MtT/l26LEMLnG1kDC2ivo/mKQkhymZhyib5Dg1FFMoSgLoTwzA4nsUmH96YTcQwcXo6A8mSMsfYcyLBrzfsLeHOITeT5FHvQa8UFR6870njMZRVs2iOj1Q+96xo5ImLE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oktPMqE9; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lR5Irs5a0OyIKlR5Jr2quP; Sat, 16 Mar 2024 11:16:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710584174;
	bh=OSlR5GvDt2806hNeUTYx8/WT+aSfsQ3aAdO0kIWpAbI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oktPMqE9K76+qTe1SGAycahtUVr0fDUnE20/jtLH0fnfbqvFqpIGtRqVuLnR0CYoj
	 c1xfGyUUbacK6ljMlo8X25MQpLSXBr+2MZVVK2DAvT8IgAJ6MSFH8Gc1hYQH0sbShW
	 CRv9uOdqlrGI+0/hePANK4PIdVjHvGRq1WL7NIsyd94RzPZmt3utmYd+Vvdw4lYZ+p
	 OR1TKdnW4UhODYadew31r5kWXmSuEMdvFVDbdyrseHsyob8WOaALvOgf8mGqop4GKJ
	 +OmmZ/CuRH8eTXWnE6ZqKQ9iakDpuk57RfLzUwrpPLHVRHMKeJpHf7rP/NCX874O8J
	 wf/njDAC6zkzA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Mar 2024 11:16:14 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Date: Sat, 16 Mar 2024 11:16:10 +0100
Message-ID: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
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

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/caif/cfctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index 8480684f2762..b6d9462f92b9 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -206,7 +206,7 @@ int cfctrl_linkup_request(struct cflayer *layer,
 	u8 tmp8;
 	struct cfctrl_request_info *req;
 	int ret;
-	char utility_name[16];
+	char utility_name[UTILITY_NAME_LENGTH];
 	struct cfpkt *pkt;
 	struct cflayer *dn = cfctrl->serv.layer.dn;
 
-- 
2.44.0


