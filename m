Return-Path: <linux-kernel+bounces-133460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB989A40A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A78F1F233F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212117279B;
	Fri,  5 Apr 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lkTgAZOC"
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BC17277E;
	Fri,  5 Apr 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341103; cv=none; b=N4mYQfwxE4ql/UFPnBUMx/l1iPM0nzTwvAJconZ2LkHIJ1c0Hou8grae224g9ya2NW4aXJWAC0Cn3pmXQB6eRyzeEgQYtxJTzdS8ouAOGIJYxYaSeoNtmRHkkt4fTE42RW4b9phuqpJNyxWCT572Q0/KoTilOlEhFUlDutINc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341103; c=relaxed/simple;
	bh=cvs/43SwtLRtedcsO543rgUvMrFflja1dGXNQx9R344=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJPgNLkb2Dn1CV4p1WCwHCbGSc6TCY++D2ffXiOEl//avpCIWR9DmE3HHQOK89jH98qdWR6g1gMv1GlCR/7a3LrIM2BOAiBl68csoO/dk78FTJgZgsRzkZhSF+RU1PLVe4RMaaitte1HP9xcN6aWpH8HmGLw0wj75Pd5DMecwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lkTgAZOC; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id so7frCyNy41mCso7gr3bZJ; Fri, 05 Apr 2024 20:17:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712341028;
	bh=CBOkN9rmFPDZtUIpA+M9rXhLCZmZnPuzbOdFADzAiHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lkTgAZOCcEfDQ6oFnLdPtpbDX3pQNJE5xRzadS8UtdiIVUW+JpWKdYOywrEp0LFns
	 1M8+YXAffelLS48FIErg2gSVHJS+vxT6xtJfEF1OEIOQ3gPk4IYsAZEYkTo0HTr7cE
	 7LT1vBFXD97HtS5IVWNigCSzRk9OBpRSmOPvsTfs9ok8+JQQSCt6togt8evYjq0LsT
	 jkdxr5HXJH2VQKEXwbuHRyMXWKL4VVlJ9TWkpytUrdSiVMJBTWxVgjxve2TsA5QRsK
	 cCqp7kPNj4FYzNODtt8cF9vi/SnH9G8nvFEYlBSC9v+8x+ZHHhkWAoRatIb3jlwR2V
	 Rk0Vvb+rxDpQA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Apr 2024 20:17:08 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Remove some unused fields in struct pci_epf_group
Date: Fri,  5 Apr 2024 20:16:59 +0200
Message-ID: <6507d44b6c60a19af35a605e2d58050be8872ab6.1712341008.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct pci_epf_group", the 'type_group' field is unused.

This was added, but already unused, by commit 70b3740f2c19 ("PCI: endpoint:
Automatically create a function specific attributes group")

Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/pci/endpoint/pci-ep-cfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 0ea64e24ed61..ad4e2e329ae9 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,7 +23,6 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
-	struct config_group *type_group;
 	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
-- 
2.44.0


