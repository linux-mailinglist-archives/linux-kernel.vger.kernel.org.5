Return-Path: <linux-kernel+bounces-162489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88B8B5BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E61C218B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323AF81725;
	Mon, 29 Apr 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="CXNBUgdO"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904087EF18
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402259; cv=none; b=haRX6ME3VkKmlvnQ/5zpo2iXA1F8jyY34G1/Eub1tKoShXe25M4TNicWxJadQAWtCwe7OqZz05PaubpIfQRDf2iFpS4SSPwSFqtnf7FMZhxnbJ0GBQQ4UneO/aYqsywUofFAZkS9eABANn6i4e1KEkjcDTc9QcR1WTy9DbvFMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402259; c=relaxed/simple;
	bh=LPUEFAe2CFZFvNUk6/2zfnIXl6UTcgi77ORqhlB5NFU=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=MZnbEX1YKvRm252++bu7POu7XWUqoIMJ4Gx4vnwDciS1p+CP1MYXND9WUCbvaDbDEOcHRb+qS0z5PV4l5jFjN+5PSpNbvrUQrLf4C4xD3Lvzwn/lG0qhEFM3kfxPo8p8flQEwrBhTHkHsl/I6ZajSd8VVyDvhVrCkRSnhsvN8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=CXNBUgdO; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401928; bh=LPUEFAe2CFZFvNUk6/2zfnIXl6UTcgi77ORqhlB5NFU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=CXNBUgdOn5PNXgtyDNwXHO8yQOrEkUxX54+HLpUqqlmPCxNpmwaO4VcqfAGzitumj
	 kMM5ltDX112P8EZk7MFGls3nhyXJfeysaS1C5DXOir5WwYRJQNTsOPeH8SwrTjsJil
	 mnCcRq1nZd2X0FNGxsZd8xfDXdyhvLrKGbEC/g3ahNDVr9CbUuGpW+rqZkBDwMa5S+
	 rxtxcee5ggpTAKmyCrkmKryRC/qY4V4QOkaRIs+YVqCDffKcY6zU03+hrs1Avpl7qP
	 70ULbKdGL5+YBiSjD6IOORV1mbCgIQpTNvAhMVr2yYSjmSmyqbmFtaIu62fWrvJft/
	 Nii0ChNLj3/Wg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMr0vyHzBL;
	Mon, 29 Apr 2024 16:45:28 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:27 +0200
Message-Id: <17f0bcb197b82e6a7bd8860178a363c96f85572d.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 02/12] regulator/core: set_consumer_device_supply: remove
 `has_dev`
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

`has_dev` is only ever used once to check if the name is non-NULL.
Inline the check and make the intent obvious.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 62dd3ac19e6d..5db3bf08145c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1738,16 +1738,10 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 				      const char *supply)
 {
 	struct regulator_map *node, *new_node;
-	int has_dev;
 
 	if (supply == NULL)
 		return -EINVAL;
 
-	if (consumer_dev_name != NULL)
-		has_dev = 1;
-	else
-		has_dev = 0;
-
 	new_node = kzalloc(sizeof(struct regulator_map), GFP_KERNEL);
 	if (new_node == NULL)
 		return -ENOMEM;
@@ -1755,7 +1749,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 	new_node->regulator = rdev;
 	new_node->supply = supply;
 
-	if (has_dev) {
+	if (consumer_dev_name != NULL) {
 		new_node->dev_name = kstrdup(consumer_dev_name, GFP_KERNEL);
 		if (new_node->dev_name == NULL) {
 			kfree(new_node);
-- 
2.39.2


