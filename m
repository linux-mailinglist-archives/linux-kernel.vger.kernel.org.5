Return-Path: <linux-kernel+bounces-137565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170DD89E3FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487921C23627
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FE1581F5;
	Tue,  9 Apr 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qdqurBoH"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C815749F;
	Tue,  9 Apr 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692604; cv=none; b=bsMKoifmnsi/3I5VMhYwwbBc+50B625u2pbV8aqAKBd7RSA8gnBM/AMq/E5N9YU3WbctIe1gj84jeuM4HuvN9EFZ3+SaUqvjaEaYIx0NosESpqjN77fENK6AZKc9slT+4ZNB8bXZ2Yu+gmfaOUXOmamlgZgDnLba6zCmPWo/dBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692604; c=relaxed/simple;
	bh=z7BAwHdlIOFlrDrp4E1/+ZBYeK6Y4f5EcDVqiHKagr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnKHmkWx322XRaDtAYECoVmnxv0wwA3mDaGMdgBGBBHOxD+0jR0dIDk7NKaLbNK2zYaVHyDe+aP1CYcHfQdr9iQChpmcSIYuTdierxDo+VKPxHry1/aK3uHg2+WW7OKWvpUjBTfRw2o+PmlS60MRZzFnjqbGyPvy38L6xOFWFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qdqurBoH; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id uHa9rwxIo83vquHa9rIXzq; Tue, 09 Apr 2024 21:56:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712692599;
	bh=fu5z4vCgv5ADaSG0dkgCAD7sDLo0K4zyVyA83A0IAdI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qdqurBoHVqAzZ2c9o312nL4dTD+sj2NhJYfzHw4TlE6jYLXojmdXtoINymkHisIGS
	 jbdRjM70I8RxAUyScubaNP8GsQQXSQ2avXCkjjldcwgh/P2N6vTnlqiwiB+Lhin8ul
	 7yk1oNCV2NUNrzNBq5cS+tTYBn5f8bkykJB+sdemHwUdB1kKPHwhFoVlMaExnvCZrS
	 mHcPmDIufMkWU8tpDGT05lPoRObO17Bb92OeQrecYkE6KZ8uhcXnHqbYHOziH83U2B
	 1uiq0AmruaUWFypV6AstfIjmNx0NBMEabaxze0bRlkW8H6ERglTjbrGfiaV0EsTEsM
	 +IXCUX1ombSyg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Apr 2024 21:56:39 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] thermal/drivers/qcom: Remove some unused fields in struct qpnp_tm_chip
Date: Tue,  9 Apr 2024 21:56:34 +0200
Message-ID: <d1c3a3c455f485dae46290e3488daf1dcc1d355a.1712687589.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct qpnp_tm_chip", the 'prev_stage' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Apparently, it has never been used. It is not a left-over from a
refactoring.
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 78c5cfe6a0c0..3cd74f6cac8f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -74,7 +74,6 @@ struct qpnp_tm_chip {
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
-	unsigned int			prev_stage;
 	unsigned int			base;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
-- 
2.44.0


