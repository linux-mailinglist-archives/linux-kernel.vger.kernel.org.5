Return-Path: <linux-kernel+bounces-31751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC54833370
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DE1F22325
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E8D28F;
	Sat, 20 Jan 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dlikXYNv"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFAC8C4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705744574; cv=none; b=eFgHhZdh0YevGmBnE+cQsa5TU82vPVOo9Foi3wE+i5zQfwbV8OjoWtGU7Nq0uTwY0NW2/gba/wLBqdF8BVViwyKPXvN0fAtJ9gh1tAhvY2oXHvxUIG3PGVAm+IbEJgWOlKgNqMmUoogd9JyS6r9sGkKFc00qNJkQtlmaeGERKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705744574; c=relaxed/simple;
	bh=BOcX8KWEnibygk4fjeA6ev0h6FDA5vSRBlJ1zvGoVtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzTyNsv8bgg7L+9H4yn6t80c44ZLGqR4e+3Rkhjv06K1/SEbf25C0NF67r8EQ+9Kqurzy61iXqGrlDZg2ljrpfSWNWqgJxTvWNy+hL0W3B30g75IQ8hmrStubXip0pciLsUGjOHttOv0ss9htB9VHVfitOrYu50X8ercW8/jhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dlikXYNv; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id R859rc6amXxngR859rqY8F; Sat, 20 Jan 2024 10:56:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705744569;
	bh=6/Q426ZzIQUJLm346t0hoGiEGD7EVC/MiQvvpwN1st0=;
	h=From:To:Cc:Subject:Date;
	b=dlikXYNvorCGCI/zMlw+kQotCzT38LYn+0/29+wiIY+D+2X0okIBuyhrqgbaTeGCE
	 MLiREdT44J3NpJ91NyxVIJW5JAzfiezWkZW4GDFgFi821WNWYGUbNzWWzbCRr6ufYm
	 nGRStL1OW06bVoduZxNUjOatbL1M7gBTMsquonPrYmJ8uiWol4sU8cEu5fBOY5BxSc
	 CnCYtDo7by24j06iVPoUz84OMhcVsDts9s9FXWA6xOikHfBwJTEDzltFQsJGbcw/OD
	 QV3w9sOphKFjXX8Jl8b7kqp5BChAZd90U2SLDORzsqRgQMon3hYjIng0NZ/wx1IDUs
	 gSdpIxW6k/3Dw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jan 2024 10:56:09 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
Date: Sat, 20 Jan 2024 10:56:06 +0100
Message-ID: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llc_register() calls pass a string literal as the 'name' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/nfc/hci/llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index 2140f6724644..8c7b5a817b25 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -49,7 +49,7 @@ int nfc_llc_register(const char *name, const struct nfc_llc_ops *ops)
 	if (llc_engine == NULL)
 		return -ENOMEM;
 
-	llc_engine->name = kstrdup(name, GFP_KERNEL);
+	llc_engine->name = kstrdup_const(name, GFP_KERNEL);
 	if (llc_engine->name == NULL) {
 		kfree(llc_engine);
 		return -ENOMEM;
@@ -83,7 +83,7 @@ void nfc_llc_unregister(const char *name)
 		return;
 
 	list_del(&llc_engine->entry);
-	kfree(llc_engine->name);
+	kfree_const(llc_engine->name);
 	kfree(llc_engine);
 }
 
-- 
2.43.0


