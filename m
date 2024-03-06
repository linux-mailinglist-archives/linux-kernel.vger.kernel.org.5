Return-Path: <linux-kernel+bounces-93706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E3873398
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6DA1C2516F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781595F848;
	Wed,  6 Mar 2024 10:07:15 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 49C275D8FF;
	Wed,  6 Mar 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719635; cv=none; b=pvlpWLkX91d+Rq6ne6+X4RR4MFFB4+rNah0GKBK+o6Sf450c1R5Pnpz0wBCltkN1cWpKrTq5ObiuhOGGWozRFc/4MSa+B/z07jjLzghdkzyP2jL1ftou2m5jlDk6ivrbac3nihOmcdOjhDzsl5/yL43kY7kpVwkplq9M4puDKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719635; c=relaxed/simple;
	bh=SPyotqgd+ZQ+ck8sF39EEIx+dSieElGkiTrHdYt1FxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kbKeOqwoGzzPcEaOJMLsCq6JBEywpoJgOJnjyIiIC1z27XHFrrd9iehPTPcGE4hpOe0A/to3sIjRNoBLqzMguc6OkCeI0mcAwe0fQFQjBsTcBoCzTuGADQsH7DxcZly2UeFWyzPyI5ffz5iWbGL1aPxkn6p1fyIBg+iMA5CdhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id CDE2060301EE7;
	Wed,  6 Mar 2024 18:07:06 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: jonathan.derrick@linux.dev,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?sed-opal:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20ret?=
Date: Wed,  6 Mar 2024 18:06:59 +0800
Message-Id: <20240306100659.106521-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index b6887920a84e9..f62b7ee933f7f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2576,7 +2576,7 @@ static int opal_get_discv(struct opal_dev *dev, struct opal_discovery *discv)
 	const struct opal_step discovery0_step = {
 		opal_discovery0, discv
 	};
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
@@ -3065,7 +3065,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 {
 	struct opal_suspend_data *suspend;
 	bool was_failure = false;
-	int ret = 0;
+	int ret;
 
 	if (!dev)
 		return false;
-- 
2.18.2


