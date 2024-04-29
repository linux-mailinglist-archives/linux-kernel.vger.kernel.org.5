Return-Path: <linux-kernel+bounces-162476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B999B8B5BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762452819A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0483CB2;
	Mon, 29 Apr 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ff8RvQJf"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91180624
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401941; cv=none; b=jRCVTWr2rWMeGta7guolOr5kmlfEN91wvPxQbapSFIiQxpnHXVEs6yLpxBrqv8kiAUP4iaUVBhdiGbg5bXNPyPl+81gxcl7bcu5ZxbhYan8LnKTVKJ/eIvTM7qLOKJqcws3uhRCPP02Gr8QSKuzUgcInKQqyNaivGRN4Ze5Z/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401941; c=relaxed/simple;
	bh=SQFjFnDvj4pBVC5wVcGxU/7jwPxTwAo0q5RMDCeQAH4=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=kfjsIT/5rW1V9Y8Nt2YtjVaJV9H+Nxew8V4Q32ZrtUpEr9Ai+gsN5yDbOOvuIVEMQvuk3fmyeWBrR+HZOQaUQXcKlb7Gf3ugQyVZnBRxyyzt7HhnzqU+U6VsAChf06DZ/kSP4PSQ1iVTdMEF2GtKM4SVx7gVrjVCZxFT1ODGFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=ff8RvQJf; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401931; bh=SQFjFnDvj4pBVC5wVcGxU/7jwPxTwAo0q5RMDCeQAH4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=ff8RvQJfgPFfPn3n24LNh7YmnyyvRDaQfxk3WY6L3jXeNXHFfERWjsGno2mQ/BuJr
	 YFuVwwptDS9hNmqExoO14nmqD6mpb4RTF6dsnSB3n6Ue1m2wWzquBec2KpCtScaDW1
	 Ts1XsxxhPbQNIa49oY6O8jMeZPEg81FsRfn5RUNpktsQ9Jse55xP4PlTkkW4TK/x5Z
	 0piKBUn5ngKrY65OK67wmi9LmpXNfX4VbuQerQ5RDSLW5qMFGCe/lX5g9C7qJwolJU
	 KFYdGSkLlDwQUhA+YqdtGJk18CDz1olvhq++djjwxJGXgtlo21EnYYu6ngUh0c79MO
	 rNp3uu+duAgdQ==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMv0rxTzbm;
	Mon, 29 Apr 2024 16:45:31 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:30 +0200
Message-Id: <92a354a86ceb572c4fde35047177c5681d83f81f.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 08/12] regulator/core: set_consumer_device_supply: avoid
 copying const data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc:	linux-kernel@vger.kernel.org

As consumer_dev_name might as well be const, don't copy it if not
required.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index efb68a5c85af..431e1c164b11 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1747,7 +1747,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 	new_node->supply = supply;
 
 	if (consumer_dev_name != NULL) {
-		new_node->dev_name = kstrdup(consumer_dev_name, GFP_KERNEL);
+		new_node->dev_name = kstrdup_const(consumer_dev_name, GFP_KERNEL);
 		if (new_node->dev_name == NULL) {
 			kfree(new_node);
 			return -ENOMEM;
@@ -1782,7 +1782,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 
 fail:
 	mutex_unlock(&regulator_list_mutex);
-	kfree(new_node->dev_name);
+	kfree_const(new_node->dev_name);
 	kfree(new_node);
 	return -EBUSY;
 }
@@ -1794,7 +1794,7 @@ static void unset_regulator_supplies(struct regulator_dev *rdev)
 	list_for_each_entry_safe(node, n, &regulator_map_list, list) {
 		if (rdev == node->regulator) {
 			list_del(&node->list);
-			kfree(node->dev_name);
+			kfree_const(node->dev_name);
 			kfree(node);
 		}
 	}
-- 
2.39.2


