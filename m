Return-Path: <linux-kernel+bounces-162477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818F8B5BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDAFB26202
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D583CDC;
	Mon, 29 Apr 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="K/6yZKWl"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5780630
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401942; cv=none; b=MysiyK6O1QSwB6h6VBoNwh+Qt8zxB6Bpi4BEThgGq7kElAY1e3BU2o1Mj9wzNP3dhGCZaLVEmUleZanqAcbeNgn4+jIVU/mbR02jvVJv/leQ5jFcxCVPaEnnFLZAKtbuRfBxDX7vwqUWfxg2dkgJaXpqUKpsE5jxRrQ6EHDMvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401942; c=relaxed/simple;
	bh=k7yssPLl4cYxHXyuaFfTk1eIg9XDOAgEkwYZs+A/6+Y=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=Upo9rjNLD8poYag7dp059SOqFWtZ+ziX96y2XY2AF4bmI11mGNzq9B90EWyNqHxFyzZ3VUMyRLUM8WLlwe92xdstpc1PTnSfRMphyj2xdFDVu5EvFkb8/h6P1wUplS4cYa3xu+gIBgc6mKGad91I77PTq5KJsBN2gLpaFYD6P0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=K/6yZKWl; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401929; bh=k7yssPLl4cYxHXyuaFfTk1eIg9XDOAgEkwYZs+A/6+Y=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=K/6yZKWlXnXuIAKoHr8Up9gv8Xr1P9W4PDTG7JgJoiRBvl00GyLGx8jdDUfHnFTlb
	 JgIFTglD3fLXds8DHiufcvT4RF9DF7XNXdtsnT+sCLJEGzXLnjKWGpV3iytmFBJK3w
	 yASZcniKZ8d9qgxf0S3xMjICRi7clmRUQ7AE1bpedNPviPbsskDL80xX7GaxD6sVn7
	 zAdS4iP6GBOYaDqSQxq6xwUyoICJ7D8oK0LWN240MPqhk8wuCsOJvqx/9XBWkVZXEf
	 hJl3MhDbym+ZaSEWl7N2V9ZP4jt9j1sium6WqLffrI74nLhK0OsLGcqXLfsPo0l95v
	 sXjXGztBpywKg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMs287zzFK;
	Mon, 29 Apr 2024 16:45:29 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:29 +0200
Message-Id: <43306deb3b0200298dded485bfa4057f37f1e7a5.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 05/12] regulator/core: regulator_ena_gpio_ctrl: pull in
 ena_gpio state handling
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

Deduplicate `ena_gpio_state` handling by pulling it into
regulator_ena_gpio_ctrl().

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a1573a7ff2b2..4cb30e49c03d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2625,6 +2625,10 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	if (!pin)
 		return -EINVAL;
 
+	if (rdev->ena_gpio_state == enable)
+		return 0;
+	rdev->ena_gpio_state = enable;
+
 	if (enable) {
 		/* Enable GPIO at initial use */
 		if (pin->enable_count == 0)
@@ -2744,12 +2748,9 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	}
 
 	if (rdev->ena_pin) {
-		if (!rdev->ena_gpio_state) {
-			ret = regulator_ena_gpio_ctrl(rdev, true);
-			if (ret < 0)
-				return ret;
-			rdev->ena_gpio_state = 1;
-		}
+		ret = regulator_ena_gpio_ctrl(rdev, true);
+		if (ret < 0)
+			return ret;
 	} else if (rdev->desc->ops->enable) {
 		ret = rdev->desc->ops->enable(rdev);
 		if (ret < 0)
@@ -2963,13 +2964,9 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 	trace_regulator_disable(rdev_get_name(rdev));
 
 	if (rdev->ena_pin) {
-		if (rdev->ena_gpio_state) {
-			ret = regulator_ena_gpio_ctrl(rdev, false);
-			if (ret < 0)
-				return ret;
-			rdev->ena_gpio_state = 0;
-		}
-
+		ret = regulator_ena_gpio_ctrl(rdev, false);
+		if (ret < 0)
+			return ret;
 	} else if (rdev->desc->ops->disable) {
 		ret = rdev->desc->ops->disable(rdev);
 		if (ret != 0)
-- 
2.39.2


