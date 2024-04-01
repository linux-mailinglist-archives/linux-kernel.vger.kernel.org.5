Return-Path: <linux-kernel+bounces-127056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B76894646
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C1F28225C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB3E54FA5;
	Mon,  1 Apr 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="byCKusv8"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E04E1D5;
	Mon,  1 Apr 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004616; cv=none; b=oQIcSQFbIFEyz/y7l6E+9vQYU/hZlqw9CVbjtc7fSE6yCg5KgEyeLhmWlg4oEnTXXl3OUM3NMazV8uh4YT64qCNE4KMZAwY0v6RN7o7/iuzvzNOhEWFfm6jBa9+v7/zJLRNXAdA3noFqUgtqAjI9t/RGNP3Z5xKpaq1aNyGGn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004616; c=relaxed/simple;
	bh=VKgxvyuMDn6pPuzrSQH/fyXU71CRcxvmHV5mShrhvU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srOgBqivxnNESPDECyDSDCvFNvTQ95lxotCoMfaD6X+scOUE9hgVl4XNHeKCJSYYXpI0QC/5CCtAS5K4bXKXh9OLTiBUTrj1A2hJIAgQ+xts9jhUu7v/x1l3vVDiwEU3qZYKO6HhFE2XXOQKPpLuj8YHp4pUwjtQ9cdzyaSdYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=byCKusv8; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rOaSrTguCRo54rOaTrI000; Mon, 01 Apr 2024 22:49:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712004543;
	bh=VPi98jZXacwHLVzFnIc7JUWg7LJMcQPKff2POQefCl8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=byCKusv8wkGLaFBaQFNvZ5G2kLW3RWNvThLQQygSe4RTcCOdA6jG9JascXZynUFlZ
	 MHXcF1oKKwslBSp5r+R0wD5D2YuhMvCr7lGoKdOnifttuEoe/S0i0zlBhJWsVJP/rC
	 Ae/+eVgT2pCScoEUlXmec83fcVkBjYQDm+kEQrI3vsilo5u5jybTmI4yZ1bdsf8PjL
	 /CyUHTq4djDRlTVdRkS6Gy5GNOSOR5bLFdumIV2wO+FxQ8+xoAoc3YrvK2I3s3PoJ3
	 xUMyciEpw0oZ9v3rYfcDWSu/n7ijHBVJXXzNJUwcuvFbNAUseeMS5g422Tns91Eq/f
	 YTR7sA2fxIR9A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Apr 2024 22:49:03 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: pinctrl-single: Remove some unused fields in struct pcs_function
Date: Mon,  1 Apr 2024 22:48:55 +0200
Message-ID: <a6b653642298d35b1e3656e9bfc6d1b322fbbe68.1712004518.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct pcs_function", the 'pgnames' and 'npgnames' fields are unused.
This is a left-over from commit 571aec4df5b7 ("pinctrl: single: Use generic
pinmux helpers for managing functions");

Remove them.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/pinctrl/pinctrl-single.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 19cc0db771a5..2261d4663d19 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -81,8 +81,6 @@ struct pcs_conf_type {
  * @name:	pinctrl function name
  * @vals:	register and vals array
  * @nvals:	number of entries in vals array
- * @pgnames:	array of pingroup names the function uses
- * @npgnames:	number of pingroup names the function uses
  * @conf:	array of pin configurations
  * @nconfs:	number of pin configurations available
  * @node:	list node
@@ -91,8 +89,6 @@ struct pcs_function {
 	const char *name;
 	struct pcs_func_vals *vals;
 	unsigned nvals;
-	const char **pgnames;
-	int npgnames;
 	struct pcs_conf_vals *conf;
 	int nconfs;
 	struct list_head node;
-- 
2.44.0


