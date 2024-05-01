Return-Path: <linux-kernel+bounces-165195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5DD8B895A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B028611F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E597823CC;
	Wed,  1 May 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="reAEfJUA"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E349D5A4CD;
	Wed,  1 May 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563472; cv=none; b=jkvzcbW7Ad/mn7i3mmNz/HWjz4i0fDOjGlrAncKcHkJfPrGxv6AFUYV/boMzjl3FIu9ZyK/tIinrJ3sM/19XIf07OCSHVISbsQ/OJLvcOfMKoK9DZZzjUcNGt4zyRyqJ6zTyX9Gfb0zwxtHrntx0PXxuwJRMbhhwBjxQWbCYPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563472; c=relaxed/simple;
	bh=5PygkcuyBUAwRIUORJnEko9R4njhlZJJ/lQkQ/6nwtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdrWu7JcpY6Q68MkxajX5drE63gmBkDHisJ5FM77R30UiHSf6HMw/haSpigAYhK3mkqBSL+ExQfVbeclEwS7yQiPSaCM06DgIVwK7QGOmfpz2n+UBbyIOUhia27P7QVcfVArfO4Du57fE+WxlGL9GLy5oTGAZS0dDTwA/Dw3k74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=reAEfJUA; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 288ws0LoSn00P288ws2F8X; Wed, 01 May 2024 13:28:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714562939;
	bh=UX/wu/RLILUA2125zmuAeWndUa2Tzy8BmAzyIuX2a+k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=reAEfJUA8LXqgKp8cz7LdG6qlni18euoRbsIoCeDdhDwomJt9JhRMWIfRAivA067S
	 JOXF9qQv0AYSPgvMbBsXt/Nq50WQ6O0bANCynxI2OwGt+GPjJuemJlxz8q/urhHNuD
	 kWORNwkKZ1Yt8kvR7Yc+EJ7EEn9dKiTEA2i85c49gZi+P9BiDyVsKMwWOvSzknBupl
	 GJBg+8DVvKnpLL47NgFXzH1MBxba3SulC+9UChmR3RoE3lkpLnPPJjU11bf843r8qQ
	 DKL/pRtjD9U7nfr6F2QgIMn2tJCKx5fwNT4DuuaKiMnvIvpSg0LE0BW5yP7grub/Ws
	 45ikphYXwxJ7Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 13:28:59 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Gerald Loacker <gerald.loacker@wolfvision.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: tmag5273: Remove some unused field in struct tmag5273_data
Date: Wed,  1 May 2024 13:28:50 +0200
Message-ID: <7bd16d7fea12c64b6b3dc3cd32839cfce145bcf3.1714562912.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct tmag5273_data", the 'scale' and 'vcc' fields are unused.
Remove them.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 866a1389174b ("iio: magnetometer: add
ti tmag5273 driver") but was never used.
---
 drivers/iio/magnetometer/tmag5273.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 218b1ce076c1..4187abe12784 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -118,11 +118,9 @@ struct tmag5273_data {
 	unsigned int version;
 	char name[16];
 	unsigned int conv_avg;
-	unsigned int scale;
 	enum tmag5273_scale_index scale_index;
 	unsigned int angle_measurement;
 	struct regmap *map;
-	struct regulator *vcc;
 
 	/*
 	 * Locks the sensor for exclusive use during a measurement (which
-- 
2.44.0


