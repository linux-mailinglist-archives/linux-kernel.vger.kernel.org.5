Return-Path: <linux-kernel+bounces-165293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3A78B8AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9928486F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48412A173;
	Wed,  1 May 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Vxryiura"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862E152795;
	Wed,  1 May 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568144; cv=none; b=jFIfFlc6Qs+MAUP+FpxA9yxui4u5joIg6YQxelPaRJf7WT5BRxxI2ZkrR7b3hH9LUMgkiFAfOWP08B+a8xkamFt/D/qSbzoECpUTo70Jwg42dNZhrz50H93SxsVM9Ta0qBtfrKWqELH97x6F2aR0e1WF14hppkeHuFjmZ4p+6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568144; c=relaxed/simple;
	bh=NBgYdcHUCJr2zggLECCR21wmsZRkdOrh4ygOHWbMBS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUZQ7vQj8v136Vj3TOuqqr0YaO7k8/7GbrZJ6OJnKttT3Pgh70aUUTHJ+VgQ13KACGdfVdmUcTfBqdanSLSxJ+yHHATZ8QqvFKft6ZMDRrPeW054cSlmCIHuszIjc04rOyv+80DVgoy2JK4uyWUEDBjrl7SLkaUR1vf+Mwokt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Vxryiura; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 29Uesw7dCrs7M29Uesx1c2; Wed, 01 May 2024 14:55:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714568137;
	bh=ifjDig8VZYbrit5qHyl96IjDpPnIKF9bUdbgNbDrla4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VxryiuraRCb6MD5kJqlKoAh6UecY/ITM0dK/ouJipgfYDtNNymscBI9/JrgbOcrc/
	 A+0pilTBHyd5yZQGss4dnIeUUgHl9D0yGaexL+HdwZqxQosX2oXjr3YHstLwZbuzjc
	 aV3AbhP+lTRtuXapLuzxk+m3Z8zJFACx818ILEaCpRsSlfeaHrWoM3JRWL7B5LdZWW
	 KA95KS3MXD9HhQ6iXC+0hrM91jZekryfeboH4OGOCZkIxxko8Xs2tZilNxz4c77hGn
	 5hMXMn/QUQzhO7PFX3OUIG3pobi2VcHhwswRB0v3MA8jvJxA0MkzU3gInFOnPaK2o4
	 ilwenAetXU6TQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 14:55:37 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: gp2ap020a00f: Remove some unused field in struct gp2ap020a00f_data
Date: Wed,  1 May 2024 14:55:17 +0200
Message-ID: <57e9f29c7062d1bb846064bf6dbd7a8385a855e7.1714568099.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct gp2ap020a00f_data", the 'pdata' field is unused.

Moreover the "struct gp2ap020a00f_platform_data" is defined nowhere.
Neither in this file, nor in a global .h file, so it is completely
pointless.

So, remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit bf29fbeaa13d ("iio: gp2ap020a00f: Add a
driver for the device") but was never used.
---
 drivers/iio/light/gp2ap020a00f.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 9f41724819b6..9a476697aa1f 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -237,7 +237,6 @@ enum gp2ap020a00f_thresh_val_id {
 };
 
 struct gp2ap020a00f_data {
-	const struct gp2ap020a00f_platform_data *pdata;
 	struct i2c_client *client;
 	struct mutex lock;
 	char *buffer;
-- 
2.44.0


